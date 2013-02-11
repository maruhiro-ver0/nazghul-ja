;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define alex-lvl 8)
(define alex-species sp_human)
(define alex-occ oc_wizard)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ����ݥꥹ�������Τκ�
;;----------------------------------------------------------------------------
(define alex-bed ph-bed3)
(define alex-mealplace ph-tbl3)
(define alex-workplace ph-hall)
(define alex-leisureplace ph-dine)
(kern-mk-sched 'sch_alex
               (list 0  0 alex-bed          "sleeping")
               (list 7  0 alex-mealplace    "eating")
               (list 8  0 alex-workplace    "working")
               (list 12 0 alex-mealplace    "eating")
               (list 13 0 alex-workplace    "working")
               (list 18 0 alex-mealplace    "eating")
               (list 19 0 alex-leisureplace "idle")
               (list 22 0 alex-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (alex-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ����å����ϥ��饹�ɥ�󷳤���Ĺ�ǡ�����ݥꥹ���Ի�μԤγ�������������
;; ���Ϥ�Ǥ̳�ˤĤ��Ƥ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (alex-hail knpc kpc)
  (say knpc "�褦�����������Ԥ衣�桹���ɤθ��¦�Ͼ����ϰ�������"))

(define (alex-name knpc kpc)
  (say knpc "���饹�ɥ�󷳤Υ���å�����Ĺ����"))

(define (alex-job knpc kpc)
  (say knpc "��Ʈ��ѻա������Ƥ��������Ϥλش��������桹������̤ꤿ���Τ��͡�")
  (if (yes? kpc)
      (alex-pass knpc kpc)
      (say knpc "�����Ѥ�ä������դˤĤ��ƿҤͤƤ��졣")))

(define (alex-bye knpc kpc)
  (say knpc "�ɤγ��Ǥ��ظ�˵���Ĥ���"))

(define (alex-warm knpc kpc)
  (say knpc "��Ʈ��ѻդϡ���Ʈ��ˡ������Ȥ�����κ���Τʤ�ߤ��狼�뤫�͡�")
  (yes? kpc)
  (say knpc "������ɤ����Ĥ��뤫�������˹Ԥ�����������Τ�˺���ʡ�"))

(define (alex-garr knpc kpc)
  (say knpc "�����ϥ���ݥꥹ�ˤ����뷳�λ��Ĥ������Ϥΰ�Ĥ���"
       "����������Ϥϲ�ʪ���Ͼ�ؽФʤ��褦�˥���ݥꥹ����������äƤ��롣")
  (prompt-for-key)
  (say knpc "���������������Ϥϲ��μ��ƽ����������Ի�μԤ򿩤��ߤ�롣")
  (prompt-for-key)
  (say knpc "�軰�������ϤϡĤɤ���³�����狼��ʤ�ƻ���äƤ��롣")
  )

(define (alex-unde knpc kpc)
  (say knpc "����ݥꥹ�Τ����ؤˤϡ��Ի�μԤ����ۤ���Ť��֤����롣��ιͤ����Τꤿ������")
  (if (yes? kpc)
      (say knpc "�Ի�μԤɤ�ϥ�å��˻Ť��Ƥ���Τ��ȹͤ��Ƥ��롣")
      (say knpc "�ʤ�з����𤵤��ʤ����Ჿ�����ʤ��Ǥ�������")))

(define (alex-lich knpc kpc)
  (say knpc "��å��Ȥϲ�����������Ի����ѻդǤ��롣��å��ϼ�ʸ��Ʊ���褦�˻�Ԥ���뤳�Ȥ��Ǥ��롣�Ǥⶲ����Ũ����"))

(define (alex-pass knpc kpc)
  (say knpc "����դϡֿ�ʥ�פ���"))

(define (alex-thir knpc kpc)
  (say knpc "�軰�������ϤȤ�Ϣ�����ʤ��ʤäƤ��롣"
       "Ϣ�����Τΰ�ͤ����μ��ƽ�ˤ��롣"
       "����ब�����ˤ��������ʤäƤ��ޤä��ΤǤϤʤ����ȶ���Ƥ��롣�������Ͽͤ򤽤Τ褦�ˤ��Ƥ��ޤ���"))

(define (alex-pris knpc kpc)
  (say knpc "���ƽ�عԤ�������С��Ϥ����򲼤�ʤ�����"))

(define (alex-firs knpc kpc)
  (say knpc "����������ϤعԤ�������С��Ϥ������ꡢ�̤عԤ������θ����عԤ��ʤ�����"))

(define alex-conv
  (ifc kurpolis-conv

       ;; basics
       (method 'hail alex-hail)
       (method 'bye alex-bye)
       (method 'job alex-job)
       (method 'name alex-name)

       (method 'warm alex-warm)
       (method 'garr alex-garr)
       (method 'comm alex-garr)
       (method 'lich alex-lich)
       (method 'pass alex-pass)

       (method 'thir alex-thir)
       (method 'pris alex-pris)
       (method 'firs alex-firs)
       ))

(define (mk-alex)
  (bind 
   (kern-mk-char 
    'ch_alex           ; tag
    "����å���"       ; name
    alex-species         ; species
    alex-occ              ; occ
    s_companion_wizard     ; sprite
    faction-men      ; starting alignment
    2 5 1            ; str/int/dex
    0 0              ; hp mod/mult
    0 0              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    alex-lvl
    #f               ; dead
    'alex-conv         ; conv
    sch_alex           ; sched
    'townsman-ai              ; special ai
    nil              ; container
    (list t_sword
    		t_shield
    		t_leather_helm
					         t_armor_leather_2
					         )               ; readied
    )
   (alex-mk)))
