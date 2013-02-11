;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; グラスドリン
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_jess
               (list 0  0  gj-bed      "sleeping")
               (list 7  0  ghg-counter "working")
               (list 9  0  g-fountain  "idle")
               (list 10 0  ghg-counter "working")
               (list 13 0  gc-hall     "idle")
               (list 14 0  ghg-counter "working")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (jess-mk) (list 'townsman))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ジェスはグラスドリンの酒場「聖杯」の主の女性である。
;; 彼女の顔には、クロスボウ兵としてグラスドリンの兵役に就いていたころ、ゴブリ
;; ンから受けた傷がある。
;;----------------------------------------------------------------------------

;; Basics...
(define (jess-hail knpc kpc)
  (if (string=? "working" (kern-obj-get-activity knpc))
      (say knpc "［あなたは人を引きつけるような若い女性と会った。顔の片側に深い傷がある。］"
           "くつろいでください。ついにあなたは聖杯を手にしました！")
      (say knpc "［あなたは人を引きつけるような若い女性と会った。顔の片側に深い傷がある。］"
           "いい天気ね。")))

(define (jess-default knpc kpc)
  (say knpc "うーん…わかりません。"))

(define (jess-name knpc kpc)
  (if (working? knpc)
      (say knpc "私はジェス。この憩いの場の主です。")
      (say knpc "私はジェス。憩いの場「聖杯」の主です。"
           "喉が渇いたら、開いているときに来てくださいな。")))

(define (jess-join knpc kpc)
  (say knpc "いいえ。ここで飲み物を出すので精一杯です。それに私の兵役はもう終わりました。"))

(define (jess-job knpc kpc)
  (say knpc "飲み物が売れるか心配です。見てもらえますか？")
  (if (kern-conv-get-yes-no? kpc)
      (begin
        (say knpc "［彼女はウィンクした。］そう言うと思ってました！")
        (jess-trade knpc kpc))
      (say knpc "残念ね。")))

(define (jess-bye knpc kpc)
  (say knpc "さようなら。また来てください！"))

(define jess-catalog
  (list
   (list t_food 7  "聖騎士の皆さんはあぶり肉が大好きです。")
   (list t_beer 12 "聖杯を満たしましょう！")
   ))

(define jess-merch-msgs
  (list "私がいるときに「聖杯」に来てください。朝食は午前7時から9時、昼食は10時から午後1時、そして2時から深夜まで再開店します。"
        "メニューです！"
        nil ;; sell
        nil ;; trade
        "楽しんでください！" ;; sold-something
        "ああ、固パンで叩かれたみたいです！" ;; sold-nothing
        nil ;; the rest are nil
        ))

;; Trade...
(define (jess-buy knpc kpc) (conv-trade knpc kpc "buy" jess-merch-msgs jess-catalog))

;; Holy Grail
(define (jess-grai knpc kpc)
  (say knpc "言い伝えでは迷い人がこの名前にしたとか。"
       "彼の世界でよく知られた話が元になっているそうですよ。"))

;; Scar
(define (jess-scar knpc kpc)
  (say knpc "洞窟ゴブリンと、寝ていた衛兵のせいです。"
       "睡眠中に不意打ちを受け、斧の刃を頬に受けました。"
       "でも兜のおかげで致命傷にはなりませんでした。"
       "戦いの話は好きですか？")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "この町の人はこんな話を一つくらいは持っています。私たちは皆兵役に就きましたから。")
      (say knpc "残念ですね。ここではこんな話ばかりです。")))

(define (jess-serv knpc kpc)
  (say knpc "グラスドリンの市民はみんな兵役の義務があります。"
       "私はクロスボウ兵で、重装兵を背後から支援するのが仕事でした。"
       "私の部隊は森の東側の境界にいました。"))

(define (jess-wood knpc kpc)
  (say knpc "警備隊はよく守っていると思います。"
       "でも、あの年には洞窟ゴブリンとトロルの大群が押し寄せてきました。"))

;; Townspeople...
(define (jess-glas knpc kpc)
  (say knpc "基地であることを考えれば、十分によい所です。"))

(define (jess-ange knpc kpc)
  (say knpc "すばらしい人です。戦士としては活躍できませんでしたが、彼女には彼女の役目があります。"))

(define (jess-patc knpc kpc)
  (say knpc "あの汚れた年寄り！いえ、冗談ですよ。"))

(define jess-conv
  (ifc glasdrin-conv

       ;; basics
       (method 'default jess-default)
       (method 'hail jess-hail)
       (method 'bye  jess-bye)
       (method 'job  jess-job)
       (method 'name jess-name)
       (method 'join jess-join)
       
       ;; trade
       (method 'grai jess-grai)
       (method 'holy jess-grai)
       (method 'trad jess-buy)
       (method 'room jess-buy)
       (method 'buy  jess-buy)
       (method 'drin jess-buy)
       (method 'ware jess-buy)
       (method 'food jess-buy)

       ;; scar
       (method 'trade jess-buy)
       (method 'scar  jess-scar)
       (method 'serv  jess-serv)
       (method 'tour  jess-serv)
       (method 'wood  jess-wood)

       ;; town & people
       (method 'glas jess-glas)
       (method 'ange jess-ange)
       (method 'patc jess-patc)

       ))

(define (mk-jess)
  (bind 
   (kern-mk-char 'ch_jess           ; tag
                 "ジェス"           ; name
                 sp_human            ; species
                 nil                 ; occ
                 s_townswoman        ; sprite
                 faction-glasdrin         ; starting alignment
                 0 0 1               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 3  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'jess-conv         ; conv
                 sch_jess           ; sched
                 'townsman-ai                 ; special ai
                 (mk-inventory (list (list 1 t_dagger)))                 ; container
                 nil                 ; readied
                 )
   (jess-mk)))
