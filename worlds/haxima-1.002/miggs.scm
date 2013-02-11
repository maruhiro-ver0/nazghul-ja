;;----------------------------------------------------------------------------
;; Schedule
;;
;; トリグレイブ
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_miggs
               (list 0  0  trigrave-miggs-bed      "sleeping")
               (list 7  0  trigrave-tavern-kitchen "working")
               (list 23 0  trigrave-miggs-bed      "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (miggs-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;;
;; メグスは酒場の主人である
;;----------------------------------------------------------------------------
(define miggs-merch-msgs
  (list "酒場が開いているときに来てください。午前7時から深夜までです。"
        "［彼女は黙ってメニューを指差した。］"
        nil
        nil
        "ありがとう。"
        "そうですか。"
        ))

(define miggs-catalog
  (list
   (list t_food 5 "［彼女はおいしそうなにおいのシチューをすくって見せた。］")
   (list t_beer 3 "［彼女はフェンマイアの特級と書かれたラベルの樽を指差した。］")
  ))

(define (miggs-trade knpc kpc) (conv-trade knpc kpc "buy" miggs-merch-msgs miggs-catalog))

(define (miggs-hail knpc kpc)
  (kern-print "［あなたは大柄なかわいらしい顔立ちの女性と会った。"
              "彼女は恥ずかしそうに視線を避けた。］\n"))

(define (miggs-job knpc kpc)
  (say knpc "この「陽気な杯」をしています。"))

(define (miggs-lust knpc kpc)
  (say knpc "ここは酒場です。何かいりますか？")
  (if (kern-conv-get-yes-no? kpc)
      (miggs-trade knpc kpc)
      (say knpc "そうですか。")))

(define miggs-conv
  (ifc basic-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default (lambda (knpc kpc) (say knpc "［彼女は黙ったままだ。］")))
       (method 'hail miggs-hail)
       (method 'bye (lambda (knpc kpc) (say knpc "［彼女は少し微笑んだ。］")))
       (method 'job miggs-job)       
       (method 'name (lambda (knpc kpc) (say knpc "メグス。")))

       (method 'trad miggs-trade)
       (method 'buy miggs-trade)
       (method 'food miggs-trade)
       (method 'lust miggs-lust)
       (method 'jugs miggs-lust)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-miggs tag)
  (bind 
   (kern-mk-char tag                 ; tag
                 "メグス"            ; name
                 sp_human            ; species
                 nil                 ; occ
                 s_fat_townswoman    ; sprite
                 faction-men         ; starting alignment
                 2 0 0             ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 3  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'miggs-conv        ; conv
                 sch_miggs          ; sched
                 'townsman-ai                 ; special ai
                  nil                ; container
                 (list t_dagger)                 ; readied
                 )
   (miggs-mk)))
