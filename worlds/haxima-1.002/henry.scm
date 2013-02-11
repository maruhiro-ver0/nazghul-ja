;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ���ѡ����
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_henry
               (list 0  0  bilge-water-bed     "sleeping")
               (list 8  0  bilge-water-counter "working")
               (list 23 0  bilge-water-bed     "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (henry-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; �إ�꡼�ϥ��ѡ������Ҽ�μ��μ�ǡ��������Ǥ��롣
;; ��Ϥ��Ĥƶ����������Ǥ��ä���
;;----------------------------------------------------------------------------

;; Basics...
(define (henry-hail knpc kpc)
  (say knpc "�Τ��ʤ����۵��ʡ��Ҽ꤬����ˤȲ�ä�����"
       "�褪��������"))

(define (henry-default knpc kpc)
  (say knpc "��������ʹ���Ƥ���褦�ʤ�����"))

(define (henry-name knpc kpc)
  (say knpc "����ϥإ�꡼�����Υإ�꡼����"))

(define (henry-join knpc kpc)
  (say knpc "�����٤�ʡ��㤤�Ρ�"
       "���������줬�ФƹԤä���ï�������Ǵ������������������ʡ�"))

(define (henry-job knpc kpc)
  (say knpc "�ʤ����줬�һդˤʤä���������Ϥ��δ������(��������)���������������"))

(define (henry-bye knpc kpc)
  (say knpc "ŷ������դ���衪"))

(define henry-catalog
  (list
   (list t_food 5 "̾ʪ�Υ������㥦������­�ޤǲ������ʤ뤾��")
   (list t_beer 5 "����������ǳڤ��⤦�����Ȥ�������ī�˻�̤Ȥ��Ƥ⡪")
   (list t_wine 7 "�������»��ͤ��褿�Ȥ��Τ����ͥ��ʥ�Τ��Ѱդ��Ƥ��롣")
   ))

(define henry-merch-msgs
  (list "�����줤�������ޤä��鲿���Ф�����"
        "�۵��ˤ�������"
        "���٤�������ߤ����Ϥ����"
        "���ä��Ƥ��롪"
        "����������˾��ʡ�"
        "�����֥�֥餷���������ʤ�����줬����������"
        "����ǥ����塼���Ǥ���ʡ�"
        "�ޤ�������"
        "ʢ�����ä�����äƤ��ʡ�"
        "�����֥�֥餷���������ʤ�����줬����������"
        ))

;; Trade...
(define (henry-buy knpc kpc) (conv-trade knpc kpc "buy" henry-merch-msgs henry-catalog))
(define (henry-sell knpc kpc) (say knpc "�������Ϥ��Ǥ����"))

;; Hook...
(define (henry-hook knpc kpc)
  (say knpc "��������Ϥʤ��ʤä��ޤä��������ζ�������ʪ����ä�����衪"))

(define (henry-mons knpc kpc)
  (say knpc "���顼����ϥ�����Ӥ򤢤äȸ����֤˱��ͤ������Х��Ǥ⤮��ä���"
       "��Ĥ�ͦ���Τͤ����إӤΤ褦�˱󤯤���Ϸ�äƤ��ʤ��ä���"
       "���ˤԤä���ȵۤ��դ��ơ����Ĥ򿩤��ˤä������"))

(define (henry-serp knpc kpc)
  (say knpc "���إӤ������Ĥ�������������ȤϤ��롣"
       "��������Ĥ�ϲ��¤ǡ��󤯤���Фζ̤��Ǥ��Τ򹥤ࡣ"))

;; Townspeople...
(define (henry-opar knpc kpc)
  (say knpc "�����Ϥ��������"))

(define (henry-gher knpc kpc)
  (say knpc "���ݤΥ����ƥ����������ʹ��������ʡ�"
       "�Ť���Ļ���Ҥͤ��Ƥ⤤�ʤ��ٹ��1�Ĥ��Ƥ�������"
       "˴����򤱤衪��Ĥ���ܤ�������Ƥ��롪")
	(quest-data-assign-once 'questentry-ghertie))

(define (henry-ghos knpc kpc)
  (say knpc "���ϻ�ͤǤ��äѤ����������Ƥ�����β��ͤ��ϥ����ƥ����ˤ���Τ���"
       "������롢��Ĥ餬ǭ�Τ褦�˲���ʤ���ʪ��õ���Τ򸫤����Ȥ����롪"
       "����٤��Ԥϻ����������ƥإ�꡼�νɤ˵�¤ä���")
	(quest-data-assign-once 'questentry-ghertie))

(define (henry-alch knpc kpc)
  (say knpc "�������������ʥ�Ĥ���"))

(define (henry-bart knpc kpc)
  (say knpc "�������ǡϥС��ȤϤ���Ⱦ��Ǻǹ��¤�����ͤ���"
       "�δ�꤫���ꡢ�������������ǡϤ�����ͣ���¤�����ͤǤ⤢�롪"))

(define (henry-seaw knpc kpc)
  (say knpc "���襤��̼����Φ�ε��Τ褦���Ѥ��Ԥ���"))

(define (henry-osca knpc kpc)
  (say knpc "�ߤ���ǡ��������ʹͤ��Υ�Ĥ����Ǥ⤳���Ǥϰ��˰���Ǥ��롣"))

(define henry-conv
  (ifc basic-conv

       ;; basics
       (method 'default henry-default)
       (method 'hail henry-hail)
       (method 'bye  henry-bye)
       (method 'job  henry-job)
       (method 'name henry-name)
       (method 'join henry-join)
       
       ;; trade
       (method 'trad henry-buy)
       (method 'buy  henry-buy)
       (method 'sell henry-sell)
       (method 'sacr henry-buy)

       ;; hand
       (method 'hook henry-hook)
       (method 'hand henry-hook)
       (method 'mons henry-mons)
       (method 'deep henry-mons)
       (method 'sea  henry-serp)
       (method 'serp henry-serp)

       ;; town & people
       (method 'opar henry-opar)
       (method 'alch henry-alch)
       (method 'gher henry-gher)
       (method 'ghas henry-gher)
       (method 'bart henry-bart)
       (method 'witc henry-seaw)
       (method 'lia  henry-seaw)
       (method 'osca henry-osca)

       ))

(define (mk-henry)
  (bind 
   (kern-mk-char 'ch_henry           ; tag
                 "�إ�꡼"          ; name
                 sp_human            ; species
                 nil                 ; occ
                 s_townsman          ; sprite
                 faction-men         ; starting alignment
                 1 0 0               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 6  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'henry-conv         ; conv
                 sch_henry           ; sched
                 'townsman-ai                 ; special ai
                 (mk-inventory (list (list 1 t_dagger)))     ; container
                 nil                 ; readied
                 )
   (henry-mk)))
