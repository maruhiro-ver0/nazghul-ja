;;----------------------------------------------------------------------------
;; ϣ��ѻդϸ��Ԥΰ�ͤȤ��ƿ������롣����������Ϥ��ޤ�褤�ͤǤϤʤ�����
;; �ϤȤƤ�ͭǽ�ǡ��ȤƤ��߿����������ƿͤ���ޤ����Ȥ򹥤ࡣ�ޤ���ˤ�¿����
;; �μ������롣��ϥȥꥰ�쥤�֤�˺���줿���ǤΤ��꤫���ΤäƤ��롣��������
;; ƻ�դ����Ǥϲ��Τ���ˤ��뤫�ΤäƤ��롣��������Τˤ󤲤�α���Ȥξ���
;; �ΤäƤ��롣
;;
;; ϣ��ѻդϥҥɥ顢ε�������ƥ�å��η���������ȤȤƤ��֡���϶��ʧ
;; �������κ�����򶵤��뤫�⤷��ʤ�?
;;----------------------------------------------------------------------------
;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ���ѡ����
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_alch
               (list 0   0  alkemist-shop "idle")
               (list 2   0  alkemist-bed  "sleeping")
               (list 8   0  bilge-water-seat-9   "eating")
               (list 9   0  alkemist-shop "working")
               (list 12  0  bilge-water-seat-9 "eating")
               (list 13  0  alkemist-shop "working")
               (list 17  0  bilge-water-seat-9 "eating")
               (list 18  0  bilge-water-hall "idle")
               (list 19  0  sea-witch-shop   "idle")
               (list 20  0  alkemist-shop "idle")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (alch-mk)
	(list
        (mk-quest) ;; dragon
        #f ;; lich
        #f ;; hydra
        ))


(define (alchq-dragon gob) (car gob))
(define (alchq-lich? gob) (cadr gob))
(define (alchq-hydra? gob) (caddr gob))
(define (alchq-lich! gob val) (set-car! (cdr gob) val))
(define (alchq-hydra! gob val) (set-car! (cddr gob) val))

;;----------------------------------------------------------------------------
;; Conv
;;----------------------------------------------------------------------------

(define alch-catalog
  (list
   (list t_heal_potion             18 "�襤�ο�������ǥޥ�<Mani>�����Ϥ��ʤ��ʤäƤ⡢���줬����н����������")
   (list t_cure_potion             18 "���󡦥Υ���<An Nox>�������¾夬�����������μ���������������ΤϤʤ�������")
   (list t_mana_potion             18 "¾�����Ǥϻ�Τ�ΤΤ褦�����Ϥ����᤻�ʤ��Ǥ�����")
   
   (list t_poison_immunity_potion  18 "ͽ�ɤϼ����˾��롪����ȱ֤���������Ф⤦�Ǥ򶲤��ɬ�פϤʤ���")
   (list t_invisibility_potion    100 "����������Ԥ�Ũ�˸��Ĥ��뤳�ȤϤʤ�������")
   (list t_str_potion             999 "�������ǥȥ������ϤϷ��Τ�Τ���" )  ;; limited stock would be nice...
   (list t_dex_potion             999 "�����������С�������Ͽ��¤Τ褦�ˤޤä��������֤�����")  ;; limited stock would be nice...
   (list t_int_potion             999 "�ΤΤ���ԤϤ���Τ���롪�������Ϥ��ꤴ����ʤǤ���ʷ��ˤʤ�������")  ;; limited stock would be nice...
   (list t_info_potion            150 "���ͤϸ��ä����򼫿Ȥ��Τ졣�������Ϥ��ν����Ȥʤ������")
   
   (list t_oil                      6 "Ũ�˱����Ӥ�������¦�̤��ꡢ��α�ΰϤߤ�ƨ�����ᡪ")
   (list t_slime_vial              25 "����Ϻǹ�˳ڤ�����ʬ������Ǵ�դ������Ũ�򤫤��𤷤�")
   ))

