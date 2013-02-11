;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;;
;; トリグレイブ
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_gwen
               (list 0  0  trigrave-gwens-bed        "sleeping")
               (list 8  0  trigrave-tavern-table-1a  "eating")
               (list 9  0  trigrave-inn-counter      "working")
               (list 13 0  trigrave-tavern-table-1d  "eating")
               (list 14 0  trigrave-inn-counter      "working")
               (list 20 0  trigrave-tavern-table-1a  "eating")
               (list 21 0  trigrave-inn-counter      "working")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (gwen-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;;
;; グベンは宿屋の主人で、優雅で謎の多い女性である。
;;----------------------------------------------------------------------------
(define (gwen-trade knpc kpc)
  (if (not (string=? "working" (kern-obj-get-activity knpc)))
      (say knpc "私の店が開いているときに来てください。"
           "宿屋「灰色の鳩」はこの町の北西にあります。"
           "午前9時に開いて、深夜に閉店します。")
      (let ((door (eval 'trigrave-inn-room-1-door)))
        ;; is the room still open?
        (if (not (door-locked? (kobj-gob door)))
            ;; yes - remind player
            (say knpc "あなたのお部屋はもう開いています！")
            ;; no - ask if player needs a room
            (begin
              (say knpc "お部屋が御入り用ですか？")
              (if (kern-conv-get-yes-no? kpc)
                  ;; yes - player wants a room
                  (begin
                    (say knpc 
                         "料金は金貨" trigrave-inn-room-price "枚、"
                         "この町にいる間、何度でも出入りできます。"
                         "よろしいですか？")
                    (if (kern-conv-get-yes-no? kpc)
                        ;; yes - player agrees to the price
                        (let ((gold (kern-player-get-gold)))
                          ;; does player have enough gold?
                          (if (>= gold trigrave-inn-room-price)
                              ;; yes - player has enough gold
                              (begin
                                (kern-player-set-gold 
                                 (- gold 
                                    trigrave-inn-room-price))
                                (say knpc "1号室です。ごゆっくりどうぞ！")
                                (send-signal knpc door 'unlock)
                                (kern-conv-end)
                                )
                              ;; no - player does not have enouvh gold)
                              (say knpc "残念ですがお金が足りません！")))
                        ;; no - player does not agree to the price
                        (say knpc 
                             "ここより良い宿は、この半島にはありませんよ！")))
                  ;; no - player does not want a room
                  (say knpc "またの機会にどうぞ。")))))))

(define (gwen-thie knpc kpc)
  (say knpc "緑の塔から最近来た客が、東の山道でとても急いでいる人を見たそうですよ。緑の塔のあたりで聞いてみればよいかもしれません。")
  (quest-data-update-with 'questentry-thiefrune 'tower 1 (quest-notify (grant-party-xp-fn 10)))
  )

(define (gwen-news knpc kpc)
  (say knpc "魔道師が何か重要なものをなくしたそうですよ。"))

(define gwen-conv
  (ifc basic-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default (lambda (knpc kpc) 
                          (say knpc "残念ながらお手伝いできません。")))
       (method 'hail
               (lambda (knpc kpc)
                 (kern-print "［あなたは灰色の服を着た魅力的な女性と会った。"
                             "腰のベルトには細く長い^c+m剣^c-が見える。］\n")
                 (say knpc "ようこそ。旅の方。")))
       (method 'bye (lambda (knpc kpc) (say knpc "ありがとうございました。")))
       (method 'job 
               (lambda (knpc kpc) 
                 (say knpc "トリグレイブの宿屋をしております。")
                 (gwen-trade knpc kpc)))
       (method 'name (lambda (knpc kpc) (say knpc "私はグベンです。")))
       (method 'trad gwen-trade)
       (method 'join 
               (lambda (knpc kpc) 
                 (say knpc "私の旅はもう終わりました。"
                      "でも、お誘いありがとうございます。")))
       (method 'chan
               (lambda (knpc kpc)
                 (say knpc "あのお調子者は普段は酒場にいます。"
                      "夜遅くなると船乗りみたいに酔って部屋に戻ってきます。")))
       (method 'civi 
               (lambda (knpc kpc) 
                 (say knpc "このあたりのことを話す都市の人はあまりいません。")))
       (method 'earl
               (lambda (knpc kpc)
                 (say knpc "素敵な、でも物忘れの激しいご老人です。"
                      "彼は私の宿の南で店を切り盛りしてます。")))
       (method 'enem 
               (lambda (knpc kpc) (say knpc "あなたには関係のないことです。")))
       (method 'esca 
               (lambda (knpc kpc)
                 (say knpc "もし、敵や恥じるべき行いから身を隠したいなら、"
                      "このシャルドの忘れられた地より良い場所はないでしょう。")))
       (method 'inn  
               (lambda (knpc kpc)
                 (say knpc "宿屋は楽しい仕事です。"
                            "旅人から色々な話を聞けますから。")))
       (method 'jim
               (lambda (knpc kpc)
                 (say knpc "ハンサムな、でも少し荒っぽい人です。"
                      "彼は東の端で鍛冶屋を営んでます。")))
       (method 'news gwen-news)
       (method 'stor gwen-news)
       (method 'room gwen-trade)
       (method 'sham 
               (lambda (knpc kpc) (say knpc "あなたには関係のないことです。")))
       (method 'swor
               (lambda (knpc kpc) 
                 (say knpc "友人から譲り受けたものです。")))
       (method 'tave
               (lambda (knpc kpc)
                 (say knpc "「陽気な杯」はこの町の南側にあります。")))
       (method 'thie gwen-thie)
       (method 'trig 
               (lambda (knpc kpc) 
                 (say knpc "ここは都市から離れた小さな町です。"
                      "たくさんの人が逃れるためにここにいます。")))

       ))
