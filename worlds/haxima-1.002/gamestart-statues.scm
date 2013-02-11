(define (gsstatue-unknown knpc kpc)
  (say knpc "���������ۤ����ޤޤ���"))

(define (gsstatue-hail knpc kpc)
  (say knpc "�������ä������Ƥ�����")
  (gamestart-statue-clean knpc "statspeak")
  )
    
(define gsstatue-conv
  (ifc '()
       ;; fundamentals
       (method 'default gsstatue-unknown)
       (method 'hail gsstatue-hail)
       )
       )

(define (gsstatue-dostat knpc kpc iname iset iget dname dset dget initial)
	(define (gs-check-upper value)
		(if (> value 11)
			(begin
				(say knpc "����ʾ塢���" iname "��夲�뤳�ȤϤǤ��̡�")
				#t
				)
			#f))
	(define (gs-check-lower value)
		(if (< value 1)
			(begin
				(say knpc "����ʾ塢���" dname "�򲼤���٤��ǤϤʤ���")
				#t
				)
			#f))
	(define (gs-initialcheck)
		(say knpc dname "��" iname "�˴����뤫��")
		(if (kern-conv-get-yes-no? kpc)
			#f #t)
		)
	(define (gs-repeatcheck)
		(say knpc "³���뤫��")
		(if (kern-conv-get-yes-no? kpc)
			#f #t)
		)
	(let ((ival (iget kpc))
			(dval (dget kpc))
			)
		(cond ((gs-check-upper ival))
			((gs-check-lower dval))
			((and initial (gs-initialcheck)) (say knpc "��ΰդΤޤޤˡ�"))
			((and (not initial) (gs-repeatcheck)) (say knpc "��ΰդΤޤޤˡ�"))
			(#t
				(iset kpc (+ ival 1))
				(dset kpc (- dval 1))
				(say knpc "[���ʤ���" iname "���夬�ä�]")
				(say knpc "[���ʤ���" dname
					(cond ((< dval 3) "����ޤä���]")
						((< dval 9) "�������ä�]")
						(#t " wanes]")
					)
				)
				(gamestart-reset-lamps kpc)
				(gsstatue-dostat knpc kpc iname iset iget dname dset dget #f)
			)
		)	
	))
		       
;; Statue of intelligence

(define (gs-int-hail knpc kpc)
  (say knpc "�褦������õ��Ԥ衣�����Τˤ���ǽ��Ϳ���褦��")
  (gamestart-statue-clean knpc "statspeak")
  )
  
(define (gs-int-job knpc kpc)
	(say knpc "I represent the force of reason, and can assist you in endeavors of magic or wit.")
	)
  
(define (gs-int-assi knpc kpc)
	(say knpc "I can raise your intellect, but it will cost you some of your strength or dexterity")
	)

(define (gs-int-rais knpc kpc)
	(say knpc "You will need to say which attribute you want to suffer the penalty")
	)
		
;; expand on this as other abilities become available
(define (gs-int-inte knpc kpc)
  (say knpc "�����Ԥ����Ϥ����߽Ф������դ���ԤνѤ��Ǥ��ä��������򤫤ʼԤ��Ǥ蘆�졢�ưפ˵�����롣"
       "õ��Ԥ衢����Ĥ��뤬�褤���ٰ�����ǽ����Ԥ���ιԤ�ƻ���Ԥ������Ƥ��롣"
       "���μԤ�������ۤ���ˤ����Ϥ�ɬ�פ�����Ϥ�����ߤ��뤫��")
  (if (yes? kpc)
      (say knpc "���Ϥ����뤿��ˤϡ����Ϥ��Ҿ����Τ����줫�򺹤��Ф��ͤФʤ�ʤ���")
      (say knpc "���Ϥ�󤶤���Ԥϰ���򴿴���������")
      )
  )
	
(define (gs-int-stre knpc kpc)
  (say knpc "ʹ����õ��Ԥ衪���ϤǤϰǤκǤ⶯���Ϥ�Ω�����������ȤϤǤ��̤Ǥ�����")
  (gsstatue-dostat knpc kpc "��ǽ" kern-char-set-intelligence kern-char-get-base-intelligence 
                   "����" kern-char-set-strength kern-char-get-base-strength #t)
  )
      
	
(define (gs-int-dext knpc kpc)
  (say knpc "�ͤ��衢õ��ԡ��Ǥ�®����ΰ��⡢�ٰ��ʹ���ѻդˤ�������̤�����"
       "���������Ϥ��������줿��Ϥ��������뤳�Ȥ��Ǥ��ʤ���")
  (gsstatue-dostat knpc kpc "��ǽ" kern-char-set-intelligence kern-char-get-base-intelligence 
                   "�Ҿ���" kern-char-set-dexterity kern-char-get-base-dexterity #t)
  )

(define (gs-int-bye knpc kpc)
  (say knpc "�Ԥ���õ��Ԥ衣������Ϥ��򼫿Ȥ��ꡢ���Ԥ��줿�Ԥ��������������Ծ��ʼԤξ�˱����ι뱫��ߤ餻�󤳤Ȥ�")
  )

(define gs-int-conv
  (ifc '()
       ;; fundamentals
       (method 'default gsstatue-unknown)
       (method 'bye gs-int-bye)
       (method 'hail gs-int-hail)
       (method 'job gs-int-inte)
       (method 'inte gs-int-inte)
       (method 'int gs-int-inte)
       (method 'wis gs-int-inte)
       (method 'wisd gs-int-inte)
       (method 'stre gs-int-stre)
       (method 'str gs-int-stre)
       (method 'dext gs-int-dext)
       (method 'dex gs-int-dext)
       )
  )
       
;; Statue of might

(define (gs-str-hail knpc kpc)
  (say knpc "�褦������õ��Ԥ衣���������Ԥˤ����Ϥ�Ϳ���褦��")
  (gamestart-statue-clean knpc "statspeak")
  )
  
;; expand on this as other abilities become available
(define (gs-str-stre knpc kpc)
	(say knpc "���Ϥ�����С����Ũ�γ����ꡢ����դ������ʴ�դǤ���Ǥ�����"
             "�Ǥ�Ť��������뤳�Ȥ��Ǥ���Ũ���Ƿ�ϰ�̣��ʤ��̤Ǥ�����"
             "���ϤϺǤ���פʤ�ΤǤϤʤ���ͣ��ɬ�פʤ�ΤǤ��롪"
             "����Ϥ���뤫��")
        (if (yes? kpc)
            (say knpc "���ϤΤ���������衣��ǽ��������Ȥ��Ҿ�������")
            (say knpc "��ιԤ�����򼫿Ȥ�ߤ��Τ��ϤΤߤǤ��롣")
            ))
	
(define (gs-str-inte knpc kpc)
  (say knpc "��Τˤ����Ѥ���ɬ�פ����������Ǥ�ɬ�פʤΤ����ϤǤ��롪")
  (gsstatue-dostat knpc kpc "����" kern-char-set-strength kern-char-get-base-strength 
                   "��ǽ" kern-char-set-intelligence kern-char-get-base-intelligence #t)
  )
	
(define (gs-str-dext knpc kpc)
  (say knpc "���ͧ���Ҿ�����̯�������ܤ��������"
       "�����������Ũ���ϤǤΤ������Ǥ���Ǥ�����")
  (gsstatue-dostat knpc kpc "����" kern-char-set-strength kern-char-get-base-strength 
                   "�Ҿ���" kern-char-set-dexterity kern-char-get-base-dexterity #t)
  )

(define (gs-str-bye knpc kpc)
  (say knpc "�Ԥ��������ư��˰���Ϳ����Τ���"))

(define gs-str-conv
  (ifc '()
       ;; fundamentals
       (method 'default gsstatue-unknown)
       (method 'bye gs-str-bye)
       (method 'hail gs-str-hail)
       (method 'job gs-str-stre)
       (method 'stre gs-str-stre)
       (method 'inte gs-str-inte)
       (method 'int gs-str-inte)
       (method 'dext gs-str-dext)
       (method 'dex gs-str-dext)
       )
  )
       
;; Statue of agility

(define (gs-dex-hail knpc kpc)
  (say knpc "�褯�����ä���õ��Ԥ衣����������٤μԤ����Τ褦�ˡ���˽ä��Ϥ⡢��ζ��γؼԤ����Ϥ�Ϳ���뤳�Ȥ��Ǥ��̡�"
       "�����Ҿ���������뤳�ȤϤǤ��롣")
  (gamestart-statue-clean knpc "statspeak")
  )
  
(define (gs-dex-dext knpc kpc)
  (say knpc "�Ҿ�����ͭǽ�������Ԥ�ɬ�פǤ��롣�ɤΤ褦�˸��γݤ��ä�����Ǥ��ˤ롩\n\n"
       "����Ȥȴ��Ѥ��������ưפ˸��Ĥ����Ȥ����ɤΤ褦�ˤ��ӽ�����ѽ���ܤ�ƨ��롩\n\n"
       "Ũ���󤯤������Ť˷�äƤ����Ȥ����ɤΤ褦�˺������Ǥ褤�������򤹤롩\n\n"
       "���ˡ����٤�Ƚ�Ǥ��٤�ϵ��Ϥ򾷤������ᤤ�ȤΤ��ʤ��ȷ��ǤϾ�����⤿�餹�Ǥ�����"
       "��⤽���ͤ��뤫��")
  (if (yes? kpc)
      (say knpc "�����̤ꡣ�Ҿ����϶��ߤ����Ϥ����ܤ���ǽ�����ˤ�����ͤ����롣")
      (say knpc "���������ࡣͧ�衢���ۤ˵���Ĥ��衣��ͤϤΤ�ޤʵ����Ԥ򹥤��Τ���")
      )
  )
	
(define (gs-dex-inte knpc kpc)
  (say knpc "��ǽ��ɾ�����줹���Ƥ���Ȳ�ϻפ���"
       "˴������άå�Ǥ���Ȥ��ˡ�ï�⤽��˴�������������褦�ʤɤȤϻפ�ʤ����Ȥ������Ȥ���")
       (gsstatue-dostat knpc kpc "�Ҿ���" kern-char-set-dexterity kern-char-get-base-dexterity 
                        "��ǽ" kern-char-set-intelligence kern-char-get-base-intelligence #t)
       )
	
(define (gs-dex-stre knpc kpc)
  (say knpc "���Ϥϱƶ�������䤹���Ԥˤ�ͦ�ޤ����ƶ���Ϳ���������"
       "������������ȳ���������֤Τ�̵��̣�ʶ�ϫ�Τ褦�˻פ��롣")
  (gsstatue-dostat knpc kpc "�Ҿ���" kern-char-set-dexterity kern-char-get-base-dexterity 
                   "����" kern-char-set-strength kern-char-get-base-strength #t)
  )

(define (gs-dex-bye knpc kpc)
  (say knpc "����С���˵��ΤȤȤ�ˤ��졣"
       "�����ൡ��⡢��������������ʭ���뵡��⡢ƨ���ƤϤʤ�̡�"
       "�����Ƥ����ʤ�Ȥ��⡢õ��Ԥ衢�褤������򤹤뤳�Ȥ�˺��ƤϤʤ�̡�")
  )

(define gs-dex-conv
  (ifc '()
       ;; fundamentals
       (method 'default gsstatue-unknown)
       (method 'bye gs-dex-bye)
       (method 'hail gs-dex-hail)
       (method 'job gs-dex-dext)
       (method 'dex gs-dex-dext)
       (method 'dext gs-dex-dext)
       (method 'stre gs-dex-stre)
       (method 'str gs-dex-stre)
       (method 'inte gs-dex-inte)
       (method 'int gs-dex-inte)
       )
  )
