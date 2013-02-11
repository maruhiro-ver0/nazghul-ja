;;----------------------------------------------------------------------------
;; ����Ū�ʲ���
;;----------------------------------------------------------------------------

;; ����
(define (generic-hail knpc kpc)
  (say knpc "����ˤ��ϡ�"))

(define (generic-unknown knpc kpc)
  (say knpc "����ϸ����ʤ���"))

(define (generic-bye knpc kpc)
  (say knpc "���褦�ʤ顣")
  (kern-conv-end))

(define (generic-join knpc kpc)
  (say knpc "��֤ˤϤʤ�ʤ���"))

(define (generic-leav knpc kpc)
  (cond ((is-player-party-member? knpc)
         (cond ((is-only-living-party-member? knpc)
                (say knpc "�ޤ��¤��ͤ��������ʤ���Фʤ�ʤ���"
                     "����Ȥ���Τ��ѻդ���äƤ��ޤ�������"))
               (else
                (say knpc "��֤��鳰����ߤ�����")
                (cond ((yes? kpc)
                       (cond ((kern-char-leave-player knpc)
                              (say knpc "�������ԤäƤ���Τǡ������Ѥ�ä����ä��������ߤ�����")
                              (kern-conv-end)
                              )
                             (else 
                              (say knpc "�����̤���ʤ���"))))
                      (else
                       (say knpc "����ưž�����衣"))))))
         (else
          (say knpc "���ʤ�ã�ΰ���ǤϤʤ���"))))

