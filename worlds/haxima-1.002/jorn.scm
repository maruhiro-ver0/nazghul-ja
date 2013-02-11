;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define jorn-lvl 5)
(define jorn-species sp_human)
(define jorn-occ oc_wrogue)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; �Ф���
;;----------------------------------------------------------------------------
(define jorn-bed gt-jorn-bed)
(define jorn-mealplace gt-ws-tbl1)
(define jorn-workplace gt-jorn-hut)
(define jorn-leisureplace gt-ws-hall)
(kern-mk-sched 'sch_jorn
               (list 0  0 jorn-bed          "sleeping")
               (list 11 0 jorn-mealplace    "eating")
               (list 12 0 jorn-workplace    "working")
               (list 18 0 jorn-mealplace    "eating")
               (list 19 0 jorn-leisureplace "idle")
               (list 24 0 jorn-workplace    "working")               
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (jorn-mk) nil)

(define (jorn-on-death knpc)
	(kern-obj-put-at (kern-mk-obj t_skull_ring_j 1) (kern-obj-get-location knpc))
	)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ���硼��ϸ���±�ΰ��ޤǡ������Ф���ˤ��롣
;; ��Ϥ��Ĥƻ��ῼ�����ξ��Ȱ��ǡ�˴��Ȥʤä������ƥ���Ĺ�������Τ����ɤ�
;; ��Ƥ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (jorn-hail knpc kpc)
  (say knpc "�Τ��ʤ�����˽�������Ե������ˤȲ�ä����ϲ�����"))

(define (jorn-default knpc kpc)
  (say knpc "¾�������äƤ��졣"))

(define (jorn-name knpc kpc)
  (say knpc "���ϥ��硼�����ʹ�������Ȥ��뤫��")
   (quest-data-update 'questentry-ghertie 'jorn-loc 1)
  (if (yes? kpc)
      (say knpc "����㤤�����ٹ𤵤줿������")
      (say knpc "�������Ǥˡ����椷�����ʤ�������")))

(define (jorn-join knpc kpc)
  (say knpc "��������䤫�˾Фä�����"))

(define (jorn-job knpc kpc)
  (say knpc "���󤿤ˤϴط��ʤ��͡�"))

(define (jorn-bye knpc kpc)
  (say knpc "����Ϥ��ʤ���̵�뤷������"))


;; Town & Townspeople

;; Quest-related
(define (jorn-pira knpc kpc)
  (say knpc "���ˤ�����ۤ��ʡ�"))

(define (jorn-ring knpc kpc)
      (quest-data-update 'questentry-ghertie 'jorn-loc 1)
        (say knpc "������䤿���ܤǤ��ʤ��򸫤����Ϥʤˡ����줬�ߤ����Τ���")
        (if (no? kpc)
            (say knpc "�ʤ��ۤäƤ�")
            (begin
              (say knpc "�ʤ�Ф��λؤ��ڤ�ͤФʤ��ʡ�"
                   "�ɤ������ڤ�����ϤǤ�������")
              (if (no? kpc)
                  (say knpc "����Ϥ����Фä����Ϥ����ϻפ�ʤ��͡�")
                  (begin
                    (say knpc "�ζ�������夲��ȡ���ϸ����ʤ��ۤɤ�®���Ƿ���ȴ�������ʤ���Ʊ���褦���ڤ�Ĥ��Ƥ�������")
                    (kern-being-set-base-faction knpc faction-outlaw)
                    (kern-conv-end))))))

(define jorn-conv
  (ifc basic-conv

       ;; basics
       (method 'default jorn-default)
       (method 'hail jorn-hail)
       (method 'bye  jorn-bye)
       (method 'job  jorn-job)
       (method 'name jorn-name)
       (method 'join jorn-join)
       
       ;; other responses
       (method 'pira jorn-pira)
       (method 'gher jorn-pira)
       (method 'merc jorn-pira)
       (method 'ring jorn-ring)

       ))

(define (mk-jorn)
	(let ((knpc
		(kern-mk-char 
			'ch_jorn           ; tag
			"���硼��"         ; name
			jorn-species     ; species
			jorn-occ         ; occ
			s_brigand        ; sprite
			faction-men      ; starting alignment
			2 0 1            ; str/int/dex
			0 0              ; hp mod/mult
			0 0              ; mp mod/mult
			max-health ; hp
			-1                ; xp
			max-health ; mp
			0
			jorn-lvl
			#f               ; dead
			'jorn-conv       ; conv
			sch_jorn           ; sched
			'spell-sword-ai  ; special ai

			;; container
			(mk-inventory (list
				(list 1 t_sword_2)
				(list 1 t_dagger_4)
				(list 1 t_armor_leather_2)
				(list 1 t_leather_helm_2)
				(list 67 t_gold_coins)
				(list 3 t_picklock)
				(list 3 t_heal_potion)
			))
			nil              ; readied
		)))
		(bind knpc  (jorn-mk))
		(kern-char-force-drop knpc #t)
		(kern-char-arm-self knpc)
		(kern-obj-add-effect knpc 
			ef_generic_death
			'jorn-on-death)
		knpc
	))
