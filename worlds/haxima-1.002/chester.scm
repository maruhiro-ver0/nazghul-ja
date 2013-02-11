;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ���饹�ɥ��
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_ches
               (list 0  0  gc-bed       "sleeping")
               (list 7  0  ghg-s3       "eating")
               (list 8  0  gas-counter "working")
               (list 11 0  ghg-s3       "eating")
               (list 12 0  gas-counter "working")
               (list 18 0  ghg-s3       "eating")
               (list 19 0  ghg-hall     "idle")
               (list 21 0  gc-bed       "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (ches-mk) (list 'townsman))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ��������������ﲰ�����ˤǡ����饹�ɥ��˽���Ǥ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (ches-hail knpc kpc)
  (say knpc "�Τ��ʤ����ڤδ��Τ褦���Ӥ����ˤȲ�ä�����"
       "�褪����Τ���"))

(define (ches-default knpc kpc)
  (say knpc "����ϲ����μ���Ķ���Ƥ��롣"))

(define (ches-name knpc kpc)
  (say knpc "����Ƚ�פΥ�������������"
       "���ͤʿ�ʪ�ȸ����뤿��ˤϡ����ͤ���郎ɬ�פ���"
       "������̣�Τ���ʪ�Ϥ��뤫��")
  (if (kern-conv-get-yes-no? kpc)
      (ches-trade knpc kpc)))

(define (ches-join knpc kpc)
  (say knpc "�ݡ�ͧ�衣�����Ԥˤ������򶡵뤹��ï����ɬ�פ���"))

(define (ches-job knpc kpc)
  (say knpc "�����ϤǺǤ��ɤ����ȳ�����äƤ��롣"
       "���Ƥ�������")
       (if (kern-conv-get-yes-no? kpc)
           (ches-trade knpc kpc)
           (say knpc "�ޤ�����������������ꤤ��ʪ�Ϥʤ���"
                "�Ǹ����롣")))

(define (ches-bye knpc kpc)
  (say knpc "����С�ͧ�˲���Ź�Τ��Ȥ��ä��Ƥ��졪"))

(define ches-catalog
  (list
   (list t_staff            20 "��֤���ѻդ˾���������С��������������狼��Ϥ�����")
   (list t_dagger           65 "������˰�Ĥ���Ĥ�û������Ǧ�Ф��Ƥ�����")
   (list t_mace             80 "��̷��Ƭ������դ���������ˤϤ���������")
   (list t_axe              85 "������Ϥޤ��˽���뤿��Τ�Τ���")
   (list t_sword            85 "������Τμ��Ϥ�������")
   (list t_2H_axe           90 "����ξ���ब�������򴢤���褦��Ũ��ʤ��ݤ��롣")
   (list t_2H_sword        100 "���������Ŀ�Ū�ˤϤ��ζ��Ϥ�ξ��������ߤ���")
   (list t_morning_star    105 "���λ��դ�Ŵ�����Ф��С����������Ũ���य������")
   (list t_halberd         150 "�������ļԤ����ˤ���С����̤϶�������������")
   
   (list t_sling            50 "�⤷�Ҷ�������ʤ顢����ɳ�Ϻǽ�����Ȥ��ƤϤ���������")
   (list t_spear            15 "����ϥ��֥�����²���褯�ȤäƤ���������")

   (list t_self_bow        120 "���ξ����ʵݤϾ�����ưʪ����ˤϤ�äƤ�������")
   (list t_bow             200 "������Τ褦�˿�������礤���ԤˤϤ��εݤ�������")
   (list t_arrow             1 "�⤷Ũ��ľ�̤������ʤ���С�������̤˻��äƤ����٤�����")
   
   (list t_crossbow        380 "�⤷Ũ���Ϥ���ƨ���Ф����ʤ顢���Υ����ܥ����ݤ���")
   (list t_hvy_crossbow    600 "Ũ�˰Ϥޤ줿�顢ͦ�ޤ�����Τ⤳������������������")
   (list t_bolt              1 "���饹�ɥ��η��Ϻǹ��������Ƥ��롣������ͣ�첶�������ܥ�����򶡵뤷�Ƥ��롣")
   
   (list t_leather_helm     50 "�ڤ����ϱ�ɮ�Τ褦�ʼ�Τʤ餺�ԤˤϤԤä������")
   (list t_chain_coif      100 "��Ƭ�Ҥϻ볦��פ餺�˼����롣")
   (list t_iron_helm       150 "����Ŵ���Ϥ��ޤ���Ƭ��Ǥ�Ǥ���������Ѥ��������")
   (list t_armor_leather   150 "��γ���ư���Τ���ޤˤʤ�ʤ���������¤��ɸ��Ϥ����ʤ���")
   (list t_armor_chain     330 "�������Ӥ�������Τ˺�Ŭ�γ��������������Ϥ��Τ��Ȥ�褯�狼�äƤ��롣")
   (list t_armor_plate    1000 "���ɤ������Ի�Ȥ���Τˤʤ�롣")
   
   (list t_shield           30 "���פʽ⤬����б󤯤����äƤ��벲�¼Ԥ�Ũ����Ȥ���롣")
   
   (list t_spiked_helm     250 "����Ϻ�����ɸ�������λ��դ������������Ƥ������������̤ǤϤʤ���")
   (list t_spiked_shield   250 "���λ��դ��⤬��������ϤۤȤ�ɤ���ʤ�������")
   ))

