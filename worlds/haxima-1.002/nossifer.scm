;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define nossifer-x 16)
(define nossifer-y 6)
(define noss-lvl 20)
(define noss-species sp_balron)
(define noss-occ oc_wizard)

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (noss-mk) (list #f))
(define (noss-spoke? gob) (car gob))
(define (noss-spoke! gob) (set-car! gob #t))

;;----------------------------------------------------------------------------
;; Conv
;;----------------------------------------------------------------------------

;; Basics...
(define (noss-hail knpc kpc)
  (say knpc "ついに我は呼び出された！かくも遅れた罰を誰に与えてくれようぞ。"))

(define (noss-default knpc kpc)
  (say knpc "我の言葉を無駄にする愚か者は死すべし。"))

(define (noss-name knpc kpc)
  (say knpc "眠れる者、ノシファーなり。"))

(define (begin-last-battle knpc kpc)
  (say knpc "汝の霊が虚空に召されることはない。"
       "我の永遠の責め苦を受けるであろう！")
  (kern-being-set-base-faction knpc faction-demon)
  (kern-conv-end))

(define (noss-job knpc kpc)
  (say knpc "我は世界に忘却をもたらす者なり。命じるため悪魔を呼び出す魔術師のことは聞いたことがあろう？")
  (yes? kpc)
  (say knpc "我はそのために人を呼び出した。それが汝だったとしたら？")
  (kern-log-msg "彼は笑った。あたりに硫黄の臭いが立ち込めた。")
  (say knpc "汝は道を開き、その役目を終えた。"
       "今、褒美を与えよう…")
  (quest-data-update 'questentry-whereami 'nossifer 1)
  (kern-being-set-base-faction knpc faction-demon)
  (kern-conv-end))

(define (noss-bye knpc kpc)
  (say knpc "まだだ。話は終わっておらぬ。")
  (prompt-for-key)
  (noss-job knpc kpc))

(define noss-conv
  (ifc nil

       ;; basics
       (method 'default noss-default)
       (method 'hail noss-hail)
       (method 'bye noss-bye)
       (method 'job noss-job)
       (method 'name noss-name)

       ))

(define (noss-ai kchar)
  (warlock-ai kchar))

(define (mk-nossifer)
  (let ((kchar (bind 
                 (kern-mk-char 
                  'ch_nossifer           ; tag
                  "ノシファー"             ; name
                  noss-species         ; species
                  noss-occ              ; occ
                  s_balron          ; sprite
                  faction-men      ; starting alignment
                  20 5 20            ; str/int/dex
                  0 5              ; hp mod/mult
                  0 2              ; mp mod/mult
                  max-health ; hp
                  0                   ; xp
                  max-health ; mp
                  0
                  noss-lvl
                  #f               ; dead
                  'noss-conv       ; conv
                  nil           ; sched
                  'noss-ai  ; special ai
                  nil              ; container
                  (list
                   t_flaming_sword
                   t_armor_plate
                   ))
                (noss-mk))))
    (map (lambda (eff) (kern-obj-add-effect kchar eff nil))
         demon-effects)
    (kern-obj-add-effect kchar ef_charm_immunity nil)
    kchar
    ))
