;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define angriss-lvl 20)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; アングリスの住み家
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (angriss-mk)
  (list #f (mk-quest)))

(define (angriss-quest angriss) (cadr angriss))
(define (angriss-spoke? angriss) (car angriss))
(define (angriss-spoke! angriss) (set-car! angriss #t))

;;----------------------------------------------------------------------------
;; Conv
;;
;; アングリスはクモたちの女王で、アングリスの住み家にいる。
;; 疑り深く、嫉妬深い、異形のものである。
;;----------------------------------------------------------------------------

;; Basics...
(define (angriss-hail knpc kpc)
  (say knpc "おぞましく柔らかな\n"
       "招かざるものよ　今すぐ決めよ\n"
       "崇拝か死か"))

(define (angriss-default knpc kpc)
  (say knpc "［網の中の彼女は像のように反応しなかった。］"))

(define (angriss-name knpc kpc)
  (say knpc "人にはアングリス\n"
       "ゴブリンにはルカ\n"
       "トロルにはヒブリミノス\n"))

(define (angriss-join knpc kpc)
  (say knpc "唇が器と会えども\n"
       "乾いたものは吸えぬ\n"
       "妾と人はそのようなもの"))

(define (angriss-job knpc kpc)
  (say knpc "飢え"))

(define (angriss-bye knpc kpc)
  (say knpc "汝は光の支配に\n"
       "呼び出されしもの　たどり着けるのであれば\n"
       "上り戻るがよい\n"))


(define (angriss-soft knpc kpc)
  (say knpc "暗きワインを飲むとき\n"
       "人は葡萄を潰す　妾は人を\n"
       "潰したワインを飲む"))

(define (angriss-hung knpc kpc)
  (say knpc "血の川が\n"
       "妾の巣に流れ込む\n"
       "骨蝋の山とともに"))

(define (angriss-men knpc kpc)
  (say knpc "何と誇らしい鎧\n"
       "何と柔らかい中身\n"
       "何と甘い愚かさ"))

(define (angriss-gobl knpc kpc)
  (say knpc "忍び足の狩人\n"
       "不愉快なもがき\n"
       "ついには長き眠り"))

(define (angriss-trol knpc kpc)
  (say knpc "石を投げ　岩で打つ\n"
       "恐ろしい怒鳴り声は\n"
       "悲鳴へと変わる"))

(define (angriss-choose knpc kpc)
  (say knpc "妾への捧げものを選べ")
  (let ((kchar (kern-ui-select-party-member))
        (quest (angriss-quest (kobj-gob-data knpc))))
    (if (null? kchar)
        (begin
          (say knpc "妾をもてあそぶか　消えよ")
          (harm-relations knpc kpc)
          (harm-relations knpc kpc)
          (kern-conv-end))
        (if (is-dead? kchar)
            (begin
              (say knpc "新しき肉を妾は求む！\n"
                   "毒！腐敗！これは死した血！\n"
                   "他を捧げよ")
              (kern-conv-end))
            (begin
              (say knpc "妾は満たされた\n")
              (if (not (quest-done? quest))
                  (quest-done! quest #t))
              (kern-char-leave-player kchar)
              (kern-being-set-base-faction kchar faction-none)
              (improve-relations knpc kpc)
              (kern-conv-end))))))


(define (angriss-rune knpc kpc)
  (let ((quest (angriss-quest (kobj-gob-data knpc))))
    (if (quest-done? quest)
        (begin
          (say knpc "太古の秘密\n"
               "地獄への鍵\n"
               "汝のものなり")
          (kern-obj-remove-from-inventory knpc t_rune_f 1)
          (kern-obj-add-to-inventory kpc t_rune_f 1)
          (rune-basic-quest 'questentry-rune-f s_runestone_f)
         )
        (say knpc "汝の探し物を妾は知る\n"
             "だがまずは\n"
             "犠牲で妾を満たせ"))))

(define (angriss-sacr knpc kpc)

  (define (player-alone?)
    (< (num-player-party-members) 
       2))

  (let ((quest (angriss-quest (kobj-gob-data knpc))))

    (define (refused)
      (say knpc "妾の前から消えよ\n"
           "妾の怒りからは逃げられよう\n"
           "だが　戻ることはできぬであろう")
      (harm-relations knpc kpc)
      (harm-relations knpc kpc)
      (kern-conv-end))

    (define (offer-quest)
      (display "offer-quest")(newline)
      (if (player-alone?)
          (begin
            (say knpc "見つけよ　求めるなら\n"
                 "愚か者を引き込み　差し出せ\n"
                 "汝より愚かなものを\n"
                 "［…どうする？］")
            (if (kern-conv-get-yes-no? kpc)
                (begin
                  (quest-accepted! quest)
                  (improve-relations knpc kpc)
                  (improve-relations knpc kpc))
                (refused)))
          (begin
            (say knpc "汝らの中から\n"
                 "一人の犠牲を選べ\n"
                 "されば自由になろう\n"
                 "［…どうする？］")
            (if (kern-conv-get-yes-no? kpc)
                (angriss-choose knpc kpc)
                (refused)))))
            
    (if (quest-done? quest)
        (say knpc "それは成し遂げられた")
        (if (quest-accepted? quest)
            (if (player-alone?)
                (say knpc "汝は一人なり\n"
                     "捕らえし死すべき定めの\n"
                     "犠牲はいずこ")
                (choose-victim))
            (offer-quest)))))


(define (angriss-hono knpc kpc)
  (say knpc "妾は崇拝を求む\n"
       "そして犠牲を　妾に与えよ\n"
       "しからずば逃亡か死か"))

(define angriss-conv
  (ifc basic-conv

       ;; basics
       (method 'default angriss-default)
       (method 'hail angriss-hail)
       (method 'bye angriss-bye)
       (method 'job angriss-job)
       (method 'name angriss-name)
       (method 'join angriss-join)
       
       (method 'soft angriss-soft)
       (method 'hung angriss-hung)
       (method 'rune angriss-rune)
       (method 'men angriss-men)
       (method 'gobl angriss-gobl)
       (method 'trol angriss-trol)
       (method 'sacr angriss-sacr)
       (method 'hono angriss-hono)
       ))

(define (angriss-ai kchar)
  (if (angriss-spoke? (kobj-gob-data kchar))
      (spider-ai kchar)
      (begin
        (angriss-spoke! (kobj-gob-data kchar))
        (kern-conv-begin kchar))))

(define (mk-angriss)
  (bind 
   (kern-char-force-drop
    (kern-mk-char 
     'ch_angriss         ; tag
     "アングリス"        ; name
     sp_queen_spider     ; species
     nil                 ; occ
     s_purple_spider     ; sprite
     faction-spider ; starting alignment
     20 0 20             ; str/int/dex
     10 5                ; hp mod/mult
     10 5                ; mp mod/mult
     max-health ;;..current hit points
     -1 ;;...........current experience points
     max-health ;;..current magic points
     0
     angriss-lvl
     #f                  ; dead
     'angriss-conv       ; conv
     nil                 ; sched
     'angriss-ai          ; special ai
     
     ;;..........container (and contents)
     (mk-inventory (list (list 1 t_rune_f)))
     nil                 ; readied
     )
    #t)
    (angriss-mk)))
