;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ���饹�ɥ��
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_stew
               (list 0  0  gv-bed       "sleeping")
               (list 7  0  ghg-s4       "eating")
               (list 8  0  gc-hall "idle")
               (list 12 0  ghg-s1       "eating")
               (list 13 0  gc-hall "idle")
               (list 18 0  ghg-s1       "eating")
               (list 19 0  gc-hall "idle")
               (list 20 0  gv-bed       "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (stew-mk) (list 'townsman #f))
(define (stew-met? stew) (cadr stew))
(define (stew-met! stew) (set-car! (cdr stew) #t))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; �������ȥꥢ�ϥ��饹�ɥ��ΰ��Ū�ʻ�Ƴ�Ԥǡ������Ԥ�̾������äƤ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (stew-hail knpc kpc)
  (if (not (stew-met? (kobj-gob-data knpc)))
      (begin
        (say knpc "�Τ��ʤ��ϰҸ���ɺ�������Ȳ�ä�����"
             "�褦�������¤��ͤ衣���ʤ�����뤳�Ȥ�ʹ���Ƥ��ޤ�����")
        (stew-met! (kobj-gob-data knpc)))
      (say knpc "�Τ��ʤ��ϰҸ���ɺ�������Ȳ�ä�����"
           "�ޤ��񤤤ޤ����͡��¤��ͤ衣")))

(define (stew-default knpc kpc)
  (say knpc "����ϼ�����Ǥ��ޤ���"))

(define (stew-name knpc kpc)
  (say knpc "��ϥ������ȥꥢ�����饹�ɥ��������ԤǤ���"))

(define (stew-join knpc kpc)
  (say knpc "���������ʡ�"))

(define (stew-job knpc kpc)
  (say knpc "���饹�ɥ��������ԤǤ���"))

(define (stew-bye knpc kpc)
  (say knpc "�����ƻ��ʤߤʤ������¤��ͤ衣"))

;; Warritrix...
(define (stew-warr knpc kpc)
  (cond ((player-found-warritrix?)
      (if (ask? knpc kpc "��������������ä����Ȥ�ʹ���ޤ������䤬�����ؤ�ä��Ȥϡ�������ͤ��Ƥ��ޤ���͡�")
          (say knpc "�����Ǥ������蘆��̵�뤷�ʤ���������ϻ����Ũ�����᤿��ΤǤ���")
          (begin
            (say knpc "�����ˤ����ʤ���Τʤ�С�������������Ǥ��ʤ�����"
                 "�Ǥ�ٹ𤷤ޤ������ʤ��Ͻɤʤ�������˷�������ƻ�Ϥ����ϤǺǤ��ϤΤ���Į�λ��ۼԤʤΤǤ���"
                 "����ϻ�Ȥ��ʤ��θ��դ�Ʊ���������Ƶ���ι�ȯ�ͤϸ�����ȳ������Ǥ��礦��")
            (aside kpc 'ch_ini "�¤��ʤɤʤ���΢�ڤ�Ԥ�����衢�桹�Ϥ��ʤ����ʤ��롣"
                   "���ʤ��ʾ�θ��դǤ�äơ�")
            )
          ))
      ((quest-data-assigned? 'questentry-wise)
		(say knpc "���Ф餯��äƤ���ޤ��󡣲�����Ǥ̳�ο����Ȼפ��ޤ���")
		(quest-data-update 'questentry-warritrix 'assignment 1)
		)
	(else
		(say knpc "���κǤ�ͥ�줿��ΤǤ������Ϸ����˽ФƤ���Ȼפ��ޤ���")
		 (quest-data-update 'questentry-warritrix 'general-loc 1)
		 )
      ))

(define (stew-erra knpc kpc)
  (say knpc "�����ե꡼�����ᴱ��ʹ���Ƥ�����������ʤ�ܤ������Ȥ��ΤäƤ���Ϥ��Ǥ���"))

;; Steward...
(define (stew-stew knpc kpc)
  (say knpc "���饹�ɥ������Ф��줿�����Ԥˤ�äƼ�����Ƥ��ޤ���"
       "������̳��Į�����ڤ��뤳�Ȥˤ���ޤ���"))

(define (stew-real knpc kpc)
  (say knpc "���饹�ɥ������ڤϡ����μ����Ӥ�������ο��ޤǤǤ���"
       "�Ͼ���ϲ��ΰݻ���ԤäƤ��ޤ���"))

;; Rune...
(define (stew-rune knpc kpc)
	(if (quest-data-assigned? 'questentry-wise)
		(say knpc "Ʈ�Τ����Ǥ��˳ݤ��Ƥ��ޤ����Ĥ��ޤ���"
			"�Ǥ⡢�����񤫤�Ƥ���Τ����Τ�ޤ���")
		(say knpc "Ʈ�Τ����Ǥ��˳ݤ��Ƥ��ޤ���"
			"�Ǥ⡢�����񤫤�Ƥ���Τ����Τ�ޤ���")
		)
       (quest-data-assign-once 'questentry-rune-l)
       )

(define (stew-wore knpc kpc)
	(if (quest-data-assigned? 'questentry-wise)
		(say knpc "�������������ΤǤ������������ְ㤨�������Ǥ���")
		(stew-default knpc kpc)
	))

;; Absalot...
(define (stew-absa knpc kpc)
  (say knpc "���֥���åȤϤ����Ϥ��¤ǡ�"
       "�������������˴����˼������ʤ���Фʤ�ޤ���Ǥ�����"
       "���η��ǤˤĤ��Ƥ����򤷤Ƥ��������ޤ��͡�")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "��Τʤ��ͤޤ�̿����Ȥ������Ȥ����Ǥ���"
           "�����������ε����ʤ����臘���ȤϤǤ��ʤ��ΤǤ���")
      (say knpc "���ʤ��˲����狼��Ȥ����ΤǤ�����"
           "���ʤ��Ϥ����Τʤ餺�ԤǤ��礦��")))

(define (stew-inno knpc kpc)
  (say knpc "���֥���åȤ����ƤμԤ��ٰ����ä��櫓�ǤϤ���ޤ���"
       "�������ٰ�������ˤ��ꡢ������Ф�����Ǥ�����"))

(define (stew-wick knpc kpc)
  (say knpc "���֥���åȤο͡��Ͽʹ֤����Ӥ䰭����Ҥ�ԤäƤ��ޤ�����"
       "������¾��Į�Ĥ���Į�ˤ�����Ԥ�����Ϥ�ޤ�����"))

(define (stew-conv knpc kpc)
  (say knpc "���Τ��Ȥ��Τä��Ȥ�������з��ˤ��ޤ�����"
       "��ϸ��Ԥ�¾��Į�λ�Ƴ�Ԥ����Ȳ񤤡��ɤ�����Τ����ޤ�����")
  (prompt-for-key)
  (say knpc "���Ԥ���β��ͤ�������ޤ�������������"
       "�䤿��������ȿ�аո���Ѳ�����Ϣ�緳��������ޤ�����"
       "�����ƥ��֥���åȤ˿ʷ��������٤ȺƷ��Ǥ��̤褦�˲�����ϩ�����������ΤǤ���"))

(define (stew-wise knpc kpc)
  (say knpc "���Ԥ�Į�λ�Ƴ�Ԥ������Ƥ��ޤ�������ͤǤϾ������Ϥ�������ޤ���"
       "���Ĥƻ䤿����ȿ�Ф�����ƻ�դǤ��������饹�ɥ����Ϥˤ��񹳤Ǥ��ޤ���Ǥ�����")
       (quest-wise-subinit 'questentry-enchanter)
       )

(define (stew-rogu knpc kpc)
  (say knpc "���ʤ��Ϥɤ������褿�ΤǤ������桹���ϤǤ���Ū�ϡ�"
       "�⤷��۹�η�����͸��Ǥϡ�")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "�����ࡣ�⤷���ʤ��θ������Ȥ������ʤ顢����Ԥ�����ꤲ���ߡ�"
           "����ˤ������Ƥ��Ǥ��Ф�����Ǥ��礦��"
           "���������ºݤˤϸ������ۤ��������򤫤���Ω�������결�Ǥ��礦��"
           "�¤��ͤ衢̵����ФǤ��褦��̵�˾ä��ʤ�����")
      (say knpc "���������ʤ��϶����������褿����������˷�Ǥ��礦��"
           "������ˤ��衢�¤��ͤ衢���ʤ��ˤ���դ��٤��Ǥ���"
           "����Į���ؤ��褦�ʤ��Ȥ�����С�����Ԥμ�ˤ�äƻ���ܤ���Τ뤳�ȤǤ��礦��"))
  (kern-conv-end))

;; Townspeople...
(define (stew-glas knpc kpc)
  (say knpc "���饹�ɥ��ϰŰǤ���ˤ���Ƴ���θ��Ǥ���"
       "�����Τ����Ϥ������ڤ������Τ���˿Ȥ򤵤������Ǥ򲡤��ᤷ�Ƥ��ޤ���"
       "Ⱦ��ο͡��Ϥ���Į�β��äˤ������äƤ��ޤ���"))

(define (stew-unde knpc kpc)
  (say knpc "�ϲ����������Τ�����ʤ���ʪ�����ޤ����Ǥ���"
       "��ˤ����ƤˤȤäƶ��ҤǤ��밭�����Ԥ�������ݤ����̳������ޤ���"))

(define stew-conv
  (ifc glasdrin-conv

       ;; basics
       (method 'default stew-default)
       (method 'hail stew-hail)
       (method 'bye  stew-bye)
       (method 'job  stew-job)
       (method 'name stew-name)
       (method 'join stew-join)

       (method 'city stew-glas)
       (method 'town stew-glas)
       (method 'glas stew-glas)
       (method 'warr stew-warr)
       (method 'erra stew-erra)
       (method 'stew stew-stew)
       (method 'real stew-real)
       (method 'absa stew-absa)
       (method 'wore stew-wore)
       (method 'rune stew-rune)
       (method 'inno stew-inno)
       (method 'wick stew-wick)
       (method 'conv stew-conv)
       (method 'wise stew-wise)
       (method 'rogu stew-rogu)
       (method 'wrog stew-rogu)
       (method 'unde stew-unde)
       ))

(define (mk-steward)
  (bind 
   (kern-char-force-drop
    (kern-mk-char 'ch_steward         ; tag
                  "�������ȥꥢ"      ; name
                  sp_human            ; species
                  nil                 ; occ
                  s_lady              ; sprite
                  faction-glasdrin         ; starting alignment
                  1 3 0               ; str/int/dex
                  0 0                 ; hp mod/mult
                  0 0                 ; mp mod/mult
                  max-health -1 max-health 0 6  ; hp/xp/mp/AP_per_turn/lvl
                  #f                  ; dead
                  'stew-conv          ; conv
                  sch_stew            ; sched
                  'townsman-ai                 ; special ai
                  (mk-inventory (list (list 1 t_sword_4)
                                      (list 1 t_stewardess_chest_key)
                                      ))    ; container
                  nil                 ; readied
                  )
    #t)
   (stew-mk)))
