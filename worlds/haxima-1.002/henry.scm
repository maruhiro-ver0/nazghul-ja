;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; オパーリン
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_henry
               (list 0  0  bilge-water-bed     "sleeping")
               (list 8  0  bilge-water-counter "working")
               (list 23 0  bilge-water-bed     "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (henry-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ヘンリーはオパーリンの片手の酒場の主で、取り引きできる。
;; 彼はかつて屈強な船乗りであった。
;;----------------------------------------------------------------------------

;; Basics...
(define (henry-hail knpc kpc)
  (say knpc "［あなたは陽気な、片手が鉤の男と会った。］"
       "よお、相棒！"))

(define (henry-default knpc kpc)
  (say knpc "悪い塩に聞いているようなもんだ！"))

(define (henry-name knpc kpc)
  (say knpc "オレはヘンリー！酒場のヘンリーだ。"))

(define (henry-join knpc kpc)
  (say knpc "心が踊るな、若いの。"
       "だが、オレが出て行ったら誰がここで器を満たすんだ？ムリだな！"))

(define (henry-job knpc kpc)
  (say knpc "なぜオレが牧師になったか！それはこの器を聖餐(せいさん)で満たすためだ！"))

(define (henry-bye knpc kpc)
  (say knpc "天気に注意しろよ！"))

(define henry-catalog
  (list
   (list t_food 5 "名物のクラムチャウダーは足まで温かくなるぞ。")
   (list t_beer 5 "ああ、飲んで楽しもう。たとえ明日の朝に死ぬとしても！")
   (list t_wine 7 "突然、紳士様が来たときのために優雅なモノも用意している。")
   ))

(define henry-merch-msgs
  (list "二日酔いがおさまったら何か出そう。"
        "陽気にいこう！"
        "食べかけや飲みかけはいらん。"
        "今話している！"
        "飲んだら船に乗るな！"
        "ただブラブラしたいだけなら船着場がいいだろう。"
        "これでシチューができるな。"
        "まあいい。"
        "腹が減ったら戻ってきな！"
        "ただブラブラしたいだけなら船着場がいいだろう。"
        ))

;; Trade...
(define (henry-buy knpc kpc) (conv-trade knpc kpc "buy" henry-merch-msgs henry-catalog))
(define (henry-sell knpc kpc) (say knpc "押し売りはお断りだ。"))

;; Hook...
(define (henry-hook knpc kpc)
  (say knpc "おお、手はなくなっちまった。深海の恐ろしい怪物と戦ったからよ！"))

(define (henry-mons knpc kpc)
  (say knpc "クラーケンはオレの腕をあっと言う間に汚ねえクチバシでもぎ取った！"
       "ヤツは勇気のねえ海ヘビのように遠くからは撃ってこなかった。"
       "船にぴったりと吸い付いて、甲板を食い破ったんだ！"))

(define (henry-serp knpc kpc)
  (say knpc "海ヘビが巻きついて船を壊すことはある。"
       "だが、ヤツらは臆病で、遠くから火の玉を吐くのを好む。"))

;; Townspeople...
(define (henry-opar knpc kpc)
  (say knpc "ここはいい所だ。"))

(define (henry-gher knpc kpc)
  (say knpc "恐怖のガーティーの伝説を聞いたんだな！"
       "古い海鳥が尋ねられてもいない警告を1つしておこう。"
       "亡霊を避けよ！ヤツらは怒りに満ちている！")
	(quest-data-assign-once 'questentry-ghertie))

(define (henry-ghos knpc kpc)
  (say knpc "海は死人でいっぱいだ。そしてその内の何人かはガーティーによるものだ。"
       "満月の夜、ヤツらが猫のように音もなく獲物を探すのを見たことがある！"
       "恐るべき者は死んだ。そしてヘンリーの宿に居座った！")
	(quest-data-assign-once 'questentry-ghertie))

(define (henry-alch knpc kpc)
  (say knpc "ああ、おかしなヤツだ。"))

(define (henry-bart knpc kpc)
  (say knpc "［大声で］バートはこの半島で最高の造船職人だ！"
       "［寄りかかり、少し小さな声で］そして唯一の造船職人でもある！"))

(define (henry-seaw knpc kpc)
  (say knpc "かわいい娘だが陸の魚のような変わり者だ！"))

(define (henry-osca knpc kpc)
  (say knpc "みじめで、おかしな考えのヤツだ。でもここでは一緒に飲んでいる。"))

(define henry-conv
  (ifc basic-conv

       ;; basics
       (method 'default henry-default)
       (method 'hail henry-hail)
       (method 'bye  henry-bye)
       (method 'job  henry-job)
       (method 'name henry-name)
       (method 'join henry-join)
       
       ;; trade
       (method 'trad henry-buy)
       (method 'buy  henry-buy)
       (method 'sell henry-sell)
       (method 'sacr henry-buy)

       ;; hand
       (method 'hook henry-hook)
       (method 'hand henry-hook)
       (method 'mons henry-mons)
       (method 'deep henry-mons)
       (method 'sea  henry-serp)
       (method 'serp henry-serp)

       ;; town & people
       (method 'opar henry-opar)
       (method 'alch henry-alch)
       (method 'gher henry-gher)
       (method 'ghas henry-gher)
       (method 'bart henry-bart)
       (method 'witc henry-seaw)
       (method 'lia  henry-seaw)
       (method 'osca henry-osca)

       ))

(define (mk-henry)
  (bind 
   (kern-mk-char 'ch_henry           ; tag
                 "ヘンリー"          ; name
                 sp_human            ; species
                 nil                 ; occ
                 s_townsman          ; sprite
                 faction-men         ; starting alignment
                 1 0 0               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 6  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'henry-conv         ; conv
                 sch_henry           ; sched
                 'townsman-ai                 ; special ai
                 (mk-inventory (list (list 1 t_dagger)))     ; container
                 nil                 ; readied
                 )
   (henry-mk)))
