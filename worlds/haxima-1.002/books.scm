;; ----------------------------------------------------------------------------
;; books.scm -- 読めるもの
;; ----------------------------------------------------------------------------

(kern-mk-sprite-set 'ss_books 32 32 2 2 0 0 "books.png")

(kern-mk-sprite 's_lexicon ss_books 1 0 #f 0)
(kern-mk-sprite 's_manual  ss_books 1 1 #f 0)
(kern-mk-sprite 's_scroll  ss_books 1 2 #f 0)

;; Fixme: see if something like this will work for books:
(define (mk-book tag name . text)
  (mk-reusable-item 
   tag name s_manual norm
   (lambda ()
     (kern-ui-page-text text))))

;;----------------------------------------------------------------------------
;; player manual
(define (basic-survival-manual-commands)
  (kern-ui-page-text
   "命令一覧"
   "方向は矢印キー(テンキー)で示す。"
   "ESCを押すと命令を中断する。"
   "先頭の文字のキーを押すと命令を実行する。"
   "詳細はマニュアルを読むこと。"
   ""
   "A)何かを攻撃する"
   "B)船などに乗る"
   "C)呪文を唱える"
   "E)町や洞窟に入る"
   "F)船の大砲などで砲撃する"
   "G)置かれたものを取る"
   "H)レバーや機械を操作する"
   "K)ベッドや荒野で休息を取る"
   "L)しばらくうろつく"
   "N)順序を変更する"
   "O)箱や扉などを開く"
   "Q)ゲームを終了する"
   "R)武器や防具を装備する"
   "S)隠されたものを探す"
   "T)誰かと話す"
   "U)持ち物を使う"
   "Y)能力を使う"
   "Z)状態を表示する"
   "X)あたりを調べる"
   "@)場所や時間について表示する"
   "<space> 何もしない"
   "CTRL-S)終了せずゲームを保存する"
   "CTRL-R)最後に保存した状態を読み込む"
   "SHIFT+カーソルキー 画面をスクロールする"
   "会話中に<Tab>アルファベット・ローマ字の切替"
   )
  result-ok)

(mk-reusable-item 't_manual "生き延びるための手引書" s_manual (/ norm 3)
                  basic-survival-manual-commands)

;;----------------------------------------------------------------------------
;; 魔道師からの手紙
(mk-reusable-item 
 't_letter_from_enchanter "重要な手紙" s_lexicon norm
 (lambda (klexicon kuser)
   (kern-ui-page-text
    "迷い人へ − 重要"
   ""
   "最も^c+r重要^c-なのは、私を見つけることだ。"
   "祭壇の管理をしている者が道を教えてくれるだろ"
   "う。"
   "気をつけて。"
   ""
   "−魔道師\n"
   )
   (quest-data-assign-once 'questentry-calltoarms)
   result-ok))

;;----------------------------------------------------------------------------
;; book of the demon gate
(mk-reusable-item 
 't_demon_gate_book "ボロボロの文書" s_scroll v-hard
 (lambda (kbook kuser)
   (kern-ui-page-text
   "悪魔の門"
   ""
   "…古き賢者が悪魔の門を封印し、そして鍵を分け"
   "た…"
   "悪魔の門の寺院が現れることはない。世界が再生す"
   "るまでは…"
   "彼らは神殿への道を幻覚で封印した…"
   "その道は、愚かな者には山々であるかのように見え"
   "る…"
   ""
   "…星の川を源流へとたどれ…"
   ""
   "…門を開けた者は、想像を超えた力が…"
   ""
   "…ノシファーが待っている。"
   ""
   "−不浄なフィルデックス\n"
   )
   result-ok))

;;----------------------------------------------------------------------------
;; キャスリンの手紙
(mk-reusable-item 
 't_kathryns_letter "手紙" s_scroll norm
 (lambda (kletter kuser)
   (kern-ui-page-text
   "手紙"
   "Ｋへ"
   "魔道師は石版の一つを持っている。あらゆる意味"
   "でそれが必要だ。この話を知っているものを生か"
   "しておいてはならない。亡霊でさえもだ。"
   "−Ｓより")
   result-ok))


;;----------------------------------------------------------------------------
;; The soliloquy from Hamlet:
(mk-reusable-item 
 't_playbook_hamlet "脚本" s_scroll norm
 (lambda (kletter kuser)
   (kern-ui-page-text
   "脚本の一部"

   "To be, or not to be: that is the question:"
   "Whether 'tis nobler in the mind to suffer"
   "The slings and arrows of outrageous fortune,"
   "Or to take arms against a sea of troubles,"
   "And by opposing end them? To die: to sleep;"
   "No more; and by a sleep to say we end"
   "The heart-ache and the thousand natural shocks"
   "That flesh is heir to, 'tis a consummation"
   "Devoutly to be wish'd. To die, to sleep;"
   "To sleep: perchance to dream: ay, there's the rub;"
   ""
   "For in that sleep of death what dreams may come"
   "When we have shuffled off this mortal coil,"
   "Must give us pause: there's the respect"
   "That makes calamity of so long life;"
   ""
   "For who would bear the whips and scorns of time,"
   "The oppressor's wrong, the proud man's contumely,"
   "The pangs of despised love, the law's delay,"
   "The insolence of office and the spurns"
   "That patient merit of the unworthy takes,"
   "When he himself might his quietus make"
   "With a bare bodkin? who would fardels bear,"
   "To grunt and sweat under a weary life,"
   "But that the dread of something after death,"
   "The undiscover'd country from whose bourn"
   "No traveller returns, puzzles the will"
   "And makes us rather bear those ills we have"
   "Than fly to others that we know not of?"
   ""
   "Thus conscience does make cowards of us all;"
   "And thus the native hue of resolution"
   "Is sicklied o'er with the pale cast of thought,"
   "And enterprises of great pith and moment"
   "With this regard their currents turn awry,"
   "And lose the name of action.--Soft you now!"
   "The fair Ophelia! Nymph, in thy orisons"
   "Be all my sins remember'd."
   )))

;;----------------------------------------------------------------------------
;; Spell books
(mk-reusable-item 
 't_ylem_an_ex_book "呪文書: YAE" s_manual hard
 (lambda (kletter kuser)
   (kern-ui-page-text
   "網 - Ylem An Ex"
   ""
   "初心者のための便利な呪文"
   "網で遠くの敵を捕らえ、少しの間身動きが取れな"
   "いようにすることができる。"
   ""
   "うまく使えば、網で一時的に通路を塞ぐこともで"
   "きる。初心者には難しいかもしれないが。"
   ""
   "この呪文には、もちろん蜘蛛の糸が必要だが、目"
   "標に向かって飛ばすために黒真珠も必要である。"
   ""
   "正しく調合したら、Ylem An Ex(物体・逆・自由)"
   "と唱え、網を敵に向かって発射すること。"
   ) 
   result-ok))

(mk-reusable-item 
 't_bet_flam_hur_book "呪文書: BFH" s_manual hard
 (lambda (kletter kuser)
   (kern-ui-page-text
   "火霧 - Bet Flam Hur"
   ""
   "炎風の呪文の効果は絶大だが、唱えるのが難しく"
   "また消耗が激しいため、一部を除くほとんどの魔"
   "術師の能力を超えるものである。"
   ""
   "この火霧の呪文は、炎風の呪文を簡素に再構成し"
   "たものである。もちろん唱える者の能力が高いほ"
   "ど効果が増す。"
   ""
   "火霧の呪文の範囲は長柄武器と比べてもそれほど"
   "広くはない。さらに炎風の呪文のように場に炎の"
   "力を残すことはできない。"
   ""
   "この呪文には、炎の力のための硫黄の灰、最初の"
   "発動のための黒真珠、そして炎を円錐状に広げる"
   "ための血の苔が必要である。"
   ""
   "調合したら、Bet Flam Hur(小・火・風)と唱え、"
   "敵を巻き込む円錐の方向を指示すること。"
   )
   result-ok))

(mk-reusable-item
 't_ranger_orders "警備隊長命令書" s_scroll norm
 (lambda (kletter kuser)
   (kern-ui-page-text
    "警備隊長命令"
    ""
    "この命令書を持つ者は、警備隊員一名を一時的に指"
    "揮下に置くことができる。")
   result-ok))

(mk-reusable-item
 't_prisoner_receipt "収容証明書" s_scroll norm
 (lambda (kletter kuser)
   (kern-ui-page-text
    "収容証明書"
    ""
    "この証明書は一人の囚人を看守に渡したことを証明"
    "するものである。")
   result-ok))


;;;;;;;;;;;;;;;;;;;; White Magick ;;;;;;;;;;;;;;;;;;;;

(mk-reusable-item
 't_spell_book_white_magick_1 "白魔法: 第一巻" s_manual (/ norm 3)
 (lambda (kbook kuser)
   (kern-ui-page-text
    "白魔法: 第一巻"
    "治癒の呪文、第一陣"
    "┌────────────────────┐"
    "│　　　　　　Mで秘薬を調合せよ　　　　　 │"
    "│　　　　しかるべきときにCで唱えよ　　　 │"
    "│　　　　　白は汝を癒すであろう　　　　　│"
    "│　　　　 さほどの知識は要らぬ！　　　　 │"
    "└────────────────────┘"
    "解毒 <AN NOX>"
    "- 人参、大蒜"
    ""
    "覚醒 <AN ZU>"
    "- 人参、大蒜"
    ""
    "小回復 <MANI>"
    "- 人参、蜘蛛の糸"
    )
   result-ok))

(mk-reusable-item
 't_spell_book_white_magick_2 "白魔法: 第ニ巻"  s_manual (/ norm 3)
 (lambda (kbook kuser)
   (kern-ui-page-text
    "白魔法: 第二巻"
    "治癒と保護の呪文"
    "┌────────────────────┐"
    "│　　　調合と詠唱の言い伝えを知れ　　　　│"
    "│　唱えれば多くの益が得られるであろう　　│"
    "│　　　だが忘れるな　思慮と責務を　　　　│"
    "│　　　来るもの全てに癒しを与えよ　　　　│"
    "└────────────────────┘"
    "耐毒 <Sanct Nox>"
    "- 大蒜、ナイトシェイド、ロイヤルケープ茸"
    ""
    "耐火 <In Flam Sanct>"
    "- 硫黄の灰、大蒜、[汚れ]"
    ""
    "脱魔法 <An Ort Xen>"
    "- 硫黄の灰、大蒜、マンドレイク"
    ""
    "保護 <IN SANCT>"
    "- 硫黄の灰、大蒜、人参"
    ""
    "全解毒 <VAS AN NOX>"
    "- 大蒜、人参、マンドレイク"
    ""
    "大回復 <VAS MANI>"
    "- 人参、蜘蛛の糸、マンドレイク"
    )
   result-ok))

(mk-reusable-item
 't_spell_book_white_magick_3 "白魔法: 第三巻"  s_manual (/ norm 3)
 (lambda (kbook kuser)
   (kern-ui-page-text
    "白魔法: 第三巻"
    "高位の治癒の魔法"
    "┌────────────────────┐"
    "│　今調合せよ　そして冠の主よ　唱えよ！　│"
    "│　　　だが招き寄せよ　素早い力を！　　　│"
    "│　　　汝が賢ければできるであろう　　　　│"
    "│ KAL WIS - IN MANI - AN CORP - ZU QUAS  │"
    "└────────────────────┘"
    "全解毒 <VAS AN NOX>"
    "- 人参、大蒜、マンドレイク"
    ""
    "全耐毒 <VAS SANCT NOX>"
    "- 大蒜、ナイトシェイド、マンドレイク、"
    "  ロイヤルケープ茸"
    ""
    "大回復 <VAS MANI>"
    "- 人参、蜘蛛の糸、マンドレイク"
    ""
    ""
    "──────── 高位の魔法 ────────"
    ""
    "蘇生 <IN MANI CORP>"
    "- 人参、大蒜、蜘蛛の糸、硫黄の灰、血の苔、"
    "  マンドレイク"
    ""
    "  −生きるべき者を殺してはならぬ！−"
    "  −休むべき者を蘇らせてはならぬ！−"

    )
   result-ok))


;;;;;;;;;;;;;;;;;;;; Force Magick ;;;;;;;;;;;;;;;;;;;;

(mk-reusable-item
 't_spell_book_force_magick_12 "威力: 第一巻" s_manual (/ norm 3)
 (lambda (kbook kuser)
   (kern-ui-page-text
    "威力: 第一巻"
    "力の呪文、第一陣、第二陣"
    "┌────────────────────┐"
    "│           Mで秘薬を調合せよ            │"
    "│       しかるべきときにCで唱えよ        │"
    "│       力は敵に恐怖を知らしめる         │"
    "│    汝が愚かでも呪文は苦痛を与える！    │"
    "└────────────────────┘"
    "第一陣:"
    "────────────"
    "魔法の矢 <GRAV POR>"
    "- 硫黄の灰、黒真珠"
    ""
    "光 <IN LOR>"
    "- 硫黄の灰"
    ""
    "────────────"
    "第二陣:"
    "────────────"
    "風変化 <REL HUR>"
    "- 硫黄の灰、血の苔"
    ""
    "火霧 <BET FLAM HUR>"
    "- 硫黄の灰、血の苔、黒真珠"
    ""
    "毒撃 <IN NOX POR>"
    "- ナイトシェイド、血の苔、黒真珠"
    )
   result-ok))

(mk-reusable-item
 't_spell_book_force_magick_battle "威力: 戦闘"  s_manual (/ norm 3)
 (lambda (kbook kuser)
   (kern-ui-page-text
    "威力: 戦闘"
    "┌────────────────────┐"
    "│　　　　戦闘準備　詠唱し調合せよ　　　　│"
    "│　　　　戦闘開始　唱え浴びせよ　　　　　│"
    "│　　　敵は苦悶のうちに死ぬであろう　　　│"
    "│強力だが汝には困難か　それとも汝は聡明か│"
    "└────────────────────┘"
    "第一陣:"
    "────────────"
    "魔法の矢 <GRAV POR>"
    "- 硫黄の灰、黒真珠"
    ""
    "雷撃 <ORT GRAV>"
    "- 硫黄の灰、黒真珠、マンドレイク"
    ""
    "────────────"
    "第三陣:"
    "────────────"
    "火球 <VAS FLAM>"
    "- 硫黄の灰、黒真珠"
    ""
    "耐火 <IN FLAM SANCT>"
    "- 硫黄の灰、[焦げ]、ロイヤル[灰の汚れ]"
    ""
    "────────────"
    "第六陣:"
    "────────────"
    "地震 <IN VAS POR YLEM>"
    "- 硫黄の灰、血の苔、マンドレイク"
    )
   result-ok))


(mk-reusable-item
't_spell_book_force_magick_winds "威力: 死の風"  s_manual (/ norm 3)
 (lambda (kbook kuser)
   (kern-ui-page-text
    "威力: 死の風"
    "┌────────────────────┐"
    "│　風のために調合せよ　風のために唱えよ！│"
    "│　汝の敵は眠り　無力さを知るであろう　　│"
    "│　汝の敵は打たれ　焼かれ　苦しむであろう│"
    "│　　だが　汝は風の向きを変えるべきか？　│"
    "│風の向きを変える必要がなければ　変わらず│"
    "│　　　　　それでも変えるか？　　　　　　│"
    "└────────────────────┘"
    "第一陣、第二陣:"
    "────────────"
    "煙幕 <BET YLEM HUR>"
    "- 硫黄の灰"
    ""
    "風変化 <REL HUR>"
    "- 硫黄の灰、血の苔"
    ""
    "火霧 <BET FLAM HUR>"
    "- 硫黄の灰、血の苔、黒真珠"
    ""
    "────────────"
    "第七陣:"
    "────────────"
    "催眠風 <IN ZU HUR>"
    "- 人参、血の苔、マンドレイク"
    ""
    "毒風 <IN NOX HUR>"
    "- 硫黄の灰、血の苔、ナイトシェイド"
    ""
    "────────────"
    "第八陣:"
    "────────────"
    "炎風 <IN FLAM HUR>"
    "- 硫黄の灰、血の苔、マンドレイク"
    )
   result-ok))
(mk-reusable-item
't_spell_book_force_magick_matter "威力: 問題解決"  s_manual (/ norm 3)
 (lambda (kbook kuser)
   (kern-ui-page-text
    "威力: 問題解決"
    "┌────────────────────┐"
    "│　　調合し唱えよ　力は問題を支配する　　│"
    "│　　　　力は小から大まで扱える　　　　　│"
    "│汝が聡明なら　この忠告がわかるであろう　│"
    "│　　　　鉄の秘密は？（柔らかな肉）　　　│"
    "│　　　　片腕の音は？（蝶）　　　　　　　│"
    "└────────────────────┘"
    "第一陣、第二陣:"
    "────────────"
    "罠解除 <AN SANCT YLEM>"
    "- 血の苔"
    ""
    "開錠 <AN SANCT>"
    "- 硫黄の灰、血の苔"
    ""
    "施錠 <SANCT>"
    "- 硫黄の灰、蜘蛛の糸"
    ""
    "風変化 <REL HUR>"
    "- 硫黄の灰、血の苔"
    ""
    "────────────"
    "第六陣:"
    "────────────"
    "地震 <IN VAS POR YLEM>"
    "- 硫黄の灰、血の苔、マンドレイク"
    ""
    "念力 <IN REL POR>"
    "- 蜘蛛の糸、血の苔、黒真珠"
    ""
    "────────────"
    "[走り書き]"
    "────────────"
    "引揚 <VAS UUS YLEM>"
    "- 試み１：灰、真珠、マンドレイク？？？"
    "- 試み２：[焦げ]、イモリの目？"
    "- ゲイザーの目？竜の脾臓？オーガの唾？"
    )
   result-ok))

(mk-reusable-item
't_spell_book_force_magick_mechanismus "威力: 機械・装置"  s_manual (/ norm 3)
 (lambda (kbook kuser)
   (kern-ui-page-text
    "威力: 機械・装置"
    "┌────────────────────┐"
    "│　　　　　知　調合　物　詠唱！　　　　　│"
    "│　　　恐るべき罠？その脅威は過ぎ去る！　│"
    "│　　　　鍵がない？だがそれは開く！　　　│"
    "│　　　光を放つかんぬきは無力である！　　│"
    "│　　　　　速さを保て　流行を保て　　　　│"
    "│　　　時間を保て(あるいはその君主を)　　│"
    "│　　この呪文があれば　閉じた？？？を　　│"
    "│　　　　　奪うならず者はいない　　　　　│"
    "└────────────────────┘"
    "第一陣、第二陣:"
    "────────────"
    "罠解除 <An Sanct Ylem>"
    "- 血の苔"
    ""
    "開錠 <An Sanct>"
    "- 硫黄の灰、血の苔"
    ""
    "施錠 <Sanct>"
    "- 硫黄の灰、蜘蛛の糸"
    ""
    "────────────"
    "第五陣:"
    "────────────"
    "封印解除 <In Ex Por>"
    "- 硫黄の灰、血の苔"
    ""
    "封印 <An Ex Por>"
    "- 硫黄の灰、大蒜、血の苔"
    )
   result-ok))

(mk-reusable-item
't_spell_book_force_magick_fields "威力: 領域"  s_manual (/ norm 3)
 (lambda (kbook kuser)
   (kern-ui-page-text
    "威力: 領域"
    "┌────────────────────┐"
    "│　　　　　調合し唱えよ　場に力を　　　　│"
    "│　　　　　　眠り　毒　炎　雷　　　　　　│"
    "│　　　あるいは汝を阻む場を消し去れ　　　│"
    "│  IN GRAV - AN POR - AN GRAV - EX POR   │"
    "└────────────────────┘"
    "第三陣:"
    "────────────"
    "催眠場 <In Zu Grav>"
    "- 人参、蜘蛛の糸、黒真珠"
    ""
    "毒場 <In Nox Grav>"
    "- 蜘蛛の糸、黒真珠、ナイトシェイド"
    ""
    "火炎場 <In Flam Grav>"
    "- 硫黄の灰、蜘蛛の糸、黒真珠"
    ""
    "────────────"
    "第四陣:"
    "────────────"
    "障壁 <In Sanct Grav>"
    "- 蜘蛛の糸、黒真珠、マンドレイク"
    ""
    "脱魔法場 <An Grav>"
    "- 硫黄の灰、黒真珠"
    )
   result-ok))

(mk-reusable-item
't_spell_book_force_magick_high_magick "威力: 上級魔法"  s_manual (/ norm 3)
 (lambda (kbook kuser)
   (kern-ui-page-text
    "威力: 上級魔法"
    "┌────────────────────┐"
    "│　　用心せよ　汝はそれほど強くない！　　│"
    "│　　用心せよ　汝は本当は賢くない！　　　│"
    "│　　ここに書かれしは高位の魔法である　　│"
    "│　　汝が愚かなら　汝は死ぬであろう　　　│"
    "│　　だがここに記す　恐るべき力を　　　　│"
    "└────────────────────┘"
    "第六陣 - 無力化 <In An>"
    "- 硫黄の灰、大蒜、マンドレイク"
    ""
    "第七陣 - 死 <Xen Corp>"
    "- 黒真珠、マンドレイク"
    ""
    "第八陣 - 死風 <In Vas Grav Corp>"
    "- 硫黄の灰、ナイトシェイド、マンドレイク"
    ""
    "第八陣 - 時間停止 <An Tym>"
    "- 大蒜、血の苔、マンドレイク"
    )
   result-ok))


;;;;;;;;;;;;;;;;;;;; Necromancy ;;;;;;;;;;;;;;;;;;;;

(mk-reusable-item
 't_spell_book_necromancy "死と不死の秘儀" s_manual (/ norm 3)
 (lambda (kbook kuser)
   (kern-ui-page-text
    "死と不死の秘儀"
    "┌────────────────────┐"
    "│Sanctus Corporem ex Nihilo, Rel Oculume │"
    "│De Vermiis Mysteriis, Astralis Sangrem  │"
    "└────────────────────┘"
    "第二陣 - 不死還 <An Xen Corp>"
    "- 硫黄の灰、大蒜"
    ""
    "第八陣 - 不死召還 <Kal Xen Corp>"
    "- 蜘蛛の糸、ナイトシェイド、マンドレイク"
    ""
    "第二陣 - 毒撃 <In Nox Por>"
    "- 血の苔、黒真珠、ナイトシェイド"
    ""
    "第七陣 - 毒風 <In Nox Hur>"
    "- 硫黄の灰、血の苔、ナイトシェイド"
    ""
    "第七陣 - 死 <Xen Corp>"
    "- 黒真珠、ナイトシェイド"
    ""
    "第七陣 - 複製 <In Quas Xen>"
    "- 硫黄の灰、人参、蜘蛛の糸、血の苔、"
    "  ナイトシェイド、マンドレイク"
    ""
    "第八陣 - 蘇生 <In Mani Corp>"
    "- 硫黄の灰、人参、大蒜、蜘蛛の糸、血の苔、"
    "  マンドレイク"
    )
   result-ok))


;;;;;;;;;;;;;;;;;;;; Summoning ;;;;;;;;;;;;;;;;;;;;

(mk-reusable-item
 't_spell_book_summoning "召還: 獣と存在" s_manual (/ norm 3)
 (lambda (kbook kuser)
   (kern-ui-page-text
    "召還: 獣と存在"
    "┌────────────────────┐"
    "│KAL        召喚師へ - 注意せよ      KAL │"
    "│CORP         呼び出した者は         XEN │"
    "│BET       送り返すことはできぬ      ORT │"
    "│SANCT  [ABRAD] - [ACAD] - [ABRA]   YLEM │"
    "└────────────────────┘"
    "第二陣 - 虫召還 <In Bet Xen>"
    "- 硫黄の灰、血の苔、蜘蛛の糸"
    ""
    "第五陣 - 獣召還 <Kal Xen>"
    "- 蜘蛛の糸、マンドレイク"
    ""
    "第八陣 - 融解 <Kal Xen Nox>"
    "- 蜘蛛の糸、ナイトシェイド、マンドレイク"
    ""
    "第八陣 - 不死召還 <Kal Xen Corp>"
    "- 蜘蛛の糸、ナイトシェイド、マンドレイク"
    )
   result-ok))


;;;;;;;;;;;;;;;;;;;; Dimensions and Gate Magick ;;;;;;;;;;;;;;;;;;;;

(mk-reusable-item
 't_spell_book_gate_magick "次元: 門" s_manual (/ norm 3)
 (lambda (kbook kuser)
   (kern-ui-page-text
    "次元: 門"
    "┌────────────────────┐"
    "│　嗚呼　探求者よ　旅は　真に自由である　│"
    "│      IN POR - IN WIS - EX POR WIS      │"
    "│　　　　　　　　　　　　　　　　　　　　│"
    "│　　月の言い伝えが　門を支配する！　　　│"
    "│　　太陽−フィア　輝き　24　(12,12) 　　│"
    "│　　　月−ルミス　黄　　60　(5)x8 　　　│"
    "│　　　月−オード　青　　36　(9)x8 　　　│"
    "│　　　　　　　　　　　　　　　　　　　　│"
    "│汝が聡明なら　　　　　　　満ち欠けを見よ│"
    "└────────────────────┘"
    "位置 <In Wis>"
    "- ナイトシェイド"
    ""
    "千里眼 <In Quas Wis>"
    "- ナイトシェイド、マンドレイク"
    ""
    "跳躍 <Bet Por>"
    "- 血の苔、黒真珠"
    ""
    "上昇 <Uus Por>"
    "- 調合すべからず、唱えるべからず！"
    "  破り去り空白とする！"
    ""
    "下降 <Des Por>"
    "- 罠に注意せよ！"
    "  この言い伝えを探るべからず！"
    ""
    "高速化 <Rel Tym>"
    "- 硫黄の灰、血の苔、マンドレイク"
    ""
    "瞬間移動 <Vas Por>"
    "- 血の苔、黒真珠、マンドレイク"
    ""
    "門 <Vas Rel Por>"
    "- 硫黄の灰、黒真珠、マンドレイク"
    )
   result-ok))


;;;;;;;;;;;;;;;;;;;; Enchantment ;;;;;;;;;;;;;;;;;;;;

(mk-reusable-item
 't_spell_book_enchantment_wards "結界: 防御" s_manual (/ norm 3)
 (lambda (kbook kuser)
   (kern-ui-page-text
    "結界: 防御"
    "┌────────────────────┐"
    "│SANCT -      汝自身を守れ！     - SANCT │"
    "│　　調合せよ！守りの呪文を唱えよ！　　　│"
    "│　　　　汝の周りを力の場が覆う　　　　　│"
    "│探求者よ-汝は危機の最中にあり！-注意せよ│"
    "└────────────────────┘"
    "耐毒 <Sanct Nox>"
    "- 大蒜、ナイトシェイド、ロイヤルケープ茸"
    ""
    "耐火 <In Flam Sanct>"
    "- [不明瞭]、[汚れ]、沿岸の王子の冠"
    ""
    "全耐毒 <Vas Sanct Nox>"
    "- 大蒜、ナイトシェイド、マンドレイク、"
    "  ロイヤルケープ茸"
    ""
    "保護 <In Sanct>"
    "- 硫黄の灰、人参、大蒜"
    ""
    "脱魔法 <An Ort Xen>"
    "- 硫黄の灰、大蒜、マンドレイク"
    ""
    "無力化 <In An>"
    "- 硫黄の灰、大蒜、マンドレイク"
    ""
    "障壁 <In Sanct Grav>"
    "- 蜘蛛の糸、黒真珠、マンドレイク"
    )
   result-ok))

(mk-reusable-item
 't_spell_book_enchantment_curses "結界: 呪詛" s_manual (/ norm 3)
 (lambda (kbook kuser)
   (kern-ui-page-text
    "結界: 呪詛"
    "┌────────────────────┐"
    "│　　　　　　これを読む者へ　　　　　　　│"
    "│　　　呪われよ　我は汝の光を奪う！　　　│"
    "│　　────────────────　　│"
    "│　　　これを読む者へ　−　賢くあれ　　　│"
    "│　　　必要とあらば　調合し唱えよ　　　　│"
    "└────────────────────┘"
    "網 <Ylem An Ex>"
    "- 蜘蛛の糸、黒真珠"
    ""
    "対蜘蛛 <An Xen Bet>"
    "- 大蒜、蜘蛛の糸"
    ""
    "催眠 <Xen Zu>"
    "- 人参、蜘蛛の糸"
    ""
    "魅了 <An Xen Ex>"
    "- 蜘蛛の糸、黒真珠、ナイトシェイド"
    ""
    "混乱 <Quas An Wis>"
    "- ナイトシェイド、マンドレイク"
    ""
    "恐怖 <In Quas Corp>"
    "- 大蒜、ナイトシェイド、マンドレイク"
    )
   result-ok))

(mk-reusable-item
 't_spell_book_enchantment_miscellanea "結界: 雑録" s_manual (/ norm 3)
 (lambda (kbook kuser)
   (kern-ui-page-text
    "結界: 雑録"
    "┌────────────────────┐"
    "│　　[ぼやけた文字]の秘術！[にじみ]　　　│"
    "│　[意味不明な文字]から隠された[染み]　　│"
    "│AN EX WIS -                  - KAL QUAS │"
    "└────────────────────┘"
    "高速化 <Rel Tym>"
    "- 硫黄の灰、血の苔、マンドレイク"
    ""
    "透視 <Wis An Ylem>"
    "- 硫黄の灰、マンドレイク"
    ""
    "不可視 <Sanct Lor>"
    "- 血の苔、ナイトシェイド、マンドレイク"
    ""
    "念力 <In Rel Por>"
    "- 蜘蛛の糸、血の苔、黒真珠"
    ""
    "毒風 <In Nox Hur>"
    "- 硫黄の灰、血の苔、ナイトシェイド"
    ""
    "催眠風 <In Zu Hur>"
    "- 人参、血の苔、マンドレイク"
    ""
    "時間停止 <An Tym>"
    "- 大蒜、血の苔、マンドレイク"
    )
   result-ok))


;;;;;;;;;;;;;;;;;;;; Illusions, Misdirections, and Schemes ;;;;;;;;;;;;;;;;;;;;

(mk-reusable-item
 't_spell_book_illusion_1 "幻覚: 下級秘伝" s_manual (/ norm 3)
 (lambda (kbook kuser)
   (kern-ui-page-text
    "幻覚: 下級秘伝"
    "┌────────────────────┐"
    "│　　　　汝はならず者か魔術師か？　　　　│"
    "│　　　策略が　狡猾さが　汝を生かす　　　│"
    "│　これらの呪文を使うべし　調合し唱えよ　│"
    "└────────────────────┘"
    "煙幕 <Bet Ylem Hur>"
    "- 硫黄の灰"
    ""
    "罠探知 <Wis Sanct>"
    "- 硫黄の灰"
    ""
    "催眠 <Xen Zu>"
    "- 人参、蜘蛛の糸"
    ""
    "対蜘蛛 <An Xen Bet>"
    "- 大蒜、蜘蛛の糸"
    )
   result-ok))

(mk-reusable-item
't_spell_book_illusion_2 "幻覚: 上級秘伝" s_manual (/ norm 3)
 (lambda (kbook kuser)
   (kern-ui-page-text
    "幻覚: 上級秘伝"
    "┌────────────────────┐"
    "│汝は泥棒の王か　覆い隠された魔術師か？　│"
    "│最高の策略　　　　　　　　　　　　　　　│"
    "│　　たぐいまれな狡猾さ　　　　　　　　　│"
    "│　　　　日々を生き延びる　　　　　　　　│"
    "│　　　　　　調合し呪文を唱えよ　　　　　│"
    "│　　　　　　　　　警告　　　　　　　　　│"
    "│愚か者に汝を苦しめさせるな　　　　　　　│"
    "└────────────────────┘"
    "混乱 <Quas An Wis>"
    "- ナイトシェイド、マンドレイク"
    ""
    "魅了 <An Xen Ex>"
    "- 蜘蛛の糸、黒真珠、ナイトシェイド"
    ""
    "恐怖 <In Quas Corp>"
    "- 大蒜、ナイトシェイド、マンドレイク"
    ""
    "不可視 <Sanct Lor>"
    "- 血の苔、ナイトシェイド、マンドレイク"
    )
   result-ok))


;;;;;;;;;;;;;;;;;;;; Divination Magick ;;;;;;;;;;;;;;;;;;;;

(mk-reusable-item
't_spell_book_divination "予知の秘儀" s_manual (/ norm 3)
 (lambda (kbook kuser)
   (kern-ui-page-text
    "予知の秘儀"
    "┌────────────────────┐"
    "│    IN WIS - AN QUAS - VAS KAL EX WIS   │"
    "│ああ探求者よ汝は賢きものか？わが謎を解け│"
    "│我は探求者を探求する　我は倒すものを倒す│"
    "│我はならず者を騙す　　我は職人を作る　　│"
    "│　　　　　　　　我は誰？　　　　　　　　│"
    "└────────────────────┘"
    "罠探知 <Wis Sanct>"
    "- 硫黄の灰"
    ""
    "罠解除 <An Sanct Ylem>"
    "- 血の苔"
    ""
    "位置 <In Wis>"
    "- ナイトシェイド"
    ""
    "千里眼 <In Quas Wis>"
    "- ナイトシェイド、マンドレイク"
    ""
    "可視 <Wis Quas>"
    "- 硫黄の灰、ナイトシェイド"
    ""
    "透視 <Wis An Ylem>"
    "- 硫黄の灰、マンドレイク"
    )
   result-ok))


;;;;;;;;;;;;;;;;;;;; Master Spellbook ;;;;;;;;;;;;;;;;;;;;

(mk-reusable-item
 't_basic_spell_book "呪文書" s_manual (/ norm 3)
 (lambda (kbook kuser)
   (kern-ui-page-text
    "呪文書"
    ""
    "┌────────────────────┐"
    "│　　　 Mで秘薬を調合し呪文を作れ　　　　│"
    "│　　　 Cでしかるべきときに唱えよ　　　　│"
    "│　　　この碑は汝の役に立つであろう　　　│"
    "│　嗚呼　だが　読むときは注意すべし！　　│"
    "└────────────────────┘"
    "                                           "
    "………………………　秘薬　………………………"
    "人 人参                     蜘 蜘蛛の糸    "
    "大 大蒜                     黒 黒真珠      "
    "硫 硫黄の灰                 血 血の苔      "
    "ナ ナイトシェイド           マ マンドレイク"
    "ロ ロイヤルケープ茸                        "
    "………………………　呪文　………………………"
    "───────── 第一陣 ─────────"
    "An Nox           解毒           人  大     "
    "An Zu            覚醒           人  大     "
    "Grav Por         魔法の矢       硫  黒     "
    "In Lor           光             硫         "
    "Mani             小回復         人  蜘     "
    "Wis Sanct        罠探知         硫         "
    "An Sanct Ylem    罠解除         血         "
    "Ylem An Ex       網             蜘  黒     "
    "Bet Ylem Hur     煙幕           硫         "
    "───────── 第ニ陣 ─────────"
    "Sanct Nox        耐毒           ナ  大  ロ "
    "An Sanct         開錠           硫  血     "
    "Sanct            施錠           硫  蜘     "
    "An Xen Corp      不死還         大  硫     "
    "In Wis           位置           ナ         "
    "In Bet Xen       虫召還         蜘  血  硫 "
    "Rel Hur          風変化         硫  血     "
    "In Nox Por       毒撃           ナ  血  黒 "
    "An Xen Bet       対蜘蛛         蜘  大     "
    "Bet Flam Hur     火霧           黒  硫  血 "
    "In Quas Wis      千里眼         ナ  マ     "
    "Xen Zu           催眠           蜘  大     "
    "───────── 第三陣 ─────────"
    "In Flam Grav     火炎場         硫  黒  蜘 "
    "In Nox Grav      毒場           ナ  黒  蜘 "
    "In Zu Grav       催眠場         人  黒  蜘 "
    "Vas Flam         火球           黒  硫     "
    "Vas Lor          強光           硫  マ     "
    "In Flam Sanct    耐火           大  硫  ロ "
    "Vas An Nox       全解毒         マ  大  人 "
    "An Ort Xen       脱魔法         大  マ  硫 "
    "───────── 第四陣 ─────────"
    "An Grav          脱魔法場       黒  硫     "
    "In Sanct Grav    障壁           マ  黒  蜘 "
    "In Sanct         保護           硫  人  大 "
    "Wis Quas         可視           ナ  硫     "
    "Bet Por          跳躍           黒  血     "
    "Vas Sanct Nox    全耐毒         マ ナ 大 ロ"
    "Ort Grav         雷撃           黒  マ  硫 "
    "───────── 第五陣 ─────────"
    "In Ex Por        封印解除       硫  血     "
    "An Ex Por        封印           硫  血  大 "
    "In Zu            全催眠         人  ナ  蜘 "
    "Vas Mani         大回復         人  蜘  マ "
    "Rel Tym          高速化         硫  血  マ "
    "Kal Xen          獣召還         蜘  マ     "
    "Rel Xen Quas     獣幻視         ナ  血     "
    "───────── 第六陣 ─────────"
    "In An            沈黙           大  マ  硫 "
    "Wis An Ylen      透視           マ  硫     "
    "An Xen Ex        魅了           黒  ナ  蜘 "
    "In Vas Por Ylem  地震           血  マ  硫 "
    "Quas An Wis      混乱           マ  ナ     "
    "Vas Uus Ylem     引揚           マ  血  蜘 "
    "In Rel Por       念力           黒  血  蜘 "
    "Vas Por          瞬間移動       マ  黒  血 "
    "───────── 第七陣 ─────────"
    "In Nox Hur       毒風           ナ  硫, 血 "
    "In Zu Hur        催眠風         マ  人  血 "
    "In Quas Corp     恐怖           ナ  マ  大 "
    "Sanct Lor        不可視         ナ  マ  血 "
    "Xen Corp         死             ナ  黒     "
    "In Quas Xen      複製           ナマ硫蜘血人"
    "───────── 第八陣 ─────────"
    "Kal Xen Nox      融解           蜘  マ  ナ "
    "In Flam Hur      炎風           マ  硫  血 "
    "In Vas Grav Corp 死風           マ  硫  ナ "
    "An Tym           時間停止       マ  大  血 "
    "Kal Xen Corp     不死召還       蜘  マ  ナ "
    "In Mani Corp     蘇生           大人蜘硫血マ"
    "Vas Rel Por      門             硫  マ  黒 "
    )
   result-ok))
   
;;----------------------------------------------------------------------------
;; Anaxes letters
(mk-reusable-item
 't_anaxes_letter "アナクシズ宛ての手紙" s_scroll v-hard
 (lambda (kletter kuser)
   (kern-ui-page-text
    "手紙"
    ""
    "アナクシズ、"
    ""
    "私の最愛の人へ。十二人はあなたを追放しました。"
    "(ラクシマニは彼らを徹底的に脅していました。)"
    "彼は古い信仰を禁止する命令を発令しました。そし"
    "て彼以外の神を信じるものは、みな呪われた者だと"
    "言っています。"
    ""
    "これを書いている今、グラスドリンとトゥーレマン"
    "の大軍がブルンデガードを目指しています。私は彼"
    "らがあなたのもとに到着する前に倒しに行きます。"
    "入り口を封印し、私の犠牲が無駄にならないように"
    "してください。"
    ""
    "愛する人、おぼえていてください。私はあなたを決"
    "して裏切りません。霊となって虚空で会いましょ"
    "う。そしてヴァレが私たちの敵にその代償を払わせ"
    "ますように。"
    ""
    "愛する、"
    "　イシン"
    ""
    "追伸　タイタンは安全です。彼らを見たものはみな"
    "倒されました。"
    )
   result-ok))

;;----------------------------------------------------------------------------
;; Stewardess's Journal
;;
;; TODO: update last entry time to match when warritrix quest becomes available
;; Journal should not be updated if stolen by wanderer (This would also destroy its applicability as evidence)
;;
(mk-reusable-item 
 't_stewardess_journal "ヴィクトリアの日記" s_lexicon norm
 (lambda (klexicon kuser)
   (kern-ui-page-text
    "ヴィクトリアの日記"
    ""
    "1610年1月3日"
    "もし闘士がもっと有名になったら、彼女は公然と私"
    "を批判するだろう。過激な手段を取るかもしれな"
    "い。恐ろしいことだ。注意しなくては。もしかする"
    "と「我らの友」が助けになるかもしれない。彼らに"
    "は大きな貸しがある。信用できるかはわからない"
    "が。"
    ""
    "…"
    ""
    "1610年11月13日"
    "ついにヴァルスという疫病を追いやることができ"
    "た。うってつけの少しの証拠、いくつかの不快なう"
    "わさ。彼が逸脱した大酒のみであるということを大"
    "衆が受け入れる準備が整ったのだ。もし彼を独房に"
    "拘留しなければ、絶望した愚か者が向こう見ずにも"
    "像を打ったであろう。像の力は神話かもしれない。"
    "しかし賭けの機会を与えるべきではない。"
    ""
    "…"
    ""
    "1611年4月1日"
    "Ｓが迷い人のうわさが広まっていると知らせてき"
    "た。Ｓは本当に便利な道具だ。彼がどこで情報を得"
    "ているのか知りたいものだ。しかしなぜ彼は迷い人"
    "のことをそんなに気にしているのだろうか。彼らの"
    "伝説は誇張されたものに違いない。最後に迷い人が"
    "現れたのは古い神々かこのシャルドを闊歩していた"
    "ときだ。もし神話が事実ならば、だが。"
    ""
    "…"
    ""
    "1611年6月12日"
    "Ｓから準備は全て整ったとの言葉を受け取った。"
    "ジェフリーズに、失われた殿堂を占拠している調査"
    "すべき凶暴な巨人がいる、といううわさを提案する"
    "つもりだ。そうすれば闘士が名乗り出るだろう。彼"
    "女らは妖術師ではなく、巨人のクズどもがいると予"
    "想するはずだ。Ｓは彼女らの背後の道を封鎖するこ"
    "とを約束してくれた。逃げ道はない。仮にあったと"
    "しても、私の罪が問われることはない。そのときは"
    "愚かなジェフリーズが解任されるだけだ。"
    ""
    "私を批判しうるのはこの日記だけだ。しかし誰も見"
    "つけることはできないだろう。そしてもし私がこの"
    "シャルド全土の女王になったときには、歴史家はこ"
    "の日記を必要とするだろう。"
    ""
    "…"
   )
   result-ok))
