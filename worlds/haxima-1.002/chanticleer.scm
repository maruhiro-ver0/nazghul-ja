;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;;
;; �ȥꥰ�쥤��
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_chant
               (list 0  0  trigrave-east-west-road   "drunk")
               (list 2  0  trigrave-chants-bed       "sleeping")
               (list 12 0  trigrave-tavern-hall      "working")
               (list 23 0  trigrave-east-west-road   "drunk")               
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (chant-mk) (list 0))
(define (chant-get-gold knpc) (car (kobj-gob-data knpc)))
(define (chant-has-gold? knpc) (> (chant-get-gold knpc) 0))
(define (chant-set-gold! knpc amount) 
  (if (>= amount 0)
      (set-car! (kobj-gob-data knpc) 
                amount)))
(define (chant-dec-gold! knpc) (chant-set-gold! knpc 
                                                (- (chant-get-gold knpc)
                                                   1)))

;; ----------------------------------------------------------------------------
;; ����ɥ�
;;
;; ����ɥ��ι�ζ�ͷ��ͤ�¿���λ��֤�ȥꥰ�쥤�֤ǲᤴ���Ƥ��롣��Ϥ����餫
;; �ʼ����Ȥǡ����ߤǤ��ʤ��ݿͤǤ⤢�롣��ˤ�¿�����������μ������ꡢ���蘆��
;; ��ʹ�򰦤��Ƥ��ơ��͡��ʿ�ʬ��ͧ��(�����˸���ʤ���ƻ�դ�ޤ�)�����롣������
;; �⤷������ȡ�ï���Ρץ��ѥ����⤷��ʤ���������Ϥ狼��ʤ���
;; ----------------------------------------------------------------------------
(define (chant-song knpc kpc)
  (if (isdrunk? knpc)
      (say knpc "�����ߤ�ʤǡ��������������ο�ʼ���󡪡Υҥåҥåҡ�")
      (begin
        (say knpc "��βΤ��ͤδ��������Ȥ���ݣ�θ��������ԤäƤ��롪"
             "�⤷������Ⱦ����ζ�ߤ�ݣ������뤫�⡩"
             "����ϴ��Ԥ���褦�ˤ��ʤ��򸫤Ƥ��롣��ˤ����餫�ζ�ߤ�Ϳ���롩��")
        (if (kern-conv-get-yes-no? kpc)
            ;; yes - give chant some gold
            (let ((amount (kern-conv-get-amount)))
              (display "amount=")(display amount)(newline)
              (cond ((= 0 amount) 
                     (say knpc "�����ʤ���ߤˤ�ʹ�����ʤ��Τ�"
                          "����ϥ�塼�Ȥ��Ƥ��ޤͤ򤷤�����"))
                    ((< amount 2)
                     (say knpc "�����Ĥ狼��ޤ����������ޤ��衣\n"
                          "\n"
                          "���� �ȤäƤ⥱�����¤���\n"
                          "������򤤤äѤ�����Ȥ�����\n"
                          "������ʥ���ɥ�򤢤��Фä��Τ�\n"
                          "���Ҥɤ����Ǽ��򤤤äѤ��ˤ��Ƥ�롪\n"
                          "\n"
                          "����Ϲӡ����������ǲΤ����������򤷤�����"))
                    (else
                     (say knpc "�ͤο����������줿��"
                          "�������ɤ����������¡�����"
                          "����Ȥ�˺���줿��ꡩ")
                     (chant-set-gold! knpc amount))))
            ;; no -- don't give him some gold
            (say knpc "����դλ�ͤ�ï�ˤⲿ�⤷�ʤ��Τ���")))))

(define (chant-fen knpc kpc)
  (if (isdrunk? knpc)
      (say knpc "���ͤ��Ȥ����Υҥå���")
      (if (not (chant-has-gold? knpc))
          (chant-song knpc kpc)
          (begin
            (chant-dec-gold! knpc)
            (say knpc 
                 "������\n"
                 "\n"
                 "���� �⤷�⤢�ʤ����������ʤ�\n"
                 "�����ۤ���������¤�\n"
                 "��ͫݵ�ʶ������ͤ��餤�Υ����뤬\n"
                 "������κ��Ť���ť���ͤޤä�����\n"
                 "��˺���줿�����⤬(�褽�Ԥ�ٲ����Ƥ���)\n"
                 "��ƻ�ʤ����Ϥ�\n"
                 "����å�����ͩ�\n"
                 "����������Τ���\n"
                 "�������ʤ�С�ͧ��\n"
                 "���̤ξ��ϤعԤ���������\n"
                 "�������Ϥ��ʤ��ξ���")))))

