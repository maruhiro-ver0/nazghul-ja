;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define necr-lvl 8)
(define necr-species sp_human)
(define necr-occ oc_wizard)

;;----------------------------------------------------------------------------
;; Schedule
;;----------------------------------------------------------------------------
(define necr-bed nl-bed)
(define necr-mealplace nl-tbl)
(define necr-workplace nl-lab)
(define necr-leisureplace nl-lib)
(kern-mk-sched 'sch_necr
               (list 0  0 necr-bed          "sleeping")
               (list 7  0 necr-mealplace    "eating")
               (list 8  0 necr-workplace    "working")
               (list 12 0 necr-mealplace    "eating")
               (list 13 0 necr-workplace    "working")
               (list 18 0 necr-mealplace    "eating")
               (list 19 0 necr-leisureplace "idle")
               (list 22 0 necr-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (necr-mk) 
  (mk-quest))
(define (necr-quest gob) gob)

;;----------------------------------------------------------------------------
;; Conv
;;----------------------------------------------------------------------------

;; Basics...
(define (necr-hail knpc kpc)
  (let ((quest (necr-quest (kobj-gob-data knpc))))
    (if (and (quest-offered? quest)
             (not (quest-done? quest))
             (in-inventory? kpc t_lich_skull)
             )
        (necr-meet-lich knpc kpc)
        (say knpc "�Τ��ʤ��Ͽ������餻�������ȹ����������ѻդȲ�ä�����"
             "(���ۥ�)�褦�������¤��ͤ衣"))))

(define (necr-default knpc kpc)
  (say knpc "����ϳ��Ǥऻ�Ƥ��롣��"))

(define (necr-heal knpc kpc)
  (begin
    (say knpc "\n����ϳ�������Ǥ��롣��\n"
         "����פ����Υ��ۥ�ϡΥ���������")
    (prompt-for-key)

    (say knpc "�褤����\n")
    (prompt-for-key)

    (say knpc "\n�亮�����ġΥ��ۥ��")
    (prompt-for-key)

    (say knpc "\n�Υ��������ϡ�")
    (prompt-for-key)

    (say knpc "�Υ����á�")
    (kern-sleep 100)
    (say knpc "���ݤ줿����")
    (kern-sleep 100)
    (say knpc "�Υϡ��ϡ���")
    (kern-sleep 3000)
    (say knpc "�ġġġ�")
    (prompt-for-key)

    (say knpc "\n�����ۤ�������")
    (prompt-for-key)

    (if (in-player-party? 'ch_mesmeme)
	(begin	
	  (say knpc "\n�����ۤ�³�����ġ�")
	  (kern-sleep 3000)
	  (aside kpc 'ch_mesmeme "���ݤ줿�Ѥ򸫤�����\n������")
	  (aside kpc 'ch_amy "�������á��������������ᡪ")
	  (prompt-for-key)
	  )
	)

    (if (in-player-party? 'ch_nate)
	(begin
	  (say knpc "\n�λ�ˤ����ʲ���Ω�ƤƤ��롣��")
	  (kern-sleep 3000)
	  (aside kpc 'ch_nate "������")
	  (kern-sleep 100)
	  (aside kpc 'ch_nate "�ޤ������ʡ�")
	  (kern-sleep 1000)
	  (aside kpc 'ch_nate "�ĥ����Ĥ�ʪ����äƤ��ä��顩")
	  (kern-sleep 500)
	  (aside kpc 'ch_roland "�ϼ��ԡ���̾���ʤ��Ȥ�")
	  (prompt-for-key)
	  )
	)
    
    (if (in-player-party? 'ch_amy)
	(begin
	  (aside kpc 'ch_amy "�ɤ����ˡ����򷡤ä��ۤ������������顩")
	  (prompt-for-key)
	  )
	)

    (kern-sleep 3000)
    (say knpc
	 "\n����Ϥޤ���ڻ���Ƥ��롣��\n"
	 "����϶��Τ�������õ�ꤷ������\n"
	 "��^c+b���󡦥��������ޥˡ������ס�����<IN VAS MANI CORP XEN>^c-\n"
	 "")
    ;; (vas-mani knpc)  ;; SAM: Alas, this invoked UI, and emitted extra messages
    (say knpc
	 "\n����ϵ����夬�ꡢ����©��ۤä�����\n"
	 "����פȸ��äƤ�����������ޤ�ʡ�")
    ))

(define (necr-name knpc kpc)
  (say knpc "�亮������ѻդ���"))

(define (necr-join knpc kpc)
  (say knpc "�亮�������ԤǤϤʤ���"))

(define (necr-job knpc kpc)
  (say knpc "�����̩������������Ȥ���"))

(define (necr-bye knpc kpc)
  (say knpc "����ϳ��򤷤ʤ��餢�ʤ����ɤ�ʧ�ä�����"))

;; L2
(define (necr-dead knpc kpc)
  (say knpc "�ࡩ�ޤ����Ǥ���̡����ޤ��Ϥɤ�����")
  (if (yes? knpc)
      (say knpc "���������äƤ���̤褦�˸����롣")
      (say knpc "�����ϻפ�̡�"
           "������¿��������ä��Ƥ����������ޤ�����ȤϤ���ʾ��ä��ʤ��褦����")))

(define (necr-coug knpc kpc)
  (say knpc "���ä������Х����äƤ��������Ǥ⤿�ޤ˵ۤ���"))

(define (necr-spir knpc kpc)
  (say knpc "�����Ĥ��ΤȤƤ�Ť������ˤ�����Τ��Ȥ��ΤäƤ��롣(���ۥ�)"
       "�⤷�����Τꤿ�����Ȥ�����С�������Τ���ɤ����ˤ���Ϥ�����"))

;; Quest-related
(define (necr-meet-lich knpc kpc)
  (if (quest-done? (necr-quest (kobj-gob-data knpc)))
      (begin
        (say knpc "�饯���ޥ˲�����˿Ҥͤ衪�ब�����뤫��")
        (if (no? kpc)
            (begin
              (say knpc "���������顣����Ǥ褤������\n"
		   "�������ˡ�θ��դ򾧤�������"
		   "��^c+b��������������<WIS QUAS>^c-��")
              (wis-quas knpc))
            (say knpc "�����")))
      (begin
        (say knpc "�������饯���ޥ˲���Ƭ��������äƤ����ʡ�"
             "����Ǥ褤�ä�ʹ����˰㤤�ʤ���"
             "���������Ԥơ��������ˡ�")
        (kern-obj-remove-from-inventory kpc t_lich_skull 1)
        (say knpc "\n�������ˡ�θ��դ򾧤�������\n"
             "��^c+b���롦���󡦥��󡦥�����<KAL AN XEN CORP>^c-��"
             "�饯���ޥˤ衢����衪")
        (kern-obj-put-at (mk-luximene)
                         (loc-offset (kern-obj-get-location knpc)
                                     south))
        (quest-done! (necr-quest (kobj-gob-data knpc)) #t)
        (say knpc "���������ब�����뤫��")
        (if (no? kpc)
            (begin
              (say knpc "̵�����������ϤΤʤ��Ԥˤϸ��뤳�Ȥ��Ǥ��̡�\n"
                   "����Ǥ褤������\n"
                   "�������ˡ�θ��դ򾧤�������"
                   "��^c+b��������������<WIS QUAS>^c-��")
              (wis-quas knpc))
            (say knpc "���ǤΤ��Ȥ�ʹ���ʤ�����")))))

(define (necr-rune knpc kpc)
  (let ((quest (necr-quest (kobj-gob-data knpc))))
    (if (quest-offered? quest)
        (if (in-inventory? kpc t_lich_skull)
            (necr-meet-lich knpc kpc)
            (if (quest-done? quest)
                (begin
                  (say knpc "�饯���ޥ˲�����˿Ҥͤ衪�ब�����뤫��")
                  (if (no? kpc)
                      (begin
                        (say knpc "�Ļ�μ�ʸ���Ƥߤ褦��\n"
			     "�������ˡ�θ��դ򾧤�������\n"
			     "��^c+b��������������<WIS QUAS>^c-\n"
			     "��αƤ��ä����������ǤΤ��Ȥ�Ҥͤʤ�����")
			(wis-quas knpc)
			(kern-conv-end)
			)
                      (begin
			(say knpc "���������αƤ˿Ҥͤʤ�����")
			(kern-conv-end)
		      )
		  ))
                (say knpc "��å��Ȥʤä��饯���ޥ˲���Ƭ��������äƤ���Τ���"
                     "�����¿���Τ��Ȥ��狼�롣")))
        (if (not (any-in-inventory? kpc rune-types))
            (say knpc "¿�������Ǥ򸫤Ƥ�����(���ۥ�)"
                 "������Ļ��äƤ���и��뤫���Τ�̡�")
            (begin
              (say knpc "�դࡣ��������"
                   "�������Ǥ˽񤫤줿ʸ���ϡ����Ĥƥ饯���ޥ˲�����Ǹ�����Τ�Ʊ������(���ۥ�)"
                   "�����˿Ҥͤ�в��������Ƥ���뤫�⤷��̡�"
                   "�¤��ͤ衢���ޤ���ͦ�����͡�")
              (if (no? kpc)
                  (say knpc "��������ǰ�ʤ��顣"
                         "�������Ǥ϶�̣�򤽤���Τ�����(���ۥ�)")
                  (begin
                    (say knpc "�������Ȼפä���"
                         "�饯���ޥ˲��Ϻ��Ǥϥ�å��ȤʤäƤ��롣"
                         "�Ǥ⶧˽�ʡ�"
                         "�������Ф�����ϲ��ˤ�����ΰ��ֽ����ˤ��롣"
                         "�⤷���Ƭ��������äƤ���С�������ʤ��ᡢ�ä��������(���ۥ�)"
                         "������ޤ���򡢤��μ겼�ȶ����ݤ��ͤФʤ��"
                         "�Ի�μԤ��Ť������ʤ���ˡ���ΤäƤ뤫�͡�")
                    (quest-offered! quest #t)
                    (if (yes? kpc)
                        (say knpc "�ܤ���Ի�μԤ򰷤��ˤϺǤ�褤��ʸ����")
                        (say knpc "�Ф��Ƥ��������󡦥��󡦥�����<An Xen Corp>����"
                             "�Ǥ�ͭ���ʼ�ʸ�Ǥ��롣\n"
                             "^c+g����^c-��^c+gβ���γ�^c-��Ĵ�礻�衣\n"
                             "(���ۥ�)\n"
                             "�����餫���Τ�����ˤ���Ϥ�����"
                             "���äƹԤäƤ褤����"))
		    )))))))

(define (necr-absa knpc kpc)
  (say knpc "���������֥���åȡ��Ť��������ԡ����ϼ���줿��"
       "�Ԥä����ȤϤ��뤫�͡�")
  (if (yes? kpc)
      (say knpc "���ȤʤäƤ��ѿ��ΰ��פǤ����ʤ���")
      (begin
        (say knpc "���饹�ɥ��θ���ʬ��ٻ����뤫�͡�")
        (if (yes? kpc)
            (say knpc "����ϳ�ʧ���򤷤ƤĤ֤䤤������"
                 "������ĺ��ǤϤ����ˤϸ���٤���Τϲ���ʤ���")
            (say knpc "��̩��ƻ�����롣ϣ��ѻդ˿Ҥͤʤ������ब�ΤäƤ��롣")))))

;; the wise
(define (necr-ench knpc kpc)
  (say knpc "���ζ򤫤�ǯ���ϥ亮�����줿�Ԥΰ�̣�ȹͤ��Ƥ��롪"
       "�ۤϼ�ʬ��ƻ��ͣ���ƻ�ǤϤʤ����Ȥ��狼��ʤ��褦����")
       )

(define (necr-man knpc kpc)
  (say knpc "����Ͼ���ɬ�פʤȤ��񤤤���뤳�Ȥ������"
       "�����ƥ亮��ʪ���äƤ������Ȥ�����ġ�")
  (quest-data-update 'questentry-the-man 'common 1)
  )

(define (necr-alch knpc kpc)
  (say knpc "�����ˤ����������褭�����ƻ��ʤ�Ǥ��롣")
  (quest-data-update 'questentry-alchemist 'common 1)
  )

(define (necr-engi knpc kpc)
  (say knpc "�����������ƹ��񿴤�˺��ʤ��Ǥ��롣"
       "�����������Ĥⲿ�����äƤ��롣"
       "��꽪�����Ȼפ��С��������̤Τ�Τ���Ϥ�롪(���ۥ�)"
       "�������ͤ����Τȸ����礦���ȤϷ褷�Ƥʤ��Ǥ�����")
       (quest-data-update 'questentry-engineer 'common 1)
       )

(define (necr-warr knpc kpc)
	(if (quest-data-assigned? 'questentry-wise)
		(begin
		  (say knpc "����������ϵ���Ƥ��ޤä���"
		       "�������ȵ�������ǲ�ä���"
		       "���饹�ɥ��λ�Ƴ�Ԥ˻����줿�Τ���"
		       "���ϲ��򸫼ΤƤ��Τ��������졢�����β��衢�ޤ����Υ����ɤˤ��뤫��")
		       (quest-data-update 'questentry-warritrix 'slain 1)
		 )
		 (say knpc "�󤤲��顢����ۤɵ��⤭���ΤϤ��ʤ��Ǥ�����")
       ))

(define (necr-vale knpc kpc)
  (say knpc "�Ť��������Ϥ����������Ȥ������Τ��Ƥ��롣"))

(define (necr-wise knpc kpc)
  (say knpc "����ϱ󤤲���Τ�������ǡ���Ρ���ѻա��ʤ餺�Ԥ�ƻ���᤿�Ԥ���"
       "���Υ����ɤ�Ƴ���Τ���"
       "�����Ĺ����������κ��ǡ���������κǤ�Ť���ˤޤǤ����Τܤ뤳�Ȥ��Ǥ��롣"))

(define (necr-accu knpc kpc)
  (say knpc "����٤��Ԥ���(���ۥ�)���ο��Ĥ���500ǯ�����⤷������Ȥ���ʾ����˻ϤޤäƤ���ȸŤ���ä��Ƥ��줿��"
       "������������̩���Τ�̡�"
       "�ʤ��ʤ�������ϵ����ˤϵ���ʤ��������")
  (prompt-for-key)
  (say knpc "����Ϻ��Ǥ��Ƥ���褦������"
       "����ޤǤο����Ǽ���줿�Ԥλ�Ԥ򸫤����Ȥ��ʤ���"
       "���줬�Ǥ�狼��̤Τ���"))

(define (necr-gate knpc kpc)
  (say knpc "���������ΰ������θ�����������"
       "�亮��ñ�ʤ�������ȹͤ��Ƥ��롣"
       "��ƻ�դ�ʹ���Ƥߤʤ�������ϥ亮���褯�ΤäƤ��롣"
       "�亮���ͤȲ�ä���ʹ���Ƥߤ褦��"))

(define (necr-necr knpc kpc)
  (say knpc "�Υ��ۥ�ϥ亮�ϻ�ȷ�ӤĤ�����ˡ��ˤ�Ƥ��롣"))

(define necr-conv
  (ifc basic-conv

       ;; basics
       (method 'default necr-default)
       (method 'hail necr-hail)
       (method 'bye necr-bye)
       (method 'job necr-job)
       (method 'name necr-name)
       (method 'join necr-join)
       (method 'heal necr-heal)
       
       (method 'dead necr-dead)
       (method 'coug necr-coug)
       (method 'spir necr-spir)
       (method 'rune necr-rune)
       (method 'absa necr-absa)
       (method 'ench necr-ench)
       (method 'man necr-man)
       (method 'alch necr-alch)
       (method 'engi necr-engi)
       (method 'warr necr-warr)
       (method 'vale necr-vale)
       (method 'wise necr-wise)
       (method 'accu necr-accu)
       (method 'gate necr-gate)
       (method 'demo necr-gate)
       (method 'necr necr-necr)
       ))

(define (mk-necromancer)
  (bind 
   (kern-mk-char 
    'ch_necr           ; tag
    "����ѻ�"       ; name
    necr-species         ; species
    necr-occ              ; occ
    s_necromancer     ; sprite
    faction-men      ; starting alignment
    1 6 0            ; str/int/dex
    0 0              ; hp mod/mult
    0 0              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    necr-lvl
    #f               ; dead
    'necr-conv         ; conv
    sch_necr         ; sched
    'townsman-ai              ; special ai
    nil              ; container
    (list t_staff)              ; readied
    )
   (necr-mk)))
