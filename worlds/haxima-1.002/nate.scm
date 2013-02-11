;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define nate-start-lvl 2)

;;----------------------------------------------------------------------------
;; Schedule
;;
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (nate-mk) (list #f #f))
(define (nate-caught? gob) (car gob))
(define (nate-caught! gob) (set-car! gob #t))
(define (nate-met? gob) (cadr gob))
(define (nate-met! gob) (set-car! (cdr gob) #t))

;;----------------------------------------------------------------------------
;; Conv
;;
;; �ͥ��Ȥ���±��Ƭ�Ǥ��롣
;;----------------------------------------------------------------------------
(define (nate-hail knpc kpc)
  (let ((nate (kobj-gob-data knpc)))
    (define (join)
      (say knpc "�Թ礬�����Ȥ�����̩�ˤĤ���ʹ���Ƥ���������ö�ᡣ"
           "����ޤ����Ф�ƨ�����ꤷ�䤻��")
      (join-player knpc)
      (give kpc t_arrow 20)
      (nate-caught! nate)
      (quest-data-update-with 'questentry-bandits 'captured-nate 1 (quest-notify nil))
      )
    (nate-met! nate)
    (cond ((nate-caught? nate)
           (say knpc "���Ǥ���äƤ���������")
           )
          (else
           (say knpc "�����Ԥ衢�������������ͳ�Ϥʤ���"
                "��ߤϤ�ä����Ǥ�ͻ����Ϥ��Ƥͤ���"
                "��������Ƥ��졣��������Ф�������̩�򶵤��Ƥ�롣"
                "�ɤ�����")
           (cond ((yes? kpc) (join))
                 (else
                  (say knpc "ö�ᡪ���򻦤�����̩�ϲ��Ȱ��˾ä����ޤ������"
                       "��ࡢ���Ϥ��󤿤���֤ˤʤäơ����󤿤Τ������äơ����󤿤�Ť��ϤΤ�Ȥ�Ƴ�����������"
                       "ȴ���Ф����ꤷ�ͤ���"
                       "���θ�ǲ���֥�Ȣ������ʤꡢƨ�����ʤ깥���ʤ褦�ˤ��Ƥ��졣"
                       "�ɤ�����")
                  (cond ((yes? kpc) (join))
                        (else
                         (say knpc "���������ۤ򻦤��ʤ�Ʒ���ޤ�ʤ��ۤ���")
                         (kern-conv-end)
                         ))))))))

(define (nate-secr knpc kpc)
  (cond ((is-player-party-member? knpc)
         (cond ((equal? (get-place knpc) p_shard)
                (say knpc "�֥��ǥ����ɤα����줿������򶵤����ޤ�����"))
               (else
                (say knpc "ö�ᡪ�����ϰ����ǤϤ���ޤ��󤼡�����ؽФƤ��줫���ä��䤷�礦��")
                )))
        (else
         (say knpc "�����ʤ���̩�ϰ�������")
         )))

(define (nate-brun knpc kpc)
  (if (is-player-party-member? knpc)
      (say knpc "ö�ᡢ����ƻ���̤˿ʤ�����ν�ǥ֥��ǥ����ɤ�õ���䤷�礦��"
           "�����ǹ���դ򶵤��ޤ�����")
      (say knpc "���θ��դ�����ʡ�")))

(define (nate-pass knpc kpc)
  (if (is-player-party-member? knpc)
      (cond ((equal? (get-place knpc) p_brundegardt)
             (say knpc "���������������褯���Ĥ��䤷����ö�ᡣ����դϡ�"
                  "����ϻ��򤫤����᤿��"
                  "�ĥΥ�������Ϥ���©��Ĥ������Ϲ���դϥΥ�����")
             (prompt-for-key)
             (say knpc "ö�ᡢ���ꤤ������䤹��"
                  "���ä�Ĺ���֡��֥��ǥ����ɤ�������ˡ��õ������äȤΤ��Ȥ���̩�򸫤Ĥ��䤷����"
                  "����Ϣ��ƹԤäƤ���������������������Ӥ䤷�礦�����ʤ�ȿ����դ��Ƥ���������"
                  "���ꤲ�����䤹��")
             (cond ((yes? kpc)
                    (say knpc "�����ϰ���˺��䤻�󡪤Ǥ⤳����Ĺ�����ȱ�����Ƥ��䤷����"
                         "��˲������뤫ʬ����䤻��"
                         "������������������ƻ���Ǥ���������äƹԤ��䤷�礦��")
                    (prompt-for-key)
                    (say knpc "�Ǥ⡢�������ڤʤΤϡ���ʸ��Ĵ�礹�뤿��������Ǥ䤹��"
                         "ö�����ѻդ�ǽ�Ϥ�����Ф褤�ΤǤ䤹����"
                         "���θ��դ�Ф��Ƥ��Ƥ����������֤���򽪤���С����줬ɬ��ɬ�פˤʤ롣��"))
                   (else
                    (say knpc "�ͤ��ʤ����Ƥ����������Ǥ⡢�⤷����Ϣ��ƹԤ��ͤ��Τʤ顢"
                         "�ٹ��ʹ���Ƥ���������"
                         "ö��Τ褦�ʤ���äȤ�����ΤǤ⡢��ͤǥ֥��ǥ����ɤ����äƤϤ����䤻��"
                         "��ߤ䶯å��ǽ�Ϥ�����Ԥ�Ϣ��Ƥ����٤��Ǥ䤹��")
                    )))
             (else
              (say knpc "�Ǥ�ö�ᡪ�����ϥ֥��ǥ����ɤǤϤ���䤻��")
              ))
      (say knpc "����ա����ι���դ���")
      ))

(define nate-conv
  (ifc basic-conv
       (method 'name (lambda (knpc kpc) (say knpc "�ͥ��ȤȸƤФ�Ƥ��롣")))
       (method 'brun nate-brun)
       (method 'hail nate-hail)
       (method 'pass nate-pass)
       (method 'secr nate-secr)
       ))

(define nate-greetings
  (list
   "�������롪"
   "�����ʤ��Ǥ��졪"
   "��ޤ��Ƥ��졪"
   "���Τࡢϴ����Ϣ��ƹԤäƤ��졪"
   ))

(define (nate-ai knpc)
  (let ((nate (kobj-gob-data knpc)))
    (cond ((nate-met? nate) (std-ai knpc))
          ((any-player-party-member-visible? knpc)
           (taunt knpc nil nate-greetings)
           #t)
          (else
           (std-ai knpc)
           )
          )))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-nate)
  (bind 
   (kern-char-arm-self
    (kern-mk-char 
     'ch_nate ;;..........tag
     "�ͥ���" ;;.......name
     sp_human ;;.....species
     oc_wrogue ;;.. .occupation
     s_companion_bard ;;..sprite
     faction-outlaw ;;..faction
     +1 ;;...........custom strength modifier
     0 ;;...........custom intelligence modifier
     +6 ;;...........custom dexterity modifier
     pc-hp-off ;;............custom base hp modifier
     pc-hp-gain ;;............custom hp multiplier (per-level)
     0 ;;............custom base mp modifier
     0 ;;............custom mp multiplier (per-level)
     max-health ;;..current hit points
     -1  ;;...........current experience points
     max-health ;;..current magic points
     0
     nate-start-lvl  ;;..current level
     #f ;;...........dead?
     'nate-conv ;;...conversation (optional)
     nil ;;sch_nate ;;.....schedule (optional)
     'nate-ai ;;..........custom ai (optional)

     ;;..............container (and contents)
     (mk-inventory
      (list
       (list 20 t_arrow)
       (list 1   t_bow)
       (list 1   t_dagger)
       (list 1   t_sword)
       (list 1   t_leather_helm)
       (list 1   t_armor_leather)
       (list 5   t_heal_potion)
       ))

     nil ;;.........readied arms (in addition to the container contents)
     nil ;;..........hooks in effect
     ))
   (nate-mk)))
