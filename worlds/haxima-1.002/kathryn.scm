;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define kathryn-start-lvl  6)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; In Bole.
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_kathryn
               (list 0  0  bole-bed-kathryn "sleeping")
               (list 9  0  bole-table-1 "eating")
               (list 10 0  bole-courtyard   "idle")
               (list 12 0  bole-table-1 "eating")
               (list 13 0  bole-dining-hall "idle")
               (list 18 0  bole-table-1 "eating")
               (list 19 0  bole-dining-hall "idle")
               (list 23 0  bole-bed-kathryn "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (kathryn-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ���㥹���϶��ߤʽ�������ѻդǡ���ƻ�դ����Ϥ����Ǥ���ळ�Ȥ���󤷤�ť
;; ��(�ͥ���)���餽������᤹����ܥ�ˤ��롣�ĳμ¤���ƻ�դϲ����ä��Ƥ���
;; ����
;; ����ϸ������ޤ������Ǥ��롣
;; 
;; ���㥹������֤ˤʤ�(�����ƺǸ�ˤ�΢�ڤ�)��
;; ����ˤϹӡ������ɥ󤬤Ĥ��Ƥ��ơ��������֤ˤʤ�������֤ˤʤ롣
;;----------------------------------------------------------------------------
(define (kathryn-hail knpc kpc)
  (say knpc "�Τ��ʤ�����Τ��ܤǸ��뤭�줤�ʽ����Ȳ�ä����ϤϤ���"))

(define (kathryn-default knpc kpc)
  (say knpc "������Ϥ��ʤ���虜��̵�뤷������"))

(define (kathryn-name knpc kpc)
  (say knpc "�褽�Ԥˤ�̾�������ʤ��褦�ˤ��Ƥ���Ρ�"
       "�����ꡢ�Τꤿ�����Ȥ�������̤��ۤˤ����ʤ����衣"
       "���ܤ��������󤤤��դ�Ρġ�"))

(define (kathryn-join knpc kpc)
  (say knpc "������Ϥऻ��ۤɾФä�����"))

(define (kathryn-job knpc kpc)
  (say knpc "�Τ����Ф��ʤ���Ͻ�ƻ���衣���500��Ǥ����Ť��ޤ��礦����"))


(define (kathryn-blowjob knpc kpc)
  (say knpc "��̣�衣���ä��Ⱦä��ʤ�����"))

(define (kathryn-clients knpc kpc)
  (say knpc "��εҤ�̾�����������ʤ���Τ衣"
       "��������ΤäƤ����٤��ʤΤϡ������ܤ餻�ƤϤʤ�ʤ��Ȥ������Ȥ衣"))

(define (kathryn-things knpc kpc)
  (say knpc "���ʤ��Τ褦�ʿͤˤϤ狼��ʤ���Τ衣"))

(define (kathryn-thief knpc kpc)
  (say knpc "����������Ѥ��ܤǤ��ʤ��򸫤����Ϥʤ�ۤɤ͡��⤷������ȶ��Ϥ��礨�뤫�⤷��ʤ���"
       "�����ؤϵҤ������̾�����������ʤ���ͤ����Τ������뤿����褿�Ρ�"))

(define (kathryn-seller knpc kpc)
  (say knpc "��Τ���ޤ줿�Ȥ狼�ä��Ȥ��Υ���å����������Ƥߤơ�"
        "��Ȱ��������˥�Τ��׵ᤷ���顢�������ܤ�������ä����Τ衪"))

(define (kathryn-vanish knpc kpc)
  (say knpc "�ѥäȡ����ʤ��ʤä���Ʃ���λ��ؤ���äƤ����˰㤤�ʤ���"
       "�ɥ�Ȱ��ˤ����餸�夦��õ�����"))

(define (kathryn-search knpc kpc)
  (define (do-join)
    (say knpc "���Ф餷�������Τ������ť���ˤĤ��Ʋ����ΤäƤ��뤫ʹ���Ƥߤޤ��礦��")
    (if (in-inventory? knpc t_wis_quas_scroll)
        (begin
          (say knpc "���������δ�ʪ�Ϥ��ä����Ω�Ĥ"
               "���äƤ����ơ�������ˡ���ۤϤ褯�狼��ʤ����ɡ�")
          (kern-obj-remove-from-inventory knpc t_wis_quas_scroll 1)
          (kern-obj-add-to-inventory kpc t_wis_quas_scroll 1)))
    (kern-char-join-player knpc)
    (if (and (defined? 'ch_thud)
             (is-alive? ch_thud))
        (begin
          (say knpc "���̤Υɥ��ä�äƤ��������顣"
               "�����Ĥϥ����ߤ����ʤ�Τǡ��䤬���ʤ��Ȥɤ����褦��ʤ����顣")
          (kern-char-join-player ch_thud)))
    (kern-conv-end))
  (say knpc "�䤿������Ū��Ʊ���褦�͡�����Ȥ�ǰ��ޤ���ޤ��ƥ�Τ����֤��ޤ��礦��"
       "�󽷤ϽФ��"
       "�⤷��Τ����᤻��С���ȥɥ�ˤϽ�ʬ�ʳۤˤʤ�Ρ�"
       "�ɤ������դ�������֤˲ä��ʤ���")
  (if (kern-conv-get-yes-no? kpc)
      (do-join)
      (begin
        (say knpc "�������ư�ɤ������Ϥ������ɤ��������ơ�"
             "��Υܥ��϶�������˽�ʤΡ�"
             "�⤷õ���Ƥ����Τ�����֤��ʤ���С���������������Ƥ����ʤ���Фʤ�ʤ���"
             "�ɤ�����֤˲ä�äơ�")
        (if (kern-conv-get-yes-no? kpc)
            (do-join)
            (begin
              (say knpc "������Ͽ��ȤޤĤ����Ť�������"
                   "���������դ��������ʤ��ξ����衣������ʤ���ΤϤɤ��Ǥ⤤����"
                   "���ʤ��ʳ��ˤϤ��ʤ��Τ衣����õ���ޤ��礦��"
                   "�ɤ������ꤤ�����ꤤ���ޤ��ġ�")
              (if (kern-conv-get-yes-no? kpc)
                  (do-join)
                  (say knpc "��������ܤ�Ǵ���֤��������ڤ�����夲�����ϥХ���"
                       "��褹����ˡ���ʤ������ˡ�"
                       "���ʤ���õ���Ƥ���Τϡ������ϤǺǤ�Ť���ѻդ��ˤ�Ǥ���ʪ�ʤΤ衪"
                       "ť������ޤ��Ʊʱ�ζ��ˤ�Ϳ���Ƥ��"
                       "���ʤ��ϴؤ��ʤ��ۤ����ȤΤ���衪")
                  (kern-conv-end)))))))

(define (kathryn-tavern knpc kpc)
  (say knpc "������衣���ʤ��������֥�ʤ�͡�"))

(define (kathryn-companion knpc kpc)
  (say knpc "�ɥ󡩻�ΡĿ��̤衣"))

(define (kathryn-cousin knpc kpc)
  (say knpc "�󤤿��̡�"))

(define (kathryn-bill knpc kpc)
  (say knpc "����¼�ΥХ������äȿ���ƻ���Ȥ�����˽ФƹԤä��ΤǤ��礦��"
       "���˹ԤäƤ����顩"))

(define (kathryn-hackle knpc kpc)
  (say knpc "���Υ����줿��ѡ�����򺹤����ˤ��롩"
       "���ν����ϼ���ʤ��Ǥ��礦�͡���ǰ�����ɡ�"))

(define (kathryn-may knpc kpc)
  (say knpc "�ɲ��Ρ����������ΥХХ��衣���ʤ��϶����äƤʤ����������ɡ�"
       "�⤷���äƤ���С�����Ȥ�����β��˱����Ƥ������Ȥ͡�"))

(define (kathryn-melvin knpc kpc)
  (say knpc "�����ͤΡ���������������ǯ���衣"))

(define (kathryn-sorceress knpc kpc)
  (say knpc "������϶ä����դ�򤷤Ƽ�Ǹ���ʤ�ä����Ϥ�������ξ����ʱ��줿��̩�˵��Ť�����͡�"
       "�ä������ʤ���������ʤ��Ⱦ����Τ褦��ǳ�䤹��衣"))

(define (kathryn-scro knpc kpc)
  (if (is-player-party-member? knpc)
      (say knpc "���äƤ���ΤϤ��ʤ��ˤ�������������衣"
           "�ɤ��Ǽ������Τ���狼��ʤ��")
      (say knpc "��ʪ��������ϾФä����ϻ�Υݥ��åȤ˼������Ƥߤ롩"
           "��ʬ�ο��ۤ򤷤ʤ����衣")))


(define kathryn-conv
  (ifc nil
       (method 'default kathryn-default)
       (method 'hail kathryn-hail)
       (method 'bye  (lambda (knpc kpc) (say knpc "���������")))
       (method 'job  kathryn-job)
       (method 'name kathryn-name)
       (method 'join kathryn-join)

       (method 'blow kathryn-blowjob)
       (method 'bill kathryn-bill)
       (method 'clie kathryn-clients)
       (method 'comp kathryn-companion)
       (method 'cous kathryn-cousin)
       (method 'fait kathryn-seller)
       (method 'hack kathryn-hackle)
       (method 'item kathryn-seller)
       (method 'inn  kathryn-tavern)
       (method 'may  kathryn-may)
       (method 'meet kathryn-thief)
       (method 'melv kathryn-melvin)
       (method 'nun  kathryn-blowjob)
       (method 'ring kathryn-search)
       (method 'sear kathryn-search)
       (method 'sell kathryn-seller)
       (method 'sorc kathryn-sorceress)
       (method 'witc kathryn-sorceress)
       (method 'tave kathryn-tavern)
       (method 'thud kathryn-companion)
       (method 'thie kathryn-thief)
       (method 'vani kathryn-vanish)
       (method 'vill kathryn-search)
       (method 'scro kathryn-scro)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-kathryn)
  (bind 
   (kern-char-force-drop
    (kern-char-arm-self
     (kern-mk-char 
      'ch_kathryn ;;..tag
      "���㥹���" ;;....name
      sp_human ;;.....species
      oc_wizard ;;....occupation
      s_wizard ;;.....sprite
      faction-men ;;..faction
      0 ;;............custom strength modifier
      4 ;;............custom intelligence modifier
      0 ;;............custom dexterity modifier
      2 ;;............custom base hp modifier
      1 ;;............custom hp multiplier (per-level)
      4 ;;............custom base mp modifier
      2 ;;............custom mp multiplier (per-level)
      max-health ;; current hit points
      -1  ;;...........current experience points
      max-health ;; current magic points
      0
      kathryn-start-lvl  ;;..current level
      #f ;;...........dead?
      'kathryn-conv ;;conversation (optional)
      sch_kathryn ;;..schedule (optional)
      'spell-sword-ai ;;...custom ai (optional)
      ;;..............container (and contents)
      (mk-inventory
       (list
        (list 1 t_kathryns_letter)
        (list 100 t_gold_coins)
        (list 5 sulphorous_ash )
        (list 5 ginseng )
        (list 5 garlic )
        (list 3 spider_silk )
        (list 3 blood_moss )
        (list 2 black_pearl )
        (list 1 nightshade )
        (list 1 mandrake )
        (list 1 t_wis_quas_scroll)
        ))
      ;;..............readied arms (in addition to the container contents)
      (list
       t_staff
       )
      nil ;;..........hooks in effect
      ))
    #t)
   (kathryn-mk)))
