;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define jones-lvl 6)
(define jones-species sp_human)
(define jones-occ nil)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ����ݥꥹ�κ�
;;----------------------------------------------------------------------------
(define jones-bed ph-bed1)
(define jones-mealplace ph-tbl1)
(define jones-workplace ph-arms)
(define jones-leisureplace ph-hall)
(kern-mk-sched 'sch_jones
               (list 0  0 jones-bed          "sleeping")
               (list 7  0 jones-mealplace    "eating")
               (list 8  0 jones-workplace    "working")
               (list 12 0 jones-mealplace    "eating")
               (list 13 0 jones-workplace    "working")
               (list 18 0 jones-mealplace    "eating")
               (list 19 0 jones-leisureplace "idle")
               (list 22 0 jones-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (jones-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ���硼�󥸡��ϥ��饹�ɥ�󷳤���������Ư���Ƥ��롣
;; ��ϥ���ݥꥹ�κ֤ˤ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (jones-name knpc kpc)
  (say knpc "���硼�󥸡��������Ǥ�ɤ�����"))

(define (jones-job knpc kpc)
  (say knpc "���饹�ɥ�󷳤���������Ư���Ƥ��롣������äƤ�������")
  (if (yes? kpc)
      (jones-trade knpc kpc)
      (say knpc "�ʤˤ������Τ����ä�����Ƥ��졣")))

;; Trade...
(define jones-merch-msgs
  (list "����9��������6���δ֤������Ϥ���Ƥ��졣"
        "����Ū��ʪ�Ϥ���äƤ��롣"
        nil
        nil
        "����ǽ�ʬ������äȤ��ä����������ΤǤϡ�"
        "�����Ͻ�ʬ�ˤ��ä�������������"
   ))

(define jones-catalog
  (list
   (list t_arrow        1 "���Ǥϥȥ�뤬������褦�����Ȥ����Ȥˤʤ뤾��")
   (list t_bolt         1 "�����������֤����Ƥ���֤��Ƥ�Ȥ��̤����Ƥ��ޤ�������")
   (list t_oil          6 "�������б�ӥ�Ϥ���������äƤ��������Ϥ�äȤҤɤ�����")
   (list t_torch        6 "���Ǿ������ڤ餻�����Ϥʤ�������")
   (list t_heal_potion 23 "�����������⤤�������������Ǥϲ��������ϼ������ˤ��������������Ф�ɬ�פ���")
   (list t_mana_potion 23 "���Ϥ�����¿�����ä��ۤ����褤����֤���ѻդϤ��Ĥ���Ư���ʤ���Фʤ�ʤ�������")
   (list t_food        10 "�����ؤ��¤ä��Ȥ����������ʤ��ʤä���ǰ�����")
   ))

(define (jones-trade knpc kpc) (conv-trade knpc kpc "buy" jones-merch-msgs jones-catalog))

;; Quest-related

(define jones-conv
  (ifc kurpolis-conv

       ;; basics
       (method 'job jones-job)
       (method 'name jones-name)
       
       ;; trade
       (method 'trad jones-trade)
       (method 'buy jones-trade)

       ))

(define (mk-jones)
  (bind 
   (kern-mk-char 
    'ch_jones        ; tag
    "���硼�󥸡�"      ; name
    jones-species         ; species
    jones-occ              ; occ
    s_townsman     ; sprite
    faction-men      ; starting alignment
    2 0 0            ; str/int/dex
    0 0              ; hp mod/mult
    0 0              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    jones-lvl
    #f               ; dead
    'jones-conv         ; conv
    sch_jones           ; sched
    'townsman-ai              ; special ai
    nil              ; container
    (list t_axe
    		t_armor_chain)              ; readied
    )
   (jones-mk)))
