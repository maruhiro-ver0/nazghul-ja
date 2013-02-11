;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define jake-lvl 2)
(define jake-species sp_gint)
(define jake-occ nil)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ������
;;----------------------------------------------------------------------------
(define jake-bed )
(kern-mk-sched 'sch_jake
               (list 0  0 cantina-counter-zzz "sleeping")
               (list 9  0 cantina-counter "working")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (jake-mk) (list #t))
(define (jake-left? gob) (car gob))
(define (jake-left! gob val) (set-car! gob val))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ���������ȥѡ������ϵ��(2�Ĥ�Ƭ�Τ�����)�ǡ���ʪ��¼������˽���Ǥ��롣
;; �������������ڤʺ���Ƭ�ǡ������ѿ����򤷤Ƥ��롣
;; �ѡ������Ͼ��ʤʱ�¦��Ƭ�ǡ����μ�ͤȤ��ƷбĤ򤷤Ƥ��롣
;;----------------------------------------------------------------------------

(define (left-head? knpc)
  (jake-left? (gob knpc)))
(define (left-head! knpc)
  (jake-left! (gob knpc) #t)
  (say knpc "��������"))
(define (right-head! knpc)
  (jake-left! (gob knpc) #f)
  (say knpc "�������ʤ���ޤ�������"))

;; Basics...
(define (jake-hail knpc kpc)
  (kern-log-msg "���ʤ���2�Ĥ�Ƭ�Τ����ͤȲ�ä��������Ϲӡ������������⤦�����ϡ����ȸ������ġġ�"
                "���м��ȸ��äƤ�����᤮�ǤϤʤ�������")
  (if (left-head? knpc)
      (say knpc "�褪��˷�䡪")
      (say knpc "�褦������������������")
      ))

(define (jake-default knpc kpc)
  (if (left-head? knpc)
      (say knpc "�ե��Τ뤫�衪�ѡ�������ʹ����")
      (say knpc "�񤷤����äǤ������ޤ���")
      ))

(define (jake-name knpc kpc)
  (if (left-head? knpc)
      (say knpc "�����������������Ƥ��ä����ѡ����������κ���Ƭ�ϱ������������")
      (say knpc "�ѡ����Х�Ǥ������ޤ��������Ƥ����餬�錄�����αʱ��ͧ�����������Ǥ������ޤ����κ���Ƭ����¦�ˤ��ʤ���������")
      ))

(define (jake-join knpc kpc)
  (if (left-head? knpc)
      (say knpc "�ϥá��ϥá��ϥá�")
      (say knpc "����������������ޤ��󡣿Ȥ�;�뤪Ͷ���Ǥ������ޤ���")
      ))

(define (jake-job knpc kpc)
  (if (left-head? knpc)
      (say knpc "�������ѿ����������������फ�ФƹԤ�������")
      (begin
        (say knpc "�錄������Ź���С��ƥ�����Ǥ������ޤ������������ߤˤʤ�ޤ�����")
        (if (yes? kpc)
            (jake-trade knpc kpc)
            (say knpc "�ͤ�ľ���Ƥ��������ޤ����ǹ��Τ�Τ򤪽Ф��������ޤ���")
            ))))

(define (jake-bye knpc kpc)
  (if (left-head? knpc)
      (say knpc "���㤢�ʡ�")
      (say knpc "���褦�ʤ顣�ޤ��񤤤ޤ��礦��")
      ))

(define (jake-jake knpc kpc)
  (if (left-head? knpc)
      (say knpc "�����������Ѥ���")
      (begin
        (say knpc "�����˥����������ä������ΤǤ�����")
        (if (yes? kpc)
            (left-head! knpc)))
      ))

(define (jake-perc knpc kpc)
  (if (left-head? knpc)
      (begin
        (say knpc "�ʤˡ��ѡ��������ä������Τ���")
        (if (yes? kpc)
            (right-head! knpc)
            ))
      (say knpc "�Ϥ�������Ϥ錄�����Ǥ������ʤ�Ȥ������դ����������ޤ���")
      ))

(define (jake-drin knpc kpc)
  (if (left-head? knpc)
      (say knpc "�ѡ������˸�����")
      (jake-trade knpc kpc)))


;; Trade...
(define jake-merch-msgs
  (list nil ;; closed
        "��˥塼�Ǥ������ޤ���" ;; buy
        nil ;; sell
        nil ;; trade
        "���������Ǥ������Ȥ��Ф����פ��ޤ���" ;; bought-something
        "�Τ���©�Ϥ������錄�����������������ޤ�����" ;; bought-nothing
        nil
        nil
        nil
        nil
   ))

(define jake-catalog
  (list
   (list t_food 7 "���Ф餷�����ӥ����ȤǤ������ޤ�������ʤ��顢�ʹ֤ˤϤ�ä����ʤ���Τˤ������ޤ���")
   (list t_beer 4 "�Ϥ뤫�󤯤�ͭ̾�ʥ��㥤����ȥ��ѡ��ξ�¤�Ԥ�����󤻤��饬���ӡ���Ǥ������ޤ���")
   (list t_wine 6 "�磻�������ť�������󶡤��줿�ǹ�Υ磻��Ǥ������ޤ������ۥ�ĸ��Ф��Τʤ��ܥȥ���Ȥ褤�ΤǤ�����")
   ))

(define (jake-trade knpc kpc) (conv-trade knpc kpc "buy" jake-merch-msgs jake-catalog))

;; Town & Townspeople

;; Quest-related

(define jake-conv
  (ifc basic-conv

       ;; basics
       (method 'default jake-default)
       (method 'hail jake-hail)
       (method 'bye  jake-bye)
       (method 'job  jake-job)
       (method 'name jake-name)
       (method 'join jake-join)
       
       ;; trade
       (method 'drin jake-drin)
       (method 'trad jake-trade)
       (method 'buy  jake-trade)

       ;; town & people
       (method 'jake jake-jake)
       (method 'perc jake-perc)
       ))

(define (mk-jake)
  (bind 
   (kern-mk-char 
    'ch_jake           ; tag
    "���������ȥѡ����Х�"             ; name
    jake-species         ; species
    jake-occ              ; occ
    s_gint     ; sprite
    faction-men      ; starting alignment
    0 0 0            ; str/int/dex
    0 0              ; hp mod/mult
    0 0              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    jake-lvl
    #f               ; dead
    'jake-conv         ; conv
    sch_jake           ; sched
    'townsman-ai              ; special ai
    nil              ; container
    nil              ; readied
    )
   (jake-mk)))
