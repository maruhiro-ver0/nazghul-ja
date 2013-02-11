;; shroom.scm - �Ф��������˽�����ˤ��Τ�Ϸ��

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; �Ф���
;;----------------------------------------------------------------------------
(define (mk-zone x y w h) (list 'p_green_tower x y w h))
(kern-mk-sched 'sch_shroom
               (list 0  0  (mk-zone 51 9  1  1)  "sleeping")
               (list 5  0  (mk-zone 40 11 3  3)  "idle")
               (list 6  0  (mk-zone 49 6  7  1)  "working")
               (list 12 0  (mk-zone 50 9  1  1)  "eating")
               (list 13 0  (mk-zone 49 6  7  1)  "working")
               (list 18 0  (mk-zone 56 54 1  1)  "eating")
               (list 19 0  (mk-zone 53 50 4  7)  "idle")
               (list 21 0  (mk-zone 51 9  1  1)  "sleeping"))

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (shroom-mk gave-quest? finished-quest?) (list gave-quest? 
                                                      finished-quest?))
(define (shroom-gave-quest? shroom) (car shroom))
(define (shroom-quest-done? shroom) (cadr shroom))
(define (shroom-give-quest shroom) (set-car! shroom #t))
(define (shroom-set-quest-done! shroom) (set-car! (cdr shroom) #t))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ����롼���Ⱦ����Ǥ��ꡢ�Ф����������������äƤ��롣
;; ����ϥ��֥������Ǥϥ����ӥ����η����襤�����β����ȸƤФ�Ƥ�����
;;----------------------------------------------------------------------------

(define shroom-merch-msgs
  (list "�����������Υ��ʤ󤫤���äƤ��롣Ź�������Ƥ���Ȥ������γѤ���ʤ�����"
        "���Τɤ��Ǽ��Τ����֤��������������ΤäƤ���Τ���"
        "����������ΤϤ��뤫�͡�"
        "���Υ���ۤ������������롣�����㤦���͡�"
        "����Ĥ��ƻȤäƤ���衣"
        "��ʬ�Ǽ��˹Ԥ����Ȥ���ʡ��ٰ��ʤ�Τ˻������衪"
        "����Τ����ä���ޤ���ʡ�"
        "�����ˤ���Ф�������"
        "�ɤ��⡣"
        "�����̤�����ä������ä�����������"
   ))

(define shroom-catalog
  (list
   (list sulphorous_ash (*  2 reagent-price-mult) "���ν������򸫤Ĥ���ˤϵ֤Τ��äȸ������عԤ��ͤФʤ��")
   (list garlic         (*  3 reagent-price-mult) "��������Ȫ�Ǽ�ä���Τ����ܥ�������ͤ⤳���Ĥ򵤤����äƤ롣")
   (list ginseng        (*  3 reagent-price-mult) "���ͤ��ͻ����ɤ��ˤ��뤫�����Ƥ��줿��")
   (list blood_moss     (*  4 reagent-price-mult) "��������������ݤϡ����α��λ����ڤ������Ƥ���Τ���")
   (list spider_silk    (*  5 reagent-price-mult) "����λ���������Ϥʤ����������Τ����Ѥ���")
   (list nightshade     (* 10 reagent-price-mult) "�ʥ��ȥ������ɤ������ζ᤯��õ���ͤФʤ��")
   (list mandrake       (*  8 reagent-price-mult) "�ޥ�ɥ쥤���Ϥ��ο��������Ƥ��롣�����ɤ��ˤ���Τ��ΤäƤ����ۤϾ��ʤ���")
   
   (list t_heal_potion  20 "���ϴ�ʤ����������ä��Ȥ��Τ�����äƤ����Ȥ褤������")
   (list t_mana_potion  20 "������������õ�������ꡢ���μ�ʸ�򾧤�����ˤ����Ĥ�ȤäƤ��롣")
   (list t_cure_potion  20 "̵�ѿ����Ǥ򿩤�äƤ��ޤä��餳���Ĥ�Ȥ��Ф�����")
   (list t_poison_immunity_potion 20 "�Ǥξ¤�������õ���Ȥ��Ϥ��Ĥ⤳���Ĥ����Ǥ��롣")
   (list t_slime_vial   20 "����������ۤϤ���򹥤ࡣ������������⤤�Ƥ롣�ͥХͥФ������餢�äƤ�­��ʤ����餤����")
   ))

;; Shroom's merchant procedure
(define (shroom-trade knpc kpc) (conv-trade knpc kpc "trade" shroom-merch-msgs shroom-catalog))

;; Shroom's mushroom quest
(define (shroom-wards knpc kpc)
  (let ((shroom (kobj-gob-data knpc)))
    (if (shroom-gave-quest? shroom)
        ;; gave quest
        (if (shroom-quest-done? shroom)
            ;; quest already done
            (say knpc "¾�Ϥߤ��˺����ޤä���")
            ;; quest NOT yet done
            (begin
              (say knpc "���Υ�����äƤ���вФμ�ʸ�򶵤��褦��"
                   "�Ф��Ƥ��뤫��")
              (if (kern-conv-get-yes-no? kpc)
                  (say knpc "�����")
                  (say knpc "�Τ���©�Ͻ�α��Ƥ������ۤ����褫����"
                       "Į��Υ�졢��عԤ��ȳ��ζ᤯�˻�̮�����롣"
                       "������ƶ��������������������"))))
        (begin
          (say knpc "���Τ������������襤�μ�ʸ�򤿤������ΤäƤ���"
               "�Τꤿ������")
          (if (kern-conv-get-yes-no? kpc)
              (begin
                (say knpc "���������ΤäƤ���ʸ�ϡ��Ф���Ȥ����Τ���"
                     "�������ޤ�����ߤ�ʹ���Ƥ�������褤�ʡ�")
                (if (kern-conv-get-yes-no? kpc)
                    (begin
                      (say knpc "���ƶ���ˤϻ翧�Υ��Υ��������Ƥ��롣"
                           "�������äƤ���Τ����狼�ä��ʡ�")
                      (if (kern-conv-get-yes-no? kpc)
                          (begin
                            (say knpc "�������ƶ������ϥͥХͥФ������"
                                 "�б�ӥ�򤿤�������äƤ�����")
                            (shroom-give-quest shroom))
                          (say knpc "�������ʡ��ݤ��������")))
                    (say knpc "�����Ǥϲ����㤨�󤾡��㤤�Ρ�")))
              (say knpc "̵�����������ʡ����󤿤Τ褦��ͥ������Τϡ��������Τ褦��ǯ����������鶵��뤳�Ȥϲ���ʤ��Τ����͡�"))))))
                               
(define (shroom-hail knpc kpc)
  (let ((shroom (kobj-gob-data knpc)))
    (display "shroom: ")
    (display shroom)(newline)
    (if (shroom-gave-quest? shroom)
        ;; gave quest
        (if (shroom-quest-done? shroom)
            ;; quest done
            (say knpc "�ޤ���ä��ʡ��㤤�¤��ͤ衣")
            ;; quest not done yet
            (if (in-inventory? kpc t_royal_cape)
                (begin
                  ;; player has shrooms
                  (say knpc "���������줸�㡪���Υ��Υ�����")
                  (kern-obj-remove-from-inventory kpc t_royal_cape 1)
                  (shroom-set-quest-done! shroom)
                  (say knpc "���������������֤���"
                       "���μ�ʸ�����ؤΥ��󡦥ե�ࡦ���󥯥�<In Flam Sanct>����"
                       "����륱��������β���γ������Ǥ�Ĵ�礷��"
                       "����򾧤���ʬ����֤ˤ�����ȡ��Ф����Ȥ�ʤ��ʤ�Τ��㡪"))
                ;; player does NOT have shrooms yet
                (say knpc "�ޤ��翧�Υ��Υ��ϸ��Ĥ���̤褦���ʡ�"
                      "�����뤳�ȤϤʤ���"
                      "������������ˤ��ߤ��������͡�")))
        ;; has NOT given quest yet
        (say knpc "�ʤ��Ѥ��͡�"))))

(define (shroom-thie knpc kpc)
  (say knpc "�������ۤϸ��ʤ��ä����͡�"))

(define (shroom-roya knpc kpc)
  (say knpc "����륱�������λȤ������ΤäƤ뤫��")
  (if (yes? kpc)
      (say knpc "��ä��˼������ʤ���������������Ǵ�ݤΤ�����Ǹ��Ĥ��뤳�Ȥ����롣")
      (say knpc "�����Ĥˤϵۼ������Ϥ����롪")))

(define (shroom-band knpc kpc)
  (say knpc "��±��������ǯ���Ͽ��Ǥϵ���Ĥ��ͤС�"))

(define shroom-conv
  (ifc basic-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default (lambda (knpc kpc) (say knpc "��ʹ�����褦�ʵ�������ʡ�")))
       (method 'hail shroom-hail)
       (method 'bye (lambda (knpc kpc) (say knpc "����Ф��㡣")))
       (method 'job (lambda (knpc kpc) (say knpc "���������ʤɤ���äƤ��롣")))
       (method 'name (lambda (knpc kpc) (say knpc "����롼��ȸƤФ�Ƥ��롣"
                                                "�Ѥϲ����͡�")))
       (method 'cape shroom-roya)
       (method 'roya shroom-roya)
       (method 'shro (lambda (knpc kpc) (say knpc "���Υ��Τ��Ȥ�褯�ΤäƤ��롣"
                                                "�����餢�����򥷥�롼��ȸƤ֤�����͡�")))
       (method 'maid (lambda (knpc) (say knpc "������ϲ��ܤ�ȴ���Ƥ��ޤä����򸫤�������"
                                           "�����������Ĥ����������β����ȸƤФ줿�ʤ�ƿ������뤫����"
                                           "������ϥ��饱��ȾФä�����")))
       (method 'mush shroom-trade)
       (method 'buy (lambda (knpc kpc) (conv-trade knpc kpc "buy" shroom-merch-msgs shroom-catalog)))
       (method 'trad shroom-trade)
       (method 'sell (lambda (knpc kpc) (conv-trade knpc kpc "sell" shroom-merch-msgs shroom-catalog)))
       (method 'reag shroom-trade)
       (method 'poti shroom-trade)
       (method 'join (lambda (knpc) (say knpc "�������ˤϼ㤹����衢˷�䡪")))
       (method 'gen (lambda (knpc) (say knpc "�������㤤�Ȥ��ϥϥ󥵥���ä���"
                                        "���˥٥åɤ��������������Τ���"
                                        "�����������������ʤä��ޤä���"
                                        "���֥������ɤ�����ʤ�Ƥ���")))
       (method 'stra (lambda (knpc) (say knpc "������Ͽ��ǥ��֥��ã�Ȳ񤤡�"
                                            "���˼��򤹤�褦�ˤʤä���"
                                            "Ⱦʬ���֥��ߤ����ʤ�Τ���"
                                            "�ۤ�Τ������ޤͤƤ����Ǥ⡢"
                                            "�⤦���ΥХ��ˤ�ᤵ���뤳�ȤϤǤ���衣")))
       (method 'gobl (lambda (knpc) (say knpc "�ۤ�ȤϺ����Τ⾦��򤷤Ƥ��롣"
                                            "�ۤ�μ��ѻդϤ��ο��ο�ʪ��褯�ΤäƤ롣"
                                            "���������ۤ�θ��դϾ�����ʬ���뤷����ˡ�⾯��ʬ���롣"
                                            "�������ۤ�����Ф˿��ѤǤ���")))
       (method 'thie shroom-thie)
       (method 'trus (lambda (knpc) (say knpc "���֥��ϵ��񤬤���л��֤�����˰㤤�ʤ���"
                                          "���������ۤ�ʤ餽�����롪")))
       (method 'wars (lambda (knpc) (say knpc "�������������������ϥ��֥��ɤ����ä���"
                                         "���ä��ΤΤ��Ȥ����ͤ�˺����ޤä����͡�")))
       (method 'ward shroom-wards)
       (method 'spel shroom-wards)
       (method 'band shroom-band)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-shroom tag)
  (bind 
   (kern-mk-char tag                 ; tag
                 "����롼��"        ; name
                 sp_human            ; species
                 nil                 ; occ
                 s_companion_druid   ; sprite
                 faction-men         ; starting alignment
                 1 6 1               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 3  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'shroom-conv        ; conv
                 sch_shroom          ; sched
                 'townsman-ai                 ; special ai
                 (mk-inventory (list (list 1 t_sword)))                 ; container
                 (list t_armor_leather)                 ; readied
                 )
   (shroom-mk #f #f)))
