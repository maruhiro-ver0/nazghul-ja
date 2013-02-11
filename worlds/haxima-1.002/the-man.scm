;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define the-man-start-lvl 9)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; �����˱����줿���ˤ���ˤ󤲤�α����
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_man
               (list 0  0 mans-bed    "sleeping")
               (list 7  0 mans-supper "eating")
               (list 8  0 mans-hall   "idle")
               (list 12 0 mans-supper "eating")
               (list 13 0 mans-tools  "idle")
               (list 15 0 mans-hall   "idle")
               (list 18 0 mans-supper "eating")
               (list 19 0 mans-dock   "idle")
               (list 22 0 mans-bed    "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (man-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; �֤ˤ󤲤�פȤ����Τ��륤������̤���ۤ������Ѥ���ä��ʤ餺�Ԥν�����
;; ���롣�������Τ��Ƥ��ʤ����(�ˤ󤲤�α����)�˽���Ǥ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (man-hail knpc kpc)
  (say knpc "�Τ��ʤ��Ͽͤ�����Ĥ���褦�ʡ�ǭ�Τ褦�˿ȷڤ���ǯ�ν����Ȳ�ä�����"
       "����ˤ��ϡ����Ƥ�������"))

(define (man-default knpc kpc)
  (say knpc "���Ҹ��Ƥߤ����"))

(define (man-name knpc kpc)
  (say knpc "��ϥ�������̡��Ǥ�ͤϤˤ󤲤�ȸƤ֤"))

(define (man-join knpc kpc)
  (say knpc "̥��Ū��������������Τ��ʤ��Ȥϸ����ʤ���͡��Ǥ⡢�����򤹤�ʤ��ͤ����������"))

(define (man-job knpc kpc)
  (say knpc "�����͡����Ω�����֤�ɤ����֤����������ϴ�ñ����Ϥʤ餺�Ԥ衣"))

(define (man-bye knpc kpc)
  (say knpc "�Х��Х���"))


;; Misc
(define (man-man knpc kpc)
  (say knpc "������Ͼ����Фä����Ϥ⤷�����ơ��ˤ��ȻפäƤ������顩")
  (kern-conv-get-yes-no? kpc)
  (say knpc "�ˤ󤲤�(MAN)�϶��ߤʵ����ν���(Mistress of Acquisitive Nature)��Ƭʸ���衣"
       "�������äƤ��줿�����顩")
  (kern-conv-get-yes-no? kpc)
  (say knpc "���������դ��ǽ�ˤ����Ƥ���Ȼפ��"
       "������äƺ��줿�֤�ˤ��ޤ����Τ͡�"))

(define (man-wrog knpc kpc)
  (say knpc "�ʤ餺�ԤȤϵ�§�ˤ������Ȥ衣"
       "���Τ�����衢�����Ƥ��������ʡ���§���ˤ�ΤϹ�����")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "������϶ä����դ�򤷤�������ϤȤƤ�̥��Ū���ä�����"
           "�����Ҥ͡�������������ʿ���Ǥ��򤷤ƶ��餷�ʤ���Фʤ�ʤ���͡�")
      (say knpc "���䤪�䡢�ɤ����Ƥ���ʤ˻ͳ�ĥ�äƤ���Ρ��ͳ�ĥ�ä��Τ������˹����衣"
           "�⤷������Ȥ���ǻ���ᤤ�Ƥ����Τ����顩������Ϥ��ʤ���̵�ٵ��˸�������")))

(define (man-rule knpc kpc)
  (say knpc "��§��������̩���档��Ϥ��������Ʋ��������θ������ˤ����Τ򸫤�����"
       "����Ϲ��񿴤Τ��ᡢ������ĩ��Τ���衣"
       "�ޤ��򸫤ơ������ˤ���������٤��狼�뤫���顩")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "�Ϥ����Ϥ����Ҷ�����򤹤������Τ�������Ȥⲿ�⸫���Ƥ��ʤ��Τ���")
      (say knpc "����������Ϥ���̾�Ȱ�äƤ���ʤ˶��ߤǤϤʤ��"
           "��ϡֻ��ġפ��Ȥˤ϶�̣�Ϥʤ��Ρ������֤���פ����衣"
           "���٤�äƤ��ޤ��С����θ�ˤ϶�̣�Ϥʤ���"
           "�䤬����Ǥⶽ̣�������ͤ����Τϡ���̩���Τ�Τ衣")))

