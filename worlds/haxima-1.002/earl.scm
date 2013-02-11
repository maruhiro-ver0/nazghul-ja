;;----------------------------------------------------------------------------
;; Schedule
;;
;; �ȥꥰ�쥤��
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_earl
               (list 0  0  trigrave-earls-bed        "sleeping")
               (list 5  0  trigrave-tavern-table-3a  "eating")
               (list 6  0  trigrave-earls-counter    "working")
               (list 12 0  trigrave-tavern-table-3a  "eating")
               (list 13 0  trigrave-earls-counter    "working")
               (list 18 0  trigrave-tavern-table-3a  "eating")
               (list 19 0  trigrave-tavern-hall      "idle")
               (list 20 0  trigrave-earls-room       "idle")
               (list 21 0  trigrave-earls-bed        "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (earl-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;;
;; �������Ź��ǡ��Ż��򤷤Ƥ�����֤ʤ�м������Ǥ��롣
;;----------------------------------------------------------------------------
(define earl-merch-msgs
  (list "�����Ƥ�Ȥ���Ź����Ȥ��졣���ξ���ʪ���������γѤˤ��äơ�����6��������6���ޤǤ�äƤ롣"
        "�֤��Ƥ�ʪ�򸫤��Ƥ����"
        "��������������ꤿ��ʪ�򸫤��Ȥ��졣"
        "���ä�����Ƹ��Ƥ��졣"
        "�������Ź����ä���Τ���ͧã�˸��äȤ��Ƥ��졣"
        "��������������ޤ������䡣"
        "�֤��Ȥ��Ƹ�Ǥ��줤�ˤ���衣"
        "��ꤿ��ʪ�����ä���ޤ���Ȥ��졣"
        "�⤦�����Τ������ޤ������ˤ��ʤ衣"
        "�ޤ��������ä�����äȤ��졣"
   ))

(define earl-catalog
  (list
   (list t_torch               5 "�µܤα��Ǿ������ڤ餻�����ʤ�������")
   (list t_sling              50 "����ɳ���Ƥ��㤤�����ʤ��������ۤˤԤä������")
   (list t_staff              25 "��Τʤ���ˡ�Ȥ����ʤ��ʤ����ߤ����ʤ�����")
   
   (list t_heal_potion        22 "�����ѤȤ��Ƥ������󤤤�Ϥ�����")
   (list t_cure_potion        22 "�̤ظ������������Ӥ˹Ԥ��Ȥ��Ϥ����Ĥ����äƤ������ۤ���������")
   (list t_mana_potion        22 "���Ϥ�Ȥ��̤����ƵٷƤ�Ǥ��ʤ��Ȥ��Ϥ������")
   
   (list t_arrow               1 "�ݤ���äƤ���С���¿������Ȥ������ȤϤʤ���")
   (list t_bolt                1 "���Τ�����ǰ��ְ¤������ܥ��������")
   (list t_smoke_bomb          3 "���α����Ƥ�Ũ�μͼ���ꤲ��С����Ϥ����餬�����ʤ��ʤ������")
   
   (list t_shovel             50 "���줿���򸫤Ĥ����餳�Υ���٥뤬���������")
   (list t_pick               50 "�Ĥ�Ϥ���ƻ��ɤ�����������ˤ����Ф�ɬ�פ���")
   
   (list t_sextant           500 "�����䴬ʪ�ʤ��ǹ���Ǥε��꤬�狼�롣")
   (list t_chrono            300 "���ξ����ʻ��פ�����С�����פ��ʤ���Ǥ���郎�狼�롣")
   (list t_grease             23 "�ʤ餺�ԤϤ��줬���������ʤ�����ʹ���ʡ�")
   ))

(define (earl-trade knpc kpc) (conv-trade knpc kpc "trade" earl-merch-msgs earl-catalog))

(define earl-conv
  (ifc trigrave-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default (lambda (knpc kpc) (say knpc "˺�줿�ʤ���")))
       (method 'hail (lambda (knpc kpc) (say knpc "����ä��㤤�����Τ������")))
       (method 'bye (lambda (knpc kpc) (say knpc "���������󤿤��ä��Ƥ�����ä���")))
       (method 'job (lambda (knpc kpc) (say knpc "����Ź���äƤ롣�������뤫����")
                            (if (kern-conv-get-yes-no? kpc)
                                (earl-trade knpc kpc)
                                (say knpc "������"))))
       (method 'name (lambda (knpc kpc) (say knpc "����Ϥ��Ф餯�ͤ���������ϥ����롪������")))
       (method 'buy (lambda (knpc kpc) (conv-trade knpc kpc "buy"  earl-merch-msgs earl-catalog)))
       (method 'sell (lambda (knpc kpc) (conv-trade knpc kpc "sell"  earl-merch-msgs earl-catalog)))
       (method 'trad earl-trade)
       (method 'join (lambda (knpc kpc) (say knpc "�٤�����衪��ʸ�Ϥߤ��˺����ޤä���")))

       (method 'batt
               (lambda (knpc kpc)
                 (say knpc "������������ϥ�������󲦤Ȱ��˥��֥��ɤ�η������ä��Τ���")))
       (method 'calv
               (lambda (knpc kpc)
                 (say knpc "���ĤƤ��𾭡�"
                      "���������ϳ����γ������̤�ü�ޤ����Ƥ��������������")))
       (method 'hord
               (lambda (knpc kpc)
                 (say knpc "���Τ����֥��ɤ�ϰ�ͤμ�Ĺ�β��Ƿ�«���Ƥ�����"
                      "�����ơ�����Ⱦ���˽��Ƥ�����"
                      "��������󲦤���Ĥ���ݤ��Ƥ���ϥХ�Х�ˤʤꡢ�֤˱����褦�ˤʤä���"
                      "��ˤˤϻĤäƤʤ����ʡ�")))
       (method 'mage
               (lambda (knpc kpc)
                 (say knpc "��ˡ�Ϥߤ��˺�줿�����ʤ�������"
                      "�ΤϷ����ݤ����ݤ����ʸ���ΤäƤ�����")))
       (method 'spel
               (lambda (knpc kpc) 
                 (say knpc "��ˡ�Ȥ��Ȥ�����äƤ�����衣���Τ���")))
       (method 'thie
               (lambda (knpc kpc)
                 (say knpc "��������Ĥ�����ƨ���Ƥä������䡢���������ġ������������á��פ��Ф��ͤ���")))
       ))
