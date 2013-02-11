;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define ankh-lvl 9)
(define ankh-species sp_statue)
(define ankh-occ nil)

(kern-mk-map
 'm_hidden_city 19 19 pal_expanded
	(list
	"rn rn rn rn rn rn rn rn rn rn rn rn rn rn rn rn rn rn rn  "
	"rn rn rn rn rn rn rn rn rn rn rn rn rn rn rn rn rn rn rn  "
	"rn rn rn rn rn rn rn rn rn rn rn rn rn rn rn rn rn rn rn  "
	"rn rn rn rn rn r8 r8 r8 r8 r8 r8 r8 r8 r8 rn rn rn rn rn  "
	"rn rn rn rn rc *3 *1 *1 *1 *1 *1 *1 *1 *5 ra rn rn rn rn  "
	"rn rn rn r4 *3 ** *. *8 *8 *8 *8 *8 ** *. *5 r2 rn rn rn  "
	"rn rn rn r4 *2 ** xx xx xx xx xx xx xx ** *4 r2 rn rn rn  "
	".. xx xx xx xx xx xx pp ,, ,, ,, pp xx *2 *4 r2 rn rn rn  "
	"tt ,, ,, ,, ,, ,, ,, ,, cc cc cc ,, xx *2 *4 r2 rn rn rn  "
	".. cc dd cc cc cc cc cc cc cc cc ,, xx *2 *4 r2 rn rn rn  "
	",, ,, .. ,, ,, ,, ,, ,, cc cc cc ,, xx *2 *4 r2 rn rn rn  "
	"xx rn xx xx xx xx xx pp ,, cc ,, pp xx *2 *4 r2 rn rn rn  "
	"rn rn rn r4 *2 *. xx xx ,, cc ,, xx xx *. *4 r2 rn rn rn  "
	"rn rn rn r4 *a *. ** *5 ,, cc ,, *3 ** *. *c r2 rn rn rn  "
	"rn rn rn rn r5 *a ** *4 ,, cc ,, *2 *. *c r3 rn rn rn rn  "
	"rn rn rn rn rn r5 ** *4 ,, cc ,, *2 *. r3 rn rn rn rn rn  "
	"rn rn rn rn rn r4 *2 *4 ,, cc ,, *2 *4 r2 rn rn rn rn rn  "
	"rn rn rn rn rn r4 *2 *4 ,, cc ,, *2 *4 r2 rn rn rn rn rn  "
	"rn rn rn rn rn r4 ** ** ,, cc ,, ** *. r2 rn rn rn rn rn  "
	)
)

;;----------------------------------------------------------------------------
;; Schedule
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (ankh-mk)
  (list #f))
(define (ankh-done? gob) (car gob))
(define (ankh-done! gob) (set-car! gob #t))

;;----------------------------------------------------------------------------
;; Conv
;;----------------------------------------------------------------------------

;; Basics...
(define (ankh-hail knpc kpc)
  (let ((gob (kobj-gob-data knpc)))
    (if (not (ankh-done? gob))
        (begin
          (say knpc "［頭の中で震える声が響いた。］"
               "次の時代の夜明けに、世界はどのようになるか？")
          (let ((resp (kern-conv-get-string kpc)))
            (if (not (string=? resp "サイセイ"))
                (say knpc "ならば新しい時代はまだ訪れないであろう。")
                (begin
                  (say knpc "ならば新しい時代が始まる！")
                  (shake-map 15)
                  (kern-map-flash 500)
                  (shake-map 15)
                  (kern-map-flash 500)
                  (shake-map 15)
                  (ankh-done! gob)
                  (blit-map (loc-place (kern-obj-get-location knpc))
                    0 0 31 31 m_hidden_city)
                  ))
            (kern-conv-end))))))
        

(define ankh-conv
  (ifc basic-conv
       (method 'hail ankh-hail)
       ))

(define (ankh-ai knpc)
  #t)

(define (mk-talking-ankh)
  (bind 
   (kern-mk-char 
    'ch_ankh           ; tag
    "アンク"           ; name
    ankh-species         ; species
    ankh-occ              ; occ
    s_ankh     ; sprite
    faction-men      ; starting alignment
    0 0 0            ; str/int/dex
    0 0              ; hp mod/mult
    0 0              ; mp mod/mult
    (max-hp ankh-species ankh-occ ankh-lvl 0 0) ; hp
    0                   ; xp
    (max-mp ankh-species ankh-occ ankh-lvl 0 0) ; mp
		0
    ankh-lvl
    #f               ; dead
    'ankh-conv         ; conv
    nil           ; sched
    'ankh-ai              ; special ai
    nil              ; container
    nil              ; readied
    )
   (ankh-mk)))
