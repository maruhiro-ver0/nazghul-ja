;;----------------------------------------------------------------------------
;; Schedule
;;
;; �ܥ�
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_melvin
               (list 0  0  bole-bed-melvin      "sleeping")
               (list 7  0  bole-kitchen "working")
               (list 21 0  bole-bedroom-may      "idle")
               (list 22 0  bole-bed-melvin "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (melvin-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;;
;; ��������ϥܥ�νɤ������ͤǤ��롣
;; ��ϥᥤ��(7���ܤ�)�פǤ��롣
;;----------------------------------------------------------------------------
(define melv-merch-msgs
  (list "��줬�����Ƥ�Ȥ�����Ƥ��졣����7�����鿼��ޤǤ�äƤ롣"
        "�����Τ���������" ;; buy
        nil ;; sell
        nil ;; trade
        "�����ʤ�����" ;; sold-something
        "�ޤ����äƤߤʤ衣" ;; sold-nothing
        nil ;; bought-something
        nil ;; bought-nothing
        nil ;; traded-something
        nil ;; traded-nothing
   ))

(define melv-catalog
  (list
   (list t_beer  4 "�ӡ��롢�����ī�Ӥ���")
   (list t_food  3 "���Τ����ꤸ�㥷���ɤ����Υѥ�ڡ��˥硦���å����ɾȽ����")
   ))

(define (melvin-buy knpc kpc) (conv-trade knpc kpc "buy" melv-merch-msgs melv-catalog))

;; basics...
(define (melvin-default knpc kpc)
  (say knpc "�ᥤ��ʹ���Ƥ��졣���ˤϤ狼���"))

(define (melvin-hail knpc kpc)
  (say knpc "�Τ��ʤ��������줤�������ͤȲ�ä����Ϥ���ä��㤤��"))

(define (melvin-name knpc kpc)
  (say knpc "�����ͤΥ����������"))

(define (melvin-job knpc kpc)
  (say knpc "�ܥ�μ��Ƚɤ�ʤΥᥤ�Ȥ�äƤ��롣"
       "�����������ơ��ᥤ���Ф���"))

(define (melvin-join knpc kpc)
  (say knpc "���äȤ��ޤ����ͤ��ʡ�"
       "���ʤ��Ȥ⤳���ˤ������������������Ǥ��롣"))

(define (melvin-bye knpc kpc)
  (say knpc "���꤬�Ȥ���ʢ�����ä��餤�ĤǤ���äƤ����衣"))

;; other characters & town...
(define (melvin-may knpc kpc)
  (say knpc "�ʤΥᥤ��ʿ�ޤʽ����������ˤΤ褦�˱Ԥ���"))

(define (melvin-kath knpc kpc)
  (say knpc "�����֤����줤�ʽ���"
       "������������ˡ�Ȥ�����𤴤Ȥ˼���ͤù���ۤɰ��ߤ����Ƥ⤤�ʤ������Х��Ǥ�ʤ���"
       "�������Ȥϸ���󡣤��ν��Ȥ���Ϣ��ˤ϶�Ť��ʡ�"))

(define (melvin-bill knpc kpc)
  (say knpc "�����Ĥϥͥ���1�ܤ�2�ܳ���Ƥ롣�Ǥ⤤���ۤ���"))

(define (melvin-thud knpc kpc)
  (say knpc "�֤����Ȱ����褿�ΤϿʹ֤���ʤ���"
       "�Ǥ⡢����ʤˤ��ޤ�����٤��ȥ��ϸ������Ȥ��ʤ���"
       "�褯�狼��󤬡���������ˡ���⤷���"))

(define (melvin-bole knpc kpc)
  (say knpc "�������������"))

(define (melvin-hack knpc kpc)
  (say knpc "�ϥå���Ϥ���Į�������ζ����Ϥä���ˤ��롣"
       "��������������������ǤϤʤ���"))


;; thief quest...
(define (melvin-thie knpc kpc)
  (say knpc "�Ƕ�������ۤ����Τ�����ˤ����ʡ��Ϲ����ĸ��ߤ������̤��ޤ�äƤ�������"
       "�����֤�������Ƥ����ˤ��ʤ��ʤä������ʤ��ʤ����˥ϥå�����ä��Ƥ����Ȼפ���"
       "���ִ�̯�ʤ��Ȥ���"))

;; misc...
(define (melvin-wiza knpc kpc)
  (say knpc "�������ʤ��ȤˤʤäƤ������衪"
       "�֤���ˡ�Ȥ����Ѥ��ۤδ֤ǲ����������äƤ��롣���ˤϤ狼������"))

(define (melvin-inn knpc kpc)
  (say knpc "���������뤫���䤿������ʪ���ߤ�����Хᥤ�˸��äƤ��졣"
       "������ʢ�����ä��鲶�ˤ������äƤ��졣"
       "�����˽Ф�����"))

(define (melvin-hung knpc kpc)
  (say knpc "ʢ�ϸ��äƤ��뤫��")
  (if (kern-conv-get-yes-no? kpc)
      (melvin-buy knpc kpc)
      (say knpc "������ʢ�����ä��餽�����äƤ��졪")))

(define melvin-conv
  (ifc basic-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default melvin-default)
       (method 'hail melvin-hail)
       (method 'bye  melvin-bye)
       (method 'job  melvin-job)       
       (method 'name melvin-name)
       (method 'join melvin-join)

       (method 'buy  melvin-buy)
       (method 'food melvin-buy)
       (method 'drin melvin-buy)
       (method 'supp melvin-buy)
       (method 'trad melvin-buy)

       (method 'food melvin-buy)
       (method 'trad melvin-buy)
       (method 'buy  melvin-buy)

       (method 'bill melvin-bill)
       (method 'cook melvin-inn)
       (method 'inn  melvin-inn)
       (method 'kath melvin-kath)
       (method 'red  melvin-kath)
       (method 'lady melvin-kath)
       (method 'sorc melvin-kath)
       (method 'may  melvin-may)
       (method 'hack melvin-hack)
       (method 'hung melvin-hung)
       (method 'tave melvin-inn)
       (method 'thud melvin-thud)
       (method 'thin melvin-thud)
       (method 'pet  melvin-thud)

       (method 'thie melvin-thie)
       (method 'rogu melvin-thie)
       (method 'char melvin-thie)

       (method 'bole melvin-bole)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-melvin)
  (bind 
   (kern-mk-char 'ch_melvin          ; tag
                 "��������"        ; name
                 sp_human            ; species
                 nil                 ; occ
                 s_townsman          ; sprite
                 faction-men         ; starting alignment
                 2 0 1             ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 3  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'melvin-conv        ; conv
                 sch_melvin          ; sched
                 'townsman-ai         ; special ai
                 nil     				; container
                 (list t_dagger)   ; readied
                 )
   (melvin-mk)))