(define (chant-forest knpc kpc)
  (if (isdrunk? knpc)
      (say knpc "��������������������Υҥåҥåҡ�")
      (if (not (chant-has-gold? knpc))
          (chant-song knpc kpc)
          (begin
            (chant-dec-gold! knpc)
            (say knpc 
                 "��ο�\n"
                 "\n"
                 "���� ������Ũ�ʤȤ����Ť��ƿ�����\n"
                 "�����ĤǤ⵲���Ƥ��롪\n"
                 "��ι�ͤ򤿤����󿩤٤�\n"
                 "�������Ʋ��ͤ���߹����\n"
                 "\n"
                 "�����֥��ν��߲Ȥ���±�α����\n"
                 "�������Ƶ��祯�����\n"
                 "�����˹Ԥ��Ȥ���˺����\n"
                 "���Υ�ޤʥХ���Ϣ��ƹԤ��Τ�\n"
                 )))))

(define (chant-forgotten knpc kpc)
  (if (isdrunk? knpc)
      (say knpc "˺�줿������ϵ㤭�ʤ���Фä�����")
      (if (not (chant-has-gold? knpc))
          (chant-song knpc kpc)
          (begin
            (chant-dec-gold! knpc)
            (say knpc 
                 "����줿��Ʋ \n"
                 "\n "
                 "���� ���������Ȥ����\n"
                 "���Ť��Ԥ��ܤ�Фޤ�\n"
                 "������ʪ����ΤäƤ뤫\n"
                 "��(ʪ��ϸ���ʤ��ä���)\n"
                 "��˰���⤻���ͤϸ�롪\n"
                 "\n "
                 "�α��դ�ߤ᤿����Ĵ�٤˹Ԥ��ʤ���Фʤ�ʤ��ʤä��顢"
                 "��α�ߤعԤ��Ф�����")
		 (if (null? (quest-data-getvalue 'questentry-rune-l 'know-hall))
			(quest-data-update-with 'questentry-rune-l 'approx-hall 1 (quest-notify nil))
		)
		 ))))

(define (chant-thie knpc kpc)
  (if (isdrunk? knpc)
      (say knpc 
           "���إ����ऺ���ʤ��ʤ�\n"
           "�����Ϥޤ�ʤ��ˤ��롪\n"
           "�����륷�ե���������˸����ä�����ķ�ͤ�\n"
           "�����츫�ƻ���ѻդ��Ф�\n"
           "��������ť�������Ǥ���������Ф���")
      (say knpc "�ޡ������Ϸ���õ��������ť���Ϥ���Į���򤱤Ƥ��ä��Ϥ�����"
           "�Ǥ⡢ι�ͤϸ������⤷��ʤ������٥��ʹ���Ƥߤʤ衣")))

(define (chant-man knpc kpc)
  (if (isdrunk? knpc)
      (begin
        (say knpc "�ʤ�����̩����뤫����")
        (if (yes? knpc)
            (begin
              (say knpc "�ˤ󤲤����̩��ƶ���ˤ��롣�ɤ����ΤäƤ뤫����")
              (if (yes? kpc)
                  (say knpc "���ͤ�������Υҥåҥåҡ���")
                  (say knpc "[" 
                       (loc-x the-mans-hideout-loc) "," 
                       (loc-y the-mans-hideout-loc) 
                       "]�λ��������λ�����ͤ����ԤäƤӤӤ餻�Ƥ�졪")))
            (say knpc "���ͤ�Ǥ��ͤ��������ɡ���Ĥ餷������")))
      (say knpc "�ˤ󤲤󡩤ˤ󤲤�Τ��Ȥ��Τ�ʤ��ʤ����ʤ��ͤ�ʹ���Ρ�")))

