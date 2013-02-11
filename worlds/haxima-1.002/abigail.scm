;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define abigail-lvl 1)
(define abigail-species sp_forest_goblin)
(define abigail-occ oc_wrogue)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; �Ф���
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_abigail
               (list 0 0 abigail-bed "sleeping")
               (list 7 0 gt-ws-hall "idle")
               (list 8 0 gt-woods "idle")
               (list 12 0 gt-ws-hall "idle")
               (list 13 0 gt-ruins "idle")
               (list 18 0 gt-ws-hall "idle")
               (list 19 0 gt-tower "idle")
               (list 20 0 abigail-bed "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (abigail-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ���ӥ�����ϥ��֥��ξ����ǡ��Ф���ˤ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (abigail-hail knpc kpc)
  (kern-log-msg "���ʤ��ϥ��֥��λҶ��˲�ä���")
  (say knpc "�ϡ�����")
  )

(define (abigail-default knpc kpc)
  (say knpc "������ϸ��򤹤ܤ᤿����")
  )

(define (abigail-name knpc kpc)
  (say knpc "���Ȥϻ��̾���ϥ��ӥ�������äƸ��äƤ���")
  )

(define (abigail-bye knpc kpc)
  (say knpc "�Х��Х���")
  )

(define (abigail-guto knpc kpc)
  (say knpc "�ɥꥹ�ϻ�Υ��ȤʤΡ�"))

(define (abigail-dori knpc kpc)
  (say knpc "����ϻ�Υ��Ȥ衪"))

(define (abigail-gobl knpc kpc)
  (say knpc "��Τ褦���ФΤҤȡ����ξ���衪"))

(define (abigail-both knpc kpc)
  (say knpc "���֥��Ȥ��ä����ͤȤ��ä����狼�롩ξ���衪"))

(define abigail-conv
  (ifc nil

       ;; basics
       (method 'default abigail-default)
       (method 'hail abigail-hail)
       (method 'bye abigail-bye)
       (method 'name abigail-name)

       (method 'guto abigail-guto)
       (method 'dori abigail-dori)
       (method 'gobl abigail-gobl)
       (method 'both abigail-both)
       ))

(define (mk-abigail)
  (bind 
   (kern-mk-char 
    'ch_abigail           ; tag
    "���ӥ�����"             ; name
    abigail-species         ; species
    abigail-occ              ; occ
    s_goblin_child     ; sprite
    faction-men      ; starting alignment
    0 0 1            ; str/int/dex
    0  ; hp bonus
    0 ; hp per-level bonus
    0 ; mp off
    1 ; mp gain
    max-health ; hp
    0                   ; xp
    max-health ; mp
    0
    abigail-lvl
    #f               ; dead
    'abigail-conv         ; conv
    sch_abigail           ; sched
    'townsman-ai              ; special ai
    nil
    nil              ; readied
    )
   (abigail-mk)))
