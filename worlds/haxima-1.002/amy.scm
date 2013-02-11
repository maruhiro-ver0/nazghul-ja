;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define amy-lvl 1)
(define amy-species sp_human)
(define amy-occ oc_wright)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ���ϱ�(�¤��ͤ���֤ˤʤ�ޤ�)
;;----------------------------------------------------------------------------
(define amy-bed poorh-bed2)
(define amy-mealplace poorh-sup2)
(define amy-workplace poorh-pasture)
(define amy-leisureplace poorh-dining)
(kern-mk-sched 'sch_amy
               (list 0  0 amy-bed          "sleeping")
               (list 7  0 amy-mealplace    "eating")
               (list 8  0 amy-workplace    "working")
               (list 12 0 amy-mealplace    "eating")
               (list 13 0 amy-workplace    "working")
               (list 18 0 amy-mealplace    "eating")
               (list 19 0 amy-leisureplace "idle")
               (list 22 0 amy-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (amy-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; �����ߡ��Ͽ��ͤν������������򼺤äƤ��롣
;; ����ϵ��ϱ��ˤ��롣
;; �����ߡ�����֤ˤ��뤳�Ȥ��Ǥ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (amy-hail knpc kpc)
  (meet "���ʤ��Ϸи�˭�������ʿ��ͤν����Ȳ�ä���")
  (say knpc "����ˤ��ϡ�")
  )

(define (amy-name knpc kpc)
  (say knpc "�����ߡ��ȸƤ�Ǥ���������")
  )

(define (amy-join knpc kpc)
  (if (is-player-party-member? knpc)
      (say knpc "�⤦��֤˲ä�äƤ��ޤ���")
      (begin
        (say knpc "�������äƤ����ȤϻפäƤʤ��ä��")
        (join-player knpc)
        (kern-conv-end)
        )))

(define (amy-job knpc kpc)
  (say knpc "�����ġ������������ȤȤ��Ƥ���Τ�����ɡ�"
       "�Ƕ�Ϥ��ޤ�Ż����ʤ��Τ衣")
  )

(define (amy-bye knpc kpc)
  (say knpc "���褦�ʤ顣")
  )

(define (amy-mean knpc kpc)
  (say knpc "��Ϥ��Ф餷���ͤǤ���"
       "���ε��ϱ��ˤ��ʤ���С���Ϥɤ��ʤäƤ������狼��ޤ���"
       "��ζ��򥸥����뤳�Ȥ�ʤ��Ǥ�����")
  )

(define (amy-tink knpc kpc)
  (say knpc "���������Ϥ��⤯���ͤǤ���"
       "Į����Į�ؤ�ι���������ʿͤΤ�Τ������ޤ���")
  )

(define (amy-luck knpc kpc)
  (say knpc "�͡��ϸ��Τ�̼Ԥ˿��м��ˤʤäƤ��ޤ���"
       "�ߤ�ʼ���줿�ԤΤ����Ǥ���")
  )
  
(define (amy-accu knpc kpc)
  (say knpc "����줿�ԤȤ����Τϰ�����Ҥ�����̩�μٶ��ο��Ԥ����Ǥ���")
  )

;; Quest-related

(define amy-conv
  (ifc basic-conv

       ;; basics
       (method 'hail amy-hail)
       (method 'bye amy-bye)
       (method 'job amy-job)
       (method 'name amy-name)
       (method 'join amy-join)
       

       (method 'mean amy-mean)
       (method 'tink amy-tink)
       (method 'luck amy-luck)
       (method 'accu amy-accu)
       ))

(define (mk-amy)
  (bind 
   (kern-mk-char 
    'ch_amy           ; tag
    "�����ߡ�"             ; name
    amy-species         ; species
    amy-occ              ; occ
    s_companion_tinker ; sprite
    faction-men      ; starting alignment
    2 4 4            ; str/int/dex
    pc-hp-off  ; hp bonus
    pc-hp-gain ; hp per-level bonus
    1 ; mp off
    1 ; mp gain
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    amy-lvl
    #f               ; dead
    'amy-conv         ; conv
    sch_amy           ; sched
    'townsman-ai              ; special ai
    nil              ; container
    (list
     t_armor_leather
     t_leather_helm
     t_sling
     t_sword
    ))
   (amy-mk)))