;; ����
(define (basic-ench knpc kpc)
  (say knpc "��ƻ�դ���ˡ�Ȥ��θ��Ԥ���"
       "�����Ӥ���˽���Ǥ��롣�������Τꤿ������")
  (quest-wise-subinit 'questentry-enchanter)
  (quest-data-update 'questentry-enchanter 'general-loc 1)
  (if (yes? kpc)
      (let ((kplace (get-place knpc)))
        (cond ((equal? kplace p_westpass)
               (say knpc "�Ϥ����򲼤�����¦�ؤ�ƻ�˹Ԥ��롣"
                    "�����ˤ��뵳�Τ�ƻ���ΤäƤ��������"))
              ((equal? kplace p_eastpass)
               (say knpc "ƻ����˿ʤ�ȥȥꥰ�쥤�֤���������ʹ���Ȥ褤������"))
              ((equal? kplace p_trigrave)
                (quest-data-update 'questentry-calltoarms 'directions 1)
               (say knpc "ƻ���̤عԤ��ȼ����Ӥ���"))
              (else 
               (say knpc "�����Ӥ������ˤ��롣"))
        ))))

;; Į
(define (basic-trig knpc kpc)
  (say knpc "�ȥꥰ�쥤�֤�������Ĥ����ή������ˤ��뾮����Į����"))

(define (basic-gree knpc kpc)
  (say knpc "�������������Ф���Ͽ��α������ˤ��롣"
       "�������Τꤿ������")
  (if (yes? kpc)
      (let ((kplace (get-place knpc)))
        (cond ((equal? kplace p_westpass)
               (say knpc "ƻ����˿ʤߡ��������롣"
                    "��ƻ���������顢����򤿤ɤäƤ����Ф褤������"))
              ((equal? kplace p_eastpass)
               (say knpc "���ΤϤ����򲼤ꡢ��¦�ؤ�ƻ�Ƿ�������˿Ҥͤʤ�����"))
              ((equal? kplace p_trigrave)
               (say knpc "ƻ����˿ʤ߻����������¦�ؤ�ƻ����"
                    "������ʹ���Ȥ褤������"))
              ((equal? kplace p_enchanters_tower)
               (say knpc "��عԤ��ȥȥꥰ�쥤�֤���������ʹ���Ȥ褤������"))
              ((equal? kplace p_oparine)
               (say knpc "�̤عԤ��ȥȥꥰ�쥤�֤���������ʹ���Ȥ褤������"))
              ((equal? kplace p_moongate_clearing)
               (say knpc "ƻ����ؿʤ�ȸ���������Τǡ����ؿʤࡣ"
                    "ƻ���̤ظ����ä��餽�Τޤ޿ʤߡ���ο�������Ȥ褤������"))
              (else 
               (say knpc "��������ˤ��롣"))
              ))))

(define (basic-bole knpc kpc)
  (say knpc "�ܥ��¼�Ͽ����̤ˤ��뻳̮��ë�֤ˤ��롣"
       "�������Τꤿ������")
  (if (yes? kpc)
      (let ((kplace (get-place knpc)))
        (cond ((equal? kplace p_westpass)
               (say knpc "������������ˤ��롣��̮�򤿤ɤäƹԤ��Ȥ褤������"))
              ((equal? kplace p_eastpass)
               (say knpc "���ΤϤ����򲼤ꡢ��¦�ؤ�ƻ�Ƿ�������˿Ҥͤʤ�����"))
              ((equal? kplace p_trigrave)
               (say knpc "ƻ����˿ʤ߻����������¦�ؤ�ƻ����"
                    "������ʹ���Ȥ褤������"))
              ((equal? kplace p_green_tower)
               (say knpc "�̤ο���ȴ������̮�Τդ�Ȥޤǿʤࡣ"
                    "���θ塢������ظ������ȹԤ��������"))
              ((equal? kplace p_enchanters_tower)
               (say knpc "��عԤ��ȥȥꥰ�쥤�֤���������ʹ���Ȥ褤������"))
              (else 
               (say knpc "�����̤ˤ��뻳̮�Τդ�Ȥˤ���Ȼפ���"))
              ))))
              
(define (basic-absa knpc kpc)
  (say knpc "����������Į���֥���åȤϡ����κ������������"))

(define (basic-opar knpc kpc)
  (say knpc "���ѡ����������ο����Ѥζ᤯�ˤ��롣"
       "�������Τꤿ������")
  (if (yes? kpc)
      (let ((kplace (get-place knpc)))
        (cond ((equal? kplace p_westpass)
               (say knpc "�Ϥ����򲼤ꡢƻ�����ˤ��ɤ�Ȥ褤������"))
              ((equal? kplace p_eastpass)
               (say knpc "ƻ�����ˤ��ɤ�Ȥ褤������"))
              ((equal? kplace p_trigrave)
               (say knpc "ƻ�����ˤ��ɤꡢ���Τ��ȳ��ޤǤ��ä���˿ʤ�Ȥ褤������"))
              ((equal? kplace p_green_tower)
               (say knpc "���ƻ�򤿤ɤꡢ���Τ������عԤ�����¦�ؤ�ƻ���������Ƿ�������˿Ҥͤ�Ȥ褤������"))
              ((equal? kplace p_enchanters_tower)
               (say knpc "��˥ȥꥰ�쥤�֤����롣�����ǿҤͤ�Ȥ褤������"))
              ((equal? kplace p_glasdrin)
               (say knpc "��˿ʤ�Ȥ褤������"))
              ((equal? kplace p_oparine)
               (say knpc "��������������"))
              (else 
               (say knpc "��ߤΤɤ����ˤ��롣"))
              ))))

(define (basic-east knpc kpc)
  (say knpc "Eastpass guards the eastern pass into the River Plain. Do you need directions?")
  (if (yes? kpc)
      (let ((kplace (get-place knpc)))
        (cond ((equal? kplace p_westpass)
               (say knpc "Take the ladder down, you'll come out in Eastpass."))
              ((equal? kplace p_eastpass)
               (say knpc "You're here already."))
              ((equal? kplace p_trigrave)
               (say knpc "Follow the road east and you'll run right into it."))
              ((equal? kplace p_green_tower)
               (say knpc "Travel west through the woods, then follow the road west to Westpass and ask there."))
              ((equal? kplace p_enchanters_tower)
               (say knpc "Go south to Trigrave and ask there."))
              ((equal? kplace p_glasdrin)
               (say knpc "Take the road south as far as you can and ask there."))
              ((equal? kplace p_oparine)
               (say knpc "Take the road north to Trigrave and ask there."))
              (else 
               (say knpc "It's by the mountains west of the Great Forest."))
              ))))

(define (basic-west knpc kpc)
  (say knpc "Westpass guards the western pass into the Great Forest. Do you need directions?")
  (if (yes? kpc)
      (let ((kplace (get-place knpc)))
        (cond ((equal? kplace p_westpass)
               (say knpc "This is it."))
              ((equal? kplace p_eastpass)
               (say knpc "Take the ladder down and you'll come out in it."))
              ((equal? kplace p_trigrave)
               (say knpc "Follow the road east and ask in Eastpass."))
              ((equal? kplace p_green_tower)
               (say knpc "Travel west through the woods, then follow the road west."))
              ((equal? kplace p_enchanters_tower)
               (say knpc "Go south to Trigrave and ask there."))
              ((equal? kplace p_glasdrin)
               (say knpc "Take the road south as far as you can."))
              ((equal? kplace p_oparine)
               (say knpc "Take the road north to Trigrave and ask there."))
              (else 
               (say knpc "Follow the road east from Trigrave."))
              ))))

(define (basic-glas knpc kpc)
  (say knpc "���饹�ɥ��������Τ����ξ���ԻԤ����������Τꤿ������")
  (if (yes? kpc)
      (let ((kplace (get-place knpc)))
        (cond ((equal? kplace p_westpass)
               (say knpc "����ƻ����عԤ������Τ����̤عԤ��Ф褤������"))
              ((equal? kplace p_eastpass)
               (say knpc "��عԤ�����¦�ؤ�ƻ��ʹ���Ȥ褤������"))
              ((equal? kplace p_trigrave)
               (say knpc "��عԤ�����¦�ؤ�ƻ��ʹ���Ȥ褤������"))
              ((equal? kplace p_green_tower)
               (say knpc "���ο���ȴ�����ƻ�������롣������̤˿ʤ�Ȥ褤������"))
              ((equal? kplace p_enchanters_tower)
               (say knpc "��ؿʤ߻�ƻ��ȴ������򤿤ɤ�Ф褤������"))
              ((equal? kplace p_oparine)
               (say knpc "�̤�ƻ��ʤ�ȥȥꥰ�쥤�֤���������ʹ���Ȥ褤��������������г��������̤˿ʤ�ȹԤ��������"))
              (else 
               (say knpc "��������γ��ߤζ᤯�ˤ��롣"))
              ))))

(define (basic-fens knpc kpc)
  (say knpc "�����Ӥ������ˤ��롣"))

(define (basic-kurp knpc kpc)
  (say knpc "����ݥꥹ���ϲ��θ�����פ���"
       "��������̤λ�̮�Τɤ����ˤ��롣"))

(define (basic-lost knpc kpc)
  (say knpc "����줿��Ʋ����ͷ��ͤβΤ���Ǥ���ʹ�������Ȥ��ʤ���"
       "�����Ϥɤ��ˤ���Τ����Τ�ʤ���"))

;; establishments
(define (basic-whit knpc kpc)
  (say knpc "�򤭲�������Ф���ˤ��롣"))

;; quests
(define (basic-thie knpc kpc)
  (say knpc "ť���Τ��ȤϤ狼��ʤ���"))

(define (basic-rune knpc kpc)
  (say knpc "���ǤΤ��ȤϤ褯�Τ�ʤ������Ԥ�ʹ���Ф褤���⤷��ʤ���"))

(define (basic-wise knpc kpc)
	(say knpc "���ԤϤ��Υ����ɤ��礭�ʱƶ���Ϳ���Ƥ���Ԥ�����������̾�����Τꤿ������")
	(if (yes? kpc)
		(begin
			(say knpc "��ƻ�ա�����ѻա�ϣ��ѻա��ˤ󤲤󡢵��ա�������Ʈ�Τ���")
			(map quest-wise-subinit
				(list 'questentry-enchanter 'questentry-warritrix  'questentry-alchemist
						'questentry-the-man 'questentry-engineer  'questentry-necromancer)
			)
		)
	))

(define (basic-shar knpc kpc)
  (say knpc "�����ɤȤϤ��������θƤ�̾����")
  (quest-data-update 'questentry-whereami 'shard 1)
  )

(define (basic-peni knpc kpc)
  (say knpc "Ⱦ��Ȥϲ桹�Τ��륷���ɤ�ü�Τ��Ȥ���"))

(define (basic-warr knpc kpc)
  (say knpc "Ʈ�Τ���Τθ��Ԥ����񤤤����ΤǤ���Х��饹�ɥ��عԤ��Ф褤������")
  (quest-wise-subinit 'questentry-warritrix)
  (quest-data-update 'questentry-warritrix 'general-loc 1)
  )

(define (basic-engi knpc kpc)
  (say knpc "���դϤ����ϤǺǤ�ͥ�줿���ͤ���ʹ�������Ȥ����롣"
       "������������ʾ�Τ��Ȥ��Τ�ʤ���")
       (quest-wise-subinit 'questentry-engineer)
       (quest-data-update 'questentry-engineer 'common 1)
       )

(define (basic-man knpc kpc)
  (say knpc "�ˤ󤲤�Ϥʤ餺�Ԥ�ĺ�������ɤ��ˤ���Τ�ï���Τ�ʤ���"
       "��������ι�򤷤Ƥ���Ȥ��蘆����Ƥ��롣")
       (quest-wise-subinit 'questentry-the-man)
       (quest-data-update 'questentry-the-man 'common 1)
       )

(define (basic-alch knpc kpc)
  (say knpc "ϣ��ѻդϸ��Ԥο��ͤǡ����Τ��Ȥϲ��Ǥ��ΤäƤ��롣"
       "���ѡ����ǲ񤨤������")
       (quest-wise-subinit 'questentry-alchemist)
       (quest-data-update 'questentry-alchemist 'general-loc 1)
       )

(define (basic-necr knpc kpc)
  (say knpc "����ѻդϻ����ˡ����븭�Ԥ���ˡ�Ȥ�����"
       "��ϱ����줿ƶ���˽���Ǥ���餷����")
       (quest-wise-subinit 'questentry-necromancer)
       (quest-data-update 'questentry-necromancer 'general-loc 1)
       )

(define (basic-drag knpc kpc)
  (say knpc "��˽��ε����γ��߶᤯���̤����򶼤����Ƥ����ʹ������"))

(define (basic-fire knpc kpc)
  (say knpc "�Фγ�����βл��Τ�����Τ��Ȥ���"))

(define basic-conv
  (ifc '()
       ;; fundamentals
       (method 'hail generic-hail)
       (method 'default generic-unknown)
       (method 'bye generic-bye)
       (method 'join generic-join)
       (method 'leav generic-leav)
       
       ;; wise
       (method 'ench basic-ench)
       (method 'wise basic-wise)
       (method 'warr basic-warr)
       (method 'man basic-man)
       (method 'engi basic-engi)
       (method 'alch basic-alch)
       (method 'necr basic-necr)

       ;; towns & regions
       (method 'absa basic-absa)
       (method 'bole basic-bole)
       (method 'gree basic-gree)
       (method 'trig basic-trig)
       (method 'lost basic-lost)
       (method 'opar basic-opar)
       (method 'fens basic-fens)
       (method 'shar basic-shar)
       (method 'peni basic-peni)
       (method 'kurp basic-kurp)
       (method 'glas basic-glas)
       (method 'fire basic-fire)

       ;; establishments
       (method 'whit basic-whit)

       ;; quests
       (method 'thie basic-thie)
       (method 'rune basic-rune)

       ;; monsters
       (method 'drag basic-drag)

       ))

;; Helper(s)
(define (say knpc . msg) (kern-conv-say knpc msg))
(define (yes? kpc) (kern-conv-get-yes-no? kpc))
(define (no? kpc) (not (kern-conv-get-yes-no? kpc)))
(define (reply? kpc) (kern-conv-get-reply kpc))
(define (ask? knpc kpc . msg)
  (kern-conv-say knpc msg)
  (kern-conv-get-yes-no? kpc))
(define (prompt-for-key)
  (kern-log-msg "<���������򲡤���³����>")
  (kern-ui-waitkey))
(define (meet msg)
  (kern-log-msg msg))
(define (get-gold-donation knpc kpc)
  (let ((give (kern-conv-get-amount kpc))
        (have (kern-player-get-gold)))
    (cond ((> give have)
           (say knpc "��⤬­��ʤ���")
           0)
          (else
           (kern-player-set-gold (- have give))
           give))))
(define (get-food-donation knpc kpc)
  (let ((give (kern-conv-get-amount kpc))
        (have (kern-player-get-food)))
    (cond ((> give have)
           (say knpc "��⤬­��ʤ���")
           0)
          (else
           (kern-player-set-food (- have give))
           give))))
(define (working? knpc)
  (string=? "working" (kern-obj-get-activity knpc)))

;; Not really an aside in the theatrical sense, this routine causes a party
;; member to interject something into the conversation. kpc is the character
;; being conversed with, mem-tag is either nil or the party member who should
;; do the interjection. If mem-tag is nil then a party member (other than the
;; speaker) will be chosen at random. msg is the text of the comment. If kpc is
;; the only member of the party then the aside will not do anything.
(define (aside kpc kchar-tag . msg)
  ;;(println msg)
  (if (null? kchar-tag)
      (let ((members (filter (lambda (kchar)
                               (not (eqv? kchar kpc)))
                             (kern-party-get-members (kern-get-player)))
                     ))
        (if (not (null? members))
            (let ((kchar (random-select members)))
              (say kchar msg)
              #t)
            #f)
        )
      (if (in-player-party? kchar-tag)
          (begin
            (kern-conv-say (eval kchar-tag) msg)
            #t)
          #f)
      ))
         
;;----------------------------------------------------------------------------
;; ����
;;----------------------------------------------------------------------------
(define (mk-quest) (list #f #f #f))
(define (quest-offered? qst) (car qst))
(define (quest-accepted? qst) (cadr qst))
(define (quest-done? qst) (caddr qst))
(define (quest-offered! qst val) (set-car! qst val))
(define (quest-accepted! qst val) (set-car! (cdr qst) val))
(define (quest-done! qst val) (set-car! (cddr qst) val))


;;----------------------------------------------------------------------------
;; ��������Ȥβ���
;;----------------------------------------------------------------------------
(define (ranger-ranger knpc kpc)
  (say knpc "�������Į�ȹ���ζ������äƤ��롣"
       "�桹��������ƻ뤷���Ǥ��뤫���긭�Ԥ���Ϥ��Ƥ��롣"))

(define (ranger-wise knpc kpc)
  (say knpc "������ϸ��Ԥ����������Ȥ���Ǥ��롣"
       "����ã�ϲ桹�˱���Ȥ�Ƥʤ���Ϳ�������Τ����˲桹�Ͼ�����󶡤��Ƥ��롣"
       "���ˤϲ桹�ϸ���ã���������廡��Ǥ̳������롣"))

(define (ranger-join knpc kpc)
  (cond ((has? kpc t_ranger_orders 1)
         (say knpc "̿���򸫤��Ƥ���������λ�򡣤��Ф餯�δ֡�Ʊ�Ԥ������ޤ���")
         (take kpc t_ranger_orders 1)
         (join-player knpc)
         ;; NOTE: the following only permits one ranger at a time to join the
         ;; player!
         (kern-tag 'ch_ranger_merc knpc)
         (give kpc t_arrow 20)
         (kern-conv-end)
         )
        (else
         (say knpc "��ǰ�Ǥ��������λŻ�������ޤ���"))))

(define (ranger-band knpc kpc)
  (say knpc "����򵯤������Ԥ���������ƨ������Τ���"
       "���ˤϾ��̵ˡ�Ԥ����롣"))

(define ranger-conv
  (ifc basic-conv
       (method 'join ranger-join)
       (method 'rang ranger-ranger)
       (method 'wise ranger-wise)
       (method 'band ranger-band)
       ))


;; Knight conversation -- used by Lord Froederick's troops
(define knight-conv basic-conv)

;; ���饹�ɥ��
(define (glasdrin-warr knpc kpc)
  (if (player-found-warritrix?)
      (say knpc "�ߤ�����λ���ᤷ��Ǥ��롣")
      (say knpc "Ʈ�ΤϤ��λ���ǺǤ����Ѥ���Τ�����������ɤ��ˤ���Τ����Τ�ʤ��������Ԥ������ե꡼�����ᴱ��ʹ���Ф褤������")
  	)
  	(quest-data-update 'questentry-warritrix 'general-loc 1)
  )

(define (glasdrin-stew knpc kpc)
  (if (player-stewardess-trial-done?)
      (say knpc "�����Ԥ��ä������̾�ϼ���줿��ΤȤʤä��������������ԤϤ��ĤƤλ��ᴱ�����륹����")
      (say knpc "�����ԤϤ���Į�ȥ��饹�ɥ������ڤ��äƤ��롣���ʤ������ˤ��롣")))

(define (glasdrin-jeff knpc kpc)
  (if (player-stewardess-trial-done?)
      (say knpc "�褯���äƤ⡢�����ե꡼�������ᴱ�Ȥ��ƻش����μԤ����̳���դä���"
           "�������������Ʈ�Τؤ�΢�ڤ�˶��Ϥ�����"
           "�桹�ο��������ᴱ�ϥ���˥�����")
      (say knpc "�����ե꡼���ϥ��饹�ɥ��η��λ��ᴱ�������ʤ������ˤ��롣")
      ))

(define (glasdrin-kurp knpc kpc)
         (say knpc "�̤ζ����Ϥꡢ��̮����˱�äƹԤ��ȡ�"
              "�̤�ë�֤˸����������"))
(define (glasdrin-cita knpc kpc)
  (say knpc "��������¦�κ֤���ˤ��롣"))
(define (glasdrin-ghol knpc kpc)
  (say knpc "���ᤵ�줿ť��������åȤȤ���̾�����ä��Ȼפ����֤��ϲ��δƹ��ǳΤ����Ȥ褤������")
   (quest-data-update 'questentry-ghertie 'gholet-dungeon 1)
   )
(define (glasdrin-kurp knpc kpc)
  (say knpc "���ߥ���ݥꥹ���µܤˤ�����ΤۤȤ�ɤ����롣��̮�򤿤ɤä����عԤ��ȶ�ë������������Ĥ��������"))

(define (glasdrin-glas knpc kpc)
  (say knpc "���饹�ɥ��������Τ�Į����"))

(define (glasdrin-pala knpc kpc)
  (say knpc "���饹�ɥ��������ΤϤ��Τ�����ǺǤ⶯�Ϥʷ������"))

(define glasdrin-conv
  (ifc basic-conv
       (method 'warr glasdrin-warr)
       (method 'stew glasdrin-stew)
       (method 'jeff glasdrin-jeff)
       (method 'kurp glasdrin-kurp)
       (method 'cita glasdrin-cita)
       (method 'ghol glasdrin-ghol)
       (method 'kurp glasdrin-kurp)
       (method 'glas glasdrin-glas)
       (method 'pala glasdrin-pala)
       (method 'jani 
               (lambda (knpc kpc) 
                 (if (player-stewardess-trial-done?)
                      (say knpc "��ɾ�Ĳ�ϥ���˥��򥸥��ե꡼���θ�Ǥ�Ȥ��ƻ��ᴱ�����Ф�����")
                      (say knpc "�����ե꡼����ͭǽ�ʻ��ᴱ����������������亴�Υ���˥��Τ��������Ȥ����Τ�ï�Ǥ��ΤäƤ��롣"))))
       (method 'valu
               (lambda (knpc kpc)
                 (if (player-stewardess-trial-done?)
                     (say knpc "�����륹�η����������Ԥ����������餫�ˤʤä���"
                          "��˴ؤ��뱳�򿮤��Ƥ��ޤä����Ȥ��Ѥ����������Ȥ���"
                          "�䤿������򿷤��������Ԥ����Ф�����")
                     (say knpc "�����륹���Ѥ���٤��Ԥ���������줿��"
                          "�����˻�ǰ�������º�ɤ���뾭�����ä���"))))
       ))

;; Kurpolis
(define kurpolis-conv
  (ifc basic-conv
       ))

;; Green Tower
(define (gt-gobl knpc kpc)
  (say knpc "���֥������ʹߡ����ä��԰���ʵ�����֤ˤ��롣���ϻ�������Τ��ᤳ��Į����롣���������ǲ�ä��Ȥ��ϵ���Ĥ��ʤ���Фʤ�ʤ���"))
(define (gt-towe knpc kpc)
  (say knpc "����Į��̾��������ˤ���Ť��㤫��Ȥä���Τǡ����Ϸ��������������"))
(define (gt-ruin knpc kpc)
  (say knpc "�Ť����פϤ���Į�������γѤˤ��롣"))
(define (gt-band knpc kpc)
  (say knpc "��±�Τ��Ȥϥǥ�å���Ĺ��ʹ���Ф褤������"
       "��������˼���Ȥ�Ǥ���Ԥΰ�ͤ���"))


(define green-tower-conv
  (ifc basic-conv
       (method 'gree
               (lambda (knpc kpc)
                 (say knpc "����������Į��̾��������ˤ���Ť��㤫��Ȥä���Τ���")))
       (method 'gobl gt-gobl)
       (method 'towe gt-towe)
       (method 'ruin gt-ruin)
       (method 'band gt-band)
       ))

;; Trigrave
(define trigrave-conv
  (ifc basic-conv
       (method 'thie 
               (lambda (knpc kpc) 
                 (say knpc "ť���Τ��ȤϤ狼��ʤ������٥��ι�ͤȤ褯�ä��Ƥ���Τǲ����ΤäƤ��뤫�⤷��ʤ���")))
       ))

;;----------------------------------------------------------------------------
;; Ź��

;; Indices into the merchant message list
(define merch-closed           0)
(define merch-buy              1)
(define merch-sell             2)
(define merch-trade            3)
(define merch-sold-something   4)
(define merch-sold-nothing     5)
(define merch-bought-something 6)
(define merch-bought-nothing   7)
(define merch-traded-something 8)
(define merch-traded-nothing   9)

(define (conv-trade knpc kpc menu msgs catalog)
  (println "conv-trade: " (kern-obj-get-activity knpc))
  ;;(println "conv-trade: " menu msgs catalog)
  (if (and (not (string=? "working" (kern-obj-get-activity knpc)))
           (not (null? (list-ref msgs merch-closed))))
      (say knpc (list-ref msgs merch-closed) 
           "����"
           (cond ((string=? (kern-obj-get-activity knpc) "idle") "�ٷ�")
                 ((string=? (kern-obj-get-activity knpc) "eating") "����")
                 ((string=? (kern-obj-get-activity knpc) "drunk") "����Ǥ����")
                 ((string=? (kern-obj-get-activity knpc) "commuting") "��ư")
                 (else (kern-obj-get-activity knpc)))
           "�����")
      (cond ((string=? menu "buy")
             (say knpc (list-ref msgs merch-buy))
             (if (kern-conv-trade knpc kpc "buy" catalog)
                 (say knpc (list-ref msgs merch-sold-something))
                 (say knpc (list-ref msgs merch-sold-nothing))))
            ((string=? menu "sell")
             (say knpc (list-ref msgs merch-sell))
             (if (kern-conv-trade knpc kpc "sell" catalog)
                 (say knpc (list-ref msgs merch-bought-something))
                 (say knpc (list-ref msgs merch-bought-nothing))))
            (else
             (say knpc (list-ref msgs merch-trade))
             (if (kern-conv-trade knpc kpc "trade" catalog)
                 (say knpc (list-ref msgs merch-traded-something))
                 (say knpc (list-ref msgs merch-traded-nothing))))
            )))

;; ����
(kern-dictionary
	"����"	"two"	"����"
	"���˥�"	"six"	"����"
	"����"	"eigh"	"����"
	"����"	"love"	"��"
	"�������ȥ�"	"pass"	"�����"
	"�����ĥ�"	"them"	"�����Ĥ�"
	"�����ʥ�"	"inag"	"�����ʥ�"
	"����"	"red"	"��"
	"����"	"evil"	"��"
	"������"	"demo"	"����"
	"����"		"open"	"����"
	"������"	"open"	"������"
	"����"	"leg"	"­"
	"������"	"play"	"ͷ��"
	"�������"	"play"	"ͷ���"
	"������"	"loca"	"������"
	"���ĥ��"	"coll"	"�����"
	"����"	"hole"	"��"
	"���ӥ�����"	"abig"	"���ӥ�����"
	"���֥���å�"	"absa"	"���֥���å�"
	"����凉"	"reve"	"ɽ��"
	"����"	"that"	"����"
	"����ڥ���"	"alop"	"����ڥ���"
	"���󥰥ꥹ"	"angr"	"���󥰥ꥹ"
	"���󥵥ĥ���"	"assa"	"�Ż���"
	"������"	"earl"	"������"
	"����"		"iki"	"����"
	"��������"	"ways"	"������"
	"�����ĥ�"	"more"	"�����Ĥ�"
	"�����˥�"	"sacr"	"����"
	"����"	"medi"	"���"
	"������"	"isin"	"������"
	"������"	"ruin"	"����"
	"����"	"ini"	"����"
	"����"	"dog"	"��"
	"���Υ�"	"life"	"̿"
	"���ޥ���"	"vigi"	"����"
	"���ꥢ"	"ilya"	"���ꥢ"
	"���ꥰ��"	"entr"	"�����"
	"����"	"hung"	"����"
	"������������"	"wake"	"ư���Ф���"
	"����"	"song"	"��"
	"����"	"arm"	"��"
	"����"	"sea"	"��"
	"���ߥإ�"	"sea"	"���إ�"
	"���饮���"	"betr"	"΢�ڤ��"
	"���饮��쥿"	"betr"	"΢�ڤ�줿"
	"���饮��"	"betr"	"΢�ڤ�"
	"����"		"sell"	"���"
	"����ĥ��ƥ���"	"skul"	"����Ĥ��Ƥ���"
	"����"	"luck"	"��"
	"����"		"eh"	"����"
	"������"	"abe"	"������"
	"���󥸥���"	"ange"	"���󥸥���"
	"������"	"ord"	"������"
	"��������"	"wolf"	"ϵ"
	"��������"	"drun"	"���"
	"����"		"hill"	"��"
	"����������"	"momm"	"���줵��"
	"��������"	"stra"	"��������"
	"��������"	"woma"	"��������"
	"����������"	"gran"	"����������"
	"������"	"stag"	"����"
	"��������"	"osca"	"��������"
	"������"	"afra"	"����"
	"���å�����"	"gher"	"���ä�����"
	"���å�"	"husb"	"��"
	"���ȥ�����"	"dadd"	"���㤵��"
	"���ȥ�"	"maid"	"����"
	"����"		"axe"	"��"
	"���ѡ����"	"opar"	"���ѡ����"
	"����ɥ�"	"chan"	"����ɥ�"
	"�����"	"lady"	"��"
	"��"		"ka"	"��"
	"����"		"stor"	"��"
	"�������奦����"	"conv"	"������"
	"��������"	"pira"	"��±"
	"�����֥�"	"mons"	"��ʪ"
	"����"		"buy"	"�㤦"
	"����"	"key"	"��"
	"���������ɥ���"	"pick"	"������ƻ��"
	"�����ƥ��ޥ���"	"wore"	"�ݤ��Ƥ��ޤ���"
	"���ʥ��"	"iron"	"��ʪ"
	"����"	"kama"	"����"
	"����"		"god"	"��"
	"���ߥ���"	"gods"	"����"
	"���륷�ե�����"	"kalc"	"���륷�ե�����"
	"����ӥ�"	"calv"	"����ӥ�"
	"���������"	"calv"	"���������"
	"�����"	"chan"	"�Ѥ��"
	"���󥷥�"	"jail"	"�Ǽ�"
	"�����ƥ���"	"gher"	"�����ƥ���"
	"���󥿥�"	"patc"	"����"
	"��"		"ki"	"��"
	"������"	"vani"	"�ä���"
	"������"	"dang"	"��"
	"������"	"wood"	"�ڤ���"
	"����"	"shor"	"��"
	"����"	"scar"	"��"
	"������"	"rule"	"��§"
	"���Υ�"	"shro"	"���Υ�"
	"���㥯"	"clie"	"��"
	"���㥹���"	"kath"	"���㥹���"
	"���奦����"	"camp"	"��©"
	"���祦����"	"bord"	"����"
	"���祦����"	"less"	"����"
	"���祦�ܥ�"	"sava"	"��˽"
	"���祸��"	"gint"	"���"
	"���饤"	"hate"	"����"
	"����"		"engi"	"����"
	"������"	"sacr"	"����"
	"������"	"poti"	"��"
	"����"		"shit"	"����"
	"����"		"spid"	"����"
	"����åƥ���"	"mad"	"���äƤ���"
	"�����ӥ�"	"clov"	"�����ӥ�"
	"�����󥸥�"	"blac"	"������"
	"����ݥꥹ"	"kurp"	"����ݥꥹ"
	"��"		"gu"	"��"
	"����"		"guto"	"����"
	"���Υ���"	"guno"	"���Υ���"
	"���٥�"	"gwen"	"���٥�"
	"���饹�ɥ��"	"glas"	"���饹�ɥ��"
	"���쥴����"	"greg"	"���쥴����"
	"����"	"mili"	"��"
	"������"	"patr"	"����"
	"�����ӥ���"	"rang"	"������"
	"�����ॷ��"	"pris"	"��̳��"
	"����"	"affl"	"����"
	"�����"	"brut"	"��"
	"����"	"swor"	"��"
	"���󥸥�"	"wise"	"����"
	"��������"	"gaze"	"��������"
	"����"	"lang"	"����"
	"���󥷥ƥ�"	"prim"	"����Ū"
	"��������"	"sail"	"�ҹ�"
	"�����˥�"	"repl"	"��Ǥ"
	"������"	"void"	"����"
	"����������"	"void"	"������"
	"����"	"orph"	"�ɻ�"
	"���å��祦"	"bord"	"��"
	"����"		"hut"	"����"
	"����"	"this"	"����"
	"����"	"kill"	"����"
	"������"	"kill"	"������"
	"���塞��ʥ�"	"afra"	"�ݤ���ʤ�"
	"����"	"char"	"����"
	"���֥��"	"gobl"	"���֥��"
	"���ۥ���"	"blow"	"������"
	"���ۥ�"	"coug"	"���ۥ�"
	"����å�"	"ghol"	"����å�"
	"��������"	"wors"	"�ǰ�"
	"��������"	"firs"	"�ǽ�"
	"��������"	"shri"	"����"
	"��������"	"shri"	"����"
	"�����饹"	"sila"	"�����饹"
	"��������"	"jugs"	"��"
	"������"	"tave"	"���"
	"��������"	"sear"	"õ����"
	"����ʥ�"	"bye"	"����ʤ�"
	"��������"	"sund"	"��������"
	"��"	"dead"	"��"
	"�����������ԥ�"	"shak"	"�����������ԥ�"
	"�����������ԥ�"	"shak"	"�����������ԥ�"
	"����"		"comm"	"�ش�"
	"������"	"job"	"�Ż�"
	"�����ȥ��ʥ�"	"luck"	"�Ż����ʤ�"
	"����"	"lion"	"���"
	"������"	"bard"	"���"
	"������"	"want"	"������"
	"���å�"	"fens"	"����"
	"���å�����"	"fens"	"������"
	"����"		"die"	"���"
	"���ϥ�"	"domi"	"����"
	"���ߥ�"	"civi"	"��̱"
	"������"	"shar"	"������"
	"���奦����"	"pris"	"����"
	"���奦�ɥ�����"	"num"	"��ƻ��"
	"���奦�ɥ�����"	"brot"	"��ƻ��"
	"���奦�襦����"	"pris"	"���ƽ�"
	"���奦�襦����"	"pris"	"���ƽ�"
	"���奦���"	"tink"	"������"
	"���奴"	"ward"	"���"
	"���奴�Υ�����"	"ward"	"���μ�ʸ"
	"���奴����"	"keep"	"����"
	"���奸��"	"innk"	"���"
	"����롼��"	"shro"	"����롼��"
	"���祦����"	"prom"	"����"
	"���祦��"	"evid"	"�ڵ�"
	"���祦�Х�"	"deal"	"����"
	"���祯��"	"supp"	"����"
	"���祯�˥�"	"wrig"	"����"
	"���祯�˥�"	"wrig"	"����"
	"���祯��祦"	"food"	"����"
	"����祦����ĥ�"	"necr"	"����ѻ�"
	"���쥤����"	"comm"	"���ᴱ"
	"����"	"whit"	"��"
	"����������"	"whit"	"�򤭲���"
	"���󥨥�"	"deep"	"��ʥ"
	"���󥸥�"	"trut"	"����"
	"���󥻥�"	"cous"	"����"
	"�����"	"dead"	"����"
	"����ǥ�"	"shri"	"����"
	"����襦"	"trus"	"����"
	"������"	"temp"	"����"
	"��������"	"jake"	"��������"
	"������"	"jess"	"������"
	"�����ե꡼��"	"jeff"	"�����ե꡼��"
	"������"	"gen"	"������"
	"������"	"hell"	"�Ϲ�"
	"������"	"age"	"����"
	"����"	"merc"	"����"
	"����"	"jim"	"����"
	"����"	"ja"	"����"
	"���㥢��"	"wick"	"�ٰ�"
	"����˥�"	"jani"	"����˥�"
	"���奦��"	"twel"	"����"
	"���奦�˥�"	"inha"	"����"
	"������"	"spel"	"��ʸ"
	"����"		"jo"	"����"
	"���硼��"	"jorn"	"���硼��"
	"���祦�ۥ�"	"news"	"����"
	"�����ϥ�"	"hono"	"����"
	"���٥�����"	"ques"	"���٤�����"
	"���ߥ䥭"	"char"	"ú�Ƥ�"
	"��"		"zu"	"��"
	"����������"	"zuka"	"����������"
	"��������"	"pala"	"������"
	"������"	"just"	"����"
	"��������"	"sacr"	"����"
	"������"	"stud"	"����"
	"�����ϥ�"	"holy"	"����"
	"�����˥�"	"onus"	"��Ǥ"
	"�����Х�"	"rune"	"����"
	"�����"	"sele"	"�����"
	"���󥻥�"	"doc"	"����"
	"���󥽥�"	"wars"	"����"
	"������祦"	"capt"	"��Ĺ"
	"����ȥ�"	"warm"	"��Ʈ"
	"����"	"good"	"��"
	"���󥻥�"	"outp"	"����"
	"������"	"equi"	"����"
	"���ʥ����"	"offe"	"����ʪ"
	"��������"	"reti"	"����"
	"�����ޥ�"	"torc"	"����"
	"������"	"fort"	"��"
	"������"	"help"	"����"
	"�������å�"	"batt"	"��ä�"
	"����"	"shie"	"��"
	"���Υ���"	"fun"	"�ڤ���"
	"���ӥΥ���"	"knig"	"ι�ε���"
	"���ӥӥ�"	"trav"	"ι��"
	"���٥��"	"food"	"����ʪ"
	"�����"	"reas"	"�����"
	"���󥱥�"	"dagg"	"û��"
	"��"		"da"	"��"
	"������"	"firs"	"�裱"
	"������"	"seco"	"�裲"
	"������"	"thir"	"�裳"
	"��������"	"firs"	"���"
	"��������"	"pay"	"���"
	"��������"	"thir"	"�軰"
	"�������祦"	"fail"	"���"
	"��������"	"love"	"�繥��"
	"������"	"seco"	"����"
	"������"	"free"	"�Ф���"
	"�����"	"husb"	"ö��"
	"����������"	"ches"	"����������"
	"����"	"wit"	"�η�"
	"����"	"unde"	"�ϲ�"
	"������"	"powe"	"��"
	"������"	"know"	"�μ�"
	"����"	"dadd"	"��"
	"���Υ�"	"int"	"��ǽ"
	"���奦�ȥ��"	"garr"	"������"
	"����"		"cho"	"����"
	"����祦"	"heal"	"����"
	"��"		"tu"	"��"
	"�ĥ�"	"moon"	"��"
	"�ĥ�����"	"spit"	"�ͤ��ɤ�"
	"�ĥ���"	"make"	"���"
	"�ĥ��ʥ�"	"pena"	"����"
	"�ĥߥΥʥ�"	"inno"	"��Τʤ�"
	"�ĥ�"	"thin"	"Ϣ��"
	"��"	"hand"	"��"
	"�ƥ�"	"enem"	"Ũ"
	"�ƥ���"	"crew"	"�겼"
	"�ƥĥ���"	"chor"	"������"
	"�ƥ󥷥祯"	"voca"	"ŷ��"
	"�ǥ˥�"	"denn"	"�ǥ˥�"
	"�ǥ�å�"	"deri"	"�ǥ�å�"
	"�ǥ�ɥ�"	"lost"	"��Ʋ"
	"��"		"to"	"��"
	"�ȥ�"		"towe"	"��"
	"�ȥ���"	"warr"	"Ʈ��"
	"�ȥ�����"	"band"	"��±"
	"�ȥ�������"	"stew"	"������"
	"�ȥ���"	"plac"	"��"
	"�ȥ�"	"civi"	"�Ի�"
	"�ȥå�"	"get"	"��ä�"
	"�ȥ�"		"kind"	"ͧ"
	"�ȥꥰ�쥤��"	"trig"	"�ȥꥰ�쥤��"
	"�ȥ��"	"fort"	"��"
	"�ȥ�ҥ�"	"trad"	"������"
	"�ȥ�"		"get"	"���"
	"�ȥ��"	"trol"	"�ȥ��"
	"�ɥ�����˥�"	"inn"	"Ʊ���"
	"�ɥ�����"	"cave"	"ƶ��"
	"�ɥ��֥�"	"anim"	"ưʪ"
	"�ɥ�"	"pois"	"��"
	"�ɥ��㥯"	"nati"	"����"
	"�ɥꥹ"	"dori"	"�ɥꥹ"
	"�ɥ쥤"	"slav"	"����"
	"�ɥ�ܥ�"	"thie"	"ť��"
	"�ɥ�"	"thud"	"�ɥ�"
	"��"		"na"	"��"
	"�ʥ���"	"join"	"���"
	"�ʥޥ�"	"name"	"̾��"
	"�ʥ饺���"	"wrog"	"�ʤ餺��"
	"�˥����"	"hate"	"�����"
	"�˥�"		"jink"	"ƨ��"
	"�˥����ʥ�"	"esca"	"ƨ�����ʤ�"
	"�˥���"	"esca"	"ƨ����"
	"�˥å�"	"diar"	"����"
	"�˥�"		"nin"	"�˥�"
	"�˥󥲥�"	"man"	"�ˤ󤲤�"
	"�˥��"	"erra"	"Ǥ̳"
	"��"		"nu"	"��"
	"�̥�"	"nuki"	"�̥�"
	"�̥�"	"fen"	"��"
	"�ͥ���"	"mous"	"�ͥ���"
	"��"		"no"	"��"
	"�Υ�"	"noor"	"�Υ�"
	"�Υ���"	"farm"	"����"
	"�Υ���祯"	"skil"	"ǽ��"
	"�Υ����"	"esca"	"ƨ���"
	"�Υ��ե���"	"noss"	"�Υ��ե���"
	"�Υߥ��"	"drin"	"����ʪ"
	"�Υ�"	"drin"	"����"
	"�Υ�"	"curs"	"����"
	"�Υ��쥿���"	"accu"	"����줿��"
	"��"		"ha"	"��"
	"�ϥ�"	"grav"	"��"
	"�ϥ�"		"ches"	"Ȣ"
	"�ϥ���"	"run"	"����"
	"�ϥ�"	"sham"	"�Ѥ�"
	"�ϥå���"	"hack"	"�ϥå���"
	"�ϥʥ�"	"stor"	"��"
	"�ϥʥ�"	"talk"	"�ä�"
	"�ϥ��å�"	"haml"	"�ϥ��å�"
	"�ϥ����"	"hame"	"�ϥ����"
	"�ϥ󥮥㥯"	"rebe"	"ȿ��"
	"�ϥ󥷥�"	"rebe"	"ȿ����"
	"�ϥ�ȥ�"	"peni"	"Ⱦ��"
	"�С���"	"bart"	"�С���"
	"�Х��˥�"	"sell"	"���"
	"�Х륹"	"valu"	"�Х륹"
	"�Х�"	"vale"	"�Х�"
	"�ѡ�����"	"perc"	"�ѡ�����"
	"�ѡ����Х�"	"perc"	"�ѡ����Х�"
	"�ѥ���"	"pusk"	"�ѥ���"
	"��"		"hi"	"��"
	"�ҥ���"	"enli"	"��"
	"�ҥĥ�"	"shee"	"��"
	"�ҥ�"	"men"	"��"
	"�ҥȥӥ�"	"peop"	"�͡�"
	"�ҥȥ�"	"alon"	"�Ȥ�"
	"�ҥɥ�"	"nast"	"��"
	"�ҥɥ�"	"hydr"	"�ҥɥ�"
	"�ҥΥ���"	"fire"	"�Фγ�"
	"�ҥߥ�"	"secr"	"��̩"
	"�ҥ䥯"	"reag"	"����"
	"�ӥ��ȥꥢ"	"vict"	"�ӥ��ȥꥢ"
	"�ӥ祦����"	"hosp"	"�±�"
	"�ӥ�"	"bill"	"�ӥ�"
	"�ӥ󥷥祦"	"dex"	"�Ҿ�"
	"�ե���"	"fing"	"�ե���"
	"�ե����奦"	"reve"	"����"
	"�ե�"	"unde"	"�Ի�"
	"�ե��祦"	"crip"	"���"
	"�ե�������"	"fail"	"������"
	"�ե���"	"guar"	"�ɤ�"
	"�ե���"	"two"	"���"
	"�եƥ�����"	"unna"	"��Ŭ��"
	"�ե�"	"ship"	"��"
	"�ե륤"	"old"	"�Ť�"
	"�֥��"	"brun"	"�֥��"
	"�֥��ǥ�����"	"brun"	"�֥��ǥ�����"
	"�֥�"	"cult"	"ʸ��"
	"�֥�ᥤ"	"civi"	"ʸ��"
	"�إ�����"	"tour"	"ʼ��"
	"�إ���"	"peac"	"ʿ��"
	"�إå�"	"hung"	"���ä�"
	"�إ�"	"room"	"����"
	"�إ�꡼"	"henr"	"�إ�꡼"
	"�ۡ���"	"hole"	"�ۡ���"
	"�ۥ�����"	"ruin"	"����"
	"�ۥ��"	"cita"	"����"
	"��"		"bo"	"��"
	"�ܥ����󥷥�"	"adve"	"������"
	"�ܥ��쥤"	"ghos"	"˴��"
	"�ܥʥ�"	"bona"	"�ܥʥ�"
	"�ܥ�"		"bole"	"�ܥ�"
	"��"		"ma"	"��"
	"�ޥ����"	"scro"	"��ʪ"
	"�ޥ��ॹ��"	"gran"	"¹̼"
	"�ޥ���ĥ�"	"wiza"	"��ѻ�"
	"�ޥ���"	"witc"	"���"
	"�ޥ�����"	"poor"	"�Ϥ���"
	"�ޥ�"		"town"	"Į"
	"�ޥå�"	"expe"	"�Ԥä�"
	"�ޥɥ���"	"ench"	"��ƻ��"
	"�ޥۥ�"	"mage"	"��ˡ"
	"�ޥۥ�����"	"roun"	"��ˡ��"
	"�ޥۥ��ĥ���"	"wiza"	"��ˡ�Ȥ�"
	"�ޥ襤�ӥ�"	"wand"	"�¤���"
	"�ޥ�ʥ�"	"nigh"	"������"
	"�ߡ��ˡ�"	"mean"	"�ߡ��ˡ�"
	"�ߥĥ���"	"find"	"���Ĥ���"
	"�ߥɥ�Υȥ�"	"gree"	"�Ф���"
	"�५��"	"old"	"��"
	"�ॹ��"	"daug"	"̼"
	"���"		"folk"	"¼"
	"���"	"hord"	"����"
	"��"		"me"	"��"
	"�ᥤ"		"may"	"�ᥤ"
	"�ᥤ���奦"	"dung"	"�µ�"
	"���奭"	"melu"	"���奭"
	"���ӥ�"	"melv"	"��������"
	"��������"	"melv"	"��������"
	"�⥦�⥯"	"blin"	"����"
	"�⥯�ƥ�"	"aspi"	"��Ū"
	"���"	"stuf"	"ʪ"
	"���"		"wood"	"��"
	"���"		"gate"	"��"
	"��"		"arro"	"��"
	"�䥢"		"hail"	"�䤢"
	"�䥷��"	"ambi"	"�"
	"��å���"	"trou"	"��ä���"
	"��å�"	"eigh"	"Ȭ��"
	"��ޥ�"	"sick"	"��"
	"����"	"quit"	"�����"
	"���饫"	"soft"	"���餫"
	"�楦�쥤"	"haun"	"ͩ��"
	"��ӥ�"	"ring"	"����"
	"�襯�ܥ�"	"desi"	"��˾"
	"�饯���ޥ�"	"luxi"	"�饯���ޥ�"
	"�ꥢ"	"lia"	"�ꥢ"
	"��å�"	"lich"	"��å�"
	"��㥯����"	"sack"	"άå"
	"���"		"lu"	"���"
	"��奦"	"drag"	"ε"
	"��祦����"	"real"	"�ΰ�"
	"��祦����"	"pare"	"ξ��"
	"��祦��"	"real"	"����"
	"��祦�ۥ�"	"both"	"ξ��"
	"��祦��"	"cook"	"����"
	"��祦��˥�"	"cook"	"������"
	"��󥸥�"	"neig"	"�ٿ�"
	"��"		"ru"	"��"
	"�륫"	"ruka"	"�륫"
	"��ߥ�"	"lumi"	"��ߥ�"
	"�쥤"	"spir"	"��"
	"�쥭��"	"hist"	"���"
	"��󥭥󥸥�ĥ�"	"alch"	"ϣ��ѻ�"
	"��󥷥奦"	"prac"	"����"
	"����륱����"	"cape"	"����륱����"
	"��"	"cell"	"ϴ"
	"���˥�"	"six"	"ϻ��"
	"�參���"	"leav"	"�̤��"
	"�凉���쥿"	"forg"	"˺���줿"
	"��å�"	"chop"	"��ä�"
	"����祯"	"stre"	"����"
	"�����륹"	"valu"	"�����륹"
	"������"	"vale"	"������"
	"�������ȥꥢ"	"vict"	"�������ȥꥢ"
	"��"		"tree"	"��"
	"��"		"eye"	"��"
	"��"		"fire"	"��"
)
