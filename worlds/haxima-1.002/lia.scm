;; Reagent-seller
;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; In Oparine.
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_lia
               (list 0  0  sea-witch-bed        "sleeping")
               (list 6  0  sea-witch-beach      "idle")
               (list 8  0  sea-witch-counter    "working")
               (list 20 0  sea-witch-beach      "idle")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (lia-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; �ꥢ�ϥ��ѡ����˽����������ѻդǡ���������äƤ��롣
;; �����������������˥������β��ҤΥե���ζ᤯�ˤ��롣
;; 
;; ����Ϥ褯�狼��ʤ������򤫤����Ƥ���ȸ����Ƥ��롣
;; ����ϥ˥�������¾�γ���̱�ǡ��ʹ֤λѤ��ѿȤ��Ƥ���������⤷��ʤ���
;;----------------------------------------------------------------------------

;; Basics...
(define (lia-hail knpc kpc)
  (say knpc "�Τ��ʤ���˺����ʤ��褦�����ͤȲ�ä����Ϥ���ä��㤤�ޤ���"))

(define (lia-default knpc kpc)
  (say knpc "����Ϥ��������Ǥ��ޤ���"))

(define (lia-name knpc kpc)
  (say knpc "��ϥꥢ�Ǥ���"))

(define (lia-join knpc kpc)
  (say knpc "���δߤ�Υ��뤳�ȤϤǤ��ޤ���"))

(define (lia-job knpc kpc)
  (say knpc "��������äƤ��ޤ���������������⤢��ޤ��衣"))

(define (lia-bye knpc kpc)
  (say knpc "���褦�ʤ顢�¤��ͤ���"))

;; Trade...
(define lia-merch-msgs
  (list "���Ź�ϸ���8��������8���ޤǳ����Ƥ��ޤ���"
        "����������ʤ�����ޤ���"
        "�褤ʪ��������㤤���ޤ���"
        "�㤤�ޤ���������Ȥ���ꤿ��ʪ������ޤ�����"
        "���ʤ�����ˡ�˲ø����ޤ��褦�ˡ�"
        "�狼��ޤ�����"
        "����¾��ɬ�פ�ʪ�Ϥ���ޤ�����"
        "Ŭ���ʲ��ʤ��󼨤��������Ǥ���"
        "�����������ʤ��������Ǥ��礦��"
        "����˾��ʤ顣"
   ))

(define lia-catalog
  (list
   (list sulphorous_ash         (*  2 reagent-price-mult) "���γ��ϲФγ��ˤ���ε�ο��������äƤ�����ΤǤ���")
   (list garlic                 (*  4 reagent-price-mult) "���ǤϤ褯���롢�Ǥ��ʸ�ǻȤ��䤹������Ǥ���")
   (list ginseng                (*  4 reagent-price-mult) "���οͻ��ϥޥ�ɥ쥤���Ȱ��˼�ʬ�ǰ�Ƥ���ΤǤ���")
   (list black_pearl            (*  4 reagent-price-mult) "������̤ʾ��Ǽ�ä���ΤǤ���¾�Ǥϸ��Ĥ���ʤ��Ǥ��礦��")
   (list blood_moss             (*  6 reagent-price-mult) "���Τ�����ǤϷ���ݤϤʤ��ʤ����Ĥ���ޤ���")
   (list nightshade             (* 11 reagent-price-mult) "�ʥ��ȥ������ɤϤ��Τ�����Ǥ���������ΤǤ���")
   (list mandrake               (* 11 reagent-price-mult) "�ޥ�ɥ쥤���Ͽͻ��Ȱ��˰�ƤƤ��ޤ���")
   
   (list t_in_an_scroll         (*  3 base-scroll-cost) "���ϤǾ���Ԥ�ľ�̤��Ƥ⡢���줬�����Ʊ�ʤˤʤ�ޤ���")
   (list t_in_mani_corp_scroll  (*  8 base-scroll-cost) "��֤��ݤ�Ƥ⤳�줬������ᤷ�ळ�ȤϤ���ޤ���")
   (list t_vas_rel_por_scroll   (*  3 base-scroll-cost) "������δ�ʪ������С��󤯤�ι���뤳�Ȥ⡢�Ỵ�ʾ��֤���ƨ���뤳�Ȥ�Ǥ��ޤ���")
   (list t_vas_mani_scroll      (*  2 base-scroll-cost) "�Ҥɤ�������äƤ⤳��ǲ������뤳�Ȥ��Ǥ��ޤ���")
   (list t_wis_quas_scroll      (*  2 base-scroll-cost) "���δ�ʪ�Ǹ����ʤ������ؤ��ܤ������Ǥ��礦��")
   ))

(define (lia-trade knpc kpc)  (conv-trade knpc kpc "trade" lia-merch-msgs lia-catalog))
(define (lia-buy knpc kpc)  (conv-trade knpc kpc "buy" lia-merch-msgs lia-catalog))
(define (lia-sell knpc kpc)  (conv-trade knpc kpc "sell" lia-merch-msgs lia-catalog))

(define (lia-pear knpc kpc)
  (say knpc "I have my own source for the rare black pearl. "
       "Would you like to purchase some?")
  (if (kern-conv-get-yes-no? kpc)
      (lia-buy knpc kpc)
      (say knpc "You won't get this quality anywhere else!")))

;; Shores...
(define (lia-shor knpc kpc)
  (say knpc "������ͤζ᤯�ˤ��뤿�ᡢ��Ϥ����ˤ��ʤ���Фʤ�ޤ���"))

(define (lia-love knpc kpc)
  (say knpc "��ΰ�����ͤϳ���Υ��뤳�Ȥ��Ǥ��ޤ���"
       "��ϳ��οͤβ��ҤʤΤǤ���"
       "ͦ�������¡������ƻ�μ����ˤ⤫����餺��򸫼ΤƤʤ��Ǥ��ޤ���"
       ))

;; Sea
(define (lia-sea knpc kpc)
  (say knpc "Ĺ���֡��ζ�����äƤ��ޤ���"
       "��������������"
       "ŷ�򤫤���������"
       "�����Ʊ󤯤���᤯�͡��β��ä���������"))

(define (lia-curs knpc kpc)
  (say knpc "������ä���������ޤ���"))

;; Townspeople...
(define (lia-opar knpc kpc)
  (say knpc "����Į�ο͡��ϻ�ˤϴ��������Ƥ��ޤ���"))

(define (lia-gher knpc kpc)
  (say knpc "���λ������꤬���������褯�ɤäƤ��ޤ�����"
       "��������ε����ԤǤ褯��Ƥ��ޤ�����"))

(define (lia-alch knpc kpc)
  (say knpc "��ϻ�����ơ������ˡ���ä򤷤ޤ���"
       "��οʹ֤�ͧã�ΰ�ͤǤ���"))

(define (lia-osca knpc kpc)
  (say knpc "��Τ��Ȥϡ����˹Ԥä����Ȥ��ʤ����Ȱʳ��Ϥ褯�Τ�ޤ���"))

(define (lia-henr knpc kpc)
  (say knpc "��Ϥ��ĤƤ��Ф餷�������Ǥ�����"
       "�������ΰ���ʼԤ���������ͦ�������äƤ��ޤ�����"))

(define (lia-bart knpc kpc)
  (say knpc "������Ϲ⤯ɾ������Ƥ��ޤ���"
       "�Ǥ⡢��ˤȤä������Գʹ��ǽš�������ΤǤ���"))

(define lia-conv
  (ifc basic-conv

       ;; basics
       (method 'default lia-default)
       (method 'hail lia-hail)
       (method 'bye  lia-bye)
       (method 'job  lia-job)
       (method 'name lia-name)
       (method 'join lia-join)
       
       ;; Shores
       (method 'shor lia-shor)
       (method 'love lia-love)
       (method 'sea  lia-sea)
       (method 'deep lia-sea)
       (method 'curs lia-curs)

       ;; trade
       (method 'trad lia-trade)
       (method 'reag lia-buy)
       (method 'buy  lia-buy)
       (method 'sell lia-sell)
       (method 'blac lia-buy)
       (method 'pear lia-buy)

       ;; town & people
       (method 'opar lia-opar)
       (method 'alch lia-alch)
       (method 'gher lia-gher)
       (method 'osca lia-osca)
       (method 'henr lia-henr)
       (method 'bart lia-bart)
       (method 'fing lia-love)

       ))

(define (mk-lia)
  (bind 
   (kern-mk-char 'ch_lia           ; tag
                 "�ꥢ"            ; name
                 sp_human            ; species
                 oc_wizard           ; occ
                 s_townswoman        ; sprite
                 faction-men         ; starting alignment
                 0 2 1               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 3  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'lia-conv         ; conv
                 sch_lia           ; sched
                 'townsman-ai                 ; special ai
                 (mk-inventory (list (list 1 t_dagger)))    ; container
                 nil                 ; readied
                 )
   (lia-mk)))
