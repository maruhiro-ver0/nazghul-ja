;; ----------------------------------------------------------------------------
;; 泥棒のはしご 1階
;; ----------------------------------------------------------------------------
(mk-dungeon-room
 'p_traps_1 "闇の中の謎"
 (list
  "rr rr rr rr rr rr rr xx xx xx xx xx xx xx xx xx xx rr rr "
  "rr rr rr xx xx xx xx xx ,, ,, ,, xx xx ,, ,, ,, xx rr rr "
  "rr rr rr xx ,, ,, ,, ,, ,, ,, ,, ,, x! ,, ,, ,, x! rr rr "
  "rr rr rr xx ,, ,, ,, ,, ,, ,, ,, ,, xx ,, ,, ,, xx rr rr "
  "rr rr xx xx ,, xx xx xx xx ,, xx xx xx xx ,, xx xx rr rr "
  "rr rr xx ,, ,, ,, xx xx ,, ,, ,, xx xx ,, ,, ,, xx rr rr "
  "rr rr xx ,, ,, ,, xx xx ,, ,, ,, xx xx ,, ,, ,, xx rr rr "
  "rr rr xx ,, ,, ,, xx xx ,, ,, ,, xx xx ,, ,, ,, xx rr rr "
  "rr rr xx ,, ,, ,, xx xx ,, ,, ,, xx xx ,, ,, ,, xx rr rr "
  "rr rr xx ,, ,, ,, xx xx ,, ,, ,, xx xx ,, ,, ,, xx rr rr "
  "rr rr xx ,, ,, ,, xx xx ,, ,, ,, xx xx ,, ,, ,, xx rr rr "
  "rr rr xx ,, ,, ,, xx xx ,, ,, ,, xx xx ,, ,, ,, xx rr rr "
  "rr rr xx ,, ,, ,, xx xx ,, ,, ,, xx xx ,, ,, ,, xx rr rr "
  "rr rr xx ,, ,, ,, xx xx ,, ,, ,, xx xx ,, ,, ,, xx rr rr "
  "rr rr xx xx ,, xx xx xx xx ,, xx xx xx xx ,, xx xx rr rr "
  "rr rr xx ,, ,, ,, xx ,, ,, ,, ,, ,, ,, ,, ,, xx rr rr rr "
  "rr rr x! ,, ,, ,, x! ,, ,, ,, ,, ,, ,, ,, ,, xx rr rr rr "
  "rr rr xx ,, ,, ,, xx xx ,, ,, ,, xx xx xx xx xx rr rr rr "
  "rr rr xx xx xx xx xx xx xx xx xx xx rr rr rr rr rr rr rr "
  )
 (put (mk-riddle "タマゴ" 't_lava 3 5 3 9 #f
                 "ここを通らんとするものはこの謎を解くべし。\n\n"
                 "　乳のごとく白い大理石の殿堂に\n"
                 "　絹のごとき柔らかなカーテン\n"
                 "　水晶の泉の中に\n"
                 "　黄金のりんごが現れる\n"
                 "　この砦に扉はなし\n"
                 "　しかしそれは壊され黄金は盗まれる。"
                 ) 4 14)
 (put (mk-riddle "few" 't_lava 8 5 3 9 #f
                 "ここを通らんとするものはこの謎を解くべし。\n\n"
                 "　我は３文字の単語を隠し持つ。\n"
                 "　２を加えると、より少なくなる。\n"
                 "  I know a word of letters three.\n"
                 "  Add two, and fewer there will be.\n"
                 "［注意：英語で答えること。Tabキーを押すとローマ字・アルファベットが切り替わる。］"
                 ) 9 4)
 (put (mk-riddle "eye" 't_lava 13 5 3 9 #f
                 "ここを通らんとするものはこの謎を解くべし。\n\n"
                 "　発音は１文字\n"
                 "　しかし筆記は３文字\n"
                 "　２つ文字あり\n"
                 "　そして２つのみ我の中。\n"
                 "　我は複数、そして単数、\n"
                 "　黒く、青く、灰色。\n"
                 "　終わりから読んでも\n"
                 "　我の意味は同じ。\n"
                 "  Pronounced as one letter,\n"
                 "  but written with three.\n"
                 "  Two letters there are\n"
                 "  and two only in me.\n"
                 "  I'm double, and single,\n"
                 "  and black, blue and gray.\n"
                 "  When read from both ends\n"
                 "  I'm the same either way.\n"
                 "［注意：英語で答えること。］"
                 ) 14 14)
 (put (mk-ladder-down 'p_traps_2 9 15) 14 2)
 (put (mk-ladder-up 'p_bole 43 6) 4 16)
 )

(mk-place-music p_traps_1 'ml-dungeon-town)

(kern-place-add-on-entry-hook p_traps_1 'quest-thiefrune-den1)
