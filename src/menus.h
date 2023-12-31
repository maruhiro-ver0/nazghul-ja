/* $Id: menus.h,v 1.6 2010/08/26 05:56:21 gmcnutt Exp $
 *
 * Copyright (C) 2006 Gordon McNutt
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation; either version 2 of the License, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program; if not, write to the Free Foundation, Inc., 59 Temple Place,
 * Suite 330, Boston, MA 02111-1307 USA
 */

#ifndef menus_h
#define menus_h

/**
 * Initializes the menus for first-use. The cfg script must be loaded before
 * calling this.
 *
 * @returns 0 on success, -1 on error.
 */
extern int menu_init(void);

extern char *main_menu(void);

/**
 * Let the player choose from the available saved games.
 *
 * @return The full pathname of the save file.
 */
extern char *load_game_menu(void);
extern char *save_game_menu(void);
extern void menu_add_saved_game(char *fname);
extern void options_menu(void);

/**
 * Called when the game cannot fully initialize itself to present the normal
 * UI. This is to support players on OS's that don't show stdout and stderr on
 * a console.
 *
 * @param fmt The printf-formatted error message.
 */
void menu_startup_error(const char *fmt, ...);

#endif