(define ches-merch-msgs
  (list "����Ź�ˤ���Ȥ��ˡ���Ƚ�פ���Ƥ��졣�ǹ�������ɶ�򤪸������褦������9��������6���ޤǤ�äƤ롣"
        "�������������򸫤Ƥ��졪" ;; buy
        "�Ȥä������Ⲽ��ꤹ�뤾��" ;; sell
        "�����ϤǺǹ����Τ����������򶡵뤷�Ƥ��롣�ʤˤ��ߤ�����" ;; trade
        "����Ũ��Ƭ������դ�����äȤ����Τ��ߤ����ʤä���ޤ���Ƥ��졣" ;; sold-something
        "���ޤ��������Ͼ����ŤӤƤ���ʡ��ͤ��ʤ������ۤ���������" ;; sold-nothing
        "���Υ���ܥ������򲿤���äƤ����ʡ�" ;; bought-something
        "���Υ��饯�����ߤ����ۤ�¾�ˤ���Ȥϻפ��ʤ���" ;; bought-nothing
        "��ͤ򽳻��餹�������Ǥ����ʡ�" ;; traded-something
        "�����ʤ������Ƥ����ʤ衣" ;; traded-nothing
        ))

;; Trade...
(define (ches-trade knpc kpc) (conv-trade knpc kpc "trade" ches-merch-msgs ches-catalog))
(define (ches-buy knpc kpc) (conv-trade knpc kpc "buy" ches-merch-msgs ches-catalog))
(define (ches-sell knpc kpc) (conv-trade knpc kpc "sell" ches-merch-msgs ches-catalog))

;; Paladins...
(define (ches-pala knpc kpc)
  (say knpc "ʼ��Ǥϲ��٤������Τ�Ʊ�Ԥ������Ǥ�Ԥ���ˡ���ʤ��ä���"
       "�����������Ϥ���Ź�򳫤��������"))

;; Townspeople...
(define (ches-glas knpc kpc)
  (say knpc "�����ʤ�Į���������Τʤ󤫤����ˤ�������ˤϤ�äƤ�������"))

(define (ches-ange knpc kpc)
  (say knpc "���ͤ������ɲ��Ϥ�äȹӡ������Τ����ߤ��ʡ�"))

(define (ches-patc knpc kpc)
  (say knpc "�����µ��ˤʤä����Ȥ��ʤ������������Ӥ���ʹ������"))

(define (ches-jess knpc kpc)
  (say knpc "���ϼ㤤���Τ��뤤��������"
       "������ǰ���������ðŤʤ�Ʊ��������"))

(define ches-conv
  (ifc glasdrin-conv

       ;; basics
       (method 'default ches-default)
       (method 'hail ches-hail)
       (method 'bye ches-bye)
       (method 'job ches-job)
       (method 'name ches-name)
       (method 'join ches-join)
       
       ;; trade
       (method 'trad ches-trade)
       (method 'buy ches-buy)
       (method 'sell ches-sell)

       ;; paladin
       (method 'pala ches-pala)

       ;; town & people
       (method 'glas ches-glas)
       (method 'ange ches-ange)
       (method 'patc ches-patc)
       (method 'jess ches-jess)

       ))

(define (mk-chester)
  (bind 
   (kern-mk-char 'ch_chester         ; tag
                 "����������"        ; name
                 sp_human            ; species
                 oc_warrior          ; occ
                 s_townsman          ; sprite
                 faction-glasdrin         ; starting alignment
                 5 0 2               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 3  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'ches-conv          ; conv
                 sch_ches            ; sched
                 'townsman-ai                 ; special ai
                 (mk-inventory (list (list 1 t_mace)
                                     (list 1 t_armor_chain))) ; container
                 nil ;;  readied
                 )
   (ches-mk)))