(define chant-conv
  (ifc basic-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default 
               (lambda (knpc kpc) 
                 (if (isdrunk? knpc)
                     (say knpc "��äƤ��������ġΥҥå���")
                     (say knpc "���ä��ʤ���"))))
       (method 'hail 
               (lambda (knpc kpc)
                 (if (isdrunk? knpc)
                     (say knpc "�ο�äѤ餤�ʤ���ϾФäơ���������")
                     (say knpc "�褦�������郎ͧ�衪"))))
       (method 'bye 
               (lambda (knpc kpc) 
                 (if (isdrunk? knpc)
                 (say knpc "�ХХХХ��Х��ξФ��ʤ����")
                 (say knpc "ƻ������­�˥������ޤ��褦�ˡ�"))))
       (method 'job 
               (lambda (knpc kpc) 
                 (if (isdrunk? knpc)
                     (say knpc "�Τ��������ʿȿ���ǡ���ϼ�ʬ���ܤ�غ�����"
                          "����غ����������Ƹ���ɤ�ư��򤷤ơ�"
                          "���ޤ���Ǥ��ʤ����������󥯤�������")
                     (say knpc "�ηäȲΤα��Ӽꤵ��"))))
       (method 'name 
               (lambda (knpc kpc)
                 (if (isdrunk? knpc)
                     (say knpc "����ɥꡪ�Τ������򤷤褦�Ȥ����ݤ줿����")
                     (say knpc "��ͷ��ͤΥ���ɥꡢ�ʤ�Ǥ�ɤ�����"
                          "�Τ������򤷤�������ä�����"))))
       (method 'join 
               (lambda (knpc kpc) 
                 (if (isdrunk? knpc)
                     (say knpc "������֤�����"
                          "�ԤäƤޤ�������")
                     (say knpc "ι�򤹤��ͤ�����С���ؤʼԤ⤤�롣"
                          "�ͤϸ�����ʤΤ���"))))

       (method 'chan
               (lambda (knpc kpc)
                 (if (isdrunk? knpc)
                     (say knpc "�Υҥå����Ϣ��㤭���礦���Ρ����������Ρ��Х���Ϻ�Ϥ��������\n"
                          "ï���äλҤ�˫����Τ���")
                     (say knpc "\n"
                          "\n"
                          "���� �������������Ƥ��ʻ�ͤϤ����졩\n"
                          "���Τ���˥�塼�Ȥ��Ƥ��ΤϤ����졩\n"
                          "������α�̿�Τ��ä��ä���������\n"
                          "���ह�٤���̿�����ʱ��ʤ顩"))))
       (method 'earl
               (lambda (knpc kpc)
                 (if (isdrunk? knpc)
                     (say knpc "����ʥܥ����ۤϸ������Ȥͤ���")
                     (say knpc 
                          "�ͤ�Τ��Ф餷��Ź���\n"
                          "\n"
                          "���� �Τϱ�μ���ä� \n"
                          "�����̾��夲�� \n"
                          "���Ǥ⡢���Ƥ��̤� \n"
                          "��������ˡ�˼��Ф��� \n"
                          "��������̾����פ��Ф��ʤ���"
                          ))))

       (method 'ench
               (lambda (knpc kpc)
                 (if (isdrunk? knpc)
                     (say knpc "�ޡ�����������Ǻ¤äơ�"
                          "��ˡ�ؤ������ʤ���̿�ᤷ�Ƥ����ʤ���")
                     (say knpc 
                          "��ƻ�դ����ι���뤳�Ȥ⤢��ޤ��衣"))))
       (method 'gwen
               (lambda (knpc kpc)
                 (if (isdrunk? knpc)
                     (say knpc "����Ϥ��ʤ��ˤ⤿�줫���ꡢ�����Ǹ��ä�����"
                          "��������Ϸ�����äƤ������ͤ���")
                     (say knpc
                          "��������¿���ɲ��ν���͡�\n"
                          "\n"
                          "���� ������ȷ���ޤ�ή���Ȥ�\n"
                          "���������ߤ�̲��\n"
                          "��������̸�Τ褦��˴������Ȥ�\n"
                          "���ե����Ϸ����������\n"
                          "���Ť�����˿Ҥͤ�\n"
                          "��������������ΤäƤ��롪"))))
       (method 'fen chant-fen)
       (method 'fore chant-forest)
       (method 'wood chant-forest)
       (method 'forg chant-forgotten)
       (method 'jim
               (lambda (knpc kpc)
                 (if (isdrunk? knpc)
                     (say knpc "���Τ�΢�֤��������Υ��åס���")
                     (say knpc
                          "���äȡ�����ʤ��蘆�⤢��ޤ��衪\n"
                          "\n"
                          "���� �ĵԤ�����\n"
                          "�����줬���Ф餷������\n"
                          "�����Ϸ��Ǩ��Ƥ���\n"
                          "���ʤ�����Ǥ��ݤ�\n"
                          "�������Ϥ򤫤��ä�\n"
                          "�������Ƽ���줿Ź�˾ä�������\n"
                          ))))
       (method 'roun
               (lambda (knpc kpc)
                 (if (isdrunk? knpc)
                     (say knpc "���������ͤϸ�ĥ�äƤ�����"
                          "�����Ĥ�˵���Ĥ����")
                     (say knpc "���Ǥ���ʤ��Ȥ�ʹ���Ρ���"))))
       (method 'song chant-song)
       (method 'them
               (lambda (knpc kpc)
                 (if (isdrunk? knpc)
                     (say knpc "�Τ����䤭�Ϥ����Ĥ顪���Ԥ�Ũ�����������á�")
                     (say knpc "�ε����褦�ˤ��ʤ��򸫤�����"
                          "�������礦�֤�����"))))
       (method 'thie chant-thie)
       
       (method 'towe
               (lambda (knpc kpc)
                 (if (isdrunk? knpc)
                     (say knpc "ͫ���ĤʤȤ�������")
                     (say knpc
                          "�̤μ����ӤǸ����ޤ��衣"
                          "�Ǥ⤽���عԤ������Τʤ顢"
                          "��ƻ�դ���Ҥ򹥤ޤʤ����Ȥ�Ф��Ƥ����Ƥ���������"))))

       (method 'wit
               (lambda (knpc kpc)
                 (say knpc "�����������Ϥ����Τ��蘆�ä���"
                      "̾��������С����οͤΤ��蘆��ʹ�����ޤ��衣")))
       (method 'lost
               (lambda (knpc kpc)
                 (say knpc "��������������Ū�ʼ���줿��Ʋ�βΤ��Τ�ʤ���С��ͤ϶�ͷ��ͤˤϤʤ�ʤ��ä��Ǥ��礦�͡�")))
       (method 'man chant-man)
       (method 'wrog chant-man)
       ))
