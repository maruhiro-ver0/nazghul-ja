;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define silas-lvl 8)
(define silas-species sp_human)
(define silas-occ oc_wizard)
(define shrine-path-x 97)
(define shrine-path-y 5)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; �ť��֥���å�
;;----------------------------------------------------------------------------
(define silas-bed oa-bed1)
(define silas-mealplace oa-tbl3)
(define silas-workplace oa-temple)
(define silas-leisureplace oa-baths)
(kern-mk-sched 'sch_silas
               (list 0  0 silas-bed          "sleeping")
               (list 7  0 silas-mealplace    "eating")
               (list 8  0 silas-workplace    "working")
               (list 12 0 silas-mealplace    "eating")
               (list 13 0 silas-workplace    "working")
               (list 18 0 silas-mealplace    "eating")
               (list 19 0 silas-leisureplace "idle")
               (list 22 0 silas-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (silas-mk) 
  (list #f (mk-quest) #f))
(define (silas-set-will-help! gob) (set-car! gob #t))
(define (silas-will-help? gob) (car gob))
(define (silas-quest gob) (cadr gob))
(define (silas-met? gob) (caddr gob))
(define (silas-set-met! gob) (set-car! (cddr gob) #t))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; �����饹�ϼ���줿�Ԥΰ����������λ�Ƴ�ԤǤ��롣
;; ������ܤ��٤��Ϥ���ä���ѻդǤ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (silas-hail knpc kpc)
  (if (silas-met? (kobj-gob-data knpc))
      (say knpc "�ޤ���ä��ʡ��¤��ͤ衣")
      (begin
        (silas-set-met! (kobj-gob-data knpc))
        (say knpc "�Τ��ʤ���̥��Ū��Ϸ�ͤȲ�ä����Ϥ褦������ι������"
             "��ιͤ��㤤�Ǥʤ���С������¤��ͤǤ������ɤ����͡�")
        (if (yes? kpc)
            (say knpc "�������Ȼפä��������ԤäƤ����衣")
            (say knpc "��������餫�ˤ��ʤ��θ������Ȥ򿮤��Ƥ��ʤ�����"
                 "��������¿������ʤ��Τ��ʡ�"
                 "���äȷ����ԤäƤ�����")))))

(define (silas-default knpc kpc)
  (say knpc "��ǰ��������ϼ�����Ǥ��̡�"))

(define (silas-name knpc kpc)
  (say knpc "���顣��ϥ����饹����"
       "���ϡ�ͧ�衢���鷺�Ȥ�褤��"))

(define (silas-ask-help knpc kpc)
  (cond ((yes? kpc)
         (say knpc "����������ʹ������Ӥ����ɽ�����Ȥ��Ǥ��ʤ���"
              "�������¦�ˤĤ������Ȥǡ������ɤ˴�˾�Ȱ���ο����������⤿�餹���Ȥ��Ǥ��������"
              "�����ϤǤ��Ƥ��뤫���������٤����Ȥ����롣")
         (silas-set-will-help! (kobj-gob-data knpc))
         (make-allies knpc kpc)
         )
        (else
         (say knpc "���ΤޤޤǤ������ϵ��路������"
              "���ʤ��Ǻ�����Ԥ����ͤФʤ�ʤ���"
              "��ǰ���������ΤäƤ��������"
              "�����¤��ͤ������ΤϾ����ˤ��Ѥ��Ȥ��Ǥ��ä���"
              "�¤��ͤιԤ��Ĥ��뤤�ϹԤ�ʤ����ȡĤ����Ȥ��Ƥ��θ�ο�ɴǯ�α�̿���᤿�Τ���")
         )))

(define (silas-join knpc kpc)
  (say knpc "����ϾФä����ϼºݡ���������֤˲ä��褦����������Ĥ����ä���"
       "����ܤ����ˤ϶ˤ�ƺ���ʻŻ������롣�����������Ϥȶ��ˤ���������뤲����Ǥ�����"
       "��μ�����򤷤Ƥߤ̤���")
  (silas-ask-help knpc kpc)
  )

(define (silas-job knpc kpc)
  (say knpc "�����ɸ�Ϥ��Υ����ɤ˿�������������⤿�餹���Ȥ���"
       "¿���ξ㳲��������ˤϲ�����äƤ��롣"
       "�����Ƥ�����Ū�Τ���ˤϺ�ǽ����Ԥ�ɬ�פ���"
       "�¤��ͤ衣��μ�����򤷤Ƥߤ̤����������ʤ���������뤲���ʤ���")
  (silas-ask-help knpc kpc)
  )

(define (silas-help knpc kpc)
  (say knpc "��μ�����򤷤Ƥߤ̤���")
  (silas-ask-help knpc kpc)
  )

(define (silas-bye knpc kpc)
  (say knpc "���褦�ʤ顢�¤��͡������ƹ�����"))

;; Tier 2
(define (silas-expe knpc kpc)
  (say knpc "�������������褿���Ȥ�ʹ���Ƥ�����"
       "�٤����ᤫ�췯������뤳�ȤϤ狼�äƤ�����"
       "�¤��ͤ���ˤˤĤ��Ƥ�������Ĵ�����Ƥ��롣"))
(define (silas-hist knpc kpc)
  (say knpc "�Ͼ�ο޽�ۤϾƤ��������Ⱦ�ε�Ͽ�������Ƥ��ޤä���"
       "�¤��ͤε�Ͽ�Ϥ����ˤ���鷺�����ܤ˻ĤäƤ�����������Τ�̡�"
       "�����Ƭ�򿶤ä�����"))
(define (silas-wand knpc kpc)
  (say knpc "���Ƥ��¤��ͤϺ��Ť�����̤ä��褿�����Τ褦�ˤ����������̤��礬���뤳�Ȥ��ΤäƤ��뤫�͡�")
  (if (yes? kpc)
      (say knpc "�褯�狼�äƤ���ʡ������������Τ��Ȥ���")
      (say knpc "����ϳΤ���¸�ߤ��롣�������Ȥ����Τ��Ƥ����Τ���")))

(define (silas-demo knpc kpc)
  (say knpc "���Ρ��������ϥ����ɤ��̤���������Ǥ�����"
       "������Τȿ���β������ǡ�"
       "��ѻդ����Ϥ����������̤�������ͳ�˹Ԥ��褷"
       "�μ���ʪ��ͭ���Ƥ�����")
  (prompt-for-key)
  (say knpc "�������ǽ�Ū�ˤ����꤬������Ϥ᤿��"
       "�����̤������μԤ������ȤäƼ����ʼ��ư������¾���������Ϥ᤿�Τ���"
       "�����ɤ˿ʹ�����뤳�Ȥ򶲤줿��ѻդ����ϡ���������Ȭ�Ĥ�������ܤ�"
       "Ȭ�Ĥ�ʬ����줿�����뤳�Ȥˤ�����"))

(define (silas-key knpc kpc)
  (if (any-in-inventory? kpc rune-types)
      (say knpc "���Ϸ������äƤ���褦�����̤����Ǥ���")
      (say knpc "�������̤����Ǥ�����ǰ���������Ϥ��λ���˼����Ƥ��ޤä���")))

(define (silas-rune knpc kpc)
  (say knpc "�����Ū�Τ������Ƥμ���줿���Ǥ����ᤵ�ʤ���Фʤ�ʤ���"
       "���˰�������ʱ���������뤳�Ȥ����򤷤��Ȥ��Ƥ⡢"
       "���Ǥι������Τꡢ�����ư����˴������ʤ���Фʤ�ʤ���Ʊ�դ��뤫�͡�")
  (if (yes? kpc)
      (say knpc "�������������ϤޤäȤ������ˤǤ�����")
      (say knpc "�������ͤ��Ƥߤ衣�⤷���Ǥ��������Ԥμ��������顢"
           "�⤷�����ɤ���ͤФʤ�ʤ��Ȥ����褿�顢"
           "�⤷�̤������ν�����ɬ�פˤʤä��Ȥ����顩"
           "��������褷�Ƴ�����Ĥ�꤬�ʤ��Ȥ��Ƥ⡢����褬����ΤϤ褤���Ȥ�����")))

;; Accursed, Wise
(define (silas-accu knpc kpc)
  (say knpc "����ϾФä����Ϥ����̤ꡣ��ϼ���줿�Ԥ���"
       "��ǰ�ʤ��Ȥˡ������¿���μԤ����ΰ���Ū�ʶ��ۤ��餭���Ƥ�̾����"
       "�������������äˤϲ桹�γ�ư���ؤ�äƤ���Ȥ���Ƥ��롣"
       "��Ϥ��������Ƶ�������Ǹ����롣"
       "�������桹�ο��ιԤ������������ȤǼ�����۸�򤹤뤳�ȤϤǤ��ʤ���"
       "�桹�Ϥߤ���̩�����äƤ��뤫�����"))

(define (silas-secr knpc kpc)
  (say knpc "����줿�Ԥζ����ϳ����μԤˤ���̩�ˤ������Ƥ��롣"
       "�����ƶ򤫤ʼԤ��ޤͤ褦�Ȥ��뤳�Ȥ��ɤ��Ǥ��롪"
       "�����Ǵ���������̵�ΤʼԤˤ�̵�ѤΤ�Τ���"
       "�����Ǹ����褦������ϲ����Τ�ʤ��͡��򴬤������ΤǤϤʤ���"))

(define (silas-wise knpc kpc)
  (say knpc "�������������������븭�ԡ������ΤäƤ���Ǥ�����"
       "����º�ɤ��٤��������Ʋ��ͤΤ��������ΰ�Ĥ������ʤ��Ȥ�᤮�����β��ͤ��������Ǥ��ä���"
       "�Τ���©�Ϻ����θ��Ԥϥ����ɤ���ź�������Ǥʤ���˸���ˤ�ʤäƤ��롣"
       "���֥���åȤǤιԤ���ͤ��Ƥߤ��ޤ���"))
 
(define (silas-absa knpc kpc)
  (say knpc "���ʤ鷯�ϴְ㤤�ʤ����򤷤Ƥ��������"
       "��ƻ�ա��桹�ζ����˴ְ�ä��ʤߤ���ļԤϼ���줿�Ԥ��Ǥܤ����Ȥ˿���å���Ƥ��ꡢ"
       "���饹�ɥ��������Ԥ��Ϥ˵�����������̴�������Ƥ��롣"
       "����ϥ����ɤ�Į���İ���������뤫�Ǥܤ��Ĥ�����"
       "���֥���åȤϺǤ��Թ�Τ褤�ǽ����ɸ���ä��˲᤮�ʤ���"
       "����ϴ�ñ�˾ڵ����夲��¾��Į����ƻ�դ��˲�����褦�⤭��������"
       "����ΤäƤ��̤����"))

;; Philosophy
(define (silas-evil knpc kpc)
  (say knpc "���Ȥ������ϲ��ʤΤ���ǰ�Τ���˸���������ϰ���¸�ߤ��ʤ��ȸ��äƤ���ΤǤϤʤ���"
       "�������Ȥϲ����Ȥ�������ޤǤη��δ�ǰ���䤦�Ƥ���Τ���"
       "�⤷���ҤΤ���Ԥ��桹�˲������Ǥ��뤫����ä��ʤ�С��桹�Ϥ��θ��դ򤽤Τޤ޼��������٤���������"
       "�桹�Ȥϰ㤦���ҤΤ���Ԥ����ϡ���鼫�Ȥ���Ū������ΤǤϤʤ�����"
       "�������ư�ϡ������ǧ��褦��ǧ��ޤ��ȡ��ơ�������Ū��ư���˴�Ť��Ƥ��롣")
  (prompt-for-key)
  (say knpc "�����Ƽºݤˡ��¤��ͤ衢��������٤��ʤΤ���"
       "���ƤμԤϼ��Ȥ����פΤ�����臘�٤��������줬�����ʿ����񤤤Ǥ��롣"
       "�ͤϳ���ȴ���Ф����Ȥ��Ǥ��ʤ�������ζ�ʤΤ���"
       "���������ݤ��뤳�Ȥϼ������ݤ��뤳�ȤǤ��ꡢ"
       "��ʬ�����פ��¾�Ԥ����פ�ͥ�褹�٤��Ȥ����ͤ��ϡ����ƶ�������ή�������Ǥ��롣"))

(define (silas-good knpc kpc)
  (say knpc "���ˤĤ��ƿҤͤƤ���ʤ�������褦�����������ߤ��Ƥ����Τϲ�����"
       "ʪ�����ߤ���Ԥ����ƽ��Ʋ��ͤ���ġ�"
       "�����դ˿ͤ��ߤ��뤳�Ȥϰ��Ǥ��뤫�Τ褦�ˡ���˾���ޤ���������褦�������Ƥ��롣"
       "����������εդǤ��롪"
       "���˽������̩�򶵤��褦�������μԤ�������˾�ϡ�¾�μԤ�������˾�򲡤������ळ�Ȥ���"))

(define (silas-desi knpc kpc)
  (say knpc "���������������Τ�ư�����褦�ˡ���˾������ư������"
       "��˾���ʤ���к���̵���ϤǶ�������"
       "����줿�Ԥ������ϡ��ʤ���˾���Ĥޤ��ˤ��������Ƥ����ˤ������Ƥ��Ҥ�����ͤΤ����Τϲ������Τ뤳�Ȥ���"))

(define (silas-sacr knpc kpc)
  (say knpc "����줿�Ԥζ����Ǥϵ�������˾�ΤϤ����Ǥ��롣"
       "������������򤱤��ʤ���̤������Ƥ��ˤ��뤳�ȤϤǤ��ʤ���"
       "������˾�μ¸����ܻؤ��ʤ顢¾�β�ǽ���ϼ����롣"
       "�ڤλޤ��Ϥ��ߤˤ�ä��ڤ���Ȥ����褦�ˡ������ιԤ���λ�ʬ�����������٤��ڤ���Ȥ���롣"
       "���줬�桹�ε�������ǽ�����ڤλޤ򴢤뤳�ȡ��ΰ�̣����"))

;; People
(define (silas-ench knpc kpc)
  (say knpc "�ब���Τ褦�ʼ���줿�Ԥ�Ũ�Ǥ��뤳�Ȥϻ�ǰ����"
       "�������ब�Ť���ͻ�̤��������������ư��ٰ��ȷ�᤿��ΤϿ�����Ƿ褷���Ѥ��ʤ����Ȥ������Ȥ��϶���Ƥ��롣"
       "�Թ��ʤ��Ȥ�������Ȱ��δ�ǰ�ϸ�äƤ��ꡢ���ļ¸��Բ�ǽ����"))

(define (silas-deni knpc kpc)
  (say knpc "�ǥ˥��Ͽ����ܤ�����Ψľ�˸��ä������Ϥ˷礱��㤤�ˤ���"))

(define (silas-sele knpc kpc)
  (say knpc "����ͤϺ�ǽ�Τ���㤤��������"
       "�Թ��ʤ��Ȥˡ�������Ϥ�˰���ʤ��ĵԤ��˾���ް�����Ƥ��롣"))
 
;; Quest-related
(define (silas-ques knpc kpc)
  (let* ((gob (kobj-gob-data knpc))
        (quest (silas-quest gob)))

    (define (has-all-runes?)
      (all-in-inventory? kpc rune-types))

    (define (missing-only-s-rune?)
      (all-in-inventory? kpc
                         (filter (lambda (ktype)
                                   (not (eqv? ktype t_rune_s)))
                                 rune-types)))

    (define (give-last-rune)
      (say knpc "�Ǹ�ΰ�Ĥ�������Ƥ����Ǥ���äƤ���褦���ʡ�"
           "���������٤��Ƥ������Ȥ�������ߤ������Ǹ�ΰ�Ĥϻ䤬���θť��֥���åȤ˱������Τ���"
           "����򸫤Ĥ���Τ����κǸ�λ������ȹͤ��Ƥ��졣")
	(quest-data-update-with 'questentry-rune-s 'silasinfo 1 (quest-notify nil))
	(quest-data-assign-once 'questentry-rune-s)
	)

    (define (continue-quest) 
      (say knpc "�Ǹ�ΰ�Ĥ����Ĥ���ʤ��褦���ʡ��¤��ͤ衢��������ʡ�"
           "���Ԥ˿Ҥ͡���ʥ��õ�ꡢ�󤯹���õ���Τ���"))

    (define (end-quest)
      (quest-done! quest #t)
      (say knpc "�褯��ä����¤��ͤ衣����줿���ǡ�����αɸ��λ�������Ƥ���ä���"
           "�����ˤ褯��ä���")
      (prompt-for-key)
      (say knpc "�������Ƥ����Ǥ���ä����������ݴɤ���ʤ���Фʤ�ʤ���"
           "���������ո��Ǥ��ޤʤ�������ϸ��Ԥ����Ǥδ������ѤǤ��ʤ���"
           "��ƻ�ռ��ȤǤ�������������")
      (prompt-for-key)
      (say knpc "��������ͤ��Ƥ��뤫�Ϥ狼�롢ͧ�衢���������ǤϤʤ���"
           "�����ǻ䤬�������뤳�Ȥʤ�����Ǥ��ʤ���������˾��Ǥ⤤�ʤ���"
           "�����ǤϤʤ�����ä������ʹͤ�������Τ���")
      (prompt-for-key)
      (say knpc "�¤��ͤ衣�ʤ�٤������褿��"
           "���Τ���˷��������ɤ˸ƤФ줿�Τ��Ȼ�ϻפäƤ��롣"
           "�����˼�ꡢ���õ��������������򤯡����θ������ˤ����Τ����̤��롣"
           "ͦ���򼨤��������ƿ�����������褬���Ȥʤ�Τ�����äƤ���뤫��")
      (if (yes? kpc)
          (say knpc "�ʤ�и��ԤˤⱣ���줿�������̩�򶵤��褦�����Ϥޤ������Ƥ��롢����Ũ��Ʊ����"
               "�������򸫤뤫�Ϥ狼��ʤ������������Τ��ȤϤ狼�äƤ��롧����Ũ���������������")
          (say knpc "����ϸ�����Ȥ������Ϥ���Ϸ����餦�٤����ȤǤϤʤ����¤��ͤ衢���Ϥ��������Τ褽�Ԥ���"
               "���ʤ��Ȥ⡢���ϰ������ݴɤ��Ƥ����ʤ����������ͤ����Ѥ���Ĥ�꤬�ʤ��ΤǤ���С�")))
           
    (define (offer-quest)
      (say knpc "�¤��ͤ衣�������٤��Ǥ���פʻŻ������롣"
           "����������������Ȭ�Ĥθ������Ǥ�õ������äƤ���뤫��")
      (if (yes? kpc)
          (begin
            (quest-accepted! quest #t)
            (cond
            	((has-all-runes?)
            		(say knpc "���Ǥ����Ǥ���äƤ���ʡ�")
            		(prompt-for-key)
            		(end-quest)
            		)
            	((missing-only-s-rune?)
            		(give-last-rune))
            	(#t
            		(say knpc "���ˤʤꤽ���ʼԤ��ΤäƤ��롣�Ǥ⸭���ˡ����ѡ�����ϣ��ѻդ���"
            		"�⤷������Ȥ��Ǥ�����ΤäƤ��뤫���Τ�ʤ�����"
            		"���ǽ�˿Ҥͤ�Ȥ褤������"))
             ))
          (say knpc "����򸫤Ĥ���Τϲ桹�ε�̳������˾������ͧ�衣"
               "���������ˤϷ�����ͳ�����뤳�Ȥϵ���ʤ���")))

    (if (silas-will-help? gob)
        (if (quest-done? quest)
            (say knpc "��������õ����")
            (if (quest-accepted? quest)
                (if (has-all-runes?)
                    (end-quest)
                    (if (missing-only-s-rune?)
                        (give-last-rune)
                        (continue-quest)))
                (offer-quest)))
        (say knpc "�����֤ˤʤ�ʤ����������ˤ�¿���Τ��٤����Ȥȱɸ������롣"
             "���Ϥ��������ǺǤ�̾�⤤�¤��͡ĥ����ɤǺǤ����ʱ�ͺ�Ĥˤʤ��Ǥ�����"))
    ))

(define (pissed-off-silas knpc kpc)
  (map (lambda (tag)
         (if (defined? tag)
             (let ((kchar (eval tag)))
               (if (is-alive? kchar)
                   (begin
                     (kern-being-set-base-faction kchar faction-accursed)
                     (kern-char-set-schedule kchar nil)
                     )))))
       (list 'ch_silas 'ch_dennis 'ch_selene))
  (make-enemies knpc kpc)
  )

(define (silas-noss knpc kpc)
  (say knpc "�����ɽ�����Ĥ�������ͧ�衢�ɤΤ褦�ˤ��Ƥ���̾���Τä���")
  (kern-conv-get-reply kpc)
  (say knpc "¾�μԤ����ˤ⤽�Τ褦���̤��ޤ�äƤ���Τ���")
  (if (yes? kpc)
      (say knpc "���Ȥ������Ȥ�����ǰ���������̤��Ȥ����褿�褦����")
      (say knpc "�����Ǥ��������ιԤ���̵��ˡ�ǡ������ƺ��Ͼ����ʱ���Ĥ��Ƥ��롣"
           "���Ϥ����Ǥϴ��ޤ���ʤ���"
           "�������˵��ʤ�����"))
  (pissed-off-silas knpc kpc)
  (kern-conv-end)
  )

(define silas-conv
  (ifc basic-conv

       ;; basics
       (method 'default silas-default)
       (method 'hail silas-hail)
       (method 'bye  silas-bye)
       (method 'job  silas-job)
       (method 'name silas-name)
       (method 'join silas-join)

       (method 'absa silas-absa)
       (method 'accu silas-accu)
       (method 'demo silas-demo)
       (method 'deni silas-deni)
       (method 'denn silas-deni)
       (method 'desi silas-desi)
       (method 'ench silas-ench)
       (method 'evil silas-evil)
       (method 'expe silas-expe)
       (method 'gate silas-demo)
       (method 'good silas-good)
       (method 'help silas-help)
       (method 'hist silas-hist)
       (method 'key  silas-key)
       (method 'keys silas-key)
       (method 'noss silas-noss)
       (method 'ques silas-ques)
       (method 'rune silas-rune)
       (method 'sacr silas-sacr)
       (method 'secr silas-secr)
       (method 'sele silas-sele)
       (method 'task silas-job)
       (method 'wand silas-wand)
       (method 'wise silas-wise)
       ))

(define (mk-silas)
  (bind 
   (kern-mk-char 
    'ch_silas           ; tag
    "�����饹"          ; name
    silas-species         ; species
    silas-occ              ; occ
    s_silas     ; sprite
    faction-men      ; starting alignment
    0 5 0            ; str/int/dex
    2 1              ; hp mod/mult
    2 1              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
	0
    silas-lvl
    #f               ; dead
    'silas-conv         ; conv
    sch_silas           ; sched
    'spell-sword-ai  ; special ai
    nil              ; container
    (list t_stun_wand) ; readied
    )
   (silas-mk)))
