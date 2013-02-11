;;----------------------------------------------------------------------------
;; Schedule
;;
;; �ȥꥰ�쥤��
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_miggs
               (list 0  0  trigrave-miggs-bed      "sleeping")
               (list 7  0  trigrave-tavern-kitchen "working")
               (list 23 0  trigrave-miggs-bed      "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (miggs-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;;
;; �ᥰ���ϼ��μ�ͤǤ���
;;----------------------------------------------------------------------------
(define miggs-merch-msgs
  (list "��줬�����Ƥ���Ȥ�����Ƥ�������������7�����鿼��ޤǤǤ���"
        "��������ۤäƥ�˥塼��غ���������"
        nil
        nil
        "���꤬�Ȥ���"
        "�����Ǥ�����"
        ))

(define miggs-catalog
  (list
   (list t_food 5 "������Ϥ����������ʤˤ����Υ����塼�򤹤��äƸ���������")
   (list t_beer 3 "������ϥե���ޥ������õ�Ƚ񤫤줿��٥��î��غ���������")
  ))

(define (miggs-trade knpc kpc) (conv-trade knpc kpc "buy" miggs-merch-msgs miggs-catalog))

(define (miggs-hail knpc kpc)
  (kern-print "�Τ��ʤ��������ʤ��襤�餷����Ω���ν����Ȳ�ä���"
              "������Ѥ����������˻������򤱤�����\n"))

(define (miggs-job knpc kpc)
  (say knpc "���Ρ��۵����աפ򤷤Ƥ��ޤ���"))

(define (miggs-lust knpc kpc)
  (say knpc "�����ϼ��Ǥ�����������ޤ�����")
  (if (kern-conv-get-yes-no? kpc)
      (miggs-trade knpc kpc)
      (say knpc "�����Ǥ�����")))

(define miggs-conv
  (ifc basic-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default (lambda (knpc kpc) (say knpc "��������ۤä��ޤޤ�����")))
       (method 'hail miggs-hail)
       (method 'bye (lambda (knpc kpc) (say knpc "������Ͼ������Ф������")))
       (method 'job miggs-job)       
       (method 'name (lambda (knpc kpc) (say knpc "�ᥰ����")))

       (method 'trad miggs-trade)
       (method 'buy miggs-trade)
       (method 'food miggs-trade)
       (method 'lust miggs-lust)
       (method 'jugs miggs-lust)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-miggs tag)
  (bind 
   (kern-mk-char tag                 ; tag
                 "�ᥰ��"            ; name
                 sp_human            ; species
                 nil                 ; occ
                 s_fat_townswoman    ; sprite
                 faction-men         ; starting alignment
                 2 0 0             ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 3  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'miggs-conv        ; conv
                 sch_miggs          ; sched
                 'townsman-ai                 ; special ai
                  nil                ; container
                 (list t_dagger)                 ; readied
                 )
   (miggs-mk)))
