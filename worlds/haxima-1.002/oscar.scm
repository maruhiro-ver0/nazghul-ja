;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;;
;; オパーリン
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_oscar
               (list 0  0  oparine-innkeepers-bed "sleeping")
               (list 8  0  bilge-water-seat-3     "eating")
               (list 9  0  cheerful-counter       "working")
               (list 12 0  bilge-water-seat-3     "eating")
               (list 13 0  cheerful-counter       "working")
               (list 21 0  bilge-water-seat-3     "eating")
               (list 22 0  bilge-water-hall       "idle")
               (list 23 0  oparine-innkeepers-bed "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (oscar-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;;
;; オスカーはオパーリンの宿屋である。彼は陰気で木の義足をしている。
;;----------------------------------------------------------------------------

;; Basics...
(define (oscar-hail knpc kpc)
  (say knpc "［あなたは陰気な、木の義足の男と会った。］いらっしゃい…。"))

(define (oscar-default knpc kpc)
  (say knpc "知りませんね。"))

(define (oscar-name knpc kpc)
  (say knpc "宿屋のオスカーだ。"))

(define (oscar-join knpc kpc)
  (say knpc "私がいてもじゃまになるだけだよ…。"))

(define (oscar-job knpc kpc)
  (say knpc "宿屋だ。"
       "部屋が要るようには見えないが、"
       "もし要るなら言ってくれ。"))

(define (oscar-bye knpc kpc)
  (say knpc "どうも。"))

;; Trade...
(define (oscar-trade knpc kpc)
  (if (not (string=? "working" (kern-obj-get-activity knpc)))
      (say knpc "宿屋「愉快な同居人」は午前9時から午後9時まで開いている。時々食事でいないが、"
           "そのときは後で来てくれ。")
      (let ((door (eval 'oparine-inn-room-1-door)))
        ;; is the room still open?
        (if (not (door-locked? (kobj-gob door)))
            ;; yes - remind player
            (say knpc "部屋はもう開いている。")
            ;; no - ask if player needs a room
            (begin
              (say knpc "部屋が要るのか？")
              (if (kern-conv-get-yes-no? kpc)
                  ;; yes - player wants a room
                  (begin
                    (say knpc 
                         "金貨" oparine-inn-room-price "枚だ。"
                         "この町にいる限り、何度でも出入りできる。"
                         "それでいいか？")
                    (if (kern-conv-get-yes-no? kpc)
                        ;; yes - player agrees to the price
                        (let ((gold (kern-player-get-gold)))
                          ;; does player have enough gold?
                          (if (>= gold oparine-inn-room-price)
                              ;; yes - player has enough gold
                              (begin
                                (say knpc "1号室だ。"
                                     "でも気に入らないだろうね。"
                                     "あらかじめ言っておいたんだ。"
                                     "文句は言わないでくれよ。")
                                (kern-player-set-gold 
                                 (- gold 
                                    oparine-inn-room-price))
                                (send-signal knpc door 'unlock)
                                (kern-conv-end)
                                )
                              ;; no - player does not have enouvh gold)
                              (say knpc "残念だが金貨が足りないな。"
                                   "知っての通り、ここは救貧院ではない。" )))
                        ;; no - player does not agree to the price
                        (say knpc 
                             "わかってたよ。")))
                  ;; no - player does not want a room
                  (say knpc "そうだろうね。"
                       "社交辞令で聞いてみただけだ。")))))))

;; Inn...
(define (oscar-inn knpc kpc)
  (say knpc "前の奴がこの名前にしたんだ。"
       "変えたいとは思わない。しかし、それにしても運が悪い。"))

(define (oscar-luck knpc kpc)
  (say knpc "この宿の名前のような亡霊が3号室にいるんだ。"
       "恐ろしい海賊の亡霊を怒らせたくない。")
	(quest-data-assign-once 'questentry-ghertie)
	(quest-data-update 'questentry-ghertie 'ghertieloc 1))

(define (oscar-ghost knpc kpc)
  (say knpc "ガーティーという客が3号室で自分の手下に殺された。"
       "その亡霊がまだいるから3号室は貸し出せないんだ。"
       "宿代を払って欲しいね。")
	(quest-data-update 'questentry-ghertie 'ghertieid 1)
	(quest-data-update 'questentry-ghertie 'ghertieloc 1)
	(quest-data-assign-once 'questentry-ghertie))

;; Leg...
(define (oscar-leg knpc kpc)
  (say knpc "船乗りになりたかったんだ。でも誰も雇ってくれなかった。"
       "だから船乗りらしく見えるように、自分で足を切り落としたんだ。"
       "でも雇ってくれなかった。ただ足を失っただけだ。"))

;; Townspeople...
(define (oscar-opar knpc kpc)
  (say knpc "ここは港町だ。"
       "客のほとんどは船を降りたあと北へ向かう旅人だ。"))

(define (oscar-gher knpc kpc)
  (say knpc "ガーティーは恐ろしい海賊だった。"
       "自分の手下に殺され、船と財宝を奪われたんだ。")
	(quest-data-assign-once 'questentry-ghertie))

(define (oscar-alch knpc kpc)
  (say knpc "彼の店は酒場のとなりにある。"
       "いつもよくわからない実験で使う物を探している。"))

(define (oscar-bart knpc kpc)
  (say knpc "バートはこの道のちょうど向かいの店の造船職人だ。"
       "夜になるといつも大量に飲んでいる。とてもじゃないがついていけない。"))

(define (oscar-seaw knpc kpc)
  (say knpc "海の魔女はとてもきれいだが、人を避けている。"
       "彼女は私を無視している。当然だ。"))

(define (oscar-henr knpc kpc)
  (say knpc "本物の船乗りだ。あいつのようには絶対なれない。"))

(define oscar-conv
  (ifc basic-conv

       ;; basics
       (method 'default oscar-default)
       (method 'hail oscar-hail)
       (method 'bye  oscar-bye)
       (method 'job  oscar-job)
       (method 'name oscar-name)
       (method 'join oscar-join)
       
       ;; trade
       (method 'trad oscar-trade)
       (method 'room oscar-trade)
       (method 'buy  oscar-trade)
       (method 'sell oscar-trade)

       ;; inn
       (method 'inn  oscar-inn)
       (method 'luck oscar-luck)
       (method 'ghos oscar-ghost)
       (method 'pira oscar-ghost)
       (method 'leg  oscar-leg)

       ;; town & people
       (method 'opar oscar-opar)
       (method 'alch oscar-alch)
       (method 'gher oscar-gher)
       (method 'ghas oscar-gher)
       (method 'henr oscar-henr)
       (method 'bart oscar-bart)
       (method 'sea  oscar-seaw)
       (method 'witc oscar-seaw)
       (method 'lia  oscar-seaw)

       ))

(define (mk-oscar)
  (bind 
   (kern-mk-char 'ch_oscar           ; tag
                 "オスカー"          ; name
                 sp_human            ; species
                 nil                 ; occ
                 s_townsman          ; sprite
                 faction-men         ; starting alignment
                 1 1 0               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 1  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'oscar-conv         ; conv
                 sch_oscar           ; sched
                 'townsman-ai        ; special ai
                 nil                 ; container
                 (list t_dagger)     ; readied
                 )
   (oscar-mk)))
