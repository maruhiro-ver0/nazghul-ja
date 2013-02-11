;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define enchanter-start-lvl 8)

;;----------------------------------------------------------------------------
;; Schedule
;;
;; ��ƻ�դ����1��
;; 
;; (��ϼ�ʬ�����2����ˬ��뤳�ȤϤʤ���������ϻ䤿����ʣ���ξ��Υ�������
;; ����򤤤���Ϻ��ʤ���Фʤ�ʤ��Ȼפ碌��ư���դ��ˤʤäƤ��� :-)
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_enchanter
               (list 0  0  enchtwr-ench-bed        "sleeping")
               (list 8  0  enchtwr-dining-room-2   "eating")
               (list 9  0  enchtwr-hall            "idle")
               (list 12 0  enchtwr-dining-room-2   "eating")
               (list 13 0  enchtwr-hall            "idle")
               (list 19 0  enchtwr-dining-room-2   "eating")
               (list 20 0  enchtwr-bedroom-1       "idle")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (enchanter-mk)
  (list #f 
        (mk-quest) ;; get stolen rune
        (mk-quest) ;; learn the purpose of the runes
        (mk-quest) ;; get all runes
        (mk-quest) ;; open demon gate
        ))
(define (ench-met? gob) (car gob))
(define (ench-first-quest gob) (cadr gob))
(define (ench-second-quest gob) (caddr gob))
(define (ench-quest gob n) (list-ref gob n))
(define (ench-met! gob val) (set-car! gob val))

