;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define dennis-lvl 3)
(define dennis-species sp_human)
(define dennis-occ oc_wright)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; �ť��֥���å�
;;----------------------------------------------------------------------------
(define dennis-bed oa-bed2)
(define dennis-mealplace oa-tbl1)
(define dennis-workplace oa-slaves)
(define dennis-leisureplace oa-dining-hall)
(kern-mk-sched 'sch_dennis
               (list 0  0 dennis-bed          "sleeping")
               (list 7  0 dennis-mealplace    "eating")
               (list 8  0 dennis-workplace    "working")
               (list 12 0 dennis-mealplace    "eating")
               (list 13 0 dennis-workplace    "working")
               (list 18 0 dennis-mealplace    "eating")
               (list 19 0 dennis-leisureplace "idle")
               (list 22 0 dennis-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (dennis-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; �ǥ˥��ϼ���줿�Ԥο����Ԥǡ��ť��֥���åȤ˽���Ǥ��롣
;; ��Ͽ����䤹�������ޤ������ˤ����ޤäƤ��ʤ���
;;----------------------------------------------------------------------------

;; Basics...
(define (dennis-hail knpc kpc)
  (say knpc "����ˤ��ϡ�"))

(define (dennis-default knpc kpc)
  (say knpc "���Τ�����Τ��ȤϤ狼��ޤ���"))

(define (dennis-name knpc kpc)
  (say knpc "�ǥ˥��Ǥ���"))

(define (dennis-join knpc kpc)
  (say knpc "����Ϥ����Фä����Ϥ����ϻפ��ޤ���ι�ο͡�"))

(define (dennis-job knpc kpc)
  (say knpc "�����饹�դ����̤Ǥ���"))

(define (dennis-bye knpc kpc)
  (say knpc "���褦�ʤ顣"))

;; Tier 2
(define (dennis-stud knpc kpc)
  (say knpc "�����饹�դ��顢��ʬ�ΰջפ˽��椹�뤳�ȡ������ƻ�����ʤ�˸���ˤʤ��Τ����ˤ��뤳�Ȥ򶵤�äƤ��ޤ�����ϼ�ʬ����˾����ã�Ǥ��뤳�ȤǤ��礦�������Ǥʤ��Ƥ⡢���ʤ��Ȥ����줿�Ԥ���������ˤ�뤳�Ȥ��Ǥ���Ǥ��礦��"))

(define (dennis-accu knpc kpc)
  (say knpc "����줿�Ԥϸ�򤵤�Ƥ��ޤ����ʤ���˾���ɤ�����Τϡ����ǤϤʤ����ʤΤǤ����ʤ��桹��Ũ�Ϥ��줬�狼��ʤ��ΤǤ��礦����"))

(define (dennis-enem knpc kpc)
  (say knpc "���饹�ɥ��εԻ��Ԥȶ򤫤�ǯ������ƻ�դϤ���ʤ�����Ƥ���ΤǤ���"))

(define (dennis-ways knpc kpc)
  (say knpc "����줿�Ԥ����������ʳ�Ū�����̤���������Ƥ����ޤ������줾����ʳ��ǿ����Ԥ��Ϥ����Ƥ����ޤ��������ʳ���ã���뤿��ˤϡ����̤Ϥդ��路�������򤵤����뵷����Ԥ�ʤ���Фʤ�ޤ���"))

(define (dennis-sacr knpc kpc)
  (say knpc "�����ε�������̩�ˤ���Ƥ��ޤ������ʤ��Τ褦�ʲ����Τ�ʤ��ͤˤ��ä��ޤ���"))

(define (dennis-powe knpc kpc)
  (say knpc "������Ǥ��ʤ��褦���Ϥ��������Ĥ��߼��ջ֤Τ���Ԥ��ԤäƤ��ޤ���"))

(define (dennis-sila knpc kpc)
  (say knpc "�����饹�դ��ϤΤ�����ѻա������Ƹ����������Ǥ���"))

(define (dennis-absa knpc kpc)
  (say knpc "���ζ򤫼Ԥ����ϡ��桹�������ˤ���ȹͤ��ƥ��֥���åȤ��˲����ޤ���������������Į�ο����ˤ��뤳�θŤ����֥���åȤΤ��Ȥ��Τ�ޤ���Ǥ�����"))

(define (dennis-old knpc kpc)
  (say knpc "���ΰ��פ��⤤�Ƥ���ȡ��ڷɤ�ǰ�˶���ޤ��������Ե�̣�Ǥ���������ο͡��ϴ�̯�ʿ��Ĥ���äƤ����ΤǤ��͡�"))

(define (dennis-sele knpc kpc)
  (say knpc "����ϴ���֤��������ϰ������Ȥϸ����ޤ�������ˤ϶�Ť��ʤ��ۤ��������Ǥ��衪")
  (kern-conv-end)
  )

(define dennis-conv
  (ifc basic-conv

       ;; basics
       (method 'default dennis-default)
       (method 'hail dennis-hail)
       (method 'bye dennis-bye)
       (method 'job dennis-job)
       (method 'name dennis-name)
       (method 'join dennis-join)
       
       (method 'sele dennis-sele)
       (method 'stud dennis-stud)
       (method 'teac dennis-stud)
       (method 'accu dennis-accu)
       (method 'enem dennis-enem)
       (method 'ways dennis-ways)
       (method 'sacr dennis-sacr)
       (method 'powe dennis-powe)
       (method 'sila dennis-sila)
       (method 'absa dennis-absa)
       (method 'old dennis-old)
       ))

(define (mk-dennis)
  (bind 
   (kern-mk-char 
    'ch_dennis           ; tag
    "�ǥ˥�"             ; name
    dennis-species         ; species
    dennis-occ              ; occ
    s_townsman     ; sprite
    faction-men      ; starting alignment
    0 1 0            ; str/int/dex
    0 0              ; hp mod/mult
    0 0              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    dennis-lvl
    #f               ; dead
    'dennis-conv         ; conv
    sch_dennis           ; sched
    'spell-sword-ai              ; special ai
    nil              ; container
    (list t_staff)              ; readied
    )
   (dennis-mk)))