(define (man-secr knpc kpc)
  (say knpc "��ǻ�Ƥ����ʤ�����"))

(define (man-enem knpc kpc)
  (say knpc "Ʈ�Τζ��Ϥ�Ũ�ϥ��饹�ɥ��������Ԥ����Τ�ʤ��"))

(define (man-stew knpc kpc)
  (say knpc "���������������ɤ�����Ȥ�����Ρ�"
       "�������������館���ۤ��������Τ��⤷��ʤ���"
       "����ϥ��֥���åȤ��ؤ���Ʈ�Τ�����Ǥ���Τ衣"))

(define (man-hate knpc kpc)
  (say knpc "�����Ԥ�������ʬ���ɤ�Ǥߤʤ�����"
       "�ɤ�����Ф������Τꤿ����")
  (if (yes? kpc)
      (say knpc "����������Ĥθ��դ�Ф��Ƥ����Ф������������������<Wis Quas>�衣"
           "���ʤ��ϱԤ�����ɤ��ˤ��뤫�Ϥ狼��Ǥ��礦��")
      (say knpc "�������Ǥ⤢�ʤ��ϸ���Ȥ��Ƥ���"
           "���������Ū����ά�衣")))


;; Wise Queries
(define (man-wiza knpc kpc)
  (say knpc "�������ȤƤ⶯�����Ǥ���������̩����ߤ�����"))

(define (man-wrig knpc kpc)
  (say knpc "������«���Ǥ�䤬�������ʤ����Ϥޤ����ʤ��褦�͡�"))

(define (man-warr knpc kpc)
  (say knpc "����Ϥ���ͥ��ʿ����񤤤��Τ��Ƥ��롣"
       "�������Τ��ȤϾܤ������Τ�ʤ�����ɡ�����Ũ�ϡ��⤷�������������Ȥ���褯�ΤäƤ��뤫�⤷��ʤ��"))

(define (man-necr knpc kpc)
  (say knpc "������ͧã�衣"
       "��ͤ������Ƥ���ͤ�˺�줿��������Τ��Ȥ��ΤäƤ��롣"
       "��������Ϥɤ���ä�ʹ���Ф��Τ��ΤäƤ���Τ衣"))

(define (man-alch knpc kpc)
  (say knpc "�����ͤʤΤϤ狼�äƤ뤱�ɡ���ȤϹ��ʤ���͡�"))

(define (man-engi knpc kpc)
  (say knpc "����߷׽��«��ĩ�路�Ƥߤ����"
       "�Ǥ⡢��������ˤϱ����Ƥ�����̩������ʤ��Τ衪"))

(define (man-ench knpc kpc)
  (say knpc "��κǰ�����ѻա�"
       "����ä�ʹ���˹Ԥ��Τ⡢���ι������ʤ��繥���衪"
       "�Ǥ⼫ʬ��ʪ�Ϥ�äȤ����Ȥ��ޤä��֤��٤��͡�"))

;; Accursed Queries
(define (man-accu knpc kpc)
  (say knpc "��餬��ͳ�ˤĤ����ä��Ȥ��������¾�Ԥ�����ˤ��뼫ͳ���̣���롣"
       "��§���ˤä����˲ä�ä��Ԥ⤤���Ǥ�狼�ä��Τ���鼫�Ȥ����ǤĤʤ���Ƥ���Ȥ������Ȥ�����"
       "�Բ���«�衣"))