(define alch-merch-msgs
  (list "��ǰ�������Ź�Ϻ��ϳ����Ƥ��ʤ�������9��������5���δ֤���Ƥ��줿�ޤ���"
        "�����󷯤�����������ʪ�⤢�뤾������Ϥ�߼�򤷤�����"
        "�Ȥä�ʪ���㤤��뤾�Ĥ������ͤϲ����뤬��"
        "�����������������Ϥ�褦��"
        "��������ɤ�ۤ��ɤ����狼�ä��顢��äȼ������뤿��ˤ�������������"
        "���Τ��Ф餷���������ʤ��ä����Ȥ������뤳�Ȥ��ʤ���Ф褤����"
        "�Ȥ�ƻ�����ꤽ������"
        "�̤Τ�äȤ����㤤�꤬����Ȥϻפ��ʤ�����"
        "�������������Ǥ����ʡ�"
        "���Ϥ��Τा��"
        ))

;; Basics...
(define (alch-hail knpc kpc)
  (say knpc "�Τ��ʤ����ؤ��㤯��Ĺ��ɡ�����ä�Ϸ�ͤȲ�ä�����"
       "����ˤ��ϡ������Ƥ���ä��㤤��ι������"))

(define (alch-default knpc kpc)
  (say knpc "��ǰ���������ϤǤ��ʤ��ʡ�"))

