;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define zane-start-lvl 8)

;;----------------------------------------------------------------------------
;; Schedule
;;
;; ��ƻ�դ����1��
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_zane
               (list 0  0  enchtwr-zane-bed        "sleeping")
               (list 6  0  enchtwr-campsite        "idle")
               (list 8  0  enchtwr-dining-room-1   "eating")
               (list 9  0  enchtwr-campsite        "idle")
               (list 12 0  enchtwr-dining-room-1   "eating")
               (list 13 0  enchtwr-hall            "idle")
               (list 19 0  enchtwr-dining-room-1   "eating")
               (list 20 0  enchtwr-dining-room     "idle")
               (list 21 0  enchtwr-campsite        "idle")
               (list 22 0  enchtwr-zane-bed        "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (zane-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;;
;; ������ϼ����Ӥη�������Ǥ��롣�����ƻ�դ���ǥ����פ������Τ������
;; �Ǥξ¤Ǥ����ư��ɬ�פ�ʪ����äƤ��롣
;;----------------------------------------------------------------------------
(define zane-merch-msgs
  (list nil ;; closed
        "Į��ʪ�Ͽ��ѤǤ��ʤ�����ʬ�Ǻ�äƤ롣�����Ƥ����" ;; buy
        nil ;; sell
        nil ;; trade
        "���Τ�����Ǥ�­���˵���Ĥ���" ;; bought-something
        "�����ˤ��ʡ�" ;; bought-nothing
        nil
        nil
        nil
        nil
        ))

(define zane-catalog
  (list
   ;; reagents
   (list ginseng        (* 5 reagent-price-mult) "����ϲ����˸�����")
   (list garlic         (* 4 reagent-price-mult) "�µ��ˤʤä��Ȥ�����Ϥ�����")
   (list blood_moss     (* 6 reagent-price-mult) "����Ϥʤ��ʤ����Ĥ���ʤ���")
   (list nightshade     (* 8 reagent-price-mult) "����������˥��᥸�ᤷ����Ǥ����餿�ʤ���")
   (list mandrake       (* 10 reagent-price-mult) "������ʸ�ˤϥ����Ĥ����롣")
   
   ;; potions
   (list t_heal_potion            21 "����ϥ�Х��Ȥ����������Ω�ġ�")
   (list t_cure_potion            21 "�ǤˤϤ��줬���֤�����;ʬ�˻��äƤ�����")
   (list t_poison_immunity_potion 21 "�ǤΤ�������̤�Ȥ��ϡ��ޤ���������Ǥ�����")
   
   ;; bows, arrows and bolts 
   ;; (as an accomplished Ranger, he is also a bowyer and fletcher)
   (list t_self_bow    30 "���ξ�������ĤϷڤ������᤯��Ƥ롣")
   (list t_bow         90 "���εݤϤɤ�ʤȤ���Ȥ��롣�¤��Ʒڤ��������⤤����")
   (list t_long_bow   300 "���������μ�ˤϴ�������")
   (list t_great_bow  700 "�����Τΰ�̴���������Ĥϱ󤯤���Ǥ⳻��֤�ȴ���������")
   
   (list t_arrow        2 "���������������������äƤ����")
   (list t_bolt         2 "Į��̱ʼ�Τ���˥����ܥ�������äƤ롣")
   ))

(define (zane-trade knpc kpc) (conv-trade knpc kpc "buy" zane-merch-msgs zane-catalog))

(define (zane-ench knpc kpc)
  (say knpc "��������������Ĥ�����äƤ��롣���Ƥߤ�"
       "ï�ˤ⤸��ޤ��줿���ʤ��褦����"
       "�����˲񤤤�����С�������ˡ�򸫤Ĥ��ʤ���Фʤ��ʡ�"))

(define (zane-fens knpc kpc)
  (say knpc "���������Τɿ���������ȤƤ������"
       "����Ĥ���"))
  
(define zane-conv
  (ifc ranger-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default (lambda (knpc kpc) (say knpc "¾�Υ�Ĥ�ʹ���ʡ�")))
       (method 'hail (lambda (knpc kpc) (say knpc "����Ϥ��ʤ���������")))
       (method 'bye (lambda (knpc kpc) (say knpc "���㤢�ʡ�")))
       (method 'job (lambda (knpc kpc) 
                      (say knpc "����������������Ӥ�������Ƥ롣")))
       (method 'name (lambda (knpc kpc) (say knpc "������")))
       (method 'join (lambda (knpc kpc) 
                       (say knpc "�����ʡ��⤦�Ż������롣")))
       (method 'ench zane-ench)
       (method 'fens zane-fens)
       (method 'dang
               (lambda (knpc kpc)
                 (say knpc "�ǤȲ�ʪ�Ǥ��äѤ�����"
                      "���Ф餯�����ˤ���Ĥ�꤫��")
                 (if (kern-conv-get-yes-no? kpc)
                     (begin
                       (say knpc "�Ǥ��Ф����ʸ������Ϥ�����"
                            "�ΤäƤ뤫��")
                       (if (kern-conv-get-yes-no? kpc)
                           (say knpc "�ʤ餤������������äƤ�뤾��")
                           (say knpc "�ʥ��ȥ������ɤ����Ǥ�Ĵ�礷��Sanct Nox�Ⱦ�����"
                                "�����Ϥ���������äƤ���Τ���äƤ�äƤ⤤������")
                           ))
                     (say knpc "���줬������")
                     )))
       (method 'pois
               (lambda (knpc kpc)
                 (say knpc "�Ф�����An Nox�μ�ʸ�Ǽ��롣")))
       (method 'poti
               (lambda (knpc kpc)
                 (say knpc "����������äƤ���Τ���äƤ�뤾��")))
       (method 'mons
               (lambda (knpc kpc)
                 (say knpc "Ǵ�ݡ���±���Ի�μԤɤ⡣")))
       (method 'reag
               (lambda (knpc kpc)
                 (say knpc "��ʬ�Ϥɤ��Ǥ⸫�Ĥ����롣"
                      "���ޤä�ʬ����äƤ�뤾��")))
       (method 'buy zane-trade)
       (method 'sell zane-trade)
       (method 'trad zane-trade)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-zane-first-time tag)
  (bind 
   (kern-char-arm-self
    (kern-mk-char 
     tag ;;..........tag
     "������" ;;.......name
     sp_human ;;.....species
     oc_ranger ;;.. .occupation
     s_companion_ranger ;;..sprite
     faction-men ;;..faction
     +1 ;;...........custom strength modifier
     0 ;;...........custom intelligence modifier
     +1 ;;...........custom dexterity modifier
     +1 ;;............custom base hp modifier
     +1 ;;............custom hp multiplier (per-level)
     0 ;;............custom base mp modifier
     0 ;;............custom mp multiplier (per-level)
     max-health ;;..current hit points
     -1  ;;...........current experience points
     max-health ;;..current magic points
     0 ;; AP_per_turn
     zane-start-lvl  ;;..current level
     #f ;;...........dead?
     'zane-conv ;;...conversation (optional)
     sch_zane ;;.....schedule (optional)
     'townsman-ai ;;..........custom ai (optional)

     ;;..............container (and contents)
     (mk-inventory
      (list
       (list 10  t_food)
       (list 100 t_arrow)
       (list 1   t_great_bow)
       (list 1   t_dagger)
       (list 1   t_sword)
       (list 1   t_leather_helm)
       (list 1   t_armor_leather)
       (list 5   t_torch)
       (list 5   t_cure_potion)
       (list 5   t_heal_potion)
       ))

     nil ;;.........readied arms (in addition to the container contents)
     nil ;;..........hooks in effect
     ))
   (zane-mk)))
