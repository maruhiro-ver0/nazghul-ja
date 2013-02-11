//
// nazghul - an old-school RPG engine
// Copyright (C) 2002, 2003 Gordon McNutt
//
// This program is free software; you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation; either version 2 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program; if not, write to the Free Foundation, Inc., 59 Temple Place,
// Suite 330, Boston, MA 02111-1307 USA
//
// Gordon McNutt
// gmcnutt@users.sourceforge.net
//

#include "cmdwin.h"

#include "cfg.h"
#include "common.h"
#include "console.h"
#include "dimensions.h"
#include "images.h"
#include "log.h"
#include "screen.h"
#include "sprite.h"

#include <assert.h>
#include <errno.h>
#include <stdarg.h>

#define CMDWIN_FRAG_MAX_LEN 64
#define CMDWIN_BUF_SZ       256

/* Fragment flags */
#define CMDWIN_FRAG_SEP     (1<<0)
#define CMDWIN_FRAG_MARK    (1<<1)

struct cmdwin_frag {
        struct list list;
        int flags;
        char buf[CMDWIN_FRAG_MAX_LEN];
};

static struct {
	SDL_Rect srect; /* screen rectangle (pixels) */
	char *buf;      /* string buffer */
	char *ptr;      /* next empty spot in buffer */
	int blen;       /* buffer length, this should be bigger than slen and
                         * is the max expected total size of any prompt (the
                         * longest prompts may be too big for the window) */
	int room;       /* empty space in buffer */
        int slen;       /* printable string length (blen >= slen), this is
                         * limited by the cmdwin UI size */
        struct sprite *cursor_sprite;
        struct list frags;
} cmdwin;

#ifdef DEBUG
static FILE *log = NULL;
#endif

struct dictionary *dictionary = NULL;

static inline void cmdwin_clear_no_repaint()
{
	memset(cmdwin.buf, 0, cmdwin.blen);
	cmdwin.ptr = cmdwin.buf;
	cmdwin.room = cmdwin.blen;
}

static void cmdwin_cursor_sprite_init()
{
        char *fname = cfg_get("cursor-image-filename");
        struct images *ss_cursor = 0;

        assert(fname);
        ss_cursor = images_new(0, 8, 16, 1, 4, 0, 0, fname);
        assert(ss_cursor);
        cmdwin.cursor_sprite = sprite_new(0, 4, 0, 0, 0, ss_cursor);
        assert(cmdwin.cursor_sprite);
}

static void cmdwin_clear_frag_stack(void)
{
        struct list *entry;
        
        entry = cmdwin.frags.next;
        while (entry != &cmdwin.frags) {
                struct cmdwin_frag *frag = (struct cmdwin_frag*)entry;
                entry = entry->next;
                list_remove(&frag->list);
                free(frag);
        }
}

static struct cmdwin_frag *cmdwin_top()
{
        if (list_empty(&cmdwin.frags))
                return 0;
        return (struct cmdwin_frag*)cmdwin.frags.prev;
}

static void cmdwin_reprint_buffer(void)
{
        struct list *entry;

        /* Erase the buffer */
        cmdwin_clear_no_repaint();

        /* Loop over the fragments until out of room or out of fragments */
        list_for_each(&cmdwin.frags, entry) {
                struct cmdwin_frag *frag = (struct cmdwin_frag*)entry;
                int n = 0;

                /* Append the fragment to the buffer. */
                if ((frag->flags & CMDWIN_FRAG_SEP)
                    && (entry->next != &cmdwin.frags)) {
                        /* Print a '-' after this fragment. */
                        n = snprintf(cmdwin.ptr, cmdwin.room, "%s-", frag->buf);
                } else {
                        /* No '-' afterwards. */
                        n = snprintf(cmdwin.ptr, cmdwin.room, "%s", frag->buf);
                }
                n = min(n, cmdwin.room);
                cmdwin.room -= n;
                cmdwin.ptr += n;

                /* If out of room then stop, and backup the ptr to the last
                 * entry in the buffer */
                if (!cmdwin.room) {
                        cmdwin.ptr--;
                        break;
                }

        }
}

