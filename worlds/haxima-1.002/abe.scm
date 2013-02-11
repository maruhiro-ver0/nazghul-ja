;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define abe-lvl 3)
(define abe-species sp_human)
(define abe-occ nil)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; �Ф���
;;----------------------------------------------------------------------------
(define abe-bed gt-abe-bed)
(define abe-mealplace gt-ws-tbl2)
(define abe-workplace gt-ruins)
(define abe-leisureplace gt-ws-hall)
(kern-mk-sched 'sch_abe
               (list 0  0 abe-bed          "sleeping")
               (list 7  0 abe-mealplace    "eating")
               (list 8  0 abe-workplace    "working")
               (list 12 0 abe-mealplace    "eating")
               (list 13 0 abe-workplace    "working")
               (list 18 0 abe-mealplace    "eating")
               (list 19 0 abe-leisureplace "idle")
               (list 22 0 abe-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (abe-mk) (list #f))
(define (abe-met? gob) (car gob))
(define (abe-met! gob) (set-car! gob #t))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; �����֤����ǤΤ��Ȥ�褯�Τ�ؼԤǤ��롣
;; ���ϣ��ѻդȤȤ�˥��֥���åȤ���ƨ�졢�����Ф���˽���Ǥ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (abe-hail knpc kpc)
  (kern-print "���ʤ��ϼ㤤�ؼ������ˤȲ�ä���\n")
  (if (abe-met? (gob knpc))
      (say knpc "�ޤ��񤤤ޤ����͡�")
      (begin
        (abe-met! (gob knpc))
        (say knpc "����ˤ��ϡ����Ρ��⤷�������¤��͡�")
        (if (yes? kpc)
            (say knpc "�����Ƹ��ɤǤ�����ʬ�ι������������ʤ���"
                 "��������ʹ���������Ȥ������Ǥ���"
                 "�⤷�褫�ä�����֤�����Ȥ���ʹ�����Ƥ���������")
            (say knpc "����������Ϥ����������ߤޤ��󡣤Ĥ��ĵ��ˤ��ʤ��Ǥ���������")))))

(define (abe-default knpc kpc)
  (say knpc "���񤬤��ä���Ĵ�٤Ƥ����ޤ���"))

(define (abe-name knpc kpc)
  (say knpc "�������������ͤϥ����֡�"))

(define (abe-join knpc kpc)
  (say knpc "�������䡢����ϤǤ��ޤ�����ͤϤ��������ͤǤϤʤ��Τǡ�"))

(define (abe-job knpc kpc)
  (say knpc "�ͤϳؼԤǤ����Ф���ˤ�����פ�Ĵ�٤Ƥ��ޤ����⤦���ޤ�������")
  (if (no? kpc)
      (say knpc "���פ�Į�������ˤ���ޤ�����̣������ΤǤ���")
      (begin
        (say knpc "�ϲ��ˤϤ�äȤ��뤳�Ȥ��ΤäƤ��ޤ�����")
        (yes? kpc)
        (say knpc "���������֥���åȤΤ褦�ˡ�"))))

(define (abe-absa knpc kpc)
  (say knpc "¿���οͤϥ��֥���åȤβ��˸Ť�Į�����뤳�Ȥ��Τ�ޤ���"
       "���֥���åȤ��ϲ��ΰ��פϡ������Ф���ΰ��פȤȤƤ�褯���Ƥ��ޤ���"
       "�ͤ�Ʊ��ʸ���ο͡������Ƥ��˰㤤�ʤ��ȳο����Ƥ��ޤ���"))

(define (abe-rune knpc kpc)
  (if (any-in-inventory? kpc rune-types)
      (begin
	 (say knpc "������Ť��ˤ����䤤������"
	     "��������Ȭ�Ĥθ�����äƤ���ΤǤ�����"
	     "Ĵ�٤����Ƥ���������")
		(quest-data-update 'questentry-runeinfo 'abe 1)
	 (quest-data-update-with 'questentry-runeinfo 'keys 1 (quest-notify (grant-party-xp-fn 20)))
	(if (any-in-inventory? kpc (list t_rune_k))
	    (say knpc "��������Ǥ�Ĵ�٤����Ϥ�����μ������ǤǤ���")
	    )
	(if (any-in-inventory? kpc (list t_rune_p))
	    (say knpc "��������Ǥ�Ĵ�٤����Ϥ�����Ϥ����ǤǤ���")
	    )
	(if (any-in-inventory? kpc (list t_rune_s))
	    (say knpc "��������Ǥ�Ĵ�٤����Ϥ���ϵ�ǽ�����ǤǤ���")
	    )
	(if (any-in-inventory? kpc (list t_rune_c))
	    (say knpc "��������Ǥ�Ĵ�٤����Ϥ���ϻ�θ�����ǤǤ���")
	    )
	(if (any-in-inventory? kpc (list t_rune_f))
	    (say knpc "��������Ǥ�Ĵ�٤����Ϥ���ϼ�ͳ�����ǤǤ���")
	    )
	(if (any-in-inventory? kpc (list t_rune_w))
	    (say knpc "��������Ǥ�Ĵ�٤����Ϥ�������������ǤǤ���")
	    )
	(if (any-in-inventory? kpc (list t_rune_d))
	    (say knpc "��������Ǥ�Ĵ�٤����Ϥ����ʬ�̤����ǤǤ���")
	    )
	(if (any-in-inventory? kpc (list t_rune_l))
	    (say knpc "��������Ǥ�Ĵ�٤����Ϥ�������������ǤǤ���")
	    )
	(if (has-all-runes? kpc) 
	    (say knpc "�������ʤ���"
	         "Ȭ�Ĥΰ������θ�������·�äƤ��ޤ���"
	         "�������Τɤ�����Ĥ��Ǥ�����")
	    )
	)
      (say knpc "������������Ǥ����뤽���Ǥ����ºݤ˸��뤳�Ȥ��Ǥ���Сġ�")))

(define (abe-demo knpc kpc)
  (say knpc "�������ϱ��Ρ����Ԥˤ�ä���������ޤ�����"
       "���ξ��Ϥ����뵭Ͽ����ä���ޤ����������������������ǤϤɤ����̤Τۤ��ˤ��뤽���Ǥ���")
		(quest-data-update 'questentry-runeinfo 'abe 1)
	     (quest-data-update 'questentry-runeinfo 'keys 1)
  		(quest-data-update-with 'questentry-runeinfo 'gate 1 (quest-notify (grant-party-xp-fn 30)))
       )

(define (abe-keys knpc kpc)
  (say knpc "�Ϥ������������������졢����Ȭ�Ĥ�ʬ�����ޤ�����"
       "���줾�줬�Ϥ���᤿���ǤǤ���"
       "���θ夽���ϼ���줿����������ޤ�����"))
       
(define (abe-eigh knpc kpc)
	(say knpc "���������Ǥ����Ǥ�Ȭ�Ĥ��뤽���Ǥ���¾�����Ǥ�õ���Ƥ���ΤǤ�����")
	(if (yes? kpc)
		(say knpc "�Ť��äǤϡ������ӥ����θ���Ǥ��ä����Ȥ��������λ����ˤ���ʤɤȸ����Ƥ��ޤ���")
		(say knpc "���񿴤Ϥʤ��ΤǤ����������Ƥ�������������ΤäƤ��ޤ���")))

(define (abe-clov knpc kpc)
     (say knpc "����Ǥϥ����ӥ���������Ȥ��ƻ��äƤ��������Ǥ���"
           "��ϥ��֥��Ȥ������̿����Ȥ��ޤ�����������������˴������ϸ��Ĥ���ޤ���Ǥ�����"
           "ï����(�⤷�������^c+m���֥��^c-��)å�ä��Τ��⤷��ޤ���")
           (quest-data-assign-once 'questentry-rune-f)
           )
           
(define (abe-temp knpc kpc)
	(say knpc "���ѡ����������Ǥ��λ����ϵ���������⤫��Ǥ��ޤ���ï�⤿�ɤ��夯���Ȥ��Ǥ��ޤ��󤬡�"
			"����ǤϤ��ä��Ρ����Ǥ��������줿�Ȥ���Ƥ��ޤ���")
			(quest-data-assign-once 'questentry-rune-d)
			)
      
(define (abe-void knpc kpc)
  (say knpc "���Υ����ɡ�����������ƹ���ʵ�������ˤ���ΤǤ���"
       "���ĤƵ�����ҹԤ����������ꡢ�����Ϥ�褦�˵������Ϥä������Ǥ���")
       (quest-data-update 'questentry-whereami 'shard 2)
       )

(define (abe-ship knpc kpc)
  (say knpc "�������Τ��Ȥ�ʹ�������Ȥ�����ޤ������������ܤ������ȤϤ狼��ޤ���"
       "���ͤ�ĺ���ʤ餽�μ���줿¤�������狼�뤫�⤷��ޤ���")
       (quest-data-update 'questentry-whereami 'shard 2)
       )

(define (abe-wrig knpc kpc)
  (say knpc "���ͤ�ʪ���뤳�Ȥ�Ĺ�����Ԥ����Ǥ���"
       "���դϺ����ǺǤ����ʿ��ͤǤ���"))

(define (abe-quee knpc kpc)
  (say knpc "���Τ��Ȥ��褯�狼��ޤ���"))

(define (abe-civi knpc kpc)
  (say knpc "���ΰ��פ���Ƥ�ʸ���Τ��ȤϤ褯�狼��ޤ��󡣤Ǥ⤽�μ꤬����ϡ����줬�䤿���δ��Ǹ��ƤȤƤ⽹�����Ȥˤ���ޤ��������̣���뤫�狼��ޤ�����")
  (if (yes? kpc)
      (say knpc "�ʤ�и���ʤ��Ǥ����ޤ��礦��")
      (say knpc "�ͤ����ӡ������������������Ԥؤο��ҡ�����줿�Ԥν����Ǥ���")))

(define (abe-accu knpc kpc)
  (say knpc "�Ϥ�������줿�Ԥˤ�Ĺ����ˤ�����ޤ�����������������Ū�ʰ��򤫤⤷��ޤ���"
       "����������餬�Ԥ���Ԥä����ȡ����뤤��¸�ߤξڵ�Ͻ�ʬ�ˤ���ޤ���"))

(define (abe-bye knpc kpc)
  (say knpc "���פˤĤ��Ʋ����狼�ä��鶵���Ƥ���������"))

(define (abe-alch knpc kpc)
  (say knpc "���������θť��̥��Ǥ������ٿ�Ʊ�ΤǤ������Ƕ�ϲ�äƤ��ޤ���"))

(define (abe-neig knpc kpc)
  (say knpc "���֥���åȤǡ�ƨ�������Ϥ����ˤ��ޤ�����"))

(define (abe-flee knpc kpc)
  (say knpc "�Τ���©���ä���Ĺ���ʤ�ޤ�������οͤ�ʹ���ƤߤƤ����������⤦�ɤ��Ǥ⤤�����ȤǤ���"))

(define (abe-gobl knpc kpc)
  (say knpc "�ǥ�å���Ĺ���������ʹ���ƤߤƤ�������������¿���Τ��Ȥ��ΤäƤ��ޤ���"))

(define abe-conv
  (ifc green-tower-conv

       ;; basics
       (method 'default abe-default)
       (method 'hail abe-hail)
       (method 'bye abe-bye)
       (method 'job abe-job)
       (method 'name abe-name)
       (method 'join abe-join)
       

       (method 'absa abe-absa)
       (method 'rune abe-rune)
       (method 'demo abe-demo)
       (method 'gate abe-demo)
       (method 'keys abe-keys)
       (method 'key  abe-keys)
       (method 'eigh abe-eigh)
       (method 'quee abe-quee)
       (method 'king abe-clov)
       (method 'clov abe-clov)
       (method 'char abe-clov)
       (method 'temp abe-temp)
       (method 'civi abe-civi)
       (method 'accu abe-accu)
       (method 'bye  abe-bye)
       (method 'ruin abe-job)

       (method 'void abe-void)
       (method 'ship abe-ship)
       (method 'sail abe-ship)
       (method 'wrig abe-wrig)
       (method 'alch abe-alch)
       (method 'neig abe-neig)
       (method 'flee abe-flee)
       (method 'esca abe-flee)
       (method 'gobl abe-gobl)
       ))

(define (mk-abe)
  (bind 
   (kern-mk-char 
    'ch_abe           ; tag
    "������"          ; name
    abe-species         ; species
    abe-occ              ; occ
    s_companion_wizard ; sprite
    faction-men      ; starting alignment
    2 1 1            ; str/int/dex
    0 0              ; hp mod/mult
    0 0              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    abe-lvl
    #f               ; dead
    'abe-conv         ; conv
    sch_abe           ; sched
    'townsman-ai              ; special ai
    nil              ; container
    (list t_staff
					         t_armor_leather
					         )              ; readied
    )
   (abe-mk)))
