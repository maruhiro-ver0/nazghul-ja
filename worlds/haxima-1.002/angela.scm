;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;;
;; In Glasdrin.
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_ange
               (list 0  0  ga-bed "sleeping")
               (list 6  0  ghg-s2     "eating")
               (list 7  0  gpi-counter       "working")
               (list 11 0  ghg-s2     "eating")
               (list 12 0  gpi-counter       "working")
               (list 17 0  ghg-s2     "eating")
               (list 18 0  gpi-counter "working")
               (list 23 0  ga-bed "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (ange-mk) (list 'townsman))

;;----------------------------------------------------------------------------
;; Conv
;;
;; エンジェラは宿屋「城壁」の主の女性で、城塞都市グラスドリンに住んでいる。
;; 彼女は上品だが謎の多い女性である。
;;----------------------------------------------------------------------------

;; Basics...
(define (ange-hail knpc kpc)
  (say knpc "［あなたは魅力的な女性と会った。］ようこそいらっしゃいました。旅の方。"))

(define (ange-default knpc kpc)
  (say knpc "残念ですがわかりません。"))

(define (ange-name knpc kpc)
  (say knpc "私はエンジェラです。あなたは？")
  (let ((name (kern-conv-get-string kpc)))
    (say knpc "会えてうれしいです、" name 
         "様。グラスドリンの滞在を楽しんでください。")))

(define (ange-join knpc kpc)
  (say knpc "お世辞はよしてください！何年も前はよき冒険者でしたが、"
       "もう辞めたのです。"))

(define (ange-job knpc kpc)
  (say knpc "グラスドリンの宿屋をしております。"
       "部屋が必要ならお申し付けください！"))

(define (ange-bye knpc kpc)
  (say knpc "さようなら、旅の方。またいらしてください！"))

;; Trade...
(define (ange-trade knpc kpc)
  (if (not (string=? "working" (kern-obj-get-activity knpc)))
      (say knpc "ああ、私が宿にいるときに泊まりに来てください！"
           "「城壁」は午前7時から午後11時まで開いています。"
           "また後で会いましょう！")
      (let ((door (eval 'glasdrin-inn-room-1-door)))
        ;; is the room still open?
        (if (not (door-locked? (kobj-gob door)))
            ;; yes - remind player
            (say knpc "1号室は町を離れるまではあなたの部屋です！")
            ;; no - ask if player needs a room
            (begin
              (say knpc "お部屋が必要ですか？")
              (if (kern-conv-get-yes-no? kpc)
                  ;; yes - player wants a room
                  (begin
                    (say knpc 
                         "金貨" glasdrin-inn-room-price "枚です。"
                         "町を出るまではあなたの部屋です。"
                         "よろしいですか？")
                    (if (kern-conv-get-yes-no? kpc)
                        ;; yes - player agrees to the price
                        (let ((gold (kern-player-get-gold)))
                          ;; does player have enough gold?
                          (if (>= gold glasdrin-inn-room-price)
                              ;; yes - player has enough gold
                              (begin
                                (say knpc "ありがとうございます！お部屋は1号室です。"
                                     "ごゆっくりどうぞ。")
                                (kern-player-set-gold 
                                 (- gold 
                                    glasdrin-inn-room-price))
                                (send-signal knpc door 'unlock)
                                (kern-conv-end)
                                )
                              ;; no - player does not have enouvh gold)
                              (say knpc "ああ、残念ですが料金が足りません！"
                                   "お金を稼いだらぜひおこしください。" )))
                        ;; no - player does not agree to the price
                        (say knpc "泊まっていただけるとうれしいのですが。"
                             "珍しいお客様ですね！")))
                  ;; no - player does not want a room
                  (say knpc "ああ、残念です。"
                       "変わったお客様ですね！"
                       "またの機会にどうぞ。")))))))

;; Inn...
(define (ange-inn knpc kpc)
  (say knpc "城壁はすばらしい宿と思っております。"))

(define (ange-adve knpc kpc)
  (say knpc "知っているかもしれませんが、全てのグラスドリン市民には兵役の義務があります。"
       "私はかつて補給部隊に所属していて、警備の聖騎士と同行していました。"))

(define (ange-patr knpc kpc)
  (say knpc "よい任務でした。星の下の陣はすばらしいものでした。"
       "でも、巨人の襲撃で全てが台無しにされました。"))

(define (ange-gint knpc kpc)
  (say knpc "巨人は姿は人間と似ていますが、巨大で頭が二つあります。"
       "かつて山には普通にいましたが、グラスドリンの警備のおかげで洞窟に追いやることができました。"
       "彼らは最も凶暴で恐るべき存在です。"
       "巨人が重装備の戦士を石ころのように投げつけるのを見たことがあります！"))

;; Townspeople...
(define (ange-glas knpc kpc)
  (say knpc "グラスドリンはすばらしい町です。そう思いませんか？")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "まったくです。")
      (say knpc "旅の中ですばらしい町をいくつも見てきたのでしょうね。"
           "私はこの町を愛しています。ここは私の家です。")))

(define (ange-patc knpc kpc)
  (say knpc "眼帯先生はこのあたりで最も優れた医師です。"
       "傷がひどくなければ、最近亡くなった人を蘇生することもできます。"))

(define ange-conv
  (ifc glasdrin-conv

       ;; basics
       (method 'default ange-default)
       (method 'hail ange-hail)
       (method 'bye ange-bye)
       (method 'job ange-job)
       (method 'name ange-name)
       (method 'join ange-join)
       
       ;; trade
       (method 'trad ange-trade)
       (method 'room ange-trade)
       (method 'buy ange-trade)
       (method 'sell ange-trade)

       ;; inn
       (method 'inn  ange-inn)
       (method 'adve ange-adve)
       (method 'gint ange-gint)
       (method 'patr ange-patr)

       ;; town & people
       (method 'glas ange-glas)
       (method 'patc ange-patc)

       ))

(define (mk-angela)
  (bind 
   (kern-mk-char 'ch_angela          ; tag
                 "エンジェラ"        ; name
                 sp_human            ; species
                 nil                 ; occ
                 s_townswoman        ; sprite
                 faction-glasdrin         ; starting alignment
                 0 1 0               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 3  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'ange-conv          ; conv
                 sch_ange            ; sched
                 'townsman-ai                 ; special ai
                 (mk-inventory (list (list 1 t_dagger)))                 ; container
                 (list t_dagger
					         )                  ; readied
                 )
   (ange-mk)))
