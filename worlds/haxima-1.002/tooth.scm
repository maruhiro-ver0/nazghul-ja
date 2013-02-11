;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define tooth-lvl 2)
(define tooth-species sp_rat)
(define tooth-occ oc_wrogue)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ��ʪ��¼������
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_tooth
               (list 0 0 campfire-4 "sleeping")
               (list 6 0 black-market-counter "working")
               (list 19 0 cantina-12 "idle")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (tooth-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; �ޥ��ФϿ��м��ʥͥ��߿ʹ֤ǡ���ʪ��¼������ǰǻԤȼ���Ĥ�Ǥ��롣
;; �����ζ�ʳ�ޤμ�ꤹ��(�ޤ��϶��Ǿɾ�)�Ƕ줷��Ǥ���褦�˸����롣
;;----------------------------------------------------------------------------

;; Basics...
(define (tooth-hail knpc kpc)
  (kern-log-msg "���ʤ��Ϥ��븭������ǯϷ�����礭�������Υͥ��ߤȲ�ä�����Ͽ��м������˿̤����Τ��ɤ餷�Ƥ��롣"
                "���ե�����μ�ꤹ�����֥�å����������Ф������ʤ��ˤϲ���狼��ʤ���")
  (say knpc "����äȡ����䤫��������Ϥ���衣�ɤ�ʾ���⤢��衪�������䡪�������䡪"
       "���äȤ��졢�Ѱդ���衢���Ȥ��졪����ʹ���Ƥʤ�����������ʤ���")
  )

(define (tooth-default knpc kpc)
  (say knpc "�Τ�ʤ���������Τ�ʤ������󡩲��ˤϴط��ʤ���")
  )

(define (tooth-name knpc kpc)
  (say knpc "�ޥ��С�ͭ̾���衪ɾȽ�����衣���ҤϤߤ�ʵ������äƤ롣"
       "�ߤ�ʤޤ���롣���ҤΤ�ͧã�ϲ��Τ����ä��Ƥ롩���̡�"
       "����ϤȤäƤ⤤���衣���ҤϤߤ����̩�ˤ��Ƥ롣���Ϥ�������̩��ͭ̾����̩��")
  )

(define (tooth-join knpc kpc)
  (say knpc "�Ǥ��ʤ���ͧ�衣Ź���ʤ��㡣�ڶ��֤��ʤ��㡣��ʼ����ƨ���ʤ��㡣˻�������롪ư���ʤ��㡪")
  )

(define (tooth-job knpc kpc)
  (say knpc "���䡪���䡪���䡪���䡪���䡪���䡪������������������"
       "�����Ǥ�������ˤ���������Ǥ�����������������")
  (tooth-trade knpc kpc)
  )

(define (tooth-bye knpc kpc)
  (say knpc "����ʤ��᤯�Ԥ��Ρ��⤦����Ρ���äȤ���衪�������󤢤�衪"
       "������Ρ��Ǥ⤳���ˤϤʤ��������䡪ê��������Ǥ��ä���������Ǥ�ǡġ�"
       "����Ϥ��ʤ������ޤǤ��Τ褦�ʤ��Ȥ����³��������")
  )

(define tooth-merch-msgs
  (list nil ;; closed
        "���츫�ơ����Τ������θ��ơ���������������������Ω�ġ�¾�ˤʤ���" ;; buy
        "����ʪ��������롣�ɤ��Ǹ��Ĥ������ɤ��Ǥ⤤����" ;; sell
        "�������㤤�����ɤ���ä��٤��Ƥ롩�狼��ʤ�����ʬ�ǳΤ���ơ�" ;; trade
        "����������ޤ�����衪" ;; sold-something
        "�Ԥơ��ɤ��Ԥ�����äơ��̤θ��ơ����δ�ʪ���쥯����󸫤���" ;; sold-nothing
        "��äȤ��ä���ޤ���ơ����ĤǤ⸫��衪" ;; bought-something
        "��äȤ�����Ρ���ˡ�Τ�Ρ����С��ݽ��ʡ�" ;; bought-nothing
        "���ܤ�˺��ʤ����б�ӥ����С�������ƻ��" ;; traded-something
        "�Ԥơ��ɤ��Ԥ�����äơ��̤θ��ơ����δ�ʪ���쥯����󸫤���" ;; traded-nothing
        ))

(define tooth-catalog
  (list
   (list t_picklock            5 "��򳫤��롪����äȵ������롪")
   (list t_gem                20 "��̩��������ƻ�򸫤Ĥ��롪ť���ϥ��줬�繥����")
   (list t_grease             25 "�����Ȥ������롩�����")

   (list t_oil                 5 "Ǵ�ݤ��臘�Τ˰��֡�")
   (list t_slime_vial         30 "Kal Xen Nox���ӵͤᤷ������ʼ����ƨ����Τˤ�����")
   (list t_arrow               3 "��Ϥ��äѤ�����衪")
   (list t_bolt                3 "�Ƥ�¿�����뤳�ȤϤʤ���")
   (list t_smoke_bomb          4 "�褯������ƨ��ƻ���롪")

   (list t_spiked_helm       300 "Ƭ���廊��")
   (list t_spiked_shield     300 "������ʪ�����⤬�繥���ʿͤˡ�")

   (list t_dagger_4           (* 4 65) "�ȤäƤ⤤�����������������롢�Ǥ�������ݤ���")
   (list t_sword_2            (* 2 85) "���̤η���ꤤ���������ڤ���򸫤ơ�")
   (list t_sword_4            (* 4 85) "���֤������Ƕ�����ʪ�λ�ηݽѲȤ���")
   (list t_morning_star_2     (* 2 105) "�����˥��å��������ޤȤ���ݤ���")

   (list t_leather_helm_2     (* 2 100) "����ä�;ʬ���ɸ椬�פ�ʤ餺�Ը�����")
   (list t_chain_coif_4       (* 4 100) "���Τ��Ĥ����ܸ��ơ����ζ�����ӤĤ����ɤ�ʿϤ��¤餲�롪")
   (list t_iron_helm_4        (* 4 150) "�ȤäƤ���������Ƭ�򲥤��Ƥ����餤�ˤ��������ʤ���")

   (list t_armor_leather_2    (* 2 150) "��ͤ����ˤ�ť���ˤʤꤿ�����ȥ�뤫�����Ф���ߤ���������ߤ����ʷڤ��Ƥ�����Ĥ��פ롪")
   (list t_armor_leather_4    (* 4 150) "�ΤΤʤ餺�Ԥ����äƤ�����ߤΥ٥åɤ�ǯ��äƻ��������󤿤�Ǥ��롪")
   (list t_armor_chain_4      (* 4 330) "����ϴ�����ư���Υ���ޤˤʤ�ʤ��ƶ�����")
   (list t_armor_plate_4      (* 4 660) "��ͤȥȥ�뤬���äƤ�����ʤ����������������ʳ��ˤʤ���")

   (list t_xen_corp_scroll    (* 7 base-scroll-cost) "�Ż��Ԥ����������������롪")
   (list t_sanct_lor_scroll   (* 7 base-scroll-cost) "�ʤ餺�Ԥ������������ʤ��ʤäƽ����ꤹ�롪")
   (list t_an_xen_ex_scroll   (* 6 base-scroll-cost) "�ݤ��ʤ���ĤϤ��μ�ʸ����֤ˤ���")
   (list t_in_ex_por_scroll   (* 4 base-scroll-cost) "�����Ĥ����äѤ�����С���ˡ�����ߤ���ʤ���")
   (list t_wis_quas_scroll    (* 4 base-scroll-cost) "�����ʤ���(�����Ƹ����ʤ�Ũ)�򸫤Ĥ���Τ˴�����")
   (list t_in_quas_xen_scroll (* 7 base-scroll-cost) "��ʬ������ߤ��������δ�ʪ���ɤᡪ")
   (list t_an_tym_scroll      (* 8 base-scroll-cost) "�����˥�Х��Ȥ��Ϥ��δ�ʪ���ɤ�ǻ��֤�ߤ��ƨ����")
   ))

(define (tooth-trade knpc kpc) (conv-trade knpc kpc "trade" tooth-merch-msgs tooth-catalog))
(define (tooth-buy   knpc kpc) (conv-trade knpc kpc "buy"   tooth-merch-msgs tooth-catalog))
(define (tooth-sell  knpc kpc) (conv-trade knpc kpc "sell"  tooth-merch-msgs tooth-catalog))

(define tooth-conv
  (ifc nil

       ;; basics
       (method 'default tooth-default)
       (method 'hail tooth-hail)
       (method 'bye  tooth-bye)
       (method 'job  tooth-job)
       (method 'name tooth-name)
       (method 'join tooth-join)

       (method 'trad tooth-trade)
       (method 'buy  tooth-buy)
       (method 'sell tooth-sell)
       (method 'deal tooth-trade)
       ))

(define (mk-tooth)
  (bind 
   (kern-mk-char 
    'ch_tooth           ; tag
    "�ޥ���"             ; name
    tooth-species         ; species
    tooth-occ              ; occ
    s_rat     ; sprite
    faction-men      ; starting alignment
    0 4 1            ; str/int/dex
    0  ; hp bonus
    0 ; hp per-level bonus
    0 ; mp off
    1 ; mp gain
    max-health ; hp
    -1                  ; xp
    max-health ; mp
    0
    tooth-lvl
    #f               ; dead
    'tooth-conv         ; conv
    sch_tooth           ; sched
    'townsman-ai              ; special ai
    nil
    nil              ; readied
    )
   (tooth-mk)))
