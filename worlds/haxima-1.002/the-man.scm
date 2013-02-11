;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define the-man-start-lvl 9)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; 安全に隠された場所にあるにんげんの隠れ家
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_man
               (list 0  0 mans-bed    "sleeping")
               (list 7  0 mans-supper "eating")
               (list 8  0 mans-hall   "idle")
               (list 12 0 mans-supper "eating")
               (list 13 0 mans-tools  "idle")
               (list 15 0 mans-hall   "idle")
               (list 18 0 mans-supper "eating")
               (list 19 0 mans-dock   "idle")
               (list 22 0 mans-bed    "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (man-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; 「にんげん」として知られるイヴォンヌは卓越した技術を持ったならず者の女性で
;; ある。安全な知られていない場所(にんげんの隠れ家)に住んでいる。
;;----------------------------------------------------------------------------

;; Basics...
(define (man-hail knpc kpc)
  (say knpc "［あなたは人を引きつけるような、猫のように身軽な中年の女性と会った。］"
       "こんにちは。すてきな方。"))

(define (man-default knpc kpc)
  (say knpc "ぜひ見てみたいわ。"))

(define (man-name knpc kpc)
  (say knpc "私はイヴォンヌ、でも人はにんげんと呼ぶわ。"))

(define (man-join knpc kpc)
  (say knpc "魅力的な方、引かれるものがないとは言えないわね。でも、何かをするなら一人の方がいいわ。"))

(define (man-job knpc kpc)
  (say knpc "そうね。私の立ち位置をどこに置くか？答えは簡単、私はならず者よ。"))

(define (man-bye knpc kpc)
  (say knpc "バイバイ…"))


;; Misc
(define (man-man knpc kpc)
  (say knpc "［彼女は少し笑った。］もしかして…男だと思ってたかしら？")
  (kern-conv-get-yes-no? kpc)
  (say knpc "にんげん(MAN)は強欲な気質の女王(Mistress of Acquisitive Nature)の頭文字よ。"
       "気に入ってくれたかしら？")
  (kern-conv-get-yes-no? kpc)
  (say knpc "たしか技師が最初にそう呼んだと思うわ。"
       "こうやって作られた綴りにだまされるのね。"))

(define (man-wrog knpc kpc)
  (say knpc "ならず者とは規則破りの専門家よ。"
       "見知らぬ方よ、教えてくださいな。規則を破るのは好き？")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "［彼女は驚いたふりをした。それはとても魅力的だった。］"
           "悪い子ね！君が帰る前に平手打ちをして教育しなければならないわね。")
      (say knpc "おやおや、どうしてそんなに四角張っているの？四角張ったのは本当に好きよ。"
           "もしかするとそれで私を磨いてくれるのかしら？［彼女はあなたを無邪気に見た。］")))

(define (man-rule knpc kpc)
  (say knpc "規則、鍵、秘密、謎。私はそれらを全て壊し、その向こうにあるものを見たい。"
       "それは好奇心のため、そして挑戦のためよ。"
       "まわりを見て。ここにある莫大な富がわかるかしら？")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "はぁ。貧しい子供時代をすごしたのか、それとも何も見えていないのか。")
      (say knpc "いいえ。私はあだ名と違ってそんなに強欲ではないわ。"
           "私は「持つ」ことには興味はないの。ただ「する」だけよ。"
           "一度やってしまえば、その後には興味はない。"
           "私が求める最も興味深く価値あるものは、秘密そのものよ。")))

(define (man-secr knpc kpc)
  (say knpc "私で試してごらんなさい。"))

(define (man-enem knpc kpc)
  (say knpc "闘士の強力な敵はグラスドリンの統治者かも知れないわ。"))

(define (man-stew knpc kpc)
  (say knpc "彼女の日記を一度読んだことがあるの。"
       "本当は彼女を捕らえたほうがいいのかもしれない。"
       "彼女はアブサロットで背いた闘士を憎んでいるのよ。"))

(define (man-hate knpc kpc)
  (say knpc "統治者の日記を自分で読んでみなさい。"
       "どうすればいいか知りたい？")
  (if (yes? kpc)
      (say knpc "ただこの二つの言葉を覚えておけばいいわ。ウィス・クァス<Wis Quas>よ。"
           "あなたは鋭いからどこにあるかはわかるでしょう。")
      (say knpc "ああ、でもあなたは見落としているわ。"
           "これは政治的な謀略よ。")))


;; Wise Queries
(define (man-wiza knpc kpc)
  (say knpc "そう、とても強い。でも私は彼らの秘密を盗みたい。"))

(define (man-wrig knpc kpc)
  (say knpc "賢さの束、でも私が開けられない鍵はまだ作れないようね。"))

