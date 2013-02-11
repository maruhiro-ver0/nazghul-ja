;;----------------------------------------------------------------------------
;; Schedule
;; 
;; 緑の塔
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_doris
               (list 0  0  doris-bed "sleeping")
               (list 8  0  white-stag-counter "working"))

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (doris-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ドリスは緑の塔にある白き牡鹿荘の女主人である。
;;----------------------------------------------------------------------------
(define (doris-name kdoris kplayer)
  (say kdoris "私はドリス、この白き牡鹿荘の主人よ。"))

(define (doris-default)
  (say kdoris "ちょっと待って…いえ、どうすることもできないわ。"))

(define (doris-join kdoris kplayer)
  (say kdoris "［笑い］お断りよ！宿のことで精一杯だわ。"))

(define (doris-doris knpc kpc)
  (say knpc "ええ。私のことよ。"))

(define (doris-trade knpc kpc)
  (let ((door (eval 'white-stag-door))
        (price 15))
    ;; is the room still open?
    (if (not (door-locked? (kobj-gob door)))
        ;; yes - remind player
        (say knpc "バカねえ、部屋はもう開いているわ！"
             "町を去るまで出入りできるのよ。")
        ;; no - ask if player needs a room
        (begin
          (say knpc "部屋は金貨" price "枚、この町を出るまで何度でも出入りできます。"
               "よろしいですか？")
          (if (kern-conv-get-yes-no? kpc)
              ;; yes - player agrees to the price
              (let ((gold (kern-player-get-gold)))
                ;; does player have enough gold?
                (if (>= gold price)
                    ;; yes - player has enough gold
                    (begin
                      (kern-player-set-gold (- gold price))
                      (say knpc "承知しました。西側の廊下を進んでください。"
                           "広間の端の最初の部屋よ。")
                      (send-signal knpc door 'unlock)
                      (kern-conv-end)
                      )
                    ;; no - player does not have enouvh gold)
                    (say knpc "お金が足りないようね。"
                         "足りるまでこのあたりを歩き回って、誰かを殺して死体をあさってきては？"
                         "勇敢な冒険者は皆そうしていますよ。"
                         "［彼女は魅力的に微笑んだ。］")))
              ;; no - player does not want the room
              (say knpc "ではまたの機会に。"))))))

(define (doris-lodge knpc kpc)
  (say knpc "ええ。私の全てよ。かつては父のものだったけど、天に召されてしまいました。"
       "お客のほとんどはこのあたりの森人や旅人よ。"))

(define (doris-daddy knpc kpc)
  (say knpc "父は狩りで得た少しの富でこの宿を立てました。父が死んでからは私が引き継いだのです。"))

(define (doris-local knpc kpc)
  (say knpc "このあたりには、変わり者から秘密のありそうな人まで色々いるわ。"
       "皆、信用できる有能で面白い人でもあるけれど。"
       "あなたは、ここの人達より良い友も、悪い敵も見つけることはできないでしょうね。"))

(define (doris-woodsman knpc kpc)
  (say knpc "狩人、木こり、食料を採取する人達は、このあたりに来ても普通ここを通り過ぎて行きます。"
       "町のお金持ちは狩りで遊びに来ればここに泊まります。"
       "でも、この森で働く者は普通は森の中でキャンプします。"
       "ここに来るのは少し飲む、集会、ちゃんとした食事のためです。"))

(define (doris-travelers knpc kpc)
  (say knpc "そう。あなたのような人よ。"))

(define (doris-gen knpc kpc)
  (say knpc "昔のゴブリン戦争の戦士、このあたりでは伝説みたいな人よ。"
       "木々の間でうろうろしているのが見つかるかもしれませんね。夜はよく飲みに来ていますよ。"))

(define (doris-deric knpc kpc)
  (say knpc "ええ、デリック……。会えばどんな人かわかるわ。"
       "彼は立派だけど、この辺境の地位に人生を費やすつもりはないようね。"))

(define (doris-shroom knpc kpc)
  (say knpc "彼女は魔女で、ゴブリンの魔術も知っていると言う者もいます。"
       "彼女は誰かが病気になったときは本当に頼りになるのよ。"
       "ここにもよく食べに来ますよ。"))

(define (doris-abe knpc kpc)
  (say knpc "グラスドリンの学者のようね。遺跡の調査にほとんどの時間を費やしているわ。"
       "本の虫みたいな人よ。"))

(define (doris-abigail knpc kpc)
  (say knpc "彼女は孤児なの。それで私が養子にしたのよ。ずっと自分の子供が欲しかったけど、"
       "できなかった。あの子の将来が不安…。"
       "私にはあの子が失ったものの代わりはできないわ。"))

(define (doris-goblins knpc kpc)
  (say knpc "彼らは町の人と交易をしているわ。"
       "私も時々彼らから買います。"
       "でも、彼らはいつも群れているから、大勢で町に入ることは法で禁止されているの。"
       "彼らのほとんどは商売をすぐに切り上げて、森へと戻って行くわ。"))

(define (doris-orphaned knpc kpc)
  (say knpc "シュルームが私のところにあの子を連れてきたとき、まだ赤ちゃんだった。"
       "森の中で見つけたとき、側にいた両親は死んでいたと言ってた。"
       "なぜ死んでいたのか、それとも殺されたのか。シュルームは何も言わなかった。"
       "もしかしたら私が知りたくないのかもしれない。"))

(define (doris-hail knpc kpc)
  (say knpc "白き牡鹿荘へようこそ。"))

(define (doris-bye knpc kpc)
  (say knpc "またどうぞ。"))

(define (doris-default knpc kpc)
  (say knpc "どうすることもできないわ。"))

(define (doris-thie knpc kpc)
  (say knpc "最近は怪しい人は見ておりません。デリック隊長が警備隊員の報告を聞いているかも知れません。"
       "ジェンも外で何か見ているかもしれませんね。"))

(define (doris-band knpc kpc)
  (say knpc "旅人はみんな困っている！"
       "デリックにどうにかして欲しい。このままでは商売になりません！"))

(define doris-conv
  (ifc green-tower-conv
       (method 'band      doris-band)
       (method 'hail      doris-hail)
       (method 'bye       doris-bye)
       (method 'default   doris-default)
       (method 'name      doris-name)
       (method 'room      doris-trade)
       (method 'defa      doris-default)
       (method 'job       doris-trade)
       (method 'join      doris-join)
       (method 'dori      doris-doris)
       (method 'buy       doris-trade)
       (method 'innk      doris-trade)
       (method 'whit      doris-lodge)
       (method 'stag      doris-lodge)
       (method 'lodg      doris-lodge)
       (method 'dadd      doris-daddy)
       (method 'loca      doris-local)
       (method 'wood      doris-woodsman)
       (method 'trav      doris-travelers)
       (method 'gen       doris-gen)
       (method 'deri      doris-deric)
       (method 'shro      doris-shroom)
       (method 'abe       doris-abe)
       (method 'abig      doris-abigail)
       (method 'orph      doris-orphaned)
       (method 'gobl      doris-goblins)
       (method 'thie      doris-thie)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-doris tag)
  (bind 
   (kern-mk-char tag                 ; tag
                 "ドリス"            ; name
                 sp_human            ; species
                 nil                 ; occ
                 s_townswoman   ; sprite
                 faction-men         ; starting alignment
                 0 1 0               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 2  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'doris-conv         ; conv
                 sch_doris           ; sched
                 'townsman-ai        ; special ai
                 nil                 ; container
                 (list t_dagger)     ; readied
                 )
   (doris-mk)))
