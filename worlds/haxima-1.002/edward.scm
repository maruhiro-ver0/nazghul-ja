;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define edward-start-lvl 4)

;;----------------------------------------------------------------------------
;; Schedule
;;
;; �Ф�����ϲ�
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_edward
               (list 0  0  gtl-jailor-bed "sleeping")
               (list 7  0  gtl-jail       "working" )
               (list 21 0  gtl-jailor-bed "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (edward-mk) (list #f #f))
(define (edward-met? gob) (car gob))
(define (edward-meet! gob) (set-car! gob #t))
(define (edward-has-nate? gob) (cadr gob))
(define (edward-has-nate! gob) (set-car! (cdr gob) #t))

;;----------------------------------------------------------------------------
;; Conv
;;
;; ���ɥ�ɤ����ܤ�Ϸ�ͤǡ��Ф�����ϲ��ǴǼ�λŻ��򤷤Ƥ��롣
;;----------------------------------------------------------------------------
(define (edward-hail knpc kpc)
  (meet "���ʤ��Ͽ�����ܤ����ä�Ϸ�ͤȲ�ä���")
  (let ((edward (kobj-gob-data knpc)))
    (cond ((not (edward-met? edward))
           (say knpc "ï������Τ���̾��졪")
           (reply? kpc)
           (edward-meet! edward)
           (say knpc "�Τ�ʤ���Ĥ���æ�������Τ���")
           (if (yes? kpc)
               (say knpc "���ä��ȹԤ������󤿤�ߤ��ˤ�ǯ���ꤹ���Ƥ��롣")
               (say knpc "�¿�������ï���ä���꤬���ʤ��ΤǤ͡�")
               )
           )
          (else
           (say knpc "�ޤ��褿�͡�­���Ǥ狼�ä��衣")
           ))))

(define (edward-give-nate knpc kpc)
  (say knpc "���ͤ�Ϣ��Ƥ����Τ���")
  (cond ((yes? kpc)
         (cond ((is-only-living-party-member? ch_nate)
                (say knpc "�⤷�����������ʤ顢���󤷤ʤ�����"
                     "���������λ��Τ򲿤Ȥ����Ƥ������"
                     "�����ϻ����֤���ǤϤʤ���")
                )
               (else
                (say knpc "����������������֤��������襤������ϥͥ��Ȥ������ꡢ��˼�����츰�򤫤�������")
                (kern-char-leave-player ch_nate)
                (kern-obj-relocate ch_nate (mk-loc p_green_tower_lower 9 10) nil)
                (prompt-for-key)
                (say knpc "���줬�����������Ĺ���Ϥ��ʤ�����")
                (give (kern-get-player) t_prisoner_receipt 1)
                (edward-has-nate! (kobj-gob-data knpc))
                (quest-data-update-with 'questentry-bandits 'nate-given-to-jailor 1 (quest-notify nil))                
                )))
        (else
         (say knpc "��������������ϥͥ��Ȥ�������������򤹤��᤿����")
         )))

(define (edward-pris knpc kpc)
  (cond ((in-player-party? 'ch_nate) (edward-give-nate knpc kpc))
        (else
         (let ((edward (kobj-gob-data knpc)))
           (if (edward-has-nate? edward)
               (say knpc "���Ͽ����֥��ȡ����󤿤�Ϣ��Ƥ����ۤ����롣")
               (say knpc "�ǶΌ���֥�����ä���"
                    "��ĤȤϸߤ������򤷤����ʤ�����������Ȥ��ä��ä򤷤ʤ��櫓�ǤϤʤ���"))))
        ))

(define (edward-gobl knpc kpc)
  (say knpc "���������ȤϤʤ�����Ĥ�ϴ���ä��ʤ���"))

(define (edward-stor knpc kpc)
  (say knpc "����ˤĤ���ʹ�������Ȥ����뤫��")
  (cond ((no? kpc)
         (say knpc "����Ϥ��ĤƤ��ο��˸��줿��"
              "�礬�����������������Ƥ����ΤΤ��Ȥ���")
         (prompt-for-key kpc)
         (say knpc "���������������������ο��˰�ͤ��¤�������Ȥ���"
              "����ϴ�Ω���Τ褤���ͤȤ��ƻѤ򸽤�����"
              "̼�Ͽ��α��ؤ�Ͷ�����ޤ졢�Ĥ����ڤˤʤäƤ��ޤä���")
         (prompt-for-key kpc)
         (say knpc "���줬���ι������ο��λϤޤ����"
              "�����ƺ��Ǥ�¿����ͩ��Τ褦���ڡ���������ͳ����")
         )
        (else
         (say knpc "����Ȥϲ��ʤΤ���ï���Τ�ʤ���"
              "¾�ο�����Ʊ���褦�����������")
         )))

(define (edward-gate knpc kpc)
  (say knpc "��Τ��ȤϤ狼��ʤ������ĤƤ���Ϥ��ä����ΤäƤ���ΤϤ����������"))

(define (edward-gods knpc kpc)
  (say knpc "�Ť��������ä򤹤�ΤϤ褯�ʤ���"
       "�����ʹ�����ȼ�����ȸ����Ƥ��롣"))

(define (edward-accu knpc kpc)
  (say knpc "�Ť������μ���줿�ϡġ�"
       "����ϴ���ˤ⤽��Ϥ��롣"))

(define (edward-talk knpc kpc)
  (say knpc "�����Ǥϼ��ͤ����ä���꤬���ʤ���"))

(define (edward-blin knpc kpc)
  (say knpc "�ŰǤϲ��Ǥ�ʤ�������˸����и��ⲿ�Ǥ�ʤ���"
       "�ɤ����Ʊ�����Ȥ���"))

(define (edward-guar knpc kpc)
  (say knpc "��ľ�˸����ȡ���ޤ�����Ȥϻפ��ʤ���"))

(define (edward-jail knpc kpc)
  (cond ((in-player-party? 'ch_nate) (edward-give-nate knpc kpc))
        (else
         (say knpc "���ͤ˿�����Ϳ�����ä��򤹤롣"
              "��Ĥ餬ƨ����Τ��ɤ����ܤ⤢�롣")
         )))

(define edward-conv
  (ifc ranger-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default 
               (lambda (knpc kpc) 
                 (say knpc "����ϸ��򤹤��᤿����")))
       (method 'hail edward-hail)
       (method 'bye 
               (lambda (knpc kpc) 
                 (say knpc "�Ť����鵤��Ĥ��ơ�")))
       (method 'job 
               (lambda (knpc kpc) 
                 (say knpc "�Ǽ����")))
       (method 'name 
               (lambda (knpc kpc) 
                 (say knpc "���ɥ�ɤ������󤿤�̾����ʹ���Ƥ��롣")))
       (method 'join 
               (lambda (knpc kpc) 
                 (say knpc "�����������͡��Τ����Ǥ��ʤ�����")))
       (method 'accu edward-accu)
       (method 'blin edward-blin)
       (method 'esca edward-guar)
       (method 'gate edward-gate)
       (method 'gobl edward-gobl)
       (method 'god  edward-gods)
       (method 'gods edward-gods)
       (method 'guar edward-guar)
       (method 'jail edward-jail)
       (method 'old  edward-gods)
       (method 'pris edward-pris)
       (method 'stor edward-stor)
       (method 'talk edward-talk)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-edward)
  (bind 
   (kern-char-arm-self
    (kern-mk-char 
     'ch_edward ;;..........tag
     "���ɥ��" ;;.......name
     sp_human ;;.....species
     oc_ranger ;;.. .occupation
     s_old_townsman ;;..sprite
     faction-men ;;..faction
     0 ;;...........custom strength modifier
     0 ;;...........custom intelligence modifier
     0 ;;...........custom dexterity modifier
     0 ;;............custom base hp modifier
     0 ;;............custom hp multiplier (per-level)
     0 ;;............custom base mp modifier
     0 ;;............custom mp multiplier (per-level)
     max-health ;;..current hit points
     -1  ;;...........current experience points
     max-health ;;..current magic points
     0
     edward-start-lvl  ;;..current level
     #f ;;...........dead?
     'edward-conv ;;...conversation (optional)
     sch_edward ;;.....schedule (optional)
     'townsman-ai ;;..........custom ai (optional)

     ;;..............container (and contents)
     (mk-inventory
      (list
       (list 1 t_torch)
       (list 1 t_dagger)
       ))
     (list t_armor_leather)                ; readied ;;.........readied arms (in addition to the container contents)
     nil ;;..........hooks in effect
     ))
   (edward-mk)))