int cmdwin_init(void)
{
        cmdwin_cursor_sprite_init();

        list_init(&cmdwin.frags);

	cmdwin.srect.x = CMD_X;
	cmdwin.srect.y = CMD_Y;
	cmdwin.srect.w = CMD_W;
	cmdwin.srect.h = CMD_H;
	cmdwin.slen = (CMD_W / ASCII_W) - 1; /* leave one space for the
                                              * cursor */
        cmdwin.blen = CMDWIN_BUF_SZ;
        assert(cmdwin.blen >= cmdwin.slen);

	cmdwin.buf = (char *) malloc(cmdwin.blen);
	if (!cmdwin.buf)
		return -1;

#ifdef DEBUG
	log = fopen(".cmdwin", "w+");
	if (!log) {
		err(strerror(errno));
		return -1;
	}
#endif

        cmdwin_clear_no_repaint();
	return 0;
}

static void cmdwin_vpush(int flags, const char *fmt, va_list args)
{
        /* Allocate a new fragment */
        struct cmdwin_frag *frag = (struct cmdwin_frag*)malloc(sizeof(*frag));
        if (!frag) {
                warn("allocation failed");
                return;
        }

        frag->flags = flags;

        /* default to empty string */
        frag->buf[0] = 0;

        /* Store the string in the fragment */
        if (fmt != NULL) {
                vsnprintf(frag->buf, sizeof(frag->buf), fmt, args);
        }

        /* Push the fragment onto the stack */
        list_add_tail(&cmdwin.frags, &frag->list);

        /* Reprint the buffer with the new fragment */
        cmdwin_reprint_buffer();

        /* Update the display */
	cmdwin_repaint();        
}

void cmdwin_spush(const char *fmt, ...)
{
	va_list args;

	va_start(args, fmt);
        cmdwin_vpush(CMDWIN_FRAG_SEP, fmt, args);
	va_end(args);
        
}

void cmdwin_push(const char *fmt, ...)
{
	va_list args;

	va_start(args, fmt);
        cmdwin_vpush(0, fmt, args);
	va_end(args);
}

void cmdwin_push_mark()
{
        cmdwin_vpush(CMDWIN_FRAG_MARK, 0, 0);
}

void cmdwin_pop(void)
{
        struct cmdwin_frag *frag;

        /* Fragment stack should not be empty. */
        assert(! list_empty(&cmdwin.frags));

        /* Remove the last fragment and free it. */
        frag = (struct cmdwin_frag*)cmdwin.frags.prev;
        list_remove(&frag->list);
        free(frag);

        /* Reprint the buffer without the fragment */
        cmdwin_reprint_buffer();

        /* Update the display */
	cmdwin_repaint();
}

void cmdwin_pop_to_mark()
{
        struct cmdwin_frag *frag = cmdwin_top();
        while (frag && frag->flags != CMDWIN_FRAG_MARK) {
                cmdwin_pop();
                frag = cmdwin_top();
        }

        /* DON'T pop the mark itself */
}

void cmdwin_clear(void)
{
        cmdwin_clear_frag_stack();
        cmdwin_clear_no_repaint();
        cmdwin_repaint();
}

void cmdwin_repaint_cursor(void)
{
	SDL_Rect rect;

	rect.x = cmdwin.srect.x;
	rect.y = cmdwin.srect.y;
	rect.w = ASCII_W;
	rect.h = ASCII_H;

        /* If the string is too big, show the last part of it (in other words,
         * right-justify it) */
        char *start = max(cmdwin.buf, cmdwin.ptr - cmdwin.slen);
	rect.x += (cmdwin.ptr - start) * ASCII_W;

	sprite_paint(cmdwin.cursor_sprite, 0, rect.x, rect.y);
	screenUpdate(&rect);
}

