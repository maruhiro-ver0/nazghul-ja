;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define engineer-start-lvl 8)

(define voidship-parts
  (list 
  	(list t_power_core 1)
	(list sulphorous_ash 20)
	(list t_gem 10)
  ))

(define voidship-loc (mk-loc 'p_shard 50 3))

;;----------------------------------------------------------------------------
;; Schedule
;;
;; ���դξ���
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_engineer
               (list 0  0  eng-workshop   "working")
               (list 1  0  eng-bed        "sleeping")
               (list 10 0  eng-workshop   "working")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (engineer-mk)
  (list #f 
        (mk-quest)))
(define (eng-met? gob) (car gob))
(define (eng-quest gob) (cadr gob))
(define (eng-met! gob val) (set-car! gob val))

;; ----------------------------------------------------------------------------
;; Voidship plans
;; ----------------------------------------------------------------------------
(mk-reusable-item 
 't_voidship_plans "�������ײ��" s_lexicon norm
 (lambda (klexicon kuser)
   (kern-ui-page-text
   "�������ײ��"
   "���ʰ���:"
   "��β���γ� (20)"
   "������ (10)"
   "��ϧ�� (1)"
   )))

;;----------------------------------------------------------------------------
;; Conv
;;
;; ���դ��μ��Τ������ʿ��ͤǡ����Ԥΰ�ͤǤ��롣
;; ��ϥ����ɤ�ü�Τ��ɤ��夯�Τ�����ʵ����ι⸶(��������)�����Ⱦ�˽���
;; �Ǥ��롣
;;----------------------------------------------------------------------------
(define (eng-hail knpc kpc)
  (say knpc "�Τ��ʤ��Ϥ䤻�����򤯥ܥ��ܥ���ȱ���ˤȲ�ä���"
       "��Ϻǽ�Ϥ��ʤ��˵��Ť��Ƥ��ʤ��褦���ä����Ϥ��äȡ�����ˤ��ϡ�"))

(define (eng-name knpc kpc)
  (say knpc "��ɥ�դ������դȸ��ä������狼��䤹��������"))

(define (eng-job knpc kpc)
  (say knpc "����������Ȥ��������Τ���Τ������ʤ���衣"))

(define (eng-default knpc kpc)
  (say knpc "�狼��ʤ��ʡ���ƻ�դ�ʹ���Ƥ��졣"))

(define (eng-bye knpc kpc)
  (say knpc "����Ϥ��Ǥˤ��ʤ��Τ��Ȥ򵤤ˤ����Ƥ��ʤ��褦������"))

(define (eng-join knpc kpc)
  (say knpc "˻��������ʡ�Ʈ�Τ����Ǥߤʤ�������������������������顣"))

(define (eng-warr knpc kpc)
  (say knpc "����Ϥ���ޤǤǺǤ�ͥ�줿��Τΰ�ͤ��ȹͤ��Ƥ��롣"
       "�������Ǥⵤ�⤭�Ԥΰ�ͤ��Ȥ������Ȥ��ΤäƤ��롣"
       "������������ʤ��褦��ͦ�����롢�����ƶ򤫤ʤ��Ȥ򤷤��ΤǤʤ����"
       "���饹�ɥ��ǲ񤨤������")
    (quest-wise-subinit 'questentry-warritrix)
  	(quest-data-update 'questentry-warritrix 'general-loc 1)
       )

(define (eng-make knpc kpc)
  (say knpc "��Ϥɤ�ʼ���Τ�ΤǤ��롣�Ƕ��ι�����Τ˶�̣������ʡ�"
       "�㤨�С��硢�������ʤɤ���"
       "���ۤ�Ƭ���椬���äѤ����衣"))

(define (eng-wand knpc kpc)
  (say knpc "�����¤��ͤ������äȲ񤤤����ȻפäƤ��������"
       "��ϼ�ʬ�Ǻ�ä��Τ���")
  (kern-conv-get-yes-no? kpc)
  (say knpc "���äȤ��줬�ɤ��ʤäƤ���Τ��ͤ��Ƥ��롣"
       "�����Ĥ���������ͤ����������Ƥ��������˵��������߷פ����Τ���"
       "�����ޤ������ϽФƤ��ʤ���"))

(define (eng-void knpc kpc)
  (let* ((eng (kobj-gob-data knpc))
         (quest (eng-quest eng)))

    (define (remove-stuff)
      (map (lambda (ktype) 
             (kern-obj-remove-from-inventory kpc (car ktype) (cadr ktype)))
           voidship-parts))

	;;FIXME: the grammer here needs work
	
    (define (really-has-parts?)
      (display "really-has-parts?")(newline)
      (let ((missing (filter 
				(lambda (ktype)
					(let ((nrem (- (cadr ktype) (num-in-inventory kpc (car ktype)))))
						(cond 
							((> nrem 1)
								(begin
									(say knpc "�ޤ�" nrem "��" (kern-type-get-name (car ktype)) "��ɬ�פ���")
									#t))
							((> nrem 0)
								(begin
									(say knpc "�ޤ�" (kern-type-get-name (car ktype)) "��ɬ�פ���")
									#t))
							(else #f))))
					voidship-parts)))
		
        (if (null? missing)
			#t
            #f)))

    (define (build-ship)
      (say knpc "�褷�����Ƥ���ä��褦���ʡ�"
           "�Ǥϼ��ݤ���Ȥ��褦��")
      (remove-stuff)
      (kern-log-msg "�ο�¿�������ϡ���ϫ����ԡ����Ԥθ�ġ�")
      (prompt-for-key)
      (kern-log-msg "�κƻ�ԡ��Ƽ��ԡ��ʤ����äơ�ȱ��ȴ�������ġ�")
      (prompt-for-key)
      (kern-log-msg "�Τ���˶�ϫ�����������ľ�����ޤ����ԡġ�")
      (prompt-for-key)
      (kern-log-msg "�κƻ�ԡ��Ƽ��ԡ��ޡ���������ġ�")
      (prompt-for-key)
      (kern-log-msg "�������������ġ�")
      (prompt-for-key)
      (kern-log-msg "�ΡĤĤ��ˡġ�")
      (prompt-for-key)
      (kern-log-msg "�ΡĤ��äȡ��������礦�����٤ϲ������ġ�")
      (prompt-for-key)
      (kern-log-msg "�ΡĤ������ޤ�ʤ��ġ�")
      (prompt-for-key)
      (kern-obj-relocate (mk-voidship) (eval-loc voidship-loc) nil)
      (kern-log-msg "����ͤȤ����ƥܥ�ܥ������")
      (say knpc
           "����ġ������ʤ����������������Ʒ��Τ�Τ���"
           "�����������ԤäƤ��뤾�������򵧤롪")
      (kern-log-msg "����Ϥ��Ӥ��򤫤��Ϥ᤿����")
      (kern-obj-add-effect knpc ef_sleep nil)
      (quest-done! quest #t)
      (kern-conv-end))

    (define (missing-power-core?)
      (not (in-inventory? kpc t_power_core)))

    (define (has-plans)
      (say knpc "���������줬��ε������ηײ�����"
           "ɬ�פ����ʤ����Ƥ��뤫�͡�")
      (if (kern-conv-get-yes-no? kpc)
          (if (really-has-parts?)
              (build-ship))
          (if (missing-power-core?)
              (say knpc "��ο��������ܤ��Ϥä����Τɤ����˰����夲��줿�����������롣"
                   "�����ܤ��Ϥ���ˡ�򸫤Ĥ���С���������ϧ������Ф����Ȥ��Ǥ��������")
              (say knpc "�����ࡢ�����ԤäƤ���Τ��ʡ���������äƤ��ʤ�����")
              )))
      
    (define (no-plans)
      (say knpc "�����ɤμ���ˤϹ���ʵ����������äƤ��롣"
           "��ϵ������Ϥ������߷פ򤷤��������ޤ��������Ƥ��ʤ���"
           "�ɤ����˷ײ�񤬤��롣���Ĥ��Ƥ����鶵���Ƥ����")
           (quest-data-update 'questentry-whereami 'shard 2)
           )

    (if (quest-done? quest)
        (say knpc "���ƴ���������")
        (if (in-inventory? kpc t_voidship_plans)
            (has-plans)
            (no-plans)))))

(define (eng-gate knpc kpc)
  (say knpc "�����Ⱥ��Ť������������Ƥ��롣"
       "��Ϥ�������������������"
       "���������ΤäƤ��뤫�͡�")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "����������ˤ���Τ��������ǤϤʤ��Τ�������Τꤿ���Τ���")
      (say knpc "����ʸ������������롣"
           "�������ϡ��������������̤������ؤȤĤʤ��äƤ��롣"
           "���������ۤ�����줿�Ԥ���������Ĥ���������ɤ������ꤲ�ΤƤ���"
           "�⤷���줬�����ʤ��ǰ�ʤ��Ȥ���")))
  
(define (eng-key knpc kpc)
  (say knpc "���Ϥ����Ĥ������Ǥǡ�����ϼ���줿�����Х�Х�ˤʤä��Ȥ���Ƥ��롣"
       "�褯����Ĥޤ�ʤ����Ȥ��ä����������⤷������Ȥ����˿��¤γˤ�����Τ��⤷��ʤ���"))

(define (eng-wise knpc kpc)
  (say knpc "����򸭼ԤȸƤ������ʼԤϡ��ְܴۤ㤤�ʤ��򤫤ʼԤ���"
       "���󤲤�Х��饹�ɥ��������Ԥ���"))

(define (eng-stew knpc kpc)
  (say knpc "�����Ĺ���֡����Ԥΰ�ͤȤ��ƿ������Ƥ�����"
       "�����ơ����Τ��ȤǤɤ�����η줬ή���줿�Τ��狼��ʤ���"
       "���֥���åȤΤ��Ȥ�ʹ�����ʡ�")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "�Ϥΰ��Ѥδ���������������ᤷ�����Ȥ���")
      (say knpc "�����Ԥ�¾��Į����ƻ�դ��٤������֥���åȤ�Į����Ի���Ԥä��Τ���"
           "���֥���åȤϼ���줿�Ԥβ����Ȥ���Ƥ�����"
           "�⤷����줿�Ԥ�����鷺���ʾڵ�Ǥ⤢��С��Ĥ��Į��Ʊ���褦�˾Ƥ�ʧ�ä�������")))

(define (eng-accu knpc kpc)
  (say knpc "���ϰ��ȷ��󤷤��Ԥ����ν��ĤȤ���Ƥ��롣"
       ";�פʤ��ȤФ��굤�ˤ��Ƥ���Ԥ����ϡ������⤭­Ω�äƤ��롣"
       "����������ˤ��Ƥ��ʤ���"))

(define (eng-shri knpc kpc)
  (say knpc "��������Ť���ε�Ͽ�䤽�ξ���褯Ĵ�٤Ƥߤ���"
       "���������줬�ɤ��ʤäƤ���Τ����ɤ����������Ǥ���Τ�������򼨤���Τϲ���ʤ��ä���"
       "�Ǹ�ˤ��줬�������Τ�ɴǯ�ʾ����Τ��Ȥ��Ȼ�Ϲͤ��Ƥ��롣"))

(define (eng-rune knpc kpc)
  (say knpc "���������Ǥϰ������Ϥ����Ĥ������Ǥ��������줿�ȸ����Ƥ��롣"
       "�̤��äǤ����Ǥ����٤���򳫤����ʤ��褦�Х�Х�ˤ��줿�Ȥ⡢"
       "����ñ�˱���������줿�Ȥ�����Ƥ��롣"
       "�����󤽤�Ϥ����θ��������ǡ����Τ褦�����Ǥ䡢���¸�ߤ���狼��ʤ��Τ���"))

(define (eng-wiza knpc kpc)
  (say knpc "��ѻդ��Ϥ˿���å��줬������"))

(define (eng-wrog knpc kpc)
  (say knpc "�ۤȤ�ɤΤʤ餺�ԤϤ������¤Τ褦�ʤ�Τ������Ϥ������ˤ��롣"))

(define (eng-wrig knpc kpc)
  (say knpc "���ͤϻ�Τ褦�ʼԤ�������"
       "ʪ���뤳�Ȥ򹥤ߡ�ʪ�λ��Ȥߤ򸫤Ĥ��Ф���"
       "�����Ƽ�ͳ�˶�̣�Τ���ʪ�����ɤ����褦�Ȥ��롣"))

(define (eng-necr knpc kpc)
  (say knpc "�����ԤǤϤʤ������٤����١���ȵ����������Ȥ����롣")
  (quest-data-update 'questentry-necromancer 'nonevil 1)
  )

(define (eng-alch knpc kpc)
  (say knpc "���ǤǤ��ʤ����ǥʥ�����������º�ɤ��٤��Ȥ���⤢�롣"))

(define (eng-man knpc kpc)
  (say knpc "�ʤ餺�ԡ����������ˤʤ�Ԥ������Ȥ����ޤ���äƤ���衣"))

(define (eng-ench knpc kpc)
  (say knpc "��˸��碌��о�������Ū�ʤȤ������롣�ͤϳ�����������"))

(define eng-merch-msgs
  (list "���ϥ������"
        "�䤬��ȯ����ʪ�ΰ����򸫤��Ƥ����"
        nil
        nil
        "���Ĥ���֤ν������˴��դ���Ƥ���衣"
        "��������"
   ))

(define eng-catalog
  (list
   ;; Various tools and devices
   (list t_picklock       10 "���������Ĥ���ͽ���θ���ɬ�פˤʤä����ɤ�ʾ��ˤ�礦�����ʤ�Τ���")  ;; high prices, not his specialty
   (list t_shovel        100 "���Υ���٥�ϼ����������ʤ��ʡ��ɤ�������Ω�Ĥ����ˤϤ狼��ʤ�������")  ;; high prices, not his specialty
   (list t_pick          100 "���ΤĤ�Ϥ��ϻȤä���Τ������٤���������ϼ������Ƥ⤤��������")  ;; high prices, not his specialty
   (list t_sextant       200 "����ϻ�κǹ���ΰ�Ĥ�������ϻʬ��������С����󡦥�����<In Wis>�μ�ʸ�ʤ����Ͼ�Ǥΰ��֤��狼�롣")
   (list t_chrono        200 "����Ͼ����ʡ��������٤���פ������򤤤���������ϳڤ����Τ��ޤ�Фä�����")
   
   ;; A bit of oil and grease, for a grease-monkey:
   (list t_grease         20 "��Ϥ������󤢤롣�����ʤ��Ȥ˻ȤäƤ��롣")
   (list t_oil            10 "����������ȯ�ϤλȤ�ƻ�Ϥ�����Ǥ⤢�롣����϶��餯ư�ϸ��ˤ�ʤ������")  ;; high prices, not his specialty

   ;; Crossbows and bolts, as he likes intricate devices
   (list t_lt_crossbow    50 "���襤�餷�������ʥ����ܥ����������ξ����ʥ�С��ȵ����������ˤ褯�Ǥ��Ƥ��롣")
   (list t_crossbow      100 "��Ϸ�ĤΤ϶������������������˸����äƼ�ʬ�ǰ����ʷ�����򶵤��뤳�Ȥ��Ǥ������Ȼפ��ȡ��Ǥ�����ؤ�Ǥ����Ф褫�ä��Ȼפ��衣")
   (list t_hvy_crossbow  300 "ɸ��Ū�ʥ����ܥ�����ɤ����ˤϤ����ʤ��ä�������դ��Ƥߤ�Ф����˷����Ȥ狼�������")
   (list t_trpl_crossbow 500 "�⤷���٤˰�ȯ���¿����Ƥ륯���ܥ������ä��顩���ĩ�路�Ƥߤ��������Ƥ�����ä���") ;; a mechanism of his devising
   (list t_bolt            2 "�����ܥ�����ɤ��Ƥ���Ȥ���¿������ɬ�פ��ä������ǤⲿȢ���ĤäƤ��롣")
   ))

(define (eng-trade knpc kpc) (conv-trade knpc kpc "buy" eng-merch-msgs eng-catalog))

(define engineer-conv
  (ifc nil
       (method 'default eng-default)
       (method 'hail eng-hail)
       (method 'name eng-name)
       (method 'bye eng-bye)
       (method 'job eng-job)
       (method 'engi eng-job)
       (method 'join eng-join)

       (method 'trad eng-trade)
       (method 'buy  eng-trade)
       (method 'inve eng-trade)

       (method 'make eng-make)
       (method 'thin eng-make)
       (method 'wand eng-wand)
       (method 'void eng-void)
       (method 'gate eng-gate)
       (method 'key eng-key)
       (method 'wise eng-wise)
       (method 'stew eng-stew)
       (method 'accu eng-accu)
       (method 'shri eng-shri)
       (method 'rune eng-rune)
       (method 'wiza eng-wiza)
       (method 'wrog eng-wrog)
       (method 'wrig eng-wrig)
       (method 'necr eng-necr)
       (method 'alch eng-alch)
       (method 'man eng-man)
       (method 'ench eng-ench)
       (method 'warr eng-warr)
       ))

(define (mk-engineer)
  (bind 
   (kern-char-arm-self
    (kern-mk-char 
     'ch_engineer ;;..........tag
     "����" ;;.......name
     sp_human ;;.....species
     oc_wright ;;.. .occupation
     s_companion_tinker ;;..sprite
     faction-men ;;..faction
     2 ;;...........custom strength modifier
     10 ;;...........custom intelligence modifier
     2 ;;...........custom dexterity modifier
     10 ;;............custom base hp modifier
     2 ;;............custom hp multiplier (per-level)
     20 ;;............custom base mp modifier
     5 ;;............custom mp multiplier (per-level)
     max-health ;;..current hit points
     -1  ;;...........current experience points
     max-health ;;..current magic points
     0
     engineer-start-lvl  ;;..current level
     #f ;;...........dead?
     'engineer-conv ;;...conversation (optional)
     sch_engineer ;;.....schedule (optional)
     'townsman-ai ;;..........custom ai (optional)
     ;;..............container (and contents)
     (mk-inventory
      (list
       (list 1   t_dagger)
       (list 1   t_doom_staff)
       (list 1   t_trpl_crossbow)
       (list 100 t_bolt)
       (list 5   t_cure_potion)
       (list 5   t_heal_potion)
       ))
     nil ;;.........readied arms (in addition to the container contents)
     nil ;;..........hooks in effect
     ))
   (engineer-mk)))
