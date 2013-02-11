;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ���饹�ɥ��
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_jess
               (list 0  0  gj-bed      "sleeping")
               (list 7  0  ghg-counter "working")
               (list 9  0  g-fountain  "idle")
               (list 10 0  ghg-counter "working")
               (list 13 0  gc-hall     "idle")
               (list 14 0  ghg-counter "working")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (jess-mk) (list 'townsman))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; �������ϥ��饹�ɥ��μ������աפμ�ν����Ǥ��롣
;; ����δ�ˤϡ������ܥ�ʼ�Ȥ��ƥ��饹�ɥ���ʼ��˽����Ƥ����������֥�
;; �󤫤�������������롣
;;----------------------------------------------------------------------------

;; Basics...
(define (jess-hail knpc kpc)
  (if (string=? "working" (kern-obj-get-activity knpc))
      (say knpc "�Τ��ʤ��Ͽͤ�����Ĥ���褦�ʼ㤤�����Ȳ�ä��������¦�˿����������롣��"
           "���Ĥ��Ǥ����������Ĥ��ˤ��ʤ������դ��ˤ��ޤ�����")
      (say knpc "�Τ��ʤ��Ͽͤ�����Ĥ���褦�ʼ㤤�����Ȳ�ä��������¦�˿����������롣��"
           "����ŷ���͡�")))

(define (jess-default knpc kpc)
  (say knpc "������Ĥ狼��ޤ���"))

(define (jess-name knpc kpc)
  (if (working? knpc)
      (say knpc "��ϥ����������ηƤ��ξ�μ�Ǥ���")
      (say knpc "��ϥ��������Ƥ��ξ�����աפμ�Ǥ���"
           "�����餤���顢�����Ƥ���Ȥ�����Ƥ��������ʡ�")))

(define (jess-join knpc kpc)
  (say knpc "�������������ǰ���ʪ��Ф��Τ������դǤ�������˻��ʼ��Ϥ⤦�����ޤ�����"))

(define (jess-job knpc kpc)
  (say knpc "����ʪ�����뤫���ۤǤ������Ƥ�館�ޤ�����")
  (if (kern-conv-get-yes-no? kpc)
      (begin
        (say knpc "������ϥ����󥯤������Ϥ��������ȻפäƤޤ�����")
        (jess-trade knpc kpc))
      (say knpc "��ǰ�͡�")))

(define (jess-bye knpc kpc)
  (say knpc "���褦�ʤ顣�ޤ���Ƥ���������"))

(define jess-catalog
  (list
   (list t_food 7  "�����Τγ�����Ϥ��֤������繥���Ǥ���")
   (list t_beer 12 "���դ��������ޤ��礦��")
   ))

(define jess-merch-msgs
  (list "�䤬����Ȥ��ˡ����աפ���Ƥ���������ī���ϸ���7������9�����뿩��10��������1����������2�����鿼��ޤǺƳ�Ź���ޤ���"
        "��˥塼�Ǥ���"
        nil ;; sell
        nil ;; trade
        "�ڤ���Ǥ���������" ;; sold-something
        "�������ǥѥ��á���줿�ߤ����Ǥ���" ;; sold-nothing
        nil ;; the rest are nil
        ))

;; Trade...
(define (jess-buy knpc kpc) (conv-trade knpc kpc "buy" jess-merch-msgs jess-catalog))

;; Holy Grail
(define (jess-grai knpc kpc)
  (say knpc "���������Ǥ��¤��ͤ�����̾���ˤ����Ȥ���"
       "��������Ǥ褯�Τ�줿�ä����ˤʤäƤ��뤽���Ǥ��衣"))

;; Scar
(define (jess-scar knpc kpc)
  (say knpc "ƶ�����֥��ȡ����Ƥ�����ʼ�Τ����Ǥ���"
       "��̲����԰��Ǥ����������οϤ��ˤ˼����ޤ�����"
       "�Ǥ���Τ���������̿���ˤϤʤ�ޤ���Ǥ�����"
       "�襤���äϹ����Ǥ�����")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "����Į�οͤϤ�����ä��Ĥ��餤�ϻ��äƤ��ޤ����䤿���ϳ�ʼ��˽����ޤ������顣")
      (say knpc "��ǰ�Ǥ��͡������ǤϤ�����äФ���Ǥ���")))

(define (jess-serv knpc kpc)
  (say knpc "���饹�ɥ��λ�̱�Ϥߤ��ʼ��ε�̳������ޤ���"
       "��ϥ����ܥ�ʼ�ǡ�����ʼ���ظ夫��ٱ礹��Τ��Ż��Ǥ�����"
       "�������Ͽ�����¦�ζ����ˤ��ޤ�����"))

(define (jess-wood knpc kpc)
  (say knpc "������Ϥ褯��äƤ���Ȼפ��ޤ���"
       "�Ǥ⡢����ǯ�ˤ�ƶ�����֥��ȥȥ����緲�������󤻤Ƥ��ޤ�����"))

;; Townspeople...
(define (jess-glas knpc kpc)
  (say knpc "���ϤǤ��뤳�Ȥ�ͤ���С���ʬ�ˤ褤��Ǥ���"))

(define (jess-ange knpc kpc)
  (say knpc "���Ф餷���ͤǤ�����ΤȤ��Ƥϳ����Ǥ��ޤ���Ǥ�����������ˤ���������ܤ�����ޤ���"))

(define (jess-patc knpc kpc)
  (say knpc "���α��줿ǯ��ꡪ���������̤Ǥ��衣"))

(define jess-conv
  (ifc glasdrin-conv

       ;; basics
       (method 'default jess-default)
       (method 'hail jess-hail)
       (method 'bye  jess-bye)
       (method 'job  jess-job)
       (method 'name jess-name)
       (method 'join jess-join)
       
       ;; trade
       (method 'grai jess-grai)
       (method 'holy jess-grai)
       (method 'trad jess-buy)
       (method 'room jess-buy)
       (method 'buy  jess-buy)
       (method 'drin jess-buy)
       (method 'ware jess-buy)
       (method 'food jess-buy)

       ;; scar
       (method 'trade jess-buy)
       (method 'scar  jess-scar)
       (method 'serv  jess-serv)
       (method 'tour  jess-serv)
       (method 'wood  jess-wood)

       ;; town & people
       (method 'glas jess-glas)
       (method 'ange jess-ange)
       (method 'patc jess-patc)

       ))

(define (mk-jess)
  (bind 
   (kern-mk-char 'ch_jess           ; tag
                 "������"           ; name
                 sp_human            ; species
                 nil                 ; occ
                 s_townswoman        ; sprite
                 faction-glasdrin         ; starting alignment
                 0 0 1               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 3  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'jess-conv         ; conv
                 sch_jess           ; sched
                 'townsman-ai                 ; special ai
                 (mk-inventory (list (list 1 t_dagger)))                 ; container
                 nil                 ; readied
                 )
   (jess-mk)))
