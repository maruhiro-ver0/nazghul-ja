;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; グラスドリン
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_jeff
               (list 0  0  gcj-bed      "sleeping")
               (list 7  0  gs-altar    "idle")
               (list 8  0  ghg-s6      "eating")
               (list 9  0  gc-hall     "working")
               (list 12 0  ghg-s3      "eating")
               (list 13 0  gc-train    "working")
               (list 18 0  ghg-s3      "eating")
               (list 19 0  ghg-hall    "idle")
               (list 21 0  gcj-bed      "sleeping")
               )

;; Make another schedule which will be assigned when Jeffreys resigns after the
;; trial.
(kern-mk-sched 'sch_jeff_resigned
               (list 0 0 kun-road "sleeping")
               (list 9 0 campfire-4 "idle")
               (list 13 0 cantina-5 "idle")
               (list 20 0 kun-road "idle")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (jeff-mk) nil)
               
;;----------------------------------------------------------------------------
;; Conv
;; 
;; ジェフリーズはグラスドリンの聖騎士たちの司令官である。
;; 彼はグラスドリンに住んでいて、そこで指導者、現在は統治者のヴィクトリアに直
;; 接報告している。
;;----------------------------------------------------------------------------

;; Basics...
(define (jeff-hail knpc kpc)
  (cond	((player-stewardess-trial-done?)
         (say knpc "迷い人よ、このことはわかってくれ。私は闘士を裏切ってはいない。待ち伏せのことは何も知らないのだ。"
              "だが、私はいくつかの点で間違っていたと思う。疑念を持ったときに行動すべきだった。"
              "グラスドリンの司令官は決して努力を怠ってはならない。"
              "ゆえに私は辞任したのだ。")
         (aside kpc 'ch_ini "知らなかったふりをするな、手先のヒキガエルめ。"
                "次に会ったときは、どちらかが滅びるまで戦うことになるだろう。")
         (kern-conv-end)
         )
        (else
         (say knpc "［あなたは立派な姿の聖騎士と会った。］よくぞ参られた。")
         )))

(define (jeff-default knpc kpc)
  (say knpc "そのようなことは手助けできない。"))

(define (jeff-name knpc kpc)
  (say knpc "司令官のジェフリーズである。"))

(define (jeff-join knpc kpc)
  (say knpc "私にはすでに仕事がある。"))

(define (jeff-job knpc kpc)
  (say knpc "グラスドリンの聖騎士を指揮することだ。"))

(define (jeff-bye knpc kpc)
  (say knpc "さらばだ。"))

;; Special
(define (jeff-comm knpc kpc)
  (say knpc "司令官はグラスドリンでの最高位の役職で、統治者を守る者だ。"
       "グラスドリンの軍は全て私の指揮下にある。"))

(define (jeff-mili knpc kpc)
  (say knpc "グラスドリンは難攻不落の都市だ。"
       "全ての市民には兵役の義務がある。全員が危機のときに戦えるよう、軍事訓練の基礎を受けているのだ。"))

(define (jeff-pala knpc kpc)
  (say knpc "グラスドリンの聖騎士はこのシャルドにおいて今日までで優れた戦士だ。"
       "個人の能力はもちろんだが、その強さは団結力から生まれるのだ。"))

(define (jeff-skil knpc kpc)
  (say knpc "そうだ。"
       "命令のもと新兵も闘士も一丸となって戦うグラスドリンの聖騎士が敗れることはない。"))

