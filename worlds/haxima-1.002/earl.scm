;;----------------------------------------------------------------------------
;; Schedule
;;
;; トリグレイブ
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_earl
               (list 0  0  trigrave-earls-bed        "sleeping")
               (list 5  0  trigrave-tavern-table-3a  "eating")
               (list 6  0  trigrave-earls-counter    "working")
               (list 12 0  trigrave-tavern-table-3a  "eating")
               (list 13 0  trigrave-earls-counter    "working")
               (list 18 0  trigrave-tavern-table-3a  "eating")
               (list 19 0  trigrave-tavern-hall      "idle")
               (list 20 0  trigrave-earls-room       "idle")
               (list 21 0  trigrave-earls-bed        "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (earl-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;;
;; イアルは店主で、仕事をしている時間ならば取り引きできる。
;;----------------------------------------------------------------------------
(define earl-merch-msgs
  (list "開いてるときに店に来とくれ。俺の小間物屋は南西の角にあって、午前6時から午後6時までやってる。"
        "置いてる物を見せてやろう。"
        "えー、ああ、売りたい物を見せとくれ。"
        "こっちに来て見てくれ。"
        "イアルの店で買ったものだと友達に言っといてくれ。"
        "見るだけかい？まあいいや。"
        "置いといて後できれいにするよ。"
        "売りたい物があったらまた来とくれ。"
        "もういいのかい？まあ好きにしなよ。"
        "まだ何かあったら言っとくれ。"
   ))

(define earl-catalog
  (list
   (list t_torch               5 "迷宮の奥で松明を切らせたくないだろう？")
   (list t_sling              50 "投石紐は弾を買いたくないケチな奴にぴったりだ。")
   (list t_staff              25 "杖のない魔法使いは吠えない犬みたいなもんだ。")
   
   (list t_heal_potion        22 "応急用としてたくさんいるはずだ。")
   (list t_cure_potion        22 "北へ向かう？湿地帯に行くときはいくつか持っておいたほうがいい。")
   (list t_mana_potion        22 "魔力を使い果たして休憩もできないときはこれだ。")
   
   (list t_arrow               1 "弓を持っていれば、矢が多すぎるということはない。")
   (list t_bolt                1 "このあたりで一番安いクロスボウの矢だ。")
   (list t_smoke_bomb          3 "この煙幕弾を敵の射手に投げれば、相手はこちらが見えなくなるだろう。")
   
   (list t_shovel             50 "埋もれた宝を見つけたらこのシャベルがいるだろう。")
   (list t_pick               50 "つるはしは道を塞ぐ岩を壊すためには絶対に必要だ。")
   
   (list t_sextant           500 "秘薬や巻物なしで荒野での居場所がわかる。")
   (list t_chrono            300 "この小さな時計があれば、柱時計がない所でも時刻がわかる。")
   (list t_grease             23 "ならず者はこれが好きだ。なぜかは聞くな。")
   ))

(define (earl-trade knpc kpc) (conv-trade knpc kpc "trade" earl-merch-msgs earl-catalog))

(define earl-conv
  (ifc trigrave-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default (lambda (knpc kpc) (say knpc "忘れたなあ。")))
       (method 'hail (lambda (knpc kpc) (say knpc "いらっしゃい、見知らぬ方。")))
       (method 'bye (lambda (knpc kpc) (say knpc "ああ、あんたと話してたんだっけ？")))
       (method 'job (lambda (knpc kpc) (say knpc "この店をやってる。何かいるかい？")
                            (if (kern-conv-get-yes-no? kpc)
                                (earl-trade knpc kpc)
                                (say knpc "そう。"))))
       (method 'name (lambda (knpc kpc) (say knpc "［彼はしばらく考え込んだ。］イアル！そう！")))
       (method 'buy (lambda (knpc kpc) (conv-trade knpc kpc "buy"  earl-merch-msgs earl-catalog)))
       (method 'sell (lambda (knpc kpc) (conv-trade knpc kpc "sell"  earl-merch-msgs earl-catalog)))
       (method 'trad earl-trade)
       (method 'join (lambda (knpc kpc) (say knpc "遅すぎるよ！呪文はみんな忘れちまった。")))

       (method 'batt
               (lambda (knpc kpc)
                 (say knpc "そうだ。オレはカルヴィン王と一緒にゴブリンどもの群れと戦ったのさ！")))
       (method 'calv
               (lambda (knpc kpc)
                 (say knpc "かつての武将！"
                      "カルヴィンは灰色の海から北の端まで全てを征服したんだ！")))
       (method 'hord
               (lambda (knpc kpc)
                 (say knpc "あのころゴブリンどもは一人の首長の下で結束していた。"
                      "そして、この半島で暴れていた！"
                      "カルヴィン王がヤツらを倒してからはバラバラになり、丘に隠れるようになった。"
                      "歴史には残ってないがな！")))
       (method 'mage
               (lambda (knpc kpc)
                 (say knpc "魔法はみんな忘れた。杖もなくした！"
                      "昔は軍隊を丸ごと倒せる呪文を知ってたさ。")))
       (method 'spel
               (lambda (knpc kpc) 
                 (say knpc "魔法使いとして戦ってたんだよ。大昔さ。")))
       (method 'thie
               (lambda (knpc kpc)
                 (say knpc "怪しいヤツが西へ逃げてった！いや、南だ！いや…、ああ、クソッ、思い出せねえ。")))
       ))
