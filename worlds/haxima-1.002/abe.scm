;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define abe-lvl 3)
(define abe-species sp_human)
(define abe-occ nil)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; 緑の塔
;;----------------------------------------------------------------------------
(define abe-bed gt-abe-bed)
(define abe-mealplace gt-ws-tbl2)
(define abe-workplace gt-ruins)
(define abe-leisureplace gt-ws-hall)
(kern-mk-sched 'sch_abe
               (list 0  0 abe-bed          "sleeping")
               (list 7  0 abe-mealplace    "eating")
               (list 8  0 abe-workplace    "working")
               (list 12 0 abe-mealplace    "eating")
               (list 13 0 abe-workplace    "working")
               (list 18 0 abe-mealplace    "eating")
               (list 19 0 abe-leisureplace "idle")
               (list 22 0 abe-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (abe-mk) (list #f))
(define (abe-met? gob) (car gob))
(define (abe-met! gob) (set-car! gob #t))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; エイブは石版のことをよく知る学者である。
;; 彼は錬金術師とともにアブサロットから逃れ、今は緑の塔に住んでいる。
;;----------------------------------------------------------------------------

;; Basics...
(define (abe-hail knpc kpc)
  (kern-print "あなたは若い学者風の男と会った。\n")
  (if (abe-met? (gob knpc))
      (say knpc "また会いましたね。")
      (begin
        (abe-met! (gob knpc))
        (say knpc "こんにちは。あの、もしかして迷い人？")
        (if (yes? kpc)
            (say knpc "あえて光栄です！自分の幸運が信じられない！"
                 "たくさん聞きたいことがあるんです。"
                 "もしよかったら時間があるときに聞かせてください。")
            (say knpc "ああ、それはそうだ。すみません。つい…気にしないでください。")))))

(define (abe-default knpc kpc)
  (say knpc "機会があったら調べておきます。"))

(define (abe-name knpc kpc)
  (say knpc "ああ、そう、僕はエイブ。"))

(define (abe-join knpc kpc)
  (say knpc "あ、いや、それはできません…僕はそういう人ではないので。"))

(define (abe-job knpc kpc)
  (say knpc "僕は学者です。緑の塔にある遺跡を調べています。もう見ましたか？")
  (if (no? kpc)
      (say knpc "遺跡は町の南西にあります。興味深いものです。")
      (begin
        (say knpc "地下にはもっとあることを知っていますか？")
        (yes? kpc)
        (say knpc "そう、アブサロットのように！"))))

(define (abe-absa knpc kpc)
  (say knpc "多くの人はアブサロットの下に古い町があることを知りません。"
       "アブサロットの地下の遺跡は、この緑の塔の遺跡ととてもよく似ています。"
       "僕は同じ文明の人々が建てたに違いないと確信しています！"))

(define (abe-rune knpc kpc)
  (if (any-in-inventory? kpc rune-types)
      (begin
	 (say knpc "［彼は静かにささやいた。］"
	     "悪魔の門の八つの鍵を持っているのですか？"
	     "調べさせてください！")
		(quest-data-update 'questentry-runeinfo 'abe 1)
	 (quest-data-update-with 'questentry-runeinfo 'keys 1 (quest-notify (grant-party-xp-fn 20)))
	(if (any-in-inventory? kpc (list t_rune_k))
	    (say knpc "［彼は石版を調べた。］これは知識の石版です！")
	    )
	(if (any-in-inventory? kpc (list t_rune_p))
	    (say knpc "［彼は石版を調べた。］これは力の石版です！")
	    )
	(if (any-in-inventory? kpc (list t_rune_s))
	    (say knpc "［彼は石版を調べた。］これは技能の石版です！")
	    )
	(if (any-in-inventory? kpc (list t_rune_c))
	    (say knpc "［彼は石版を調べた。］これは思慮の石版です！")
	    )
	(if (any-in-inventory? kpc (list t_rune_f))
	    (say knpc "［彼は石版を調べた。］これは自由の石版です！")
	    )
	(if (any-in-inventory? kpc (list t_rune_w))
	    (say knpc "［彼は石版を調べた。］これは理性の石版です！")
	    )
	(if (any-in-inventory? kpc (list t_rune_d))
	    (say knpc "［彼は石版を調べた。］これは分別の石版です！")
	    )
	(if (any-in-inventory? kpc (list t_rune_l))
	    (say knpc "［彼は石版を調べた。］これは統制の石版です！")
	    )
	(if (has-all-runes? kpc) 
	    (say knpc "信じられない！"
	         "八つの悪魔の門の鍵が全て揃っています！"
	         "これを一体どうするつもりですか？")
	    )
	)
      (say knpc "たくさんの石版があるそうです。実際に見ることができれば…。")))

(define (abe-demo knpc kpc)
  (say knpc "悪魔の門は遠い昔、賢者によって封印されました。"
       "その場所はあらゆる記録から消されました。しかし、言い伝えではどこか北のほうにあるそうです。")
		(quest-data-update 'questentry-runeinfo 'abe 1)
	     (quest-data-update 'questentry-runeinfo 'keys 1)
  		(quest-data-update-with 'questentry-runeinfo 'gate 1 (quest-notify (grant-party-xp-fn 30)))
       )

(define (abe-keys knpc kpc)
  (say knpc "はい。悪魔の門は封印され、鍵は八つに分けられました。"
       "それぞれが力を秘めた石版です。"
       "その後それらは失われたか、隠されました。"))
       
(define (abe-eigh knpc kpc)
	(say knpc "言い伝えでは石版は八つあるそうです。他の石版も探しているのですか？")
	(if (yes? kpc)
		(say knpc "古い話では、クロービス王の護符であっただとか、虚空の寺院にあるなどと言われています。")
		(say knpc "好奇心はないのですか？信じてください。私は知っています。")))

(define (abe-clov knpc kpc)
     (say knpc "伝説ではクロービス王が護符として持っていたそうです。"
           "彼はゴブリンとの戦争で命を落としました。しかし、その亡骸からは見つかりませんでした。"
           "誰かが(もしかすると^c+mゴブリンが^c-！)奪ったのかもしれません。")
           (quest-data-assign-once 'questentry-rune-f)
           )
           
(define (abe-temp knpc kpc)
	(say knpc "オパーリンの北西でその寺院は虚空の中に浮かんでいます。誰もたどり着くことができませんが、"
			"伝説ではずっと昔、石版が封印されたとされています。")
			(quest-data-assign-once 'questentry-rune-d)
			)
      
(define (abe-void knpc kpc)
  (say knpc "このシャルド、月、星々は全て広大な虚空の中にあるのです。"
       "かつて虚空を航行する船があり、海を渡るように虚空を渡ったそうです！")
       (quest-data-update 'questentry-whereami 'shard 2)
       )

(define (abe-ship knpc kpc)
  (say knpc "虚空船のことは聞いたことがあります。しかし、詳しいことはわかりません。"
       "職人の頂点ならその失われた造り方がわかるかもしれません。")
       (quest-data-update 'questentry-whereami 'shard 2)
       )

(define (abe-wrig knpc kpc)
  (say knpc "職人は物を作ることに長けた者たちです。"
       "技師は今日で最も偉大な職人です。"))

(define (abe-quee knpc kpc)
  (say knpc "何のことかよくわかりません。"))

(define (abe-civi knpc kpc)
  (say knpc "この遺跡を建てた文明のことはよくわかりません。でもその手がかりは、それが私たちの基準で見てとても醜いことにあります。何を意味するかわかりますか？")
  (if (yes? kpc)
      (say knpc "ならば言わないでおきましょう！")
      (say knpc "人の生贄、人肉食い、悪しき者への崇拝。呪われた者の習慣です！")))

(define (abe-accu knpc kpc)
  (say knpc "はい。呪われた者には長い歴史があります。彼らは便利な政治的な悪役かもしれません。"
       "しかし、彼らが行いや行ったこと、あるいは存在の証拠は十分にあります。"))

(define (abe-bye knpc kpc)
  (say knpc "遺跡について何かわかったら教えてください！"))

(define (abe-alch knpc kpc)
  (say knpc "ああ、あの古ダヌキですか？隣人同士でしたが最近は会っていません。"))

(define (abe-neig knpc kpc)
  (say knpc "アブサロットで。逃げる前はそこにいました。"))

(define (abe-flee knpc kpc)
  (say knpc "［ため息］話すと長くなります。周りの人に聞いてみてください。もうどうでもいいことです。"))

(define (abe-gobl knpc kpc)
  (say knpc "デリック隊長かジェンに聞いてみてください。彼らは多くのことを知っています。"))

(define abe-conv
  (ifc green-tower-conv

       ;; basics
       (method 'default abe-default)
       (method 'hail abe-hail)
       (method 'bye abe-bye)
       (method 'job abe-job)
       (method 'name abe-name)
       (method 'join abe-join)
       

       (method 'absa abe-absa)
       (method 'rune abe-rune)
       (method 'demo abe-demo)
       (method 'gate abe-demo)
       (method 'keys abe-keys)
       (method 'key  abe-keys)
       (method 'eigh abe-eigh)
       (method 'quee abe-quee)
       (method 'king abe-clov)
       (method 'clov abe-clov)
       (method 'char abe-clov)
       (method 'temp abe-temp)
       (method 'civi abe-civi)
       (method 'accu abe-accu)
       (method 'bye  abe-bye)
       (method 'ruin abe-job)

       (method 'void abe-void)
       (method 'ship abe-ship)
       (method 'sail abe-ship)
       (method 'wrig abe-wrig)
       (method 'alch abe-alch)
       (method 'neig abe-neig)
       (method 'flee abe-flee)
       (method 'esca abe-flee)
       (method 'gobl abe-gobl)
       ))

(define (mk-abe)
  (bind 
   (kern-mk-char 
    'ch_abe           ; tag
    "エイブ"          ; name
    abe-species         ; species
    abe-occ              ; occ
    s_companion_wizard ; sprite
    faction-men      ; starting alignment
    2 1 1            ; str/int/dex
    0 0              ; hp mod/mult
    0 0              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    abe-lvl
    #f               ; dead
    'abe-conv         ; conv
    sch_abe           ; sched
    'townsman-ai              ; special ai
    nil              ; container
    (list t_staff
					         t_armor_leather
					         )              ; readied
    )
   (abe-mk)))
