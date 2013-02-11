;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define bill-start-lvl 3)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; �ܥ�
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_bill
               (list 0  0  bole-bed-bill "sleeping")
               (list 6  0  bole-table-1  "idle")
               (list 7  0  bole-n-woods  "working")
               (list 12 0  bole-table-2  "eating")
               (list 13 0  bole-n-woods  "working")
               (list 18 0  bole-table-2  "eating")
               (list 19 0  bole-dining-hall "idle")
               (list 21 0  bole-bills-hut "idle")
               (list 22 0  bole-bed-bill "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (bill-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;;
;; �ӥ���ڤ���ǡ��ܥ�˽���Ǥ��롣
;; ���ޤ긭���ʤ��ԤǤ��롣
;;----------------------------------------------------------------------------
(define bill-catalog
  (list
   (list t_staff 10 "�����뤯�餤�ޤä����ʻޤϤʤ��ʤ����Ĥ���ʤ���") ;; rather cheap
   (list t_torch  3 "����⤯�Τ��������������龾�����äƤ롣") ;; rather cheap
   (list t_arrow  3 "�Ф���η�����⤿�ޤ˲��������äƤ롣")
   (list t_bolt   4 "���Τ�����ǥ����ܥ���ȤäƤ��ĤϾ��ʤ���")
   ))

(define bill-merch-msgs
  (list nil ;; closed
        "����������ä������" ;; buy
        nil ;; sell
        nil ;; trade
        "�������äƤ����㤤�����ɡ�" ;; sold-something
        "�����Ѥ�ä���ޤ���ʤ衣" ;; sold-nothing
        nil ;; bought-something
        nil ;; bought-nothing
        nil ;; traded-something
        nil ;; traded-nothing
        ))


(define (bill-buy knpc kpc) (conv-trade knpc kpc "buy" bill-merch-msgs bill-catalog))

(define (bill-goods knpc kpc)
  (say knpc "�����㤦��")
  (if (kern-conv-get-yes-no? kpc)
      (bill-buy knpc kpc)
      (say knpc "�ߤ����ʤä�����äƤ��졣")))

(define (bill-may knpc kpc)
  (say knpc "Į�μ����äƤ롣����������"))

(define (bill-lady knpc kpc)
  (say knpc "����Į�˽����������衣�����ˤ��줤�ʡ�"
       "�Ǥ⡢�Ǥ����������ͤ��ˤ��դ��Ƥ�����"))

(define (bill-bole knpc kpc)
  (say knpc "���������ϥܥ줬��������"
       "��줬���äơ��������ӿ��äơ������ۤɿ��ʧ����"
       "���ϲ��βȤ���"))

(define (bill-wolves knpc kpc)
  (say knpc "���Ĥ���դ��Ƥ롣"
       "Į�Τ��ä���ˤϤ������󤤤�ʡ�"))

(define (bill-scared knpc kpc)
  (say knpc "Į�����ˤ����Ȥ��衣"
       "ϵ�����Ƥʤ��ʤ��Ԥ��ʤ�������"
       "�������礭�ʡ��Ť��������������ڤ����ä������"
       "�����ĤϤ����Ȼפä��衣"
       "�ǡ������Ĥ��ڤ��Ȥ����顢����ư���Ф�������衪"))

(define (bill-thie knpc kpc)
  (say knpc "�������˥��ꥫ�ꤷ����Ĥ����ˤ����ʡ�"
       "���줤�ʽ����ä��Ƥ��������ˤĤ��ƥ��󥫤��Ƥ��Ȼפ��������Ĥ�Į������ε֡��ɤ����狼�뤫�����عԤ��Τ򸫤���"
       "���줫����äƤ��ʤ��ä����ɤ��عԤä����Ϥ狼��ͤ������ε֤ϹԤ��ߤޤ����"
       "�������Ѥ��ä���"))

(define (bill-mous knpc kpc)
  (say knpc "�ͥ��ߤϤɤ��ˤǤ⤤�롣�ͥ��ߤߤƤ��������äƤ��Ĥ⸫���衪"))

(define (bill-tree knpc kpc)
  (say knpc "���ˤϿ�����ڤ����롣"
       "�Ǥ�衢������ͩ���ڤ򸫤�����衪"))

(define bill-conv
  (ifc nil
       (method 'default (lambda (knpc kpc) (say knpc "����ϸ��򤹤��᤿����")))
       (method 'hail (lambda (knpc kpc) (say knpc "�衼����")))
       (method 'bye (lambda (knpc kpc) (say knpc "����ޤ���")))
       (method 'job (lambda (knpc kpc) 
                      (say knpc "����㤢�ڤ������")))
       (method 'name (lambda (knpc kpc) (say knpc "�ӥ�ȸƤФ�Ƥ롣")))
       (method 'join (lambda (knpc kpc) 
                       (say knpc "����䡪���󤿤����Ӳ�äƤ롢�����ڤ��ꡣ"
                            "���ͤ��衣�����פ��Ǥ��졣")))

       (method 'arro bill-goods)
       (method 'axe
               (lambda (knpc kpc)
                 (say knpc "�ڤ��ڤ�Ȥ���û��褫������")))
       (method 'buy bill-buy)
       (method 'bole bill-bole)
       (method 'chop
               (lambda (knpc kpc)
                 (say knpc "��Ȥäơ�")))
       (method 'fore
               (lambda (knpc kpc)
                 (say knpc "�������������ˤϤۤ�Ȥˤ��������ڤ����롣"
                      "������ϵ��ʡ�")))
       (method 'haun
               (lambda (knpc kpc)
                 (say knpc "����Ϥ��ʤ��˴�꤫���ꡢ�����Ǹ��ä�����"
                      "����Į�����Ǥ�Ф����衣"
                      "�ӤӤä�ƨ�����ޤä��衣�ϥϡ�")))
       (method 'jink bill-scared)
       (method 'ladi bill-lady)
       (method 'lady bill-lady)
       
       (method 'may bill-may)

       (method 'wood
               (lambda (knpc kpc)
                 (say knpc "�ڤ��ڤäơ���äơ��Ť��롣"
                      "���������Ⱦ�������⡣")))
       (method 'shit
               (lambda (knpc kpc)
                 (say knpc "���������顣����ʤ��ȸ����Ĥ��Ϥʤ��ä������"
                      "�ᥤ�Ϥ��ĤⲶ�˥��������������θ����ʤȸ��äƤ롣"
                      "���Ϥ��������ΤϷ���������ʡ�")))
       (method 'scar bill-scared)
       (method 'thie bill-thie)
       (method 'mous bill-mous)
       (method 'man  bill-thie)
       (method 'scur bill-thie)
       (method 'torc bill-goods)
       (method 'town bill-bole)
       (method 'trad bill-buy)
       (method 'tree bill-tree)
       (method 'ki bill-tree) ; ���ڡפȡ֥�(���֥���)�פβ���Ʊ���Ǥ��뤿��
       (method 'wake
               (lambda (knpc kpc)
                 (say knpc "�����������Ť��ߤ��ڤ������֤ä���"
                      "��ߤƤ��ʳѤ���ĤΤǤä����ܤ����äơ������ˤ�Ǥ���"
                      "���ܥ󤫤����ӽФ��ơ�"
                      "����֤��ƻ�̤ۤ����ä�ƨ�����衪")))
       (method 'wolv bill-wolves)
       (method 'wulv bill-wolves)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-bill)
  (bind 
   (kern-char-arm-self
    (kern-mk-char 
     'ch_bill ;;......tag
     "�ӥ�" ;;.......name
     sp_human ;;.....species
     nil ;;..........occupation
     s_townsman ;;...sprite
     faction-men ;;..faction
     2 ;;............custom strength modifier
     0 ;;............custom intelligence modifier
     0 ;;............custom dexterity modifier
     0 ;;............custom base hp modifier
     0 ;;............custom hp multiplier (per-level)
     0 ;;............custom base mp modifier
     0 ;;............custom mp multiplier (per-level)
     max-health ;;..current hit points
     -1  ;;...........current experience points
     max-health ;;..current magic points
     0
     bill-start-lvl  ;;..current level
     #f ;;...........dead?
     'bill-conv ;;...conversation (optional)
     sch_bill ;;.....schedule (optional)
     'townsman-ai ;;..........custom ai (optional)

     ;;..............container (and contents)
     (mk-inventory
      (list
       (list 10  t_torch)
       (list 100 t_arrow)
       (list 1   t_2h_axe)
       ))
     nil ;;.........readied arms (in addition to the container contents)
     nil ;;..........hooks in effect
     ))
   (bill-mk)))
