;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define anne-lvl 4)
(define anne-species sp_human)
(define anne-occ oc_wizard)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; クロポリスの聖騎士の砦
;;----------------------------------------------------------------------------
(define anne-bed ph-bed2)
(define anne-mealplace ph-tbl2)
(define anne-workplace ph-medik)
(define anne-leisureplace ph-dine)
(kern-mk-sched 'sch_anne
               (list 0  0 anne-bed          "sleeping")
               (list 7  0 anne-mealplace    "eating")
               (list 8  0 anne-workplace    "working")
               (list 12 0 anne-mealplace    "eating")
               (list 13 0 anne-workplace    "working")
               (list 18 0 anne-mealplace    "eating")
               (list 19 0 anne-leisureplace "idle")
               (list 22 0 anne-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (anne-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; アンネは白魔術師の女性で、医師としてグラスドリンで働いている。
;; 彼女は現在はクロポリスの聖騎士の砦の任務についている。
;;----------------------------------------------------------------------------

;; Basics...
(define (anne-name knpc kpc)
  (say knpc "アンネと呼ばれています。"))

(define (anne-job knpc kpc)
  (say knpc "グラスドリンの医師です。治療が必要ですか？")
  (if (yes? kpc)
      (anne-trade knpc kpc)))

(define (anne-trade knpc kpc)
  (if (trade-services knpc kpc
                      (list
                       (svc-mk "回復" 30 heal-service)
                       (svc-mk "治癒" 30 cure-service)
                       (svc-mk "蘇生" 100 resurrect-service)))
      (begin
        (say knpc "他に何か必要ですか？")
        (anne-trade knpc kpc))
      (begin
        (say knpc "他に何か必要ですか？")
        (if (kern-conv-get-yes-no? kpc)
            (anne-trade knpc kpc)
            (say knpc "お大事に。")))))

(define (anne-medik knpc kpc)
  (say knpc "戦いで傷ついた聖騎士を治療しています。他の人の治療も行います。料金は必要ですが。"))

(define (anne-kurp knpc kpc)
  (say knpc "ここは経験の浅い人にはつらい場所です。進めば進むほどひどくなります。"))

(define anne-conv
  (ifc kurpolis-conv

       ;; basics
       (method 'job anne-job)
       (method 'name anne-name)
       
       ;; trade
       (method 'trad anne-trade)
       (method 'heal anne-trade)
       (method 'pric anne-trade)

       (method 'medi anne-medik)
       (method 'kurp anne-kurp)
       ))

(define (mk-anne)
  (bind 
   (kern-mk-char 
    'ch_anne           ; tag
    "アンネ"           ; name
    anne-species         ; species
    anne-occ              ; occ
    s_companion_wizard     ; sprite
    faction-men      ; starting alignment
    1 3 2            ; str/int/dex
    0 0              ; hp mod/mult
    0 0              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    anne-lvl
    #f               ; dead
    'anne-conv         ; conv
    sch_anne           ; sched
    'townsman-ai              ; special ai
    nil              ; container
    (list t_sword
					         t_armor_leather
					         )               ; readied
    )
   (anne-mk)))