(define (alch-name knpc kpc)
  (say knpc "ϣ��ѻդȤ����Τ��Ƥ��롣")
  (quest-data-update 'questentry-alchemist 'found 1)
  (quest-data-complete 'questentry-alchemist)
  )

(define (alch-join knpc kpc)
  (say knpc "˻�������롪�����������ˤϺФ�Ȥ�᤮�Ƥ��롣"))

(define (alch-job knpc kpc)
  (say knpc "�����롢ƻ�ڤ����򤤤Ƥߤ롢����ʤȤ������"
       "�����ߤ�����Τ�����и��äƤ��졪"))

(define (alch-bye knpc kpc)
  (say knpc "���褦�ʤ顪���ޤ���ʤ�����"))

;; Trade...
(define (alch-trade knpc kpc) (conv-trade knpc kpc "trade" alch-merch-msgs alch-catalog))
(define (alch-buy knpc kpc) (conv-trade knpc kpc "buy" alch-merch-msgs alch-catalog))
(define (alch-sell knpc kpc) (conv-trade knpc kpc "sell" alch-merch-msgs alch-catalog))

;; Rune...
;; offered: shown k rune
;; accepted: sent to find p rune
;; done: known to have found p rune
(define (alch-dragon-reward knpc kpc)
  (say knpc "�����������������Ǥϡ�")
	(prompt-for-key)
  (say knpc
	   "�����Τϥ���ݥꥹ���ϲ��ˤ����Ĥ��κ֤��ۤ��Ƥ��롣"
	   "���Ǥΰ�Ĥ��Ǥ⿼���֤�����Ƥ���Τ���")
	(prompt-for-key)
  (say knpc
	   "�Ĥ�Ϥ��ȥ���٥뤬����з���Ф��������"
	   "����������ʤΤϷ����դ��ޤȤ����ͤ�������Τ����뤳�Ȥ���")
	   (quest-data-assign-once 'questentry-rune-p)
	   (quest-rune-p-update)
	   )
	   
(define (alch-dragon-done knpc kpc)
  (say knpc "��ǰ����¾�����ǤΤ��꤫�Ϥ狼��ʤ���"
					"�̤θ��Ԥ�ʹ���Ƥߤ�Ȥ褤������"))
		
(define (alch-dragon-quest knpc kpc qstat)
	(if (kern-conv-get-yes-no? kpc)
		(cond
			((quest-done? qstat)
				(alch-dragon-done knpc kpc)
				)
			((in-inventory? kpc t_rune_p)
				(quest-done! qstat #t)
				(say knpc "�ɤ�����Ϥ����Ǥ򸫤Ĥ����褦���ʡ�")
				(alch-dragon-done knpc kpc)
				)
			((quest-accepted? qstat)
				(alch-dragon-reward knpc kpc qstat)
				)
			((in-inventory? kpc t_dragons_blood 1)
			  (begin
				(say knpc "���ΰ�Ĥ��ɤ��˱�����Ƥ��뤫�ΤäƤ��롣"
					 "ε�η��1�ӥ���äƤ���С��򴹤Ƕ����褦��"
					 "�ɤ����뤫�͡�")
				(if (kern-conv-get-yes-no? kpc)
					(begin
						  (quest-accepted! qstat #t)
						  (kern-obj-remove-from-inventory kpc 
														  t_dragons_blood 
														  1)
						  (kern-obj-add-to-inventory knpc
													 t_dragons_blood
													 1)
						  (say knpc "����ϵ������ܤǥӥ�򸫤�����"
							   "�����������줳�����䤬���Ƥ�����Τ���")
							(quest-data-update 'questentry-dragon 'done 1)
							(quest-data-complete 'questentry-dragon)
							(quest-data-assign-once 'questentry-dragon)
						  (alch-dragon-reward knpc kpc))
					(begin
						(say knpc "�����ࡢ��ν������ʤ��Ƥ⡢��������򷡤��֤��Ф��Ĥ��ϸ��Ĥ��������"
						"����Фꤿ�ޤ���")
						(quest-data-assign-once 'questentry-dragon)
					))
				))
			(#t
				(say knpc "�ʤ�и򴹤���"
				   "���ΰ�Ĥ�������פ�����Ƥ���ȶ���ʹ������"
				   "ε�η��1�ӥ���äƤ���С����ξ��򶵤��褦��")
				(quest-data-assign-once 'questentry-dragon)))
		(say knpc "�����ࡢ�ʤ�Ф褤�����ΰ�Ĥα��������ΤäƤ���Τ�����")))

(define (alch-more knpc kpc)
	(let ((qstat (alchq-dragon (gob knpc))))
		(say knpc "�����֤����ǤΤ��Ȥ�褯�ΤäƤ��롣"
			"�̤����Ǥ�õ���Ƥߤ����Ȥϻפ�󤫤͡�")
		(quest-data-update-with 'questentry-runeinfo 'abe 1 (quest-notify nil))
		(alch-dragon-quest knpc kpc qstat)
	))
		   
(define (alch-rune knpc kpc)
	(if (not (null? (quest-data-getvalue 'questentry-dragon 'rerune)))
		(alch-more knpc kpc)
		(begin
			(say knpc "����Ͽ��᤭Ω�ä��������Ǥ��ȡ����ޤǤ˲��٤��������Ȥ����롣"
			   "���Τ򸫤��Ƥ���ʤ�����")
			(if (kern-conv-get-yes-no? kpc)
				(if (in-inventory? kpc t_rune_k 1)
					(begin
					  (say knpc "��Ϥꤽ����������Ϥ��Ĥ���ƻ�դ����äƤ�����Τ��Ȼפ���"
						   "������ΤǤϤʤ��Ȼפ������ʡ�"
						   "Ʊ���褦�ʤ�Τ򤤤��Ĥ��ߤ����Ȥ����롣"
						   "���������˲�ä��ä��ʤ���Фʤ�ʤ��Τϥ����֤���")
							(quest-data-update 'questentry-dragon 'rerune 1)
						   (quest-data-update-with 'questentry-runeinfo 'abe 1 (quest-notify nil))
					  )
					(say knpc "�ɤ��ˤ�ʤ������⤷��ʤ������Τ���"))
				(say knpc "�����Ƥ����м�����Ǥ��뤫�⤷��ʤ���")))
		))

(define (alch-abe knpc kpc)
  (say knpc "��θŤ�������Τ�礤����"
       "�����Ф���ǰ��פ�Ĵ�٤Ƥ����ʹ���Ƥ��롣"))

(define (alch-drag knpc kpc)
  (say knpc "�ºݤˤϸ������Ȥ��ʤ���"
       "��������ε�η��������뤿��ˤϡ�ε���ݤ��ʤ���Фʤ�ʤ�������"
       "�Фγ��Τ�����Ǥϵ�Τ褦�ˤ��꤭����Τ�Τ���ʹ������"
			)
	(quest-data-update-with 'questentry-dragon 'sea 1 (quest-notify nil)))


;; The Wise...
(define (alch-necr knpc kpc)
  (say knpc "����ѻդȤϸŤ�������Τ�礤����"
       "���֥���åȤ��������ư��衢�ϲ������˰�������äƤ��롣"
       "����ʤ��Ȥ������������줫���äƤ��ʤ���"))

(define (alch-ench knpc kpc)
  (say knpc "��ƻ�դϰ�����μ��Τ�����ѻդ���"
       "��ǰ������Ȥϰո������ʤ����Ȥ�¿����"
       "�Ƕ�ϼ���줿�ԤΤ��ȤФ��굤�ˤ��Ƥ��롣"
       ))

(define (alch-man-reward knpc kpc)
	(say knpc "����λ�̮�ˡ���¦���̤�����̩������������롣��ɸ��[92,10]����"))

(define (alch-man knpc kpc)
  (let ((qstat (gob knpc)))
	  (say knpc "�ˤ󤲤�Ȥϲ�ä����Ȥ��ʤ���"
		   "�Ǥ�Ϸ�֤ʤʤ餺�ԤȤ���¸�ߤ���"
		   "���餯�������٤򱣤�Ȥ��ߤ��Ƥ���Ϥ�����"
		   "�⤷�䤬�����Ԥʤ顢��ʬ���Ȥ�õ���Ф����Ȥ��������"
		   "���Ϥɤ�����")
	  (if (kern-conv-get-yes-no? kpc)
		(cond
			((alchq-hydra? qstat)
				(say knpc "���ѤǤ���Ԥ��ˤ󤲤�α���Ȥ���������ɤ��ˤ��뤫�����Ƥ��줿��")
				(alch-man-reward knpc kpc))
			((in-inventory? kpc t_hydras_blood 1)
				(begin
					(say knpc "���ѤǤ���Ԥ��ˤ󤲤�α���Ȥ���������ɤ��ˤ��뤫�����Ƥ��줿��"
						"����Ϸ��λ��äƤ���1�ӥ�Υҥɥ�η�ȸ򴹤Ƕ����褦���褤�ʡ�")
					(if (kern-conv-get-yes-no? kpc)
						(begin
							(alchq-hydra! qstat #t)
							(kern-obj-remove-from-inventory kpc 
								t_hydras_blood 
								1)
							(kern-obj-add-to-inventory knpc
								t_hydras_blood
								1)
							(say knpc "����Ϥ�����ʪ���ߤ����Ƥ��ޤ�ʤ��ä��褦������"
								"���������襤���Ĥ��襤����")
							(say knpc "���ۥ�")
							(alch-man-reward knpc kpc))
						(say knpc "��ǰ�����������äƤ��Ƥⲿ����ˤ⤿���ʤ���"
							"�����ƻ�ϼ��˹Ԥ��ˤ�ǯ���ꤹ���Ƥ��롣"))))
			(#t 
				(say knpc "�����ࡢ¿���Τ��Ȥ�ʹ�������Ȥ����뤬���ۤȤ�ɤϤ����Τ��蘆����"
					"���������ѤǤ���Ԥ��ˤ󤲤�α���Ȥ���������ɤ��ˤ��뤫�����Ƥ��줿��"
					"�⤷1�ӥ�Υҥɥ�η����äƤ���ʤ顢������̩�򷯤�����������")))
	   (say knpc "���Ȥ������Ȥ����¤��ͤ衪"
			"���������Ԥ��ȻפäƤ����衣"))))

(define (alch-hydr knpc kpc)
  (say knpc "�ҥɥ�ϺǤ⺤���Ũ����"
       "�����ڤ�Ĥ���ȡ�����Ϥ�궯���ʤ��������ʹ������"
       "�������������Ȥ��Ǥ���С����η�ˤ��Τ�ͤ��Τ뤹�Ф餷�����ͤ����롣"))

(define (alch-warr knpc kpc)
  (say knpc "Ʈ�ΤȤϿ����ä����Ȥ����롣"
       "����λ�Ǧ��������Ū����"
       "�����������ܤˤϤȤƤ�ʪ�Ť���ͥ�����"
       "���֥���åȤ��˲��˻��ä���Τ������ʹ������"))

(define (alch-engi knpc kpc)
  (say knpc "���դȤϲ�ä����Ȥ��ʤ���"
       "��ʪ�α��ۼԤ���ʹ������"))

(define (alch-alch knpc kpc)
  (say knpc "����������ϻ�����䤬ϣ��ѻդ���")
  (quest-data-update 'questentry-alchemist 'found 1)
  (quest-data-complete 'questentry-alchemist)
  )


;; Absalot...
(define (alch-absa-reward knpc kpc)
	(say knpc "�Ф�����Ϥ�����˺֤����ä���"
		 "���饹�ɥ��˿������졢��ǰ���������ˤϿͤϤ��ʤ���"
		 "��ʪ�ɤ⤬��¤äƤ���С��������̤�Τϴ�����")
	(prompt-for-key)
	(say knpc 
		 "�������֤ؤθŤ�����ϩ������Τ���"
		 "�ǽ��ƶ������¦���ɤ�Ĵ�٤�"
		 "������ϩ�����Ĥ���Ϥ�����")
	(prompt-for-key)
	(say knpc
		 "����Ǥ�Ф�����Ϥ�ɬ�פ����롣"
		 "������������롣����˹���ա���Ǥ�פȸ����а������Ϥ�롣"
		 "����դ�񤭤Ȥ�Ƥ�����")
	(prompt-for-key)
	(say knpc
		 "������ϩ�ϼ���줿Į�ζ᤯�κ�ƻ���̾��ƻ�ȺƤӹ�ή���롣"
		 "����ɤ�ʴ������äƤ�ƨ�����ʤ�����������ˡ�ʤ����ñ�ˤ��ɤ��失��Ϥ�����"))

(define (alch-absa knpc kpc)
  (let ((qstat (gob knpc)))
    (say knpc "���֥���åȤؤ�ƻ�Τ�ϡ����������Ǥ�����˴����ä���"
         "�����عԤäƤߤ褦�Ȼפ����͡�")
    (if (kern-conv-get-yes-no? kpc)
        (cond
         ((alchq-lich? qstat)
          (alch-absa-reward knpc kpc))
         ((in-inventory? kpc t_lichs_blood 1)
          (say knpc "����1�ӥ�Υ�å��η�ȸ򴹤ǡ�����΢ƻ�򶵤��褦��"
               "�ɤ����뤫�͡�")
          (if (kern-conv-get-yes-no? kpc)
              (begin
                (alchq-lich! qstat #t)
                (kern-obj-remove-from-inventory kpc 
                                                t_lichs_blood 
                                                1)
                (kern-obj-add-to-inventory knpc
                                           t_lichs_blood
                                           1)
                (say knpc "����ϥ����󥯤����ۤۤ�������Ϥޤ��ˤ��줬���Ƥ�����Τ���")
                (alch-absa-reward knpc kpc))
              (say knpc "�狼�ä���"
                   "�ְ㤤�ʤ����ˤϤ��η��Ȥä����פʷײ褬����Τ��ʡ�"
                   "��Ͼ���̤������Ԥ���������뤳�Ȥ��Ǥ��롣")))
         (else
          (say knpc "1�ӥ�Υ�å��η����äƤ���Τ���"
               "�����������̩����ϩ�򶵤��褦��")))
        (say knpc "���ȤʤäƤϤ��������Ҥ���"
             "άå�ˤ��ä��Ȥ������Ƥ�����������"))))

(define (alch-sack knpc kpc)
  (say knpc "�������������ΤäƤ��뤫��"
       "���֥���åȤϥ��饹�ɥ���Ф��㡢�����ƥ��ѡ����η���ˤ�ä�άå���줿��"
       "��餬�����ˤϡ����֥���åȤϤ��μٰ��������������Τ�����������������䤫�˾Фä�����"))

(define (alch-esca knpc kpc)
  (say knpc "���Ļ䤬�������ä��Τ���"
       "�ʤ�����ʤ��Ȥ���ä��Τ�������"
       "���֥���åȤ���ƨ���褦�Ȥ����Ԥϡ�����ڤ���Ȥ���跺���줿��"))

(define (alch-wick knpc kpc)
  (say knpc "���������֥���åȤ����˼ٰ����ä��Τǡ����Ƥ��ˡ������Ҷ��������ڤ껦���줿��"
       "�桹�ˤȤäƹ������ä��Τϡ������Τ����Ϥ���������Τ���ιԤ����ȿ����Ƥ������Ȥ���"
       "�Τ��ʤ�����ΤĤꤢ���ä�����Ψľ�ʸ������ˡ�ȿ��Ū�ʤۤΤᤫ���򴶤���ä�����"))

(define (alch-lich knpc kpc)
  (say knpc "��å����Ի����ѻդ������ζ��Ǥ�¸�ߤϡ����줿������Ƥ����������뤳�Ȥ��Ǥ���"
       "�������Ի�η��Ĥ���뤳�Ȥ��Ǥ��롣���η�ϻ���Ѥˤ�����¿���λȤ�ƻ�����롣"
       "����ϻ������ǤϤʤ����ʡ�"))

;; The Accursed...
(define (alch-accu knpc kpc)
  (say knpc "����줿�ԤȤ���Ƥ���Τϡ�¿��������٤���Τ��Ȥθ����Ȥ���Ƥ�����̩�ν��Ĥ���"
       "�������ɤ��ޤǤ����蘆����ï��������Τ�������"))

;; Townsfolk
(define (alch-lia knpc kpc)
  (say knpc "̥��Ū��¸�ߤ���"
       "�⤷��ǽ�ʤ�С�����μ�����򤤤Ƥ�ꤿ������äȸ����С������Ǥ��Ƥ�褤��"
       "������ǯ���ȸ��äƤ��졪"))

(define alch-conv
  (ifc basic-conv
       (method 'default alch-default)
       (method 'hail alch-hail)
       (method 'bye alch-bye) 
       (method 'job alch-job)
       (method 'name alch-name)
       (method 'join alch-join)

       (method 'trad alch-trade)
       (method 'buy  alch-buy)
       (method 'sell alch-sell)
       (method 'poti alch-buy)

       (method 'rune alch-rune)
       (method 'more alch-more)
       (method 'drag alch-drag)

       (method 'necr alch-necr)
       (method 'ench alch-ench)
       (method 'man  alch-man)
       (method 'hydr alch-hydr)
       (method 'warr alch-warr)
       (method 'engi alch-engi)
       (method 'alch alch-alch)

       (method 'absa alch-absa)
       (method 'sack alch-sack)
       (method 'esca alch-esca)
       (method 'wick alch-wick)
       (method 'lich alch-lich)

       (method 'accu alch-accu)

       (method 'lia alch-lia)
       (method 'abe alch-abe)

       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-alchemist)
  (bind 
   (kern-char-arm-self
    (kern-mk-char 
     'ch_alchemist ;;.....tag
     "ϣ��ѻ�" ;;.......name
     sp_human ;;.....species
     oc_wright ;;...occupation
     s_companion_tinker ;;......sprite
     faction-men ;;..faction
     0 ;;............custom strength modifier
     4 ;;............custom intelligence modifier
     1 ;;............custom dexterity modifier
     0 ;;............custom base hp modifier
     0 ;;............custom hp multiplier (per-level)
     0 ;;............custom base mp modifier
     0 ;;............custom mp multiplier (per-level)
     max-health ;;..current hit points
     -1  ;;...........current experience points
     max-health ;;..current magic points
     0
     8  ;;..current level
     #f ;;...........dead?
     'alch-conv ;;...conversation (optional)
     sch_alch ;;.....schedule (optional)
     'townsman-ai ;;..........custom ai (optional)
     nil ;;..........container (and contents)
     (list t_dagger
				t_armor_leather
				)  ;;......... readied arms (in addition to the container contents)
     nil ;;..........hooks in effect
     ))
   (alch-mk)))