;;----------------------------------------------------------------------------
;; Conv
;;
;; ��ƻ�դ��ϤΤ�����ѻդǡ����Ԥΰ�ͤǤ��롣
;; �����ƻ�դ���˽���Ǥ��롣
;; ��ϼ��פ�������¿���ǽ��פ�����餸�롣
;;----------------------------------------------------------------------------
(define (ench-hail knpc kpc)
  (let ((ench (gob knpc)))

    ;; Fourth Quest -- open the demon gate
    (define (check-fourth-quest)
      (say knpc "�������ξ��Ϥ狼�ä�����")
      (if (yes? kpc)
          (begin
            (say knpc "�ʤ�����Ǥθ��ǳ�������ϸ��Ĥ��ä�����")
            (if (yes? kpc)
                (say knpc "�ʤΤˤ��Τ�����򤦤�Ĥ��ƻ��֤�̵�̤ˤ��Ƥ���Τ���")
                (say knpc "����϶��餯�����κ��ŤΤ褦�ʤ�ΤǤ�����"
                     "�����ϱ����졢�⤷������ȰŹ�ǻѤ򸽤����⤷��ʤ���"
                     "����줿�Ԥ�õ��Ĵ�٤衣���ϼ꤬������ΤäƤ���˰㤤�ʤ���")))
          (say knpc "���֥���åȤο޽�ۤ�褯õ���Τ���")))

    ;; Third Quest -- find all the Runes
    (define (finish-third-quest)
      (say knpc "���Ǥ����Ƹ��Ĥ����Τ��ʡ�"
           "���ࡢ���ξ�ʤ�������ä��Ǥ�����")
      (prompt-for-key)
      (say knpc "�Ǹ��Ǥ̳����"
           "��������õ���Ф��������Ƥӳ����ͤФʤ�ʤ���"
           "���Ϥ狼�äƤ��뤫��")
      (if (yes? kpc)
          (say knpc "�򤬲���ľ�̤��뤫�Ϥ狼��̡�"
               "���ȤǤ褯�����衣"
               "�����������֤ˤʤ�ۤɤζ򤫼Ԥ�Ϣ��Ƥ椱��")
          (say knpc "����줿�Ԥ������ΤäƤ����˰㤤�ʤ���"
               "���֥���åȤο޽�ۤˤϤޤ��꤬���꤬�ĤäƤ��뤫���Τ�̡�"
               "�褯Ĵ�٤�Τ���")
          )
      (quest-done! (ench-quest ench 3) #t)
      (kern-char-add-experience kpc 100)
      (quest-accepted! (ench-quest ench 4) #t)      
      )

    (define (check-third-quest)
	(define (missing-only-s-rune?)
		(all-in-inventory? kpc
                         (filter (lambda (ktype)
                                   (not (eqv? ktype t_rune_s)))
                                 rune-types)))
	(cond			 
		((has-all-runes? kpc)
		(finish-third-quest)
		)
		
		((missing-only-s-rune? kpc)
		(say knpc "�ۤȤ�ɤ����Ǥ򸫤Ĥ����褦���ʡ�")
		(prompt-for-key)
		(say knpc "����ġ�")
		(prompt-for-key)
		(say knpc "���Τ��Ȥ�����Τ�����Ƥ��������������ǽ�Ϥʤ�Ǥ���Ǥ�����")
		(prompt-for-key)
		(say knpc "����줿�Ԥ�����ޤ����Ǥ�õ���Ƥ��롣���μ����ˤϤ��ä���Ĥ����ʤ����Ȥ򹬱��˻פ�ͤФʤ�ޤ���")
		(prompt-for-key)
		(say knpc "����Ũ���濴�ϡ����֥���åȤ����Ҥ�Ĵ�٤ͤФʤ�̤Ǥ�����")
		(quest-data-assign-once 'questentry-rune-s)
		)
		
		(else
		(say knpc "���Ƥ����Ǥ򸫤Ĥ�������ä��褿�ޤ���"
		     "¾�θ��Ԥ˽�������衣�������Ǥξ��μ꤬�������äƤ��뤫���Τ�̡�")
		)
	)
    )

    ;; Second Quest -- find out what the Runes are for
    (define (second-quest-spurned)
      (say knpc "����ϰ���Ω�����������ʤ�Ԥε�̳�Ǥ��롣"
           "���Ƥ���Ф���䤹���֤Ϥʤ���������Ǥ��Ϥ��ʤ�����"
           "�󽷤������ä���ФƹԤ����ޤ���")
      (kern-obj-remove-from-inventory kpc t_rune_k 1)
      (kern-obj-add-to-inventory knpc t_rune_k 1)
      (quest-accepted! (ench-second-quest ench) #f)
      (kern-conv-end))

    (define (start-second-quest)
      (quest-accepted! (ench-second-quest ench) #t)
      (say knpc "����������˻�����Ǥ�����������Ƽ��Τ���")
      (quest-data-update 'questentry-rune-k 'entrusted-with-rune 1)
      (prompt-for-key)
      (say knpc "����ˡ�¾�θ��Ԥ����Ȳ񤤡����ǤˤĤ��ƿҤͤ�Τ���"
           "���ѡ����ˤ���ϣ��ѻդ���Ϥ��Τ��褤������"
           "�������ߤʼԤ�����"
           "�������������Ȥ˿�������䤷�Ƥ��롣")
      (quest-data-assign-once 'questentry-runeinfo)
      (quest-wise-subinit 'questentry-alchemist)
      (quest-wise-init)
      (kern-conv-end)
      )

    (define (offer-second-quest-again)
      (say knpc "��äƤ����ʡ��ɿ������դ򴶤����Τ��⤷��̤ʡ�"
           "����ϲ桹�ˤȤäƺǤⰭ�����Ȥ���"
           "���ơ�����줿�Ԥ��������������ϤǤ�������")
      (if (kern-conv-get-yes-no? kpc)
          (begin
            (kern-obj-remove-from-inventory knpc t_rune_k 1)
            (kern-obj-add-to-inventory kpc t_rune_k 1)
            (start-second-quest))
          (begin
            (say knpc "�ޤ�Ǳ¤˸������ڤΤ褦����"
                 "��Ԥϼ���ζ򤫤��˵��롣"
                 "������ߤ��������˵��뤬�褤��")
            (kern-conv-end)))
      )
    
    (define (finish-second-quest)
      (say knpc "����Ͻš������ͻҤ�����"
           "�Ĥޤ������Ǥϰ���������������Ȭ�Ĥθ��ΰ�ĤʤΤ��ʡ�"
           "���������ϻĤ��õ���ͤФʤ�̡�"
           "����줿�Ԥϲ桹�����ԤäƤ��롣"
           "�����Ĥ������Ǥ�������Ƥ���Τϵ�����;�Ϥ�ʤ���"
           "���Ƥ����Ǥ򸫤Ĥ����顢��θ�����äƤ����ߤ�����")
      (quest-done! (ench-second-quest ench) #t)
      (quest-data-update 'questentry-runeinfo 'abe 1)
      (quest-data-update 'questentry-runeinfo 'keys 1)
      (quest-data-update 'questentry-runeinfo 'gate 1)
      (quest-data-update 'questentry-rune-k 'entrusted-with-rune 1)
      (quest-data-update-with 'questentry-runeinfo 'done 1 (grant-party-xp-fn 30))
      (quest-data-complete 'questentry-runeinfo)
      ;; temporary setup- will require information gathering first when done
      (prompt-for-key)
      (quest-data-assign-once 'questentry-allrunes)
      (quest-data-convert-subquest 'questentry-rune-k 'questentry-allrunes)
      (quest-data-assign-once 'questentry-rune-k)
      (quest-data-convert-subquest 'questentry-rune-c 'questentry-allrunes)
      (quest-data-convert-subquest 'questentry-rune-d 'questentry-allrunes)
      (quest-data-convert-subquest 'questentry-rune-l 'questentry-allrunes)
      (quest-data-convert-subquest 'questentry-rune-p 'questentry-allrunes)
      (quest-data-convert-subquest 'questentry-rune-s 'questentry-allrunes)
      (quest-data-convert-subquest 'questentry-rune-w 'questentry-allrunes)
      (quest-data-convert-subquest 'questentry-rune-f 'questentry-allrunes)
      (quest-accepted! (ench-quest ench 3) #t)
      )

    (define (check-second-quest)
      (say knpc "���ǤΤ��ȤϤ狼�ä����͡�")
      (if (yes? kpc)
          (begin
            (say knpc "���ࡢ����ϲ�����")
            (let ((reply (kern-conv-get-string kpc)))
              (if (or (string=? reply "demon") (string=? reply "gate") (string=? reply "key") (string=? reply "������") (string=? reply "���") (string=? reply "����"))
                  (finish-second-quest)
                  (begin
                    (say knpc "��Ϥ����ϻפ�̡����Ƥθ��Ԥ�^c+m����^c-�ˤĤ��ƿҤͤ�����")
                    (if (yes? kpc)
                        (say knpc "�ʤ�Ф��Τ����ΰ�ͤ��꤬�����Ϳ�����Ϥ�����")
                        (say knpc "������Ƥ�õ���Τ���"))))))
          (say knpc "���Ƥθ��Ԥ�^c+m����^c-�Τ��Ȥ�Ҥͤ�Τ���")))

    ;; First Quest -- find the stolen Rune
    (define (finish-first-quest)
      (say knpc "�������Ĥ��˻�����Ǥ򸫤Ĥ����褦���ʡ�")
      (kern-obj-add-gold kpc 200)
		(quest-data-update-with 'questentry-thiefrune 'done 1 (grant-party-xp-fn 20))
		(quest-data-complete 'questentry-thiefrune)
      (say knpc "���������Ω�Ĥ褦���ʡ�"
           "�����Ρġ��񹳤˲�ä����ʡ�")
      (kern-conv-get-yes-no? kpc)
      (say knpc "ť���θ��ˤϼ���줿�Ԥ����롣"
           "�������Ǥ����ʤΤ�Ĵ�٤ͤФʤ�̡�"
           "����ߤ��Ƥ���뤫��")
      (quest-offered! (ench-second-quest ench) #t)
      (if (kern-conv-get-yes-no? kpc)
          (start-second-quest)
          (second-quest-spurned)))

    (define (check-first-quest)
      (if (in-inventory? kpc t_rune_k)
          (finish-first-quest)
          (say knpc "��ࡣ�ޤ���Τ򸫤Ĥ��Ƥ���̤褦���ʡ�"
               "������¤��ͤ���֤򸫤��������ˤĤ֤䤤������")
            ))
    
    ;; Main
    (if (ench-met? ench)
        (if (quest-done? (ench-quest ench 4))
            (say knpc "�褦���������Ԥ�ͧ�衣")
            (if (quest-accepted? (ench-quest ench 4))
                (check-fourth-quest)
                (if (quest-accepted? (ench-quest ench 3))
                    (check-third-quest)
                    (if (quest-offered? (ench-second-quest ench))
                        (if (quest-accepted? (ench-second-quest ench))
                            (check-second-quest)
                            (offer-second-quest-again))
                        (if (quest-accepted? (ench-first-quest ench))
                            (check-first-quest)
                            (say knpc "���ࡣ���٤ϲ�����"))))))
        (begin
          (quest-data-update-with 'questentry-calltoarms 'talked 1 (quest-notify (grant-xp-fn 10)))
          (kern-log-msg "����ǯϷ���뤳�Ȥ��ʤ����Τ褦����ѻդϡ����ʤ��򸫤Ƥ�ä��ʤ��ä���")
          (say knpc "�褯������줿��"
               "�ԤäƤ��ä�����")
          (ench-met! ench #t)))))

(define (ench-name knpc kpc)
  (say knpc "��ƻ�դȤ����Τ��Ƥ��롣"))

(define (ench-job knpc kpc)
  (say knpc "��ǽ�ʸ¤갭���臘���Ȥ��������뤳�ȤǤ��롣"))

(define (ench-default knpc kpc)
  (say knpc "����Ͻ������̡�"))

(define (ench-bye knpc kpc)
  (say knpc "����줿�Ԥ˵���Ĥ��衪"))

(define (ench-join knpc kpc)
  (say knpc "�ݡ���������Τ���٤����Ǥ��롣"
       "������֤����ʤ顢Ʈ�Τ�õ���Τ��褤������"))


(define (ench-warr knpc kpc)
  (say knpc "Ʈ�ΤϹӡ��������ԤǤ��롣"
       "��������Τ褦����ϲ���Ƥ��롣"
       "�ºݤΤȤ������ɤ������������Τ����Τ�̡�"
       "���饹�ɥ���ʹ���Ф褫����")
       (quest-wise-subinit 'questentry-warritrix)
       (quest-data-update 'questentry-warritrix 'general-loc 1)
       )

(define (ench-wand knpc kpc)
  (say knpc "���ꡣ���ĤƲ�ä����Ȥ����롣ͽ�����̤��ȤǤ��ä���"
       "�����Ȥʤ뤫���Ȥʤ뤫�ϡ��򤷤����Ǥ��롣"))

(define (ench-offer-first-quest knpc kpc)
  (say knpc "���Ȥϡ����Ȥϲ�������������򤴤ޤ�������Ϥ��ʤ���"
       "����Ͻв񤨤��ưפ˶��̤Ǥ��롣"
       "��Ϥ����Ϥ������Ԥ���ʤ��Ĥ�꤫��")
  (if (kern-conv-get-yes-no? kpc)
      ;; yes - player intends to do good
      (begin
        (say knpc "�ʤ������ϤȤʤ���"
             "��������Ĥ��衪¿���������ĥ����Ԥϡ��ºݤˤϤ����Ǥʤ���"
             "�����ƻ�����æ��롣��ˤϻ����������и礬���뤫��")
        (if (kern-conv-get-yes-no? kpc)
            ;; yes - player is ready to be tested
            (begin
              (say knpc "��������Ƕᤢ���Τ���ޤ줿��"
                   "ť���򸫤Ĥ��Ф�����������᤹�Ԥ򸫤Ĥ��ͤФʤ�ʤ��ä��Τ���"
                   "���������뤫��")
              (if (kern-conv-get-yes-no? kpc)
                  ;; yes -- player is willing
                  (begin
                    (say knpc "��������������ť�����ɤäƥȥꥰ�쥤�֤ؤȸ����ä���"
                         "�����عԤ�^c+mť��^c-�ˤĤ��ƿҤͤ�Ȥ褤������")
							(quest-data-assign-once 'questentry-thiefrune)
              		(quest-data-complete 'questentry-calltoarms)
                  	;; if you dont read the letter, you might not get the quest till now!
              		(quest-data-assign-once 'questentry-calltoarms)
                  	(quest-data-update-with 'questentry-calltoarms 'done 1 (grant-xp-fn 10))
                    (quest-accepted! (ench-first-quest (gob knpc)) #t)
                    )
                  ;; no -- player is not willing
                  (say knpc "��򸫸�ä����⤷��̡�")))
            ;; no -- player is not ready
            (say knpc "����ʤ����ȤˤĤ����ä������Ǥ��Խ�ʬ�Ǥ��롣"
                 "����ʤ����Ȥʤ��ˡ����ˤʤ뤳�ȤϤǤ��̡�")))
      ;; no -- player does not intend to do good
      (say knpc "�狼�ä����������Ԥ����򤽤ΰ�̣��狼�餺�ʤ����Ȥ��Ǥ��롣"
           "��������ø�ʼԤϤ����ɿ���̵��Ǥ��̤��Ȥ˵��Ť�������")))

(define (ench-good knpc kpc)
  (if (quest-accepted? (ench-first-quest (gob knpc)))
      (say knpc "�����ɤ��Ԥ����ʤ����ƨ�����ΤǤ��롣"
           "����������ε�Τ��Ȥ�������")
      (ench-offer-first-quest knpc kpc)))

(define (ench-gate knpc kpc)
  (say knpc "�����ϤˤϷ�ȶ��˸����¾���ȤĤʤ��ä�¿�����礬���롣"
       "���������Ť���ϰ�Ĥ����ʤ����䤬�ΤäƤ���μ¤ʤ��Ȥϡ��̤������ȤĤʤ��äƤ���Ȥ������Ȥ�������"))

(define (ench-wise knpc kpc)
  (say knpc "���ԤϤ����ϤǺǤ��ϤΤ�����Ρ���ѻա����͡������Ƥʤ餺�ԤǤ��롣"
       "�������ܤϥ����ɤ��뤳�ȤǤ���ˤ⤫����餺�����Ƥ������ԤǤ���櫓�ǤϤʤ���"))

(define (ench-accu knpc kpc)
  (say knpc "����줿�Ԥϰ��ν��Ĥǡ���¿�����Ⱥ�ȻĵԹ԰٤˴ؤ�äƤ��롣"
       "���֥���åȤ����������Ͻ��ᤷ���Ϥ����ä���"
       "������ä���"
       "��������Ϥ���궯��ˤʤäƤ��뤳�Ȥ򶲤�Ƥ��롣"))

(define (ench-moon knpc kpc)
  (say knpc "�����Τ��Ȥϥ��륷�ե������˿Ҥͤ衣"
       "����Ϥ褯�ΤäƤ��롣"))

(define (ench-shri knpc kpc)
  (say knpc "���Ť���Ϥ��ĳ����Τ��������ͽ¬�Ǥ��ʤ��������Ƴ����ΤϾ����δ֤�������"
       "���������ä���ΤϷ褷����äƤ��ʤ���"
       "��������Τ褦���¤��ͤ��Ѥ򸽤����Ȥ����롣"))

(define (ench-rune knpc kpc)
  (say knpc "�������Ǥϱ��λվ����������ä�ʪ����"
       "�վ��Ϥ��줬���Τ���ˤ��뤫�Τ�ʤ��ä������Ĵ�٤���������Ū�������狼��ʤ��ä���"
       "����Ͻ��פǤϤʤ���ʪ�ȻפäƤ�����"
       "�ʤ��ܤ���ˤˤϤ���˴ؤ��뵭�Ҥ������ʤ��Τ�������"))

(define (ench-wiza knpc kpc)
  (say knpc "��Ρ����͡��ʤ餺�Ԥ��ϤϤߤʿ����������μ���������ΤǤ��롣"
       "��������ѻդ��Ϥ����������������ΤǤ��롣"))

(define (ench-know knpc kpc)
  (say knpc "�ܤθ����̼ԤϿ������򤹤뤳�ȤϤǤ��ʤ��褦�ˡ�"
       "��ʤ��ܤΤʤ��Ԥ���Ѥ��Ϥ����򤹤뤳�ȤϤǤ��̡�"
       "�����������ܤ򳫤����Ԥϡ��ܤ˸����̸����ȷ�̤����򤹤뤳�Ȥ��Ǥ��褦��"))

(define (ench-wrog knpc kpc)
  (say knpc "�Ǥ⸭���ʤ餺�ԤϤˤ󤲤�ǡ����˿ᤫ��ƹԤ����ꤷ�Ƥ��롣"
       "�ˤ󤲤�˵���٤���꤬����Ȥ���С�����Ϲ�̯�˱�����Ƥ��������"
       "����μԤ˿Ҥͤ衣�ߤ���ԤȤϴ��˲�äƤ��뤫���Τ�̡�")
       (quest-wise-subinit 'questentry-the-man)
       (quest-data-update 'questentry-the-man 'common 1)
       )

(define (ench-wrig knpc kpc)
  (say knpc "�Ǥ⸭�����ͤϸ��Ȥ򹥤ࡣ"
       "��������򸫤Ĥ��뤳�Ȥ��Ǥ��褦���������Į����ǤϤʤ�������"
       "��ѻդΥ��륷�ե�������õ��������ϵ��դΤ��Ȥ�褯�ΤäƤ��롣")
       (quest-wise-subinit 'questentry-engineer)
       (quest-data-update 'questentry-engineer 'kalcifax 1)
       )

(define (ench-necr knpc kpc)
  (say knpc "���Ƥθ��Ԥ���ǺǤ�������ٰ��ʼԤ���"
       "�郎��Ũ������ѻդ��ϲ�������������Ǥ��롣"
       "��϶���ǡ���������Ԥ�������줿�Ԥ���")
       (quest-wise-subinit 'questentry-necromancer)
       (quest-data-update 'questentry-necromancer 'general-loc 1)
      )

(define (ench-alch knpc kpc)
  (say knpc "ϣ��ѻդϥ��ѡ����ˤ��롣"
       "����߿������ȤƤ����Ѥ�����ˤϵ���Ĥ��ͤФʤ�̡�")
       (quest-wise-subinit 'questentry-alchemist)
       (quest-data-update 'questentry-alchemist 'oparine 1)
       )

(define (ench-thie knpc kpc)
	;;in case quest generated once in progress
	(quest-data-assign-once 'questentry-thiefrune)
  (if (quest-done? (ench-first-quest (gob knpc)))
      (say knpc "���Ǥʤ�Τ��������ñ�ʤ����ԤǤ�����"
           "��򤢤ޤ�˸���������ʤ����Ȥ�˾�ࡣ")
      (say knpc "��Τ���������ť�������˹��ߤǤ�����"
           "��������ϥȥꥰ�쥤�֤Ǹ����ä���"
           "��ä��Ԥ�^c+mť��^c-�ˤĤ��ƿҤͤ衣")))

(define (ench-kalc knpc kpc)
  (say knpc "���륷�ե���������ǰ��������ε���Ϥ狼��ʤ���"))

(define (ench-demo knpc kpc)
  (say knpc "�������ϸŤ���ѻդ��̤������ؤ��Ϥ뤿��˻Ȥä��Ȥ���������������"
       "���θ���͡��ʸ������������롣����ϼ���줿���������줿��˺���줿���˲����줿�ʤɤ���"
       "��Ϥ��äȺ���ä��ȹͤ��Ƥ�����"))

(define (ench-ench knpc kpc)
  (say knpc "������"))

(define enchanter-conv
  (ifc basic-conv
       (method 'default ench-default)
       (method 'hail ench-hail)
       (method 'name ench-name)
       (method 'bye ench-bye)
       (method 'job ench-job)
       (method 'join ench-join)
       
       (method 'ench ench-ench)
       (method 'accu ench-accu)
       (method 'alch ench-alch)
       (method 'evil ench-good)
       (method 'gate ench-gate)
       (method 'good ench-good)
       (method 'know ench-know)
       (method 'moon ench-moon)
       (method 'necr ench-necr)
       (method 'rune ench-rune)
       (method 'shri ench-shri)
       (method 'thie ench-thie)
       (method 'wand ench-wand)
       (method 'warr ench-warr)
       (method 'wise ench-wise)
       (method 'wiza ench-wiza)
       (method 'wrog ench-wrog)
       (method 'wrig ench-wrig)
       (method 'emgi ench-wrig)
       (method 'kalc ench-kalc)
       (method 'demo ench-demo)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-enchanter-first-time tag)
  (bind 
   (kern-char-arm-self
    (kern-mk-char 
     tag ;;..........tag
     "��ƻ��" ;;.......name
     sp_human ;;.....species
     oc_wizard ;;.. .occupation
     s_old_mage ;;..sprite
     ;;(mk-composite-sprite (list s_hum_body s_hum_belt s_hum_beard))
     faction-men ;;..faction
     0 ;;...........custom strength modifier
     7 ;;...........custom intelligence modifier
     0 ;;...........custom dexterity modifier
     10 ;;............custom base hp modifier
     2 ;;............custom hp multiplier (per-level)
     20 ;;............custom base mp modifier
     5 ;;............custom mp multiplier (per-level)
     max-health ;;..current hit points
     -1  ;;...........current experience points
     max-health ;;..current magic points
     0
     enchanter-start-lvl  ;;..current level
     #f ;;...........dead?
     'enchanter-conv ;;...conversation (optional)
     sch_enchanter ;;.....schedule (optional)
     'townsman-ai ;;..........custom ai (optional)
     ;;..............container (and contents)
     (mk-inventory
      (list
       (list 10  t_food)
       (list 100 t_arrow)
       (list 1   t_bow)
       (list 1   t_dagger)
       (list 1   t_sword)
       (list 1   t_leather_helm)
       (list 1   t_armor_leather)
       (list 5   t_torch)
       (list 5   t_cure_potion)
       (list 5   t_heal_potion)
       ))
     nil ;;.........readied arms (in addition to the container contents)
     nil ;;..........hooks in effect
     ))
   (enchanter-mk)))
