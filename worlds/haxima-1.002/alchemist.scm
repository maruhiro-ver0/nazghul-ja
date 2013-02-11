;;----------------------------------------------------------------------------
;; 錬金術師は賢者の一人として数えられる。しかし、彼はあまりよい人ではない。彼
;; はとても有能で、とても欲深く、そして人をだますことを好む。また彼には多くの
;; 知識がある。彼はトリグレイブの忘れられた石版のありかを知っている。そして魔
;; 道師は石版は何のためにあるか知っている。彼は北西のにんげんの隠れ家の場所を
;; 知っている。
;;
;; 錬金術師はヒドラ、竜、そしてリッチの血を手に入れるととても喜ぶ。彼は金を払
;; えば薬の作り方を教えるかもしれない?
;;----------------------------------------------------------------------------
;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; オパーリン
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_alch
               (list 0   0  alkemist-shop "idle")
               (list 2   0  alkemist-bed  "sleeping")
               (list 8   0  bilge-water-seat-9   "eating")
               (list 9   0  alkemist-shop "working")
               (list 12  0  bilge-water-seat-9 "eating")
               (list 13  0  alkemist-shop "working")
               (list 17  0  bilge-water-seat-9 "eating")
               (list 18  0  bilge-water-hall "idle")
               (list 19  0  sea-witch-shop   "idle")
               (list 20  0  alkemist-shop "idle")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (alch-mk)
	(list
        (mk-quest) ;; dragon
        #f ;; lich
        #f ;; hydra
        ))


(define (alchq-dragon gob) (car gob))
(define (alchq-lich? gob) (cadr gob))
(define (alchq-hydra? gob) (caddr gob))
(define (alchq-lich! gob val) (set-car! (cdr gob) val))
(define (alchq-hydra! gob val) (set-car! (cddr gob) val))

;;----------------------------------------------------------------------------
;; Conv
;;----------------------------------------------------------------------------

(define alch-catalog
  (list
   (list t_heal_potion             18 "戦いの真っ只中でマニ<Mani>や魔力がなくなっても、これがあれば助かるだろう！")
   (list t_cure_potion             18 "アン・ノクス<An Nox>の方が安上がりだ。だが私の治癒の薬より効くものはないだろう！")
   (list t_mana_potion             18 "他の薬では私のもののように魔力を取り戻せないであろう！")
   
   (list t_poison_immunity_potion  18 "予防は治癒に勝る！私の免疫の薬があればもう毒を恐れる必要はない！")
   (list t_invisibility_potion    100 "これを飲んだ者は敵に見つかることはないだろう！")
   (list t_str_potion             999 "この薬でトロルの腕力は君のものだ！" )  ;; limited stock would be nice...
   (list t_dex_potion             999 "この薬を飲めば、君の矢は真実のようにまっすぐに飛ぶだろう！")  ;; limited stock would be nice...
   (list t_int_potion             999 "知のある者はより知を求める！この薬はお手ごろ価格でそんな君になれるだろう！")  ;; limited stock would be nice...
   (list t_info_potion            150 "聖人は言った。汝自身を知れ。この薬はその助けとなるだろう！")
   
   (list t_oil                      6 "敵に炎を浴びせろ！君の側面を守り、死の炎の囲みに逃げ込め！")
   (list t_slime_vial              25 "これは最高に楽しい！分裂する粘液の部隊で敵をかく乱しろ！")
   ))

(define alch-merch-msgs
  (list "残念だが私の店は今は開いていない。午前9時から午後5時の間に来てくれたまえ。"
        "もちろん君が好きそうな物もあるぞ！［彼はもみ手をした。］"
        "使った物も買い取るぞ…もちろん値は下がるが。"
        "そうだ。さあ商売を始めよう！"
        "私の薬がどれほど良いかわかったら、もっと手に入れるためにここに来るだろう！"
        "このすばらしい薬を買わなかったことを後悔することがなければよいが。"
        "使い道がありそうだ。"
        "別のもっといい買い手がいるとは思えないが。"
        "いい取り引きができたな！"
        "次はたのむぞ。"
        ))