(define (man-warr knpc kpc)
  (say knpc "彼女はその優雅な振る舞いで知られている。"
       "私は彼女のことは詳しくは知らないけれど、その敵は、もしかすると彼女自身よりもよく知っているかもしれないわ。"))

(define (man-necr knpc kpc)
  (say knpc "便利な友達よ。"
       "死人は生きている人が忘れたたくさんのことを知っている。"
       "そして彼はどうやって聞き出すのか知っているのよ。"))

(define (man-alch knpc kpc)
  (say knpc "賢い人なのはわかってるけど、彼とは合わないわね。"))

(define (man-engi knpc kpc)
  (say knpc "彼の設計書の束に挑戦してみたいわ。"
       "でも、ああ、彼には隠している秘密も宝もないのよ！"))

(define (man-ench knpc kpc)
  (say knpc "私の最愛の魔術師。"
       "彼の話を聞きに行くのも、その高潔な性格も大好きよ！"
       "でも自分の物はもっとちゃんとしまって置くべきね。"))

;; Accursed Queries
(define (man-accu knpc kpc)
  (say knpc "彼らが自由について話すとき、それは他者を奴隷にする自由を意味する。"
       "規則を破って彼らに加わった者もいるわ。でもわかったのは彼ら自身が鎖でつながれているということだけ。"
       "不快の束よ。"))


;; Rune
(define (man-rune knpc kpc)
  (say knpc "石版…かつて海賊が持っていたのを知っているわ。"
       "ガーティーと「慈悲深い死」号の話を知っているかしら？")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "いろいろ旅してるのね。経験豊かな人は好きよ。")
      (say knpc "オパーリンでガーティーについて聞いてごらんなさい。"))
  (say knpc "もし慈悲深い死を見つけたら、呪文で引き上げられるわ。"
       "呪文はわかる？")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "まあ、あなたはあらゆる魔法を知っているの？"
           "愛の魔法は知らなければいいけれど、魔法使いさん！")
      (begin
			(say knpc "マンドレイク、血の苔、そして蜘蛛の糸を調合して、"
			"ヴァス・ウース・イェム<Vas Uus Ylem>と唱える。"
			"そして船が沈んだ場所を指し示しなさい。")
			(quest-data-update 'questentry-rune-c 'shipraise 1)
		)
	)
  (say knpc "ガーティーはタダでは船の場所を言わないでしょうね。"
       "でも死んでしまっても願望はあるわ。たとえ最悪の死に方をしても！"
       "ガーティーが望んでいるのは、ただ^c+m復讐^c-のみよ。"
       "この言葉を書き留めておきなさい。そして彼女の幽霊とあったとき思い出すのよ。")
	(quest-data-update 'questentry-rune-c 'info 1)
	(quest-data-assign-once 'questentry-rune-c)
	(quest-data-update 'questentry-ghertie 'ghertieid 1)
	(quest-data-update-with 'questentry-ghertie 'revenge 1 (quest-notify nil))
	(quest-data-assign-once 'questentry-ghertie)
	)

(define (man-chan knpc kpc)
  (say knpc "オンドリと会ったの？彼は私の居場所をしゃべったに違いないわ。"
       "はぁ。ええ、あの無責任なならず者は元気なようね。"))

(define man-conv
  (ifc basic-conv

       ;; basics
       (method 'default man-default)
       (method 'hail man-hail)
       (method 'bye  man-bye)
       (method 'job  man-job)
       (method 'name man-name)
       (method 'join man-join)
       
       ;; special
       (method 'man man-man)
       (method 'wrog man-wrog)
       (method 'rogu man-wrog)  ;; a synonym
       (method 'rule man-rule)
       (method 'secr man-secr)
       (method 'enem man-enem)
       (method 'stew man-stew)
       (method 'diar man-hate)
       (method 'evid man-hate)
       (method 'hate man-hate)
       (method 'wiza man-wiza)
       (method 'wrig man-wrig)
       (method 'warr man-warr)
       (method 'necr man-necr)
       (method 'alch man-alch)
       (method 'engi man-engi)
       (method 'ench man-ench)
       (method 'accu man-accu)
       (method 'rune man-rune)
       (method 'chan man-chan)
       ))

(define (mk-the-man)
  (bind 
   (kern-mk-char 'ch_man           ; tag
                 "にんげん"            ; name
                 sp_human            ; species
                 oc_wrogue           ; occ
                 s_brigandess        ; sprite
                 faction-men         ; starting alignment
                 0 3 10               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health ; hp
                 -1                   ; xp
                 max-health ; mp
                 0
                 the-man-start-lvl
                 #f                  ; dead
                 'man-conv         ; conv
                 sch_man           ; sched
                 'townsman-ai                 ; special ai
                 nil                 ; container
                 (list t_armor_leather_4
                 		t_leather_helm_2
                 		t_magic_axe)                 ; readied
                 )
   (man-mk)))