;; Rune
(define (man-rune knpc kpc)
  (say knpc "���ǡĤ��ĤƳ�±�����äƤ����Τ��ΤäƤ���"
       "�����ƥ����ȡֻ��ῼ����׹���ä��ΤäƤ��뤫���顩")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "������ι���Ƥ�Τ͡��и�˭���ʿͤϹ����衣")
      (say knpc "���ѡ����ǥ����ƥ����ˤĤ���ʹ���Ƥ����ʤ�����"))
  (say knpc "�⤷���ῼ����򸫤Ĥ����顢��ʸ�ǰ����夲����"
       "��ʸ�Ϥ狼�롩")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "�ޤ������ʤ��Ϥ�������ˡ���ΤäƤ���Ρ�"
           "������ˡ���Τ�ʤ���Ф�������ɡ���ˡ�Ȥ�����")
      (begin
			(say knpc "�ޥ�ɥ쥤��������ݡ�����������λ��Ĵ�礷�ơ�"
			"����������������������<Vas Uus Ylem>�Ⱦ����롣"
			"�������������������ؤ������ʤ�����")
			(quest-data-update 'questentry-rune-c 'shipraise 1)
		)
	)
  (say knpc "�����ƥ����ϥ����Ǥ����ξ������ʤ��Ǥ��礦�͡�"
       "�Ǥ���Ǥ��ޤäƤ��˾�Ϥ������Ȥ��ǰ��λ�����򤷤Ƥ⡪"
       "�����ƥ�����˾��Ǥ���Τϡ�����^c+m����^c-�Τߤ衣"
       "���θ��դ��α��Ƥ����ʤ����������������ͩ��Ȥ��ä��Ȥ��פ��Ф��Τ衣")
	(quest-data-update 'questentry-rune-c 'info 1)
	(quest-data-assign-once 'questentry-rune-c)
	(quest-data-update 'questentry-ghertie 'ghertieid 1)
	(quest-data-update-with 'questentry-ghertie 'revenge 1 (quest-notify nil))
	(quest-data-assign-once 'questentry-ghertie)
	)

(define (man-chan knpc kpc)
  (say knpc "����ɥ�Ȳ�ä��Ρ���ϻ�ε���򤷤�٤ä��˰㤤�ʤ��"
       "�Ϥ�������������̵��Ǥ�ʤʤ餺�Ԥϸ����ʤ褦�͡�"))

(define man-conv
  (ifc basic-conv

       ;; basics
       (method 'default man-default)
       (method 'hail man-hail)
       (method 'bye  man-bye)
       (method 'job  man-job)
       (method 'name man-name)
       (method 'join man-join)
       
       ;; special
       (method 'man man-man)
       (method 'wrog man-wrog)
       (method 'rogu man-wrog)  ;; a synonym
       (method 'rule man-rule)
       (method 'secr man-secr)
       (method 'enem man-enem)
       (method 'stew man-stew)
       (method 'diar man-hate)
       (method 'evid man-hate)
       (method 'hate man-hate)
       (method 'wiza man-wiza)
       (method 'wrig man-wrig)
       (method 'warr man-warr)
       (method 'necr man-necr)
       (method 'alch man-alch)
       (method 'engi man-engi)
       (method 'ench man-ench)
       (method 'accu man-accu)
       (method 'rune man-rune)
       (method 'chan man-chan)
       ))

(define (mk-the-man)
  (bind 
   (kern-mk-char 'ch_man           ; tag
                 "�ˤ󤲤�"            ; name
                 sp_human            ; species
                 oc_wrogue           ; occ
                 s_brigandess        ; sprite
                 faction-men         ; starting alignment
                 0 3 10               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health ; hp
                 -1                   ; xp
                 max-health ; mp
                 0
                 the-man-start-lvl
                 #f                  ; dead
                 'man-conv         ; conv
                 sch_man           ; sched
                 'townsman-ai                 ; special ai
                 nil                 ; container
                 (list t_armor_leather_4
                 		t_leather_helm_2
                 		t_magic_axe)                 ; readied
                 )
   (man-mk)))