(define (jeff-warr knpc kpc)
  (cond ((player-found-warritrix?)
         (if (ask? knpc kpc "［ゴホン］そうだ。不幸なことだ。我々はみな彼女の死を悲しんでいる。"
                   "だが、部隊が全滅したのは彼女の判断にいくつもの誤りがあったからではないだろうか。"
                   "そう思わぬか？")
             (say knpc "その通りだ。それは我々の内の最高の者にも起こりうる。あらゆる軍の指導者も失敗を犯す可能性がある。"
                  "そしてそれは命に関わることだ。すまぬが今は忙しいのだ。さらばだ。")
             (if (ask? knpc kpc "何かの罠だったとでも言いたいのか？")
                 (say knpc "話にならぬ。何と答えればよいのか。"
                      "もし不満があるのであれば、統治者に言うがよい。"
                      "そして問題を起こすのであれば、衛兵がおまえをこの町から追い出すであろう。"
                      "実際には今すぐ立ち去るのが最もよいのだが。")
                 (say knpc "よろしい。戦いでは間違いが起こりうる。時には敵と見誤って友を殺すこともある。"
                      "気をつけることだな、友よ。さらばだ。")
                 ))
         (kern-conv-end)
         )
	 ((quest-data-assigned? 'questentry-wise)
         (say knpc "闘士、この時代で最も狡猾で多才な戦士は生ける宝だ。"
              "私は彼女が自分の倍もある男を倒し、恐ろしい獣たちを圧倒する姿を見たことがある。"
              "現在はある任務の遂行中である。")
              (quest-data-update 'questentry-warritrix 'assignment 1)
         )
	 (else
         (say knpc "闘士、この時代で最も狡猾で多才な戦士、は生ける宝だ。"
              "私は彼女が自分の倍もある男を倒し、恐ろしい獣たちを圧倒する姿を見たことがある。"
              "現在は警備に出ている。")
              (quest-data-update 'questentry-warritrix 'general-loc 1)
         )
	 ))

(define (jeff-warr-ready subfn)
	(if (quest-data-assigned? 'questentry-wise)
		(subfn)
		(jeff-default knpc kpc)
		))

(define (jeff-erra knpc kpc)
	(jeff-warr-ready (lambda ()
  (say knpc "［彼は少し難しそうな顔をした。］"
       "そうだ。彼女は部隊を引き連れ、失われた殿堂へ向かった。"
       "奇妙なことにあれから何の連絡もまだないのだ…"
       "通常なら捜索隊を出すところだが、今はそれに割ける部隊がいない。")
      (quest-data-update-with 'questentry-rune-l 'located 1 (quest-notify nil)) 
      (quest-data-update 'questentry-warritrix 'lost-hall 1)
       )))

(define (jeff-sear knpc kpc)
	(jeff-warr-ready (lambda ()
	(say knpc "［彼はいら立った。］闘士の捜索に割ける部隊はいない！"
	   "失礼する。私は忙しいのだ…")
  (kern-conv-end)
  (if (is-player-party-member? ch_ini)
      (say ch_ini "腐敗のにおいがする。"
           "彼女を探さねば！"))
  )))

;; Townspeople...
(define (jeff-glas knpc kpc)
  (say knpc "強固な町グラスドリンは侵略者によって陥落することはないであろう。"))

(define (jeff-ange knpc kpc)
  (say knpc "エンジェラは最も礼儀正しく、心優しい女性だ。"))

(define (jeff-patc knpc kpc)
  (say knpc "眼帯は経験豊かな医師で、我々の病院の院長だ。"))

(define (jeff-stew knpc kpc)
  (say knpc "統治者のヴィクトリアはよくその重みに耐えている。"))

(define (jeff-ini knpc kpc)
  (say knpc "アイナゴ少佐は生まれながらの戦士で、優れた士官だ。"))

(define (jeff-jess knpc kpc)
  (say knpc "ジェスは明るい女性だ。"
       "そして苦しい日々が終わり、酒を注ぐのが楽しいように見える。"))

(define (jeff-ches knpc kpc)
  (say knpc "我々は彼の力を失ってしまった。"
       "だが、彼の武器は今でも我々を助けてくれる。"))

(define (jeff-lost knpc kpc)
  (say knpc "失われた殿堂はとても危険な所だ。一般人の行くところではない。"
       "そこに近づいてはならぬぞ！では失礼する！")
  (kern-conv-end)
  (if (is-player-party-member? ch_ini)
	(begin
      (say ch_ini "案ずるな。失われた殿堂の場所は知っている。"
           "船で["
           (loc-x lost-halls-loc) ","
           (loc-y lost-halls-loc) "]まで航行すれば見つかるだろう。")
	   (quest-data-update-with 'questentry-rune-l 'know-hall 1 (quest-notify nil))
	   (quest-data-update 'questentry-warritrix 'lost-hall-loc 1)
	   )
	   )
  )

(define jeff-conv
  (ifc glasdrin-conv

       ;; basics
       (method 'default jeff-default)
       (method 'hail jeff-hail)
       (method 'bye  jeff-bye)
       (method 'job  jeff-job)
       (method 'name jeff-name)
       (method 'join jeff-join)

       (method 'comm jeff-comm)
       (method 'jeff jeff-comm)
       (method 'jani (lambda (knpc kpc) (say knpc "私の補佐官のジャニスは戦術家として計り知れないほど重要である。")))
       (method 'mili jeff-mili)
       (method 'pala jeff-pala)
       (method 'warr jeff-warr)
       (method 'erra jeff-erra)
       (method 'glas jeff-glas)
       (method 'ange jeff-ange)
       (method 'lost jeff-lost)
       (method 'patc jeff-patc)
       (method 'stew jeff-stew)
       (method 'vict jeff-stew)  ;; A synonym
       (method 'ini  jeff-ini)
       (method 'inag jeff-ini)
       (method 'jess jeff-jess)
       (method 'ches jeff-ches)
       ))

(define (mk-jeffreys)
  (bind 
   (kern-mk-char 'ch_jeffreys       ; tag
                 "ジェフリーズ"     ; name
                 sp_human            ; species
                 oc_warrior          ; occ
                 s_companion_paladin ; sprite
                 faction-glasdrin         ; starting alignment
                 2 1 1               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 5  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'jeff-conv         ; conv
                 sch_jeff           ; sched
                 'townsman-ai                 ; special ai
                 nil                 ; container
                 (list t_armor_chain
                       t_chain_coif
                       t_sword
                       ))         ; readied
   (jeff-mk)))
