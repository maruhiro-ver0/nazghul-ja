;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define mesmeme-lvl 2)
(define mesmeme-species sp_gazer)
(define mesmeme-occ oc_wizard)

;;----------------------------------------------------------------------------
;; Schedule
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_mesmeme
               (list 0  0 campfire-1 "sleeping")
               (list 9  0 cantina-6 "idle")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (mesmeme-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;;----------------------------------------------------------------------------

;; Basics...
(define (mesmeme-hail knpc kpc)
  (kern-log-msg "あなたは傷だらけのゲイザーと会った。")
  (say knpc "我、汝を見たり。")
  )

(define (mesmeme-default knpc kpc)
  (say knpc "知らず。答えなし。独りなり。")
  )

(define (mesmeme-name knpc kpc)
  (say knpc "我、メスメメ。")
  )

(define (mesmeme-leav knpc kpc)
  (if (is-player-party-member? knpc)
      (begin
		(say knpc "独り？")
        (if (yes? kpc)
            (begin
              (if (kern-char-leave-player knpc)
                  (begin
                    (say knpc "我、待つ。虚空まで。")
                    (kern-conv-end))
                  (say knpc "ここにあらず！")))
            (say knpc "独りにあらず！")))
      (begin
		(say knpc "虚空まで。")
	    (kern-conv-end)))
  )

(define (mesmeme-join knpc kpc)
  (say knpc "然り！我、独りなり。")
  (join-player knpc)
  (kern-conv-end)
  )

(define (mesmeme-job knpc kpc)
  (say knpc "仕事なし。友なし。独りなり。")
  )

(define (mesmeme-bye knpc kpc)
  (say knpc "虚空まで。")
  )

(define (mesmeme-alon knpc kpc)
  (say knpc "我、負傷せり。話？友？否。独りなり。")
  )

(define (mesmeme-kind knpc kpc)
  (say knpc "友。ゲイザー。虫使い。")
  )

(define (mesmeme-crip knpc kpc)
  (say knpc "巨人の奴隷なり。強し。拘束、傷！")
  )

(define (mesmeme-slav knpc kpc)
  (say knpc "道具、手先。我独りでは足りず！")
  )

(define mesmeme-conv
  (ifc nil

       ;; basics
       (method 'default mesmeme-default)
       (method 'hail mesmeme-hail)
       (method 'bye mesmeme-bye)
       (method 'job mesmeme-job)
       (method 'name mesmeme-name)
       (method 'join mesmeme-join)
       (method 'leav mesmeme-leav)
       
       (method 'alon mesmeme-alon)
       (method 'kind mesmeme-kind)
       (method 'crip mesmeme-crip)
       (method 'slav mesmeme-slav)
       ))

(define (mk-mesmeme)
  (bind 
   (kern-mk-char 
    'ch_mesmeme           ; tag
    "メスメメ"             ; name
    mesmeme-species         ; species
    mesmeme-occ              ; occ
    s_gazer     ; sprite
    faction-men      ; starting alignment
    0 0 0            ; str/int/dex
    (/ pc-hp-off 2)  ; hp bonus
    (/ pc-hp-gain 2) ; hp per-level bonus
    0 ; mp off
    1 ; mp gain
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    mesmeme-lvl
    #f               ; dead
    'mesmeme-conv         ; conv
    sch_mesmeme           ; sched
    'townsman-ai              ; special ai
    nil              ; container
    nil              ; readied
    )
   (mesmeme-mk)))