void cmdwin_repaint(void)
{
        /* If the string is too big, show the last part of it (in other words,
         * right-justify it) */
        char *start = max(cmdwin.buf, cmdwin.ptr - cmdwin.slen);
	screenErase(&cmdwin.srect);
	screenPrint(&cmdwin.srect, 0, start);
	screenUpdate(&cmdwin.srect);
	cmdwin_repaint_cursor();
}

void cmdwin_flush(void)
{
        if (!strlen(cmdwin.buf))
                return;

        log_msg("%s\n", cmdwin.buf);
        cmdwin_clear();
}

int kana_to_english(char *kana, char *english, char *kanji)
{
	int i;
	
	for (i = 0; dictionary[i].kana != NULL; i++) {
		if (!strcmp(kana, dictionary[i].kana)) {
			if (english) {
				strcpy(english, dictionary[i].english);
			}
			if (kanji) {
				strcpy(kanji, dictionary[i].kanji);
			}
			return true;
		}
	}

	if (english) {
		strcpy(english, kana);
	}
	if (kanji) {
		strcpy(kanji, kana);
	}
	return false;
}

int alpha_to_kana(int key, char *buf)
{
	const static struct {
		const char *alpha;
		const char *kana;
	} kana[] = {
		{ "ayb", "�ӥ�" },
		{ "iyb", "�ӥ�" },
		{ "uyb", "�ӥ�" },
		{ "eyb", "�ӥ�" },
		{ "oyb", "�ӥ�" },
		{ "ayc", "����" },
		{ "iyc", "����" },
		{ "uyc", "����" },
		{ "eyc", "����" },
		{ "oyc", "����" },
		{ "ayd", "�¥�" },
		{ "iyd", "�¥�" },
		{ "uyd", "�¥�" },
		{ "eyd", "�¥�" },
		{ "oyd", "�¥�" },
		{ "ayf", "�ե�" },
		{ "iyf", "�ե�" },
		{ "uyf", "�ե�" },
		{ "eyf", "�ե�" },
		{ "oyf", "�ե�" },
		{ "ayg", "����" },
		{ "iyg", "����" },
		{ "uyg", "����" },
		{ "eyg", "����" },
		{ "oyg", "����" },
		{ "ayh", "�ҥ�" },
		{ "iyh", "�ҥ�" },
		{ "uyh", "�ҥ�" },
		{ "eyh", "�ҥ�" },
		{ "oyh", "�ҥ�" },
		{ "ayj", "����" },
		{ "iyj", "����" },
		{ "uyj", "����" },
		{ "eyj", "����" },
		{ "oyj", "����" },
		{ "ayk", "����" },
		{ "iyk", "����" },
		{ "uyk", "����" },
		{ "eyk", "����" },
		{ "oyk", "����" },
		{ "aym", "�ߥ�" },
		{ "iym", "�ߥ�" },
		{ "uym", "�ߥ�" },
		{ "eym", "�ߥ�" },
		{ "oym", "�ߥ�" },
		{ "ayn", "�˥�" },
		{ "iyn", "�˥�" },
		{ "uyn", "�˥�" },
		{ "eyn", "�˥�" },
		{ "oyn", "�˥�" },
		{ "ayp", "�ԥ�" },
		{ "iyp", "�ԥ�" },
		{ "uyp", "�ԥ�" },
		{ "eyp", "�ԥ�" },
		{ "oyp", "�ԥ�" },
		{ "ayq", "����" },
		{ "iyq", "����" },
		{ "uyq", "����" },
		{ "eyq", "����" },
		{ "oyq", "����" },
		{ "ayr", "���" },
		{ "iyr", "�ꥣ" },
		{ "uyr", "���" },
		{ "eyr", "�ꥧ" },
		{ "oyr", "���" },
		{ "ays", "����" },
		{ "iys", "����" },
		{ "uys", "����" },
		{ "eys", "����" },
		{ "oys", "����" },
		{ "ayt", "����" },
		{ "iyt", "����" },
		{ "uyt", "����" },
		{ "eyt", "����" },
		{ "oyt", "����" },
		{ "ayv", "����" },
		{ "iyv", "����" },
		{ "uyv", "����" },
		{ "eyv", "����" },
		{ "oyv", "����" },
		{ "ayx", "��" },
		{ "iyx", "��" },
		{ "uyx", "��" },
		{ "eyx", "��" },
		{ "oyx", "��" },
		{ "ayz", "����" },
		{ "iyz", "����" },
		{ "uyz", "����" },
		{ "eyz", "����" },
		{ "oyz", "����" },
		{ "ahc", "����" },
		{ "ihc", "��" },
		{ "uhc", "����" },
		{ "ehc", "����" },
		{ "ohc", "����" },
		{ "ahd", "�ǥ�" },
		{ "ihd", "�ǥ�" },
		{ "uhd", "�ǥ�" },
		{ "ehd", "�ǥ�" },
		{ "ohd", "�ǥ�" },
		{ "ahp", "�ե�" },
		{ "ihp", "�ե�" },
		{ "uhp", "��" },
		{ "ehp", "�ե�" },
		{ "ohp", "�ե�" },
		{ "ahs", "����" },
		{ "ihs", "��" },
		{ "uhs", "����" },
		{ "ehs", "����" },
		{ "ohs", "����" },
		{ "aht", "�ƥ�" },
		{ "iht", "�ƥ�" },
		{ "uht", "�ƥ�" },
		{ "eht", "�ƥ�" },
		{ "oht", "�ƥ�" },
		{ "ahw", "����" },
		{ "ihw", "����" },
		{ "uhw", "��" },
		{ "ehw", "����" },
		{ "ohw", "����" },
		{ "ast", "�ĥ�" },
		{ "ist", "�ĥ�" },
		{ "ust", "��" },
		{ "est", "�ĥ�" },
		{ "ost", "�ĥ�" },
		{ "ab", "��" },
		{ "ib", "��" },
		{ "ub", "��" },
		{ "eb", "��" },
		{ "ob", "��" },
		{ "ac", "��" },
		{ "ic", "��" },
		{ "uc", "��" },
		{ "ec", "��" },
		{ "oc", "��" },
		{ "ad", "��" },
		{ "id", "��" },
		{ "ud", "��" },
		{ "ed", "��" },
		{ "od", "��" },
		{ "af", "�ե�" },
		{ "if", "�ե�" },
		{ "uf", "��" },
		{ "ef", "�ե�" },
		{ "of", "�ե�" },
		{ "ag", "��" },
		{ "ig", "��" },
		{ "ug", "��" },
		{ "eg", "��" },
		{ "og", "��" },
		{ "ah", "��" },
		{ "ih", "��" },
		{ "uh", "��" },
		{ "eh", "��" },
		{ "oh", "��" },
		{ "aj", "����" },
		{ "ij", "��" },
		{ "uj", "����" },
		{ "ej", "����" },
		{ "oj", "����" },
		{ "ak", "��" },
		{ "ik", "��" },
		{ "uk", "��" },
		{ "ek", "��" },
		{ "ok", "��" },
		{ "al", "��" },
		{ "il", "��" },
		{ "ul", "��" },
		{ "el", "��" },
		{ "ol", "��" },
		{ "am", "��" },
		{ "im", "��" },
		{ "um", "��" },
		{ "em", "��" },
		{ "om", "��" },
		{ "an", "��" },
		{ "in", "��" },
		{ "un", "��" },
		{ "en", "��" },
		{ "on", "��" },
		{ "nn", "��" },
		{ "ap", "��" },
		{ "ip", "��" },
		{ "up", "��" },
		{ "ep", "��" },
		{ "op", "��" },
		{ "aq", "����" },
		{ "iq", "����" },
		{ "uq", "����" },
		{ "eq", "����" },
		{ "oq", "����" },
		{ "ar", "��" },
		{ "ir", "��" },
		{ "ur", "��" },
		{ "er", "��" },
		{ "or", "��" },
		{ "as", "��" },
		{ "is", "��" },
		{ "us", "��" },
		{ "es", "��" },
		{ "os", "��" },
		{ "at", "��" },
		{ "it", "��" },
		{ "ut", "��" },
		{ "et", "��" },
		{ "ot", "��" },
		{ "av", "����" },
		{ "iv", "����" },
		{ "uv", "��" },
		{ "ev", "����" },
		{ "ov", "����" },
		{ "aw", "��" },
		{ "iw", "��" },
		{ "uw", "��" },
		{ "ew", "����" },
		{ "ow", "��" },
		{ "ax", "��" },
		{ "ix", "��" },
		{ "ux", "��" },
		{ "ex", "��" },
		{ "ox", "��" },
		{ "ay", "��" },
		{ "iy", "��" },
		{ "uy", "��" },
		{ "ey", "����" },
		{ "oy", "��" },
		{ "az", "��" },
		{ "iz", "��" },
		{ "uz", "��" },
		{ "ez", "��" },
		{ "oz", "��" },
		{ "'n", "��" },
		{ "a", "��" },
		{ "i", "��" },
		{ "u", "��" },
		{ "e", "��" },
		{ "o", "��" },
		{ " ", "��" },
		{ "!", "��" },
		{ "\"", "��" },
		{ "#", "��" },
		{ "$", "��" },
		{ "%", "��" },
		{ "&", "��" },
		{ "'", "��" },
		{ "(", "��" },
		{ ")", "��" },
		{ "*", "��" },
		{ "+", "��" },
		{ ",", "��" },
		{ "-", "��" },
		{ ".", "��" },
		{ "/", "��" },
		{ "0", "��" },
		{ "1", "��" },
		{ "2", "��" },
		{ "3", "��" },
		{ "4", "��" },
		{ "5", "��" },
		{ "6", "��" },
		{ "7", "��" },
		{ "8", "��" },
		{ "9", "��" },
		{ ":", "��" },
		{ ";", "��" },
		{ "<", "��" },
		{ "=", "��" },
		{ ">", "��" },
		{ "?", "��" },
		{ "@", "��" },
		{ "[", "��" },
		{ "\\", "��" },
		{ "]", "��" },
		{ "^", "��" },
		{ "_", "��" },
		{ "`", "��" },
		{ "{", "��" },
		{ "|", "��" },
		{ "}", "��" },
		{ "~", "��" },
		{ NULL, NULL }
	};
	static int roman = true;
	static char roman_buf[] = { "\0\0\0\0\0" };
	int i;
	int len;
	int n;
	int soku;

	if (key == 0) { /* Clear roman buffer */
		memset(roman_buf, 0, sizeof(roman_buf));
		return 0;
	}
	if (key == -1) { /* Roman mode off */
		roman = false;
		return 0;
	}
	if (key == '\t') { /* Toggle roman mode */
		roman = !roman;
		memset(roman_buf, 0, sizeof(roman_buf));
		return 0;
	}

	if (!roman || (key & 0x80) || !isprint(key)) {
		memset(roman_buf, 0, sizeof(roman_buf));
		return 0;
	}

	memmove(roman_buf + 1, roman_buf, sizeof (roman_buf) - 1);
	roman_buf[0] = key;

	for (i = 0; kana[i].alpha != NULL; i++) {
		len = strlen(kana[i].alpha);

		if (!strncasecmp(roman_buf, kana[i].alpha, len)) {
			soku = (roman_buf[len - 1] == roman_buf[len]);

			if(soku)
				n = (roman_buf[len + 1] == 'n');
			else
				n = (roman_buf[len] == 'n');

			sprintf (buf, "%.*s%s%s%s", len + n + soku, "\b\b\b\b\b", (n ? "��": ""), (soku ? "��": ""), kana[i].kana);

			memset(roman_buf, 0, sizeof (roman_buf));
			return strlen(buf);
		}
	}
	return 0;
}
