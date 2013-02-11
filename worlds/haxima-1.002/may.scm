;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define may-start-lvl  6)
(define inn-room-price 30)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; �ܥ�
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_may
               (list 0  0  bole-bed-may "sleeping")
               (list 6  0  bole-dining-hall "working")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (may-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; �ᥤ�Ͻɲ��μ�ͤν����ǡ��ܥ�˽���Ǥ��롣
;; ��������������(7���ܤ�)�פǤ��롣
;;----------------------------------------------------------------------------
(define (may-trade knpc kpc)
  (say knpc "��˼�ˤ���ö��Υ�������˸��äȤ��졣"))

(define (may-hail knpc kpc)
  (say knpc "�Τ��ʤ������ä�����ν����Ȳ�ä����Ԥ��ܤǤ�����򸫤Ƥ��롣��"
       "��ä��������ʤΤ��褿�͡��Ǥ⤤��ä��㤤��"))

(define (may-job knpc kpc)
  (say knpc "�ܥ�Τ��μ���ö����ڤ����ꤷ�Ƥ�Τ衣"))

(define (may-husband knpc kpc)
  (say knpc "ö��Υ�����������ΤߤΥ��ǥʥ������ɡ��������ӤϤ���������Τ衣"
       "¾��ϻ�ͤ�ö�᤬�������ɡ�"
       "���νɤ��äƤ������ɬ�פ��ä����뺧������ͳ�Ϥ�������衣"))

(define (may-other-husbands knpc kpc)
  (say knpc "�ۤ���ö��Ϥ���äƥХ����ä����Τ��˲��ͤ��Ϲ������ä�����"
       "�Ǥ�ߤ�ʼ�ʬ�ΥХ����Τ����ǻ�󤸤ޤä���"
       "���󤿤�Х��ߤ������͡����Ĥ����ΥХ��Τ����ǻ�̤衣"))

(define (may-tavern knpc kpc)
  (say knpc "���������������Ƥ��������Ҥ˽Ф���"
       "��������ʪ�俩��������Ρ�����Ȥ�٤�������"))

(define (may-guests knpc kpc)
  (say knpc "������Ϥ��ʤ���Ԥ��ܤǸ������Ϥ����������뤪�����ʽ��Ȥ��Ρ�Ϣ�졣"
       "�Ǥ⡢���֤��̤��ۤ�õ���Ƥ�󤸤�ʤ����ͤ���")
  (if (kern-conv-get-yes-no? kpc)
      (begin
        (say knpc "��äѤ�ͤ����ǡ������Ĥϲ������򤤤�Τ���äƤ�����")
        (if (kern-conv-get-yes-no? kpc)
            (begin
              (say knpc "���������ͤ���������Ҥⲿ��õ���Ƥ����衣"
                   "�������ˤϴط��ʤ����ɡ�"
                   "�⤷������ȡ����ν��Ȥ��󤿤�õ���Ƥ��ۤϲ�äƤ�󤸤�ʤ����͡�"
                   "¿ʬ��������ĸ򴹤��Ƥ���"))
            (say knpc "�����󡢤���ä����ޤ��̤��ˤ�����������ɡ�"
                 "�Ǥ⤢�󤿤�������ˤ����˹ԤäƤ��ޤä��衣")))
      (say knpc "�⤷�������ļˤ�Ф��Фä���ʤΤ�����")))

(define (may-woman knpc kpc)
  (say knpc "�����������Τ�����ǤϤ���ʤ��줤�ʿͤȤϤۤȤ�ɲ��ʤ���"
       "���襤�����ʥӥ�Ϲ��줳��Ǥ��衣"
       "�����Ƥ����ΥХ�ö��Ϥ��Ȥ��뤴�Ȥˤ���餷���ܤǸ��Ƥ��롣"
       "������϶᤯�ˤ�äƤ����䤤�����ϤǤ⡢���ν��������������ν�������衪"))

(define (may-companion knpc kpc)
  (say knpc "���ν������ڤ��ۤ����Ϣ��Ƥ롣�������η������Ƥ�󤸤�ʤ����͡�"
       "¿ʬ���ν����ѿ��������Ǥⲿ�Ǹ������Ȥ�ʹ���Ƥ���Τ��Ϥ狼��ʤ��͡�"))

(define (may-bill knpc kpc)
  (say knpc "�������ӥ�Ϥ��Τ��������ǯ����Ƭ�Ϥ褯�ʤ�����ľ�ǡ��ڤ�����äƤ��롣"
       "�褯�����ǿ��äƤ�衣�����ƻ����ҤȤ���٤äƤ롣"))

(define (may-hackle knpc kpc)
  (say knpc "�ϥå���Ϥ������������ǤϤʤ�����衣�ʬ������˽���Ǥ롣"
       "���Ťε������뤱�ȡ�¾�ϲ���Ǥ��ʤ���"))

(define (may-room knpc kpc)
  (if (not (string=? "working" (kern-obj-get-activity knpc)))
      (say knpc "�ɤϤ⤦�Ĥ����衣������6���ˤޤ���Ȥ��졣")
      (let ((door (eval 'bole-inn-room-door)))
        ;; is the room still open?
        (if (not (door-locked? (kobj-gob door)))
            ;; yes - remind player
            (say knpc "�����Ϥ⤦�����Ƥ�衣")
            ;; no - ask if player needs a room
            (begin
              (say knpc "���������뤫����")
              (if (kern-conv-get-yes-no? kpc)
                  ;; yes - player wants a room
                  (begin
                    (say knpc 
                         "���" inn-room-price "��͡�"
                         "����Į�ˤ���¤겿�٤Ǥ������Ǥ��롣"
                         "����������")
                    (if (kern-conv-get-yes-no? kpc)
                        ;; yes - player agrees to the price
                        (let ((gold (kern-player-get-gold)))
                          ;; does player have enough gold?
                          (if (>= gold inn-room-price)
                              ;; yes - player has enough gold
                              (begin
                                (kern-player-set-gold 
                                 (- gold 
                                    inn-room-price))
                                (say knpc "�ɤ��⡣�����ϱ��κ��衣")
                                (send-signal knpc door 'unlock)
                                (kern-conv-end)
                                )
                              ;; no - player does not have enouvh gold)
                              (say knpc "�⤬­��ʤ��衪")))
                        ;; no - player does not agree to the price
                        (say knpc 
                             "�ʤ餽����ǿ���Ф�������ϵ�˵����դ��ʡ�")))
                  ;; no - player does not want a room
                  (say knpc "���󤿤Τ褦���ۤ⤤�Ĥ��ϵ٤����衪")))))))
  
(define (may-thief knpc kpc)
  (say knpc "����Ĥ������ʪ������"
       "����äݤ��ۤ������衣�Ƕ�������Ҥ��褿�����"))

(define (may-trouble knpc kpc)
  (say knpc "���󤿡��Τ��ۤߤ����ʸ��������ƼϤʤ���Ĥ��򤷤Ƥ롣"
       "�Ǥ⡢���󤿤ϰ��Ԥ���ʤ������͡�"))

(define may-conv
  (ifc nil
       (method 'default (lambda (knpc kpc) (say knpc "�ɤ����褦��ʤ��͡�")))
       (method 'hail may-hail)
       (method 'bye  (lambda (knpc kpc) (say knpc "�������ФƤ��ä��ФƤ��ä���")))
       (method 'job  may-job)
       (method 'name (lambda (knpc kpc) (say knpc "�ᥤ�ȸƤФ�Ƥ롣")))
       (method 'join (lambda (knpc kpc)
                       (say knpc "���󤿤ΥХ��˴������ޤʤ��Ǥ����졣")))

       (method 'buy   may-trade)
       (method 'food  may-trade)
       (method 'drin  may-trade)
       (method 'supp  may-trade)
       (method 'trade may-trade)

       (method 'bill  may-bill)
       (method 'comp  may-companion)
       (method 'thin  may-companion) ;; Ϣ��
       (method 'gues  may-guests)
       (method 'clie  may-guests) ;; ��
       (method 'hack  may-hackle)
       (method 'husb  may-husband)
       (method 'inn   may-tavern)
       (method 'melv  may-husband)
       (method 'other may-other-husbands)
       (method 'run   may-tavern)
       (method 'room  may-room)
       (method 'six   may-other-husbands)
       (method 'tave  may-tavern)
       (method 'thie  may-thief)
       (method 'trou  may-trouble)
       (method 'woma  may-woman)

       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-may)
  (bind 
   (kern-char-arm-self
    (kern-mk-char 
     'ch_may ;;......tag
     "�ᥤ" ;;.......name
     sp_human ;;.....species
     nil ;;..........occupation
     s_townswoman ;;...sprite
     faction-men ;;..faction
     0 ;;............custom strength modifier
     1 ;;............custom intelligence modifier
     0 ;;............custom dexterity modifier
     0 ;;............custom base hp modifier
     0 ;;............custom hp multiplier (per-level)
     0 ;;............custom base mp modifier
     0 ;;............custom mp multiplier (per-level)
     max-health ;;..current hit points
     -1  ;;...........current experience points
     max-health ;;..current magic points
     0
     may-start-lvl  ;;..current level
     #f ;;...........dead?
     'may-conv ;;...conversation (optional)
     sch_may ;;.....schedule (optional)
     'townsman-ai ;;..........custom ai (optional)
     nil ;;..........container (and contents)
     (list t_dagger) ;;.........readied arms (in addition to the container contents)
     nil ;;..........hooks in effect
     ))
   (may-mk)))
