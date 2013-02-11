;;----------------------------------------------------------------------------
;; Schedule
;;
;; �ȥꥰ�쥤��
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_jim
               (list 0  0  trigrave-jims-bed        "sleeping")
               (list 6  0  trigrave-tavern-table-1a  "eating")
               (list 7  0  trigrave-forge            "working")
               (list 12 0  trigrave-tavern-table-1a  "eating")
               (list 13 0  trigrave-forge            "working")
               (list 18 0  trigrave-tavern-hall      "idle")
               (list 22 0  trigrave-jims-bed         "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (jim-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;;
;; �����Ź��ǡ��Ż��򤷤Ƥ�����֤ʤ�м������Ǥ��롣����ؤ��⤯�����결
;; �򤷤Ƥ��ơ�̵���ۤǤ��롣�⤷Į�˥꡼����������Ȥ���С��������Ǥ��롣
;; �ʤ��ʤ齻̱�����º�ɤ������ΤȤ�����ȹͤ��Ƥ��뤫��Ǥ��롣��������
;; ���̾���ˤ϶�̣���ʤ�����Τ���˹�ư���뤳�ȤϤʤ�����������Ԥˤ϶�̣
;; ���ʤ���(�Ŀ�Ū�ˤ�)�����Ԥ϶򤫤��ȹͤ��Ƥ��롣�����������ȼ���������
;; �ȴ�֡�������Τߤǡ������餯�㤤����ϹӤ���Ԥ��ä���
;;----------------------------------------------------------------------------
(define jim-merch-msgs
  (list "Ź�������Ƥ�Ȥ�����Ƥ��졣����ζ�ʪ����������7��������6���ޤǤ�äƤ��롣"
        "�ߤ���ʪ������и��äƤ��졣"
        "����ʤ��ʤä�ʪ��������㤤�᤹����"
        "�ߤ���ʪ������и��äƤ��졣"
        "�ޤ��϶����Ǥơ��褭��ΤΤ���ˡ�ͧ�衣"
        "�ޤ��ε���ˡ�"
        "�Ϥ����������ʤˤ��ƻȤ��衣"
        "�ɤ��⡣"
        "�ޤ��϶����Ǥơ��褭��ΤΤ���ˡ�ͧ�衣"
        "�ɤ��⡣"
   ))

(define jim-catalog
  (list
   (list t_dagger          40 "��ΤǤʤ��ԤˤϤ���������")
   (list t_sword           80 "��̣���������ʶѹդη�����")
   (list t_axe             70 "�����γ�ư��ɬ�פ����襤�Ǥ�Ȥ��롣")
   (list t_mace            75 "��̷��ñ����������γ����夿Ũ�ˤϸ��̤Τ���������")
   
   (list t_2H_axe         240 "�������ڤ���������˺��줿�������")
   (list t_2H_sword       350 "���Ƥ�������Ϥ�����С�ξ����ϤȤƤ⶯�Ϥ�������")
   
   (list t_chain_coif     110 "��Ƭ�Ҥ�Ƭ���ؤι��⤫�����������")
   (list t_iron_helm      160 "Ŵ���������Ƭ�ؤ���̷��ľ����ɤ��������")
   (list t_armor_chain    300 "�������Ӥ餬���������οϤ����ķ���֤��롣")
   (list t_armor_plate    600 "�Ť��������ɤ϶ˤ�ƶ��Ϥʹ���䳻����̤��빶�����������Ƥ����������")
   
   (list t_shield          45 "����ܶ���Ǥ�ɬ�פ���")
   
   (list t_spiked_helm    150 "���դ����Ϥ�äȹ����Ϥ��ߤ����Ԥ˹��ޤ�롣")
   (list t_spiked_shield  150 "���դ�������ᤤ��Τδ���Ū�ʲ������ͤ�ư��򹹤ʤ빶��ˤǤ��롣")
   ))

(define (jim-trade knpc kpc) (conv-trade knpc kpc "trade" jim-merch-msgs jim-catalog))

(define jim-conv
  (ifc basic-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default (lambda (knpc kpc) (say knpc "�狼���ʡ�")))
       (method 'hail (lambda (knpc kpc) (say knpc "����ä��㤤��")))
       (method 'bye (lambda (knpc kpc) (say knpc "�ɤ��⡣")))
       (method 'job 
               (lambda (knpc kpc) 
                 (say knpc "�ȥꥰ�쥤�֤����결�����������뤫��")
                            (if (kern-conv-get-yes-no? kpc)
                                (jim-trade knpc kpc)
                                (say knpc "�ޤ����Ƥ����ʡ�"))))
       (method 'name (lambda (knpc kpc) (say knpc "������ȸƤ�Ǥ��롣")))
       (method 'buy (lambda (knpc kpc) (conv-trade knpc kpc "buy" jim-merch-msgs jim-catalog)))
       (method 'sell (lambda (knpc kpc) (conv-trade knpc kpc "sell" jim-merch-msgs jim-catalog)))
       (method 'trad jim-trade)
       (method 'join (lambda (knpc kpc) 
                       (say knpc "�����������Ȥ⡢���������ξ�����")))


       (method 'chan (lambda (knpc kpc)
                       (say knpc "����ɥ�ϥȥꥰ�쥤�֤μ��˽����ꤷ�Ƥ����ͷ��ͤ���"
                            "���Τ����ꤸ��ͭ̾����")))
       (method 'char 
               (lambda (knpc kpc)
                 (say knpc "����ú�Ƥ��ͤΤ������ǲ���������Ǯ���Ǥ��롣")))
       (method 'earl
               (lambda (knpc kpc)
                 (say knpc "������Ͼ���ʪ����Ź�����"
                      "�Τ���ѻդ��ä��ȸ���ĥ�äƤ��롣")))
       (method 'gwen
               (lambda (knpc kpc)
                 (say knpc "���٥�Ͻɲ����äƤ��롣"
                      "���ͤ������¿��������")))
       (method 'iron (lambda (knpc kpc)
                       (say knpc "�֤ˤϸ��Ф�˭�٤ˤ��롣ë�Ǥ�¿�����襤�����뤬������Ŵ��õ���ˤ����˹Ԥ�ɬ�פϤʤ���")))
       (method 'shie
               (lambda (knpc kpc)
                 (say knpc "������䤿���ܤǤ��ʤ��򸫤�����"
                      "���饹�ɥ�����Ϥν�Ϥ⤦�ΤƤ���"
                      "����ʾ��ä������ʤ��Τ�����")))
       (method 'thie
               (lambda (knpc kpc)
                 (say knpc "���������ۤϸ��ʤ��ä��ʡ����٥��ʹ���Ƥߤ�Ф������ɲ���������ι�ͤ��ä��Ƥ����������ʡ�")))
       (method 'trig 
               (lambda (knpc kpc) 
                 (say knpc "�ȥꥰ�쥤�֤ˤ��äˤʤ��ΤϤ��ޤ�ʤ���")))
       (method 'wood 
               (lambda (knpc kpc)
                 (say knpc "���Ͻä���±�Τͤ������"
                      "û�����ȷڤ�����ɬ�פ���鮤���Ǥ�Ĺ�����ȽŤ����ϼ���ˤʤ��������")))
       
       ))
