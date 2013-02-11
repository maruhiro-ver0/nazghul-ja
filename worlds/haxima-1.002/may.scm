;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define may-start-lvl  6)
(define inn-room-price 30)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ボレ
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_may
               (list 0  0  bole-bed-may "sleeping")
               (list 6  0  bole-dining-hall "working")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (may-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; メイは宿屋の主人の女性で、ボレに住んでいる。
;; メルヴィンは彼女の(7番目の)夫である。
;;----------------------------------------------------------------------------
(define (may-trade knpc kpc)
  (say knpc "厨房にいる旦那のメルヴィンに言っとくれ。"))

(define (may-hail knpc kpc)
  (say knpc "［あなたは太った高齢の女性と会った。鋭い目でこちらを見ている。］"
       "やっかいそうなのが来たね。でもいらっしゃい。"))

(define (may-job knpc kpc)
  (say knpc "ボレのこの酒場を旦那と切り盛りしてるのよ。"))

(define (may-husband knpc kpc)
  (say knpc "旦那のメルヴィンは大酒のみのロクデナシだけど、料理の腕はたいしたものよ。"
       "他に六人の旦那がいたけど。"
       "この宿をやってくために必要だった。結婚した理由はそれだけよ。"))

(define (may-other-husbands knpc kpc)
  (say knpc "ほかの旦那はそろってバカだった！確かに何人かは好きだったさ。"
       "でもみんな自分のバカさのせいで死んじまった。"
       "あんたもバカみたいだね。いつかそのバカのせいで死ぬよ。"))

(define (may-tavern knpc kpc)
  (say knpc "メルヴィンが料理してあたしが客に出す。"
       "何か飲み物や食事がいるの？それとも休む部屋？"))

(define (may-guests knpc kpc)
  (say knpc "［彼女はあなたを鋭い目で見た。］そう、今いるおかしな女とその…連れ。"
       "でも、たぶん別の奴を探してるんじゃない、ねえ？")
  (if (kern-conv-get-yes-no? kpc)
      (begin
        (say knpc "やっぱりねえ。で、そいつは何か面白いものを持ってるんだろ？")
        (if (kern-conv-get-yes-no? kpc)
            (begin
              (say knpc "おかしいねえ。今いる客も何か探してるんだよ。"
                   "あたしには関係ないけど、"
                   "もしかすると、あの女とあんたが探してる奴は会ってるんじゃないかね。"
                   "多分、何かを…交換してた。"))
            (say knpc "うーん、ちょっと前まで別の男がいたんだけど。"
                 "でもあんたが来る前にすぐに行ってしまったよ。")))
      (say knpc "もしかして田舎を出たばっかりなのかい？")))

(define (may-woman knpc kpc)
  (say knpc "そうさ。このあたりではあんなきれいな人とはほとんど会わない。"
       "かわいそうなビルは惚れこんでたよ。"
       "そしてうちのバカ旦那はことあるごとにいやらしい目で見ている。"
       "［彼女は近くによってささやいた。］でも、あの女は魔女か、魔女の修行中だよ！"))

(define (may-companion knpc kpc)
  (say knpc "あの女は野蛮な奴を引き連れてる。オーガの血を引いてるんじゃないかね。"
       "多分あの女の用心棒だ。でも何で言うことを聞いているのかはわからないね。"))

(define (may-bill knpc kpc)
  (say knpc "ああ。ビルはこのあたりの青年だ。頭はよくないが正直で、木こりをやっている。"
       "よくここで食ってるよ。そして時々客としゃべってる。"))

(define (may-hackle knpc kpc)
  (say knpc "ハックルはおかしいが危険ではない魔女よ。川が分かれる所に住んでる。"
       "治療の技があるけと、他は何もできない。"))

(define (may-room knpc kpc)
  (if (not (string=? "working" (kern-obj-get-activity knpc)))
      (say knpc "宿はもう閉じたよ。明日の6時にまた来とくれ。")
      (let ((door (eval 'bole-inn-room-door)))
        ;; is the room still open?
        (if (not (door-locked? (kobj-gob door)))
            ;; yes - remind player
            (say knpc "部屋はもう開いてるよ。")
            ;; no - ask if player needs a room
            (begin
              (say knpc "部屋がいるかい？")
              (if (kern-conv-get-yes-no? kpc)
                  ;; yes - player wants a room
                  (begin
                    (say knpc 
                         "金貨" inn-room-price "枚ね。"
                         "この町にいる限り何度でも出入りできる。"
                         "いいかい？")
                    (if (kern-conv-get-yes-no? kpc)
                        ;; yes - player agrees to the price
                        (let ((gold (kern-player-get-gold)))
                          ;; does player have enough gold?
                          (if (>= gold inn-room-price)
                              ;; yes - player has enough gold
                              (begin
                                (kern-player-set-gold 
                                 (- gold 
                                    inn-room-price))
                                (say knpc "どうも。部屋は奥の左よ。")
                                (send-signal knpc door 'unlock)
                                (kern-conv-end)
                                )
                              ;; no - player does not have enouvh gold)
                              (say knpc "金が足りないよ！")))
                        ;; no - player does not agree to the price
                        (say knpc 
                             "ならそこらで寝ればいいさ。狼に気を付けな。")))
                  ;; no - player does not want a room
                  (say knpc "あんたのような奴もいつかは休むんだよ！")))))))
  
(define (may-thief knpc kpc)
  (say knpc "おや…あんた捕り物かい。"
       "それっぽい奴がいたよ。最近怪しい客が来たんだ。"))

(define (may-trouble knpc kpc)
  (say knpc "あんた、昔の奴みたいな険しく情け容赦ない顔つきをしてる。"
       "でも、あんたは悪者じゃないだろうね。"))

(define may-conv
  (ifc nil
       (method 'default (lambda (knpc kpc) (say knpc "どうしようもないね。")))
       (method 'hail may-hail)
       (method 'bye  (lambda (knpc kpc) (say knpc "さあ、出ていった出ていった。")))
       (method 'job  may-job)
       (method 'name (lambda (knpc kpc) (say knpc "メイと呼ばれてる。")))
       (method 'join (lambda (knpc kpc)
                       (say knpc "あんたのバカに巻き込まないでおくれ。")))

       (method 'buy   may-trade)
       (method 'food  may-trade)
       (method 'drin  may-trade)
       (method 'supp  may-trade)
       (method 'trade may-trade)

       (method 'bill  may-bill)
       (method 'comp  may-companion)
       (method 'thin  may-companion) ;; 連れ
       (method 'gues  may-guests)
       (method 'clie  may-guests) ;; 客
       (method 'hack  may-hackle)
       (method 'husb  may-husband)
       (method 'inn   may-tavern)
       (method 'melv  may-husband)
       (method 'other may-other-husbands)
       (method 'run   may-tavern)
       (method 'room  may-room)
       (method 'six   may-other-husbands)
       (method 'tave  may-tavern)
       (method 'thie  may-thief)
       (method 'trou  may-trouble)
       (method 'woma  may-woman)

       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-may)
  (bind 
   (kern-char-arm-self
    (kern-mk-char 
     'ch_may ;;......tag
     "メイ" ;;.......name
     sp_human ;;.....species
     nil ;;..........occupation
     s_townswoman ;;...sprite
     faction-men ;;..faction
     0 ;;............custom strength modifier
     1 ;;............custom intelligence modifier
     0 ;;............custom dexterity modifier
     0 ;;............custom base hp modifier
     0 ;;............custom hp multiplier (per-level)
     0 ;;............custom base mp modifier
     0 ;;............custom mp multiplier (per-level)
     max-health ;;..current hit points
     -1  ;;...........current experience points
     max-health ;;..current magic points
     0
     may-start-lvl  ;;..current level
     #f ;;...........dead?
     'may-conv ;;...conversation (optional)
     sch_may ;;.....schedule (optional)
     'townsman-ai ;;..........custom ai (optional)
     nil ;;..........container (and contents)
     (list t_dagger) ;;.........readied arms (in addition to the container contents)
     nil ;;..........hooks in effect
     ))
   (may-mk)))
