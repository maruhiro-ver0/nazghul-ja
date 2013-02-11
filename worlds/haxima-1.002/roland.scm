;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (roland-mk free? joined? greeted?) (list free? joined? greeted?))
(define (roland-is-free? knpc) (car (kobj-gob-data knpc)))
(define (roland-joined? knpc) (cadr (kobj-gob-data knpc)))
(define (roland-greeted? knpc) (caddr (kobj-gob-data knpc)))
(define (roland-set-free! knpc) (set-car! (kobj-gob-data knpc) #t))
(define (roland-set-joined! knpc) (set-car! (cdr (kobj-gob-data knpc)) #t))
(define (roland-set-greeted! knpc) (set-car! (cddr (kobj-gob-data knpc)) #t))

(define roland-greetings
  (list
   "こんにちは！"
   "もし、迷い人殿！"
   ))

;;----------------------------------------------------------------------------
;; Custom AI
;; 
;; This AI controls Roland until he is freed. It constantly tries to pathfind
;; to the prison exit. Once it gets outside the cell it sets the "freed" flag
;; and resorts to the default kernel AI.
;;----------------------------------------------------------------------------
(define (roland-exit-point knpc)
  (mk-loc (kobj-place knpc)
          (rect-x slimey-cavern-prison-cell-exit)
          (rect-y slimey-cavern-prison-cell-exit)))

(define (roland-ai knpc)
  (define (out-of-cell?)
    (not (loc-in-rect? (kern-obj-get-location knpc)
                       slimey-cavern-prison-cell)))
  (define (try-to-escape)
    (kern-log-enable #f)
    (pathfind knpc (roland-exit-point knpc))
    (kern-log-enable #t))
  (define (set-free)
    (roland-set-free! knpc)
    (kern-char-set-ai knpc nil)
    (kern-being-set-base-faction knpc faction-men)
    )
  (or (roland-greeted? knpc)
      (and (any-player-party-member-visible? knpc)
           (begin
             (taunt knpc nil roland-greetings)
             (roland-set-greeted! knpc))))
  (if (out-of-cell?)
      (set-free knpc)
      (try-to-escape)))

;; Note: (can-pathfind? ...) will pathfind through the locked door nowadays, so
;; it cannot be relied on. Let's just let Roland try to get out and he'll know
;; he's free.
(define (roland-is-or-can-be-free? knpc)
  (roland-is-free? knpc))

(define (roland-join-player knpc)
  (or (roland-joined? knpc)
      (begin
        (join-player knpc)
        (roland-set-joined! knpc #t))))

;;----------------------------------------------------------------------------
;; Conv
;;
;; ローランドは旅の騎士で、クロービス王に仕えていた。
;; 彼は今では粘菌の洞窟の牢に捕らえられている。
;; ローランドは仲間になる。
;;----------------------------------------------------------------------------
(define (roland-join knpc kpc)
  (if (is-player-party-member? knpc)
      (say knpc "そう。既に仲間になっている。お導きくだされ！")
      (if (roland-joined? knpc)
          (begin
            (say knpc "再び仲間に加わったことを名誉に思う。")
            (join-player knpc)
            (kern-conv-end)
            )
          (if (roland-is-or-can-be-free? knpc)
              ;; yes - will the player accept his continued allegiance to
              ;; Froederick?
              (begin
                (say knpc "解放してくれたことに感謝する！あなたは命の恩人だ。あなたの仲間に加わりたい。どうだろうか？")
                (if (yes? kpc)
                    (begin
                      (say knpc "光栄に思う！"
                           "ならず者たちは私の鎧や持ち物を奪った。"
                           "このあたりにあるはずだ。")
                      (roland-join-player knpc))
                    (say knpc "［悲しそうに］そう望むなら。")))
              (say knpc "牢に閉じ込められてしまったのだ！ここから出して、"
                   "仲間にしてくだされ。")
              ))))
  
(define roland-conv
  (ifc basic-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default 
               (lambda (knpc kpc) 
                 (say knpc "残念ながら、それは手助けできそうにない。")))
       (method 'hail 
               (lambda (knpc kpc) 
                 (if (roland-joined? knpc)
                     (say knpc "できるならあなたのお手伝いがしたい。")
                     (roland-join knpc kpc))))

       (method 'bye (lambda (knpc kpc) (say knpc "さようなら。")))
       (method 'job 
               (lambda (knpc kpc) 
                 (say knpc "旅の騎士だ。")))
       (method 'name (lambda (knpc kpc) (say knpc "私はローランドだ。")))
       (method 'join roland-join)

       (method 'cell
               (lambda (knpc kpc)
                 (say knpc "鍵開け道具があれば扉を開けられる。"
                      "そうでなければ、扉を開ける呪文を唱えてくだされ。")))
       (method 'clov
               (lambda (knpc kpc)
                 (say knpc "私は王が倒れた日、共に戦っていたのだ。"
                      "王と私は敵の待ち伏せに会い、気を失った。"
                      "その時、隠れていた獣が王を地獄に引きずり込む夢を見た。"
                      "目が覚めると、私は野戦病院にいたのだ。")))
       (method 'free
               (lambda (knpc kpc)
                 (say knpc "待ち伏せにあい、この洞窟に誘拐されてしまったのだ。"
                      "奴らは私をこの牢に閉じ込め、身代金を要求している。")))
       (method 'pick
               (lambda (knpc kpc)
                 (say knpc "盗賊は常に鍵開け道具を持っている。")))
       (method 'spel
               (lambda (knpc kpc)
                 (say knpc "呪文は魔術師に聞いてくだされ。")))
       (method 'trig 
               (lambda (knpc kpc) 
                 (say knpc "トリグレイブは北の道が交差するところにある小さな町だ。"
                      "そこには長い歴史がある。")))
       (method 'knig 
               (lambda (knpc kpc)
                 (say knpc "私はゴブリン戦争のころクロービス王に仕えていた。"
                      "戦争が終わり、放浪するようになった。")
                 ))
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-roland)
  (bind 
    (kern-mk-char 
     'ch_roland          ; tag
     "ローランド"        ; name
     sp_human            ; species
     oc_warrior          ; occ
     s_knight            ; sprite
     faction-prisoner    ; starting alignment
     6 0 6               ; str/int/dex
     pc-hp-off           ; hp bonus
     pc-hp-gain          ; hp per-level bonus
     0                   ; mp off
     0                   ; mp gain
     max-health          ; hp
     -1                  ; xp
     max-health          ; mp
     0                   ; ap
     3                   ; lvl
     #f                  ; dead
     'roland-conv        ; conv
     nil                 ; sched
     'roland-ai          ; special ai
     nil                 ; container
     nil                 ; readied
     )
    (roland-mk #f #f #f)))
