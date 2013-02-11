;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define kalc-lvl 6)
(define kalc-species sp_human)
(define kalc-occ oc_wizard)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ���륷�ե�������¿���ξ���(������Ȥä�)ι���������ʤɤ򱿤�Ǥ��롣
;;----------------------------------------------------------------------------
(define kalc-bed cheerful-bed-2)
(define kalc-mealplace )
(define kalc-workplace )
(define kalc-leisureplace )
(kern-mk-sched 'sch_kalc
               (list 0  0 kalc-bed          "sleeping")
               (list 7  0 bilge-water-seat-5 "eating")
               (list 8  0 enchtwr-hall       "idle")
               (list 11 0 g-fountain         "idle")
               (list 12 0 ghg-s6             "eating")
               (list 13 0 eng-workshop       "idle")
               (list 16 0 trigrave-tavern-hall "idle")
               (list 17 0 trigrave-tavern-table-3b "eating")
               (list 19 0 gt-ws-hall           "idle")
               (list 23 0 kalc-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (kalc-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ���륷�ե������Ͻ�������ѻդǡ�¿���η������μ������롣
;; �����¿���ξ���(������Ȥä�)ι���������ʤɤ򱿤�Ǥ��롣
;; ���륷�ե���������֤ˤʤ롣
;;----------------------------------------------------------------------------

;; Basics...
(define (kalc-hail knpc kpc)
  (meet "�Τ��ʤ��Ϥ��襤�餷����ѻդȲ�ä�����")
  (say knpc "����ˤ��ϡ�ι�ͤ���")
  )

(define (kalc-name knpc kpc)
  (say knpc "���륷�ե������Ǥ�����ʤ��ϡġ�")
  (kern-conv-get-reply kpc)
  (say knpc "�񤨤Ƥ��줷���Ǥ��")
  )

(define (kalc-join knpc kpc)
  (if (is-player-party-member? knpc)
      (say knpc "�⤦��֤Ǥ��")
      (begin
        (say knpc "�����Ǥ���ڤ�������")
        (join-player knpc)
        (kern-conv-end)
        )
  ))

(define (kalc-job knpc kpc)
  (say knpc "���ι�򤷤ơ��͡��δ֤������뤳�ȤǤ��")
  )

(define (kalc-bye knpc kpc)
  (say knpc "�ޤ��񤨤뵤�����ޤ��")
  )

(define (kalc-gate knpc kpc)
  (say knpc "�����Ǥ���ɤ��ʤäƤ��뤫��¸�Τ����顩")
  (if (yes? kpc)
      (say knpc "�ɤ����Ƴ��ͤ�Ʊ���褦�ˤ��ʤ��Τ����顣")
      (say knpc "��ߥ����꤬���������ơ������ɤ��꤬�и��η���ΤǤ��Τ衪")))

(define (kalc-lumi knpc kpc)
  (say knpc "��ߥ��ϲ�������ä���ư�����η�Τ��ȤǤ��"))

(define (kalc-ord knpc kpc)
  (say knpc "�����ɤ��Ĥ�®��ư�����η�Ǥ��"))

(define (kalc-engi knpc kpc)
  (say knpc "��ϵ��դ�ˬ�䤷�������ʤ��Ԥΰ�ͤǤ��"
       "������Ȥ�ʤ������ξ��ˤϹԤ��ޤ���Ρ�"
       "�����ɤ�����˶ᤤ�Ȥ�������Ф褤�ΤǤ��"))

(define (kalc-peop knpc kpc)
  (say knpc "��ƻ�դ䵻�ա�Į����ͤ������������Ƥ��ޤ��Ρ�"
       "�������᤯�����򱿤�ɬ�פ����롢�����ʧ�äƤ�������ʤ�ï�Ǥ�Ǥ��"))

(define (kalc-pay knpc kpc)
  (say knpc "�ʤ��ʤ��βԤ��ˤʤ�ޤ��"))

(define kalc-conv
  (ifc basic-conv

       ;; basics
       (method 'default (lambda (knpc kpc) (say knpc "�ɤ������顣")))
       (method 'hail kalc-hail)
       (method 'bye  kalc-bye)
       (method 'job  kalc-job)
       (method 'name kalc-name)
       (method 'join kalc-join)
       
       (method 'gate kalc-gate)
       (method 'lumi kalc-lumi)
       (method 'ord  kalc-ord)
       (method 'engi kalc-engi)
       (method 'peop kalc-peop)
       (method 'erra kalc-peop)
       (method 'pay  kalc-pay)
       ))

(define (mk-kalcifax)
  (bind 
   (kern-mk-char 
    'ch_kalc           ; tag
    "���륷�ե�����"       ; name
    kalc-species         ; species
    kalc-occ              ; occ
    s_blue_wizard
    faction-men      ; starting alignment
    0 7 0            ; str/int/dex
    (/ pc-hp-off 2)  ; hp bonus
    (/ pc-hp-gain 2) ; hp per-level bonus
    pc-mp-off        ; mp bonus
    pc-mp-gain       ; mp per-level bonus
    max-health ; hp
    -1  ; xp
    max-health ; mp
    0
    kalc-lvl
    #f               ; dead
    'kalc-conv         ; conv
    sch_kalc           ; sched
    'townsman-ai              ; special ai
    nil              ; container
    (list            ;; readied
     t_staff
     )
    )
   (kalc-mk)))
