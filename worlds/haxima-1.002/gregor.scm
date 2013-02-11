;;----------------------------------------------------------------------------
;; gregor.scm - ú�Ƥ��ͤΥ��쥴����
;;----------------------------------------------------------------------------
;;----------------------------------------------------------------------------
;; Schedule
;; 
;; �����κ��� (moongate-clearing.scm)
;; ���쥴����ξ��� (gregors-hut.scm).
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_gregor
               (list 0  0  gh-gregors-bed   "sleeping")
               (list 6  0  gh-graveyard     "idle")
               (list 7  0  mgc-roadbend     "idle")
               (list 13 0  gh-table-2       "eating")
               (list 14 0  gh-pasture       "working")
               (list 17 0  gh-table-2       "eating")
               (list 18 0  gh-living-room   "idle")
               (list 20 0  gh-gregors-bed   "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
(define (gregor-mk) (list (mk-quest)))
(define (gregor-quest gob) (car gob))


;;----------------------------------------------------------------------------
;; Conv
;; 
;; ���쥴�����ú�Ƥ��ͤ�Ϸ�ͤǡ���κ��Ťζ᤯�˽���Ǥ��롣
;; ��Ϻ��Ťζ᤯�ˤ褯���롣������¹̼�Υ��ꥢ�����ä򤷤Ƥ��롣
;; 
;; ���쥴����ϥץ쥤�䡼���ǽ�˲�NPC�Ǥ��롣�����ơ����ƥץ졼����Ԥ�¿
;; �̤ʽ����ˤʤ�����򤹤롣
;;----------------------------------------------------------------------------

(define (gregor-kill-nate knpc kpc)
  (say knpc "�Υ��쥴����Ͽ̤���ؤ�ͥ��Ȥ˸��������Ϥ������Ϥ���Τ����롣")
  (aside kpc 'ch_nate "�ΤĤ֤䤭�Ϥ���Ϸ���ܤ�ϲ���ġ�")
  (prompt-for-key)
  (say knpc "����ϴ�ʪ����Ф������Ϥ���ˤ�¿�����ʧ�ä����亮�ˤ��ɤ�̤����ɤ������Ф褤���϶���ä���")
  (aside kpc 'ch_nate "�ԤơĤ���ϡġ�")
  (prompt-for-key)
  (say knpc "���󡦥�����<Xen Corp>��")
  (cast-missile-proc knpc ch_nate t_deathball)
  (aside kpc 'ch_nate "�������á�")
  (prompt-for-key)
  (if (equal? kpc ch_nate)
      (kern-conv-end)
      (say knpc "����Ͽ����֤ä����Ϥ��Τ褦�ʼԤȤ���٤��ǤϤʤ��ä����͡��Ϥ��ʤ��ˤĤ��Ƥ褫��̹ͤ�������������"))
  )
  

(define (gregor-hail knpc kpc)
  (if (in-player-party? 'ch_nate)
      (gregor-kill-nate knpc kpc)
      (if (in-inventory? kpc t_letter_from_enchanter)
           (say knpc "ʪ���äƤ����褦���ʡ����������ƻ�դ���μ�椬���롣"
                "������������������������Τ�˺��ƤϤʤ�̡�"
                "���ϤȤƤ������")
           (say knpc "�Τ��ʤ�����ȱ�ޤ�������פ�Ϸ�ͤȲ�ä�����\n"
                "�褦�������¤��ͤ衣���ȻפäƤ�����"
                "���ʤ��λ���ʪ�ϡ�����ƶ������ˤ��롣"
                "�Ԥä�Ȣ�򳫤������ʪ���äƤ������졣"
                "���Ƥ��ʤ��Τ����ʪ����"))
      ))

;; Some prompting with initial commands:
;; 
;; Hmmm...perhaps it would be desirable to have game-UI promts
;; spoken out-of-character, so that the NPCs don't break the game fiction...
(define (gregor-open knpc kpc)
  (say knpc "Ȣ��^c+b������^c-�Τ�'o'��������"))

(define (gregor-get knpc kpc)
  (say knpc "'g'�������֤��줿��Τ�^c+b���^c-���Ȥ��Ǥ��롣"))

(define (gregor-read knpc kpc)
  (say knpc "�����ɶ��'r'������^c+b��������^c-��"
       "�����������Ƥ��ʤ�����襤�ǻȤ����Ȥ��Ǥ��ʤ���"))

(define (gregor-camp knpc kpc)
  (say knpc "'k'������^c+b��©^c-����������Ϥ�����Ǥ��롣"))


(define (gregor-dang knpc kpc)
  (say knpc "�ȤƤ�������⤷������ɬ�פʤ顢Į�νɤ������ʾ�����"
       "����ǵ�©���뤳�Ȥ�Ǥ��뤬����ͤǸ�ĥ����֤��ʤ��Τϴ�����"
       "̵���������ʸ�ǲ������뤳�Ȥ�Ǥ��롣"))

(define (gregor-dead knpc kpc)
  (say knpc "�������ᤷ�����Ȥ����亮��̼�Ȥ����פ϶��ˡ�"
       "�ȥ��ɤ�˻����줿�Τ���"))

(define (gregor-charcoal knpc kpc)
  (say knpc "ú��Į�ػ��äƹԤ�����롣"
       "���줫��¼�μԤ��亮�ν���㤤����롣"))

(define (gregor-hut knpc kpc)
  (say knpc "����������ο��ˤ��롣"
       "�����ǥ亮��¹̼�Ƚ���Ǥ��롣"))

(define (gregor-ench knpc kpc)
  (quest-data-assign-once 'questentry-calltoarms)
  (say knpc "��ƻ�դϸ��Ԥΰ�ͤ���"
       "�亮�ˤ��ʤ��Τ褦���¤��ͤ�õ���褦�˸��äƤ�����"
       "��ƻ�դβ���Ƴ���ͤФʤ�̡�ƻ����Τꤿ������")
  (quest-wise-subinit 'questentry-enchanter)
  (quest-data-update 'questentry-enchanter 'common 1)
  (cond ((yes? kpc)
         (quest-data-update 'questentry-calltoarms 'directions 1)
         (quest-data-update 'questentry-enchanter 'general-loc 1)
         (say knpc "��ƻ�դ����λ��θ������ˤ���¤���ˤ��롣"
	      "��ؿʤߡ�����ƻ�򤿤ɤꡢ��ˤ����������˿Ҥͤ�Ȥ褤������")
	  )
         (else 
          (say knpc "����˾��ʤ顣���������ɬ�פˤʤä��顢����ƻ�աפȿҤͤʤ�����")
          )
        ))

(define (gregor-cave knpc kpc)
  (say knpc "����ƻ����������ʬ���줿�٤�ƻ�򤿤ɤä�����ʤ�����"
       "������Ȣ�򳫤������ʪ���äƤ������졣"
       "�ޤ�����ʹ���������Ȥ�����С���äƤ����ä�����"))

(define (gregor-ches knpc kpc)
  (say knpc "���Τޤ޿ʤ�ǡ����������ʪ���äƤ������졣"))

(define (gregor-stuf knpc kpc)
  (say knpc "¼�μԤ�����ʪ�򤷤���롣�ޤ����Ĥ������¤��ͤ����ȹͤ��Ƥʡ�"))

(define (gregor-leav knpc kpc)
  (say knpc "������Υ�줿���ʤ顢����ƻ����ؿʤ�Ф褤��"))

(define (gregor-band knpc kpc)
  (let ((quest (gregor-quest (kobj-gob-data knpc))))
    (cond ((quest-accepted? quest)
           (say knpc "��±�ɤ�Τͤ���ϸ��Ĥ��ä�����")
           (cond ((yes? kpc)
                  (say knpc "�Ť������衢���դ��ޤ���")
                  (quest-done! quest #t)
                  )
                 (else 
                  (say knpc "�Ф���عԤ�����±�ˤĤ���ʹ���Ȥ褤������")
                  )))
          (else
           (say knpc "��±�ɤ⤬������ˤ���Τ���"
                "��Ĥ�Ϥ��Ĥƥ亮�ξ�����Ӥ餷���褿���Ȥ����롣"
                "�亮�Ϥ�Ĥ����ä�����"
                "���Τ�����­�������ʤ�󤬤���褦�ˤʤä���")
           (prompt-for-key)
           (say knpc "�����亮�ˤϰ��˽���Ǥ���¹̼�����롣"
                "�ޤ������ʻҶ�����������ʤ��Ȥϰ�����Ĥ�Ϥ������ʤ�����"
                "��Ĥ餬�ޤ���뤳�Ȥ򶲤�Ƥ��롣")
           (prompt-for-key)
           (say knpc "���Τ褦�ʤ��Ȥ���ߤ����Ϥʤ������������Ĥ��¤��ͤ�¼�μԤ��������ʹ�����亮������Ƥ�����������")
           (cond ((yes? kpc)
                  (say knpc "���꤬�Ȥ���"
                       "�������ä��ʤ顢�Ф���عԤ��Ȥ褤������"
                       "��������±�Τ��Ȥ�Ҥͤ��"
                       "���꤬ʬ���뤫�⤷���")
                  (quest-data-assign-once 'questentry-bandits)
                  (quest-accepted! quest #t)
                  )
                 (else
                  (say knpc "������ᤷ�����˵�ä�����")
                  (kern-conv-end)
                  ))))))

(define (gregor-bye knpc kpc)
  (let ((quest (gregor-quest (kobj-gob-data knpc))))
    (cond ((quest-accepted? quest)
           (say knpc "����Ĥ���Τ�����"))
          (else
           (say knpc "�ԤäƤ��졪��ߤ�����Τ���")
           (prompt-for-key)
           (gregor-band knpc kpc)
           ))))

(define (gregor-fore knpc kpc)
  (say knpc "���ο����Ȥ���˹ԤäƤϤʤ�̡���±�����⡢��������Τɤ⤬���롣"))

(define gregor-conv
  (ifc basic-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default (lambda (knpc kpc) (say knpc "����ϼ�����Ǥ���ʡ�")))
       (method 'hail gregor-hail)
       ;;(method 'heal (lambda (knpc kpc) (say knpc "�γ��Ф餤��¹̼�Ϥ褯�����äƤ���Ƥ��롣")))
       (method 'bye gregor-bye)
       (method 'job (lambda (knpc kpc) (say knpc "�亮��ú�Ƥ��ͤ��������Ƥ��κ��Ťδ����⤷�Ƥ��롣")))
       (method 'join (lambda (knpc kpc) (say knpc "�����䡢�亮�ˤ��̤λŻ������롣")))
       (method 'name (lambda (knpc kpc) (say knpc "�亮��̾�ϥ��쥴�������")))

       (method 'open gregor-open)
       (method 'get  gregor-get)

       (method 'cave gregor-cave)
       (method 'ches gregor-ches)

       (method 'stuf gregor-stuf)
       (method 'equi gregor-stuf)  ;; A synonym
       (method 'gear gregor-stuf)  ;; A synonym

       (method 'read gregor-read)
       (method 'dang gregor-dang)

       (method 'camp gregor-camp)
       (method 'kamp gregor-camp) ;; A synonym

       (method 'band gregor-band)
       (method 'leav gregor-leav)

;; SAM -- This response seems to be shadowed by the gregor-band declaration above?
       (method 'band (lambda (knpc kpc) (say knpc "A band of rogues been raiding the shrine "
                                             "when I'm not around. They haven't attacked me, "
                                             "so they're probably just vagabonds, "
                                             "afraid of an old man's cudgel.")))

       (method 'char gregor-charcoal)
       (method 'burn gregor-charcoal)  ;; A synonym

       (method 'daug (lambda (knpc kpc) (say knpc "������̼�Ϥ��Ⱦ�������ƤΤ褦������ˤʤ줿��"
                                             "��ǽ�Ϥ��ä�������ʬ�˸��ԤȤ����ʤ��ä���")))
       (method 'dead gregor-dead)
       (method 'ench gregor-ench)
       (method 'folk (lambda (knpc kpc) (say knpc "���Ȼ������Ȥ�����ФäƤ���Τ���")))
       (method 'fore gregor-fore)
       (method 'wood gregor-fore)
       (method 'gate (lambda (knpc kpc) (say knpc "���줬���ĳ����Τ���"
                                             "�����Ƥ�����˲�������Τ��ϡ�ï��ʬ����̡�"
                                             "���������ˤ��̤��礬�����ʹ�������Ȥ����롣"
                                             "�������������äϱ��Τ�˺����Ƥ��ޤä���")))
       (method 'gran (lambda (knpc kpc) (say knpc "�亮�ˤϥ��ꥢ�Ȥ���̾��¹̼�����롣")))
       (method 'help (lambda (knpc kpc) (say knpc "¼�ˤϤ��Ĥ��������Ƥ���Ԥ����롣"
                                             "���������Ѥʾ��ǡ��������Ѥʻ�������")))
       (method 'hill (lambda (knpc kpc) (say knpc "�ȥ��ɤ�Ͼ�˵֤򶼤����Ƥ�����"
                                             "���ΤȤ�����äˤ�������")))
       (method 'husb (lambda (knpc kpc) (say knpc "̼̻�Ϥ��������פ��ä���"
                                             "�ʤ��ȥ��ɤ�˽���줿�Τ���ʬ�����"
                                             "�⤷������Ȥ�Ĥ�ϲ��Ԥ��˵֤��ɤ�줿�Τ����Τ�̡�")))
       (method 'hut gregor-hut)
       (method 'ilya (lambda (knpc kpc) (say knpc "���������ϰ��˽���Ǥ��롣"
                                             "���λҤ�ξ�Ƥϻ��Ǥ��ޤä���")))

;; SAM: I dont' see any reference to this lake anywhere, commenting this one out for now...
;;       (method 'lake (lambda (knpc kpc) (say knpc "Exit this shrine and ye'll find yourself in a "
;;                                             "hidden valley. Head south and you'll see the Gray Lake "
;;                                             "to the west.")))

       (method 'offe (lambda (knpc kpc) (say knpc "����ƶ�������Ȣ�����롣"
                                             "�����椫���äƤ������졣�¤��ͤϤۤȤ��ʪ��������ˤ��������ˤ��롣"
                                             "�����ƴ��ͤ��Ϥ��Ф餷���Ԥ��򤷤���"
                                             ""
                                             "������¼�μԤ����ϼ��Τ����ʪ���֤��Ƥ����Τ���")
                                             (quest-data-update 'questentry-whereami 'wanderer 2)
       										))
       (method 'pare gregor-dead)
       (method 'plac gregor-hut)

       (method 'shar (lambda (knpc kpc) (say knpc "�����ɡ������Ϥ�亮��Ϥ����Ƥ�Ǥ��롣�¤��ͤ衣")
       				(quest-data-update 'questentry-whereami 'shard 1)
       			))

       (method 'shri (lambda (knpc kpc) (say knpc "���κ��Ť�����̤äƤ���ԤΤ���ˤ��롣"
                                             "���ʤ��Τ褦���¤��ͤΤ���ˤ���"
                                             "¼�μԤ����ϡ����ʤ���ι��ɬ�פ�ʪ�򶡤�ʪ�Ȥ����֤��Ƥ����Τ���")
                                             (quest-data-update 'questentry-whereami 'wanderer 1)
       											))

       (method 'spid (lambda (knpc kpc) (say knpc "���α��ˤϲ�ʪ�Τ褦�ʥ��⤬���롣��ͺ��ۤɤ��礭������"
					     "���󥰥ꥹ�λҶ��������亮��Ϥ����Ƥ�Ǥ��롣")))
       (method 'angr (lambda (knpc kpc) (say knpc "�����θ�����������"
					     "�������ƤΥ�����졢"
                                             "�Ҷ�����ݤ��餻���Ҷ�����������ʤ��ͤˤ��뤿��Τ�Τ���")))

       (method 'town (lambda (knpc kpc) (say knpc "�ȥꥰ�쥤�֤����ֶᤤĮ����"
					     "���ƻ�˱�äƤ������¤����ȤϤʤ�������")))

       (method 'trol (lambda (knpc kpc) (say knpc "�ȥ���¼�μԤ򿩤���"
					     "�����ꡢ��ο�ޤǿ��äƤ��ޤ��Τ���"
					     "��ˤϲ���Ĥ���Ƥ��ʤ��ä���")))

       (method 'wand (lambda (knpc kpc) (say knpc "�亮�������̤ä����Ԥ��¤��ͤȸƤ�Ǥ��롣"
                                             "���μԤ������ɤ�������ơ��ɤ��عԤ��Τ���ï���Τ�̡�"
                                             "���ʤ��Ϥ���Ĺ����Ĺ��ƻ�Τ�ν��ˤ���Τ���")
                                             (quest-data-update 'questentry-whereami 'wanderer 1)
       										))

       (method 'wise (lambda (knpc kpc) (say knpc "���Ԥ϶����������ƤۤȤ�ɤ������Ԥ���"
                                             "���ϤǤ�����¤ꤳ���Ϥ������"
					     "�����Ƽ���줿�Ԥ��������äƤ��롣")))
       (method 'accu (lambda (knpc kpc) 
                       (say knpc "����줿�ԡ����蘆�Ǥ��ϤΤ���˺�����ä��餷����"
                            "�⤷���Ԥ����ʤ���С����Υ����ɤϤ�Ĥ��Ƨ�ߤˤ�����˰㤤�ʤ���")))

       (method 'witc (lambda (knpc kpc) (say knpc "���ǤϤ����ն�Ǥ�����Ϥ��ʤ��褦����")))
       ))

;;----------------------------------------------------------------------------
;; Ctor
(define (mk-gregor)
  (bind 
   (kern-mk-char 'ch_gregor ; tag
                 "���쥴����"        ; name
                 sp_human            ; species
                 nil                 ; occ
                 s_old_townsman          ; sprite
                 faction-men         ; starting alignment
                 0 10 5              ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 2  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'gregor-conv        ; conv
                 sch_gregor          ; sched
                 'townsman-ai                 ; special ai
                 nil                 ; container
					   (list t_axe
					         t_armor_leather
					         )              ; readied
                 )
   (gregor-mk)
   ))