;; Basics...
(define (alch-hail knpc kpc)
  (say knpc "［あなたは背が低く、長い鼻の太った老人と会った。］"
       "こんにちは。そしていらっしゃい、旅の方！"))

(define (alch-default knpc kpc)
  (say knpc "残念だが助言はできないな。"))

(define (alch-name knpc kpc)
  (say knpc "錬金術師として知られている。")
  (quest-data-update 'questentry-alchemist 'found 1)
  (quest-data-complete 'questentry-alchemist)
  )

(define (alch-join knpc kpc)
  (say knpc "忙しすぎる！そして冒険には歳をとり過ぎている。"))

(define (alch-job knpc kpc)
  (say knpc "薬を作る、道楽で謎を解いてみる、そんなところだ。"
       "何か欲しいものがあれば言ってくれ！"))

(define (alch-bye knpc kpc)
  (say knpc "さようなら！！また来なさい！"))

;; Trade...
(define (alch-trade knpc kpc) (conv-trade knpc kpc "trade" alch-merch-msgs alch-catalog))
(define (alch-buy knpc kpc) (conv-trade knpc kpc "buy" alch-merch-msgs alch-catalog))
(define (alch-sell knpc kpc) (conv-trade knpc kpc "sell" alch-merch-msgs alch-catalog))

;; Rune...
;; offered: shown k rune
;; accepted: sent to find p rune
;; done: known to have found p rune
(define (alch-dragon-reward knpc kpc)
  (say knpc "ああ、そうだ、石版は…")
	(prompt-for-key)
  (say knpc
	   "聖騎士はクロポリスの地下にいくつかの砦を築いている。"
	   "石版の一つが最も深い砦に埋もれているのだ。")
	(prompt-for-key)
  (say knpc
	   "つるはしとシャベルがあれば掘り出せるだろう。"
	   "だが、問題なのは君に付きまとう何人もの聖騎士がいることだ。")
	   (quest-data-assign-once 'questentry-rune-p)
	   (quest-rune-p-update)
	   )
	   
(define (alch-dragon-done knpc kpc)
  (say knpc "残念だが他の石版のありかはわからない。"
					"別の賢者に聞いてみるとよいだろう。"))
		
(define (alch-dragon-quest knpc kpc qstat)
	(if (kern-conv-get-yes-no? kpc)
		(cond
			((quest-done? qstat)
				(alch-dragon-done knpc kpc)
				)
			((in-inventory? kpc t_rune_p)
				(quest-done! qstat #t)
				(say knpc "どうやら力の石版を見つけたようだな。")
				(alch-dragon-done knpc kpc)
				)
			((quest-accepted? qstat)
				(alch-dragon-reward knpc kpc qstat)
				)
			((in-inventory? kpc t_dragons_blood 1)
			  (begin
				(say knpc "その一つがどこに隠されているか知っている。"
					 "竜の血を1ビン持ってくれば、交換で教えよう。"
					 "どうするかね？")
				(if (kern-conv-get-yes-no? kpc)
					(begin
						  (quest-accepted! qstat #t)
						  (kern-obj-remove-from-inventory kpc 
														  t_dragons_blood 
														  1)
						  (kern-obj-add-to-inventory knpc
													 t_dragons_blood
													 1)
						  (say knpc "［彼は飢えた目でビンを見た。］"
							   "そうだ、これこそが私が求めていたものだ！")
							(quest-data-update 'questentry-dragon 'done 1)
							(quest-data-complete 'questentry-dragon)
							(quest-data-assign-once 'questentry-dragon)
						  (alch-dragon-reward knpc kpc))
					(begin
						(say knpc "ううむ、私の助けがなくても、シャルド中を掘り返せばいつかは見つかるだろう。"
						"がんばりたまえ！")
						(quest-data-assign-once 'questentry-dragon)
					))
				))
			(#t
				(say knpc "ならば交換だ。"
				   "その一つがある遺跡に埋もれていると偶然聞いた。"
				   "竜の血を1ビン持ってくれば、その場所を教えよう。")
				(quest-data-assign-once 'questentry-dragon)))
		(say knpc "ううむ、ならばよい。その一つの隠し場所を知っているのだが。")))

(define (alch-more knpc kpc)
	(let ((qstat (alchq-dragon (gob knpc))))
		(say knpc "エイブは石版のことをよく知っている。"
			"別の石版も探してみたいとは思わんかね？")
		(quest-data-update-with 'questentry-runeinfo 'abe 1 (quest-notify nil))
		(alch-dragon-quest knpc kpc qstat)
	))
		   
(define (alch-rune knpc kpc)
	(if (not (null? (quest-data-getvalue 'questentry-dragon 'rerune)))
		(alch-more knpc kpc)
		(begin
			(say knpc "［彼は色めき立った。］石版だと？今までに何度か見たことがある。"
			   "君のを見せてくれないか？")
			(if (kern-conv-get-yes-no? kpc)
				(if (in-inventory? kpc t_rune_k 1)
					(begin
					  (say knpc "やはりそうだ。これはかつて魔道師が持っていたものだと思う。"
						   "盗んだものではないと思いたいな！"
						   "同じようなものをいくつかみたことがある。"
						   "君が本当に会って話さなければならないのはエイブだ。")
							(quest-data-update 'questentry-dragon 'rerune 1)
						   (quest-data-update-with 'questentry-runeinfo 'abe 1 (quest-notify nil))
					  )
					(say knpc "どこにもないぞ。もしやなくしたのか？"))
				(say knpc "見せてくれれば手助けできるかもしれない。")))
		))

(define (alch-abe knpc kpc)
  (say knpc "私の古くからの知り合いだ。"
       "今は緑の塔で遺跡を調べていると聞いている。"))

(define (alch-drag knpc kpc)
  (say knpc "実際には見たことがない。"
       "しかし、竜の血を手に入れるためには、竜を倒さなければならないだろう！"
       "火の海のあたりでは牛のようにありきたりのものだと聞いた。"
			)
	(quest-data-update-with 'questentry-dragon 'sea 1 (quest-notify nil)))


;; The Wise...
(define (alch-necr knpc kpc)
  (say knpc "死霊術師とは古くからの知り合いだ。"
       "アブサロットが崩壊して以来、地下世界に引きこもっている。"
       "哀れなことだ。だが、あれから会っていない。"))

(define (alch-ench knpc kpc)
  (say knpc "魔道師は偉大で知識のある魔術師だ。"
       "残念だが彼とは意見が合わないことが多い。"
       "最近は呪われた者のことばかり気にしている。"
       ))

(define (alch-man-reward knpc kpc)
	(say knpc "北東の山脈に、南側に面した秘密の入り口がある。座標は[92,10]だ。"))

(define (alch-man knpc kpc)
  (let ((qstat (gob knpc)))
	  (say knpc "にんげんとは会ったことがない。"
		   "最も老獪なならず者という存在だ。"
		   "恐らく相当な富を隠れ家に蓄えているはずだ。"
		   "もし私が冒険者なら、自分自身で探し出そうとするだろう。"
		   "君はどうだ？")
	  (if (kern-conv-get-yes-no? kpc)
		(cond
			((alchq-hydra? qstat)
				(say knpc "信用できる者がにんげんの隠れ家の入り口がどこにあるか教えてくれた。")
				(alch-man-reward knpc kpc))
			((in-inventory? kpc t_hydras_blood 1)
				(begin
					(say knpc "信用できる者がにんげんの隠れ家の入り口がどこにあるか教えてくれた。"
						"それは君の持っている1ビンのヒドラの血と交換で教えよう。よいな？")
					(if (kern-conv-get-yes-no? kpc)
						(begin
							(alchq-hydra! qstat #t)
							(kern-obj-remove-from-inventory kpc 
								t_hydras_blood 
								1)
							(kern-obj-add-to-inventory knpc
								t_hydras_blood
								1)
							(say knpc "［彼はその毒物が欲しくてたまらなかったようだ。］"
								"おお、かわいい…かわいい！")
							(say knpc "ゴホン。")
							(alch-man-reward knpc kpc))
						(say knpc "残念だ。君が持っていても何の役にもたたない。"
							"そして私は取りに行くには年を取りすぎている。"))))
			(#t 
				(say knpc "ううむ、多くのことを聞いたことがあるが、ほとんどはただのうわさだ。"
					"だが、信用できる者がにんげんの隠れ家の入り口がどこにあるか教えてくれた。"
					"もし1ビンのヒドラの血を持ってくるなら、その秘密を君に明かそう。")))
	   (say knpc "何ということだ、迷い人よ！"
			"君は冒険者だと思っていたよ。"))))

(define (alch-hydr knpc kpc)
  (say knpc "ヒドラは最も困難な敵だ。"
       "ただ切りつけると、それはより強くなるだけだと聞いた！"
       "だが、殺すことができれば、その血には知る人ぞ知るすばらしい価値がある。"))

(define (alch-warr knpc kpc)
  (say knpc "闘士とは数回会ったことがある。"
       "彼女の残忍さは伝説的だ。"
       "だが、見た目にはとても物静かで優雅だ。"
       "アブサロットの破壊に参加するのを拒んだと聞いた。"))

(define (alch-engi knpc kpc)
  (say knpc "技師とは会ったことがない。"
       "本物の隠遁者だと聞いた。"))

(define (alch-alch knpc kpc)
  (say knpc "そう、それは私だ。私が錬金術師だ。")
  (quest-data-update 'questentry-alchemist 'found 1)
  (quest-data-complete 'questentry-alchemist)
  )


;; Absalot...
(define (alch-absa-reward knpc kpc)
	(say knpc "火の川を見渡せる場所に砦があった。"
		 "グラスドリンに侵攻され、残念だがそこには人はいない。"
		 "怪物どもが居座っていれば、そこを通るのは危険だ。")
	(prompt-for-key)
	(say knpc 
		 "だが、砦への古い迂回路があるのだ。"
		 "最初の洞窟の東側の壁を調べろ。"
		 "隠し通路が見つかるはずだ。")
	(prompt-for-key)
	(say knpc
		 "それでも火の川を渡る必要がある。"
		 "川に石像がある。それに合言葉「責任」と言えば安全に渡れる。"
		 "合言葉を書きとめておけ！")
	(prompt-for-key)
	(say knpc
		 "隠し通路は失われた町の近くの坂道で通常の道と再び合流する。"
		 "途中どんな危険があっても逃げられないが、この方法ならより簡単にたどり着けるはずだ。"))

(define (alch-absa knpc kpc)
  (let ((qstat (gob knpc)))
    (say knpc "アブサロットへの道のりは、崩壊の前でさえ常に危険だった。"
         "そこへ行ってみようと思うかね？")
    (if (kern-conv-get-yes-no? kpc)
        (cond
         ((alchq-lich? qstat)
          (alch-absa-reward knpc kpc))
         ((in-inventory? kpc t_lichs_blood 1)
          (say knpc "その1ビンのリッチの血と交換で、喜んで裏道を教えよう。"
               "どうするかね？")
          (if (kern-conv-get-yes-no? kpc)
              (begin
                (alchq-lich! qstat #t)
                (kern-obj-remove-from-inventory kpc 
                                                t_lichs_blood 
                                                1)
                (kern-obj-add-to-inventory knpc
                                           t_lichs_blood
                                           1)
                (say knpc "［彼はウィンクし、ほほえんだ。］まさにこれが求めていたものだ！")
                (alch-absa-reward knpc kpc))
              (say knpc "わかった。"
                   "間違いなく君にはその血を使った重要な計画があるのだな。"
                   "私は常に別の冒険者から手に入れることができる。")))
         (else
          (say knpc "1ビンのリッチの血を持ってくるのだ。"
               "そうすれば秘密の通路を教えよう。")))
        (say knpc "今となってはただの廃墟だ。"
             "略奪にあったとき、全てが崩壊した。"))))

(define (alch-sack knpc kpc)
  (say knpc "ああそうだ。知っているか？"
       "アブサロットはグラスドリン、緑の塔、そしてオパーリンの軍隊によって略奪された。"
       "彼らが言うには、アブサロットはその邪悪さで崩壊したのだそうだ。［彼は冷ややかに笑った。］"))

(define (alch-esca knpc kpc)
  (say knpc "何…私がそう言ったのか？"
       "なぜそんなことを言ったのだろうか。"
       "アブサロットから逃げようとした者は、首を切り落とされ処刑された。"))

(define (alch-wick knpc kpc)
  (say knpc "そう、アブサロットは非常に邪悪だったので、全ての男、女、子供が剣で切り殺された。"
       "我々にとって幸運だったのは、聖騎士たちはそれを正義のための行いだと信じていたことだ！"
       "［あなたは彼のつりあがった眉と率直な言い方に、反語的なほのめかしを感じ取った。］"))

(define (alch-lich knpc kpc)
  (say knpc "リッチは不死の魔術師だ。この禁断の存在は、触れたもの全てを崩壊させることができ、"
       "そして不死の軍団を操ることができる。その血は死霊術において多くの使い道がある。"
       "それは私の専門ではないがな。"))

;; The Accursed...
(define (alch-accu knpc kpc)
  (say knpc "呪われた者とされているのは、多くの憎むべきものごとの原因とされている秘密の集団だ。"
       "だが、どこまでがうわさだと誰が言えるのだろうか？"))

;; Townsfolk
(define (alch-lia knpc kpc)
  (say knpc "魅力的な存在だ！"
       "もし可能ならば、彼女の呪いを解いてやりたい。もっと言えば、タダでしてもよい。"
       "おろかな年寄りと言ってくれ！"))

(define alch-conv
  (ifc basic-conv
       (method 'default alch-default)
       (method 'hail alch-hail)
       (method 'bye alch-bye) 
       (method 'job alch-job)
       (method 'name alch-name)
       (method 'join alch-join)

       (method 'trad alch-trade)
       (method 'buy  alch-buy)
       (method 'sell alch-sell)
       (method 'poti alch-buy)

       (method 'rune alch-rune)
       (method 'more alch-more)
       (method 'drag alch-drag)

       (method 'necr alch-necr)
       (method 'ench alch-ench)
       (method 'man  alch-man)
       (method 'hydr alch-hydr)
       (method 'warr alch-warr)
       (method 'engi alch-engi)
       (method 'alch alch-alch)

       (method 'absa alch-absa)
       (method 'sack alch-sack)
       (method 'esca alch-esca)
       (method 'wick alch-wick)
       (method 'lich alch-lich)

       (method 'accu alch-accu)

       (method 'lia alch-lia)
       (method 'abe alch-abe)

       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-alchemist)
  (bind 
   (kern-char-arm-self
    (kern-mk-char 
     'ch_alchemist ;;.....tag
     "錬金術師" ;;.......name
     sp_human ;;.....species
     oc_wright ;;...occupation
     s_companion_tinker ;;......sprite
     faction-men ;;..faction
     0 ;;............custom strength modifier
     4 ;;............custom intelligence modifier
     1 ;;............custom dexterity modifier
     0 ;;............custom base hp modifier
     0 ;;............custom hp multiplier (per-level)
     0 ;;............custom base mp modifier
     0 ;;............custom mp multiplier (per-level)
     max-health ;;..current hit points
     -1  ;;...........current experience points
     max-health ;;..current magic points
     0
     8  ;;..current level
     #f ;;...........dead?
     'alch-conv ;;...conversation (optional)
     sch_alch ;;.....schedule (optional)
     'townsman-ai ;;..........custom ai (optional)
     nil ;;..........container (and contents)
     (list t_dagger
				t_armor_leather
				)  ;;......... readied arms (in addition to the container contents)
     nil ;;..........hooks in effect
     ))
   (alch-mk)))
