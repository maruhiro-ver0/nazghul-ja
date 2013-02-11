;;----------------------------------------------------------------------------
;; Schedule
;; 
;; �Ф���
;;----------------------------------------------------------------------------
(define (mk-zone x y w h) (list 'p_green_tower x y w h))
(kern-mk-sched 'sch_gen
               (list 0  0  (mk-zone 2  13 1  1)  "sleeping")
               (list 4  0  (mk-zone 3  12 3  3)  "eating")
               (list 5  0  gt-woods  "idle")
               (list 10 0  (mk-zone 26 27 2  12) "idle")
               (list 12 0  (mk-zone 49 54 1  1)  "eating")
               (list 13 0  (mk-zone 49 3  7  2)  "idle")
               (list 14 0  (mk-zone 7  20 5  5)  "idle")
               (list 18 0  (mk-zone 49 54 1  1)  "eating")
               (list 19 0  (mk-zone 3  12 3  3)  "idle")
               (list 0  0  (mk-zone 2  13 1  1)  "sleeping")
               )

;; ----------------------------------------------------------------------------
;; ������Υ��֥��ñ�콸
;; ----------------------------------------------------------------------------
(mk-reusable-item 
 't_goblin_lexicon "���֥���ñ�콸" s_lexicon norm
 (lambda (klexicon kuser)
   (kern-ui-page-text
   "���֥���ñ�콸"
   "����ϥ��֥����ؤֽ����Ȥ��뤿��˽񤫤줿"
   "��ΤǤ��롣��Ω�Ĥ��Ȥ�˾�ࡣ"
   "�ݥ�����"
   ""
   "�ܡġĻ�Ρ��伫��"
   "����Ŀʹ�"
   "���ġĲȡ�����"
   "�����ġֲ�����"
   "���ġĺ�������"
   "�ϡġ��ɤ����Ϥ������ߤ�"
   "�ҡġļ���"
   "�����ĹԤ�������"
   "����Ĳä��"
   "���ġĻ���������롢�����"
   "���ġķ򹯡���̿�ϡ���"
   "���ĸ򴹡��Ѳ����ѿ�"
   "�ޡġĿ��������줿ƻ"
   "��ġ����ܡ��Ż�����̿"
   "�ʡġĤ��ʤ��Ρ����ʤ�����"
   "�̡ġ����ࡢ��롢�Ϥޤ�"
   "�Ρġ�̾��"
   "�˥�ı����줿"
   "��ġĸ��塢���ϡ�������ƶ��"
   "�ȡġļ�"
   "�ġġĤ�����������"
   "���ġĸ��롢õ��"
   )))

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (gen-mk will-join? gave-notes?) (list will-join? gave-notes?))
(define (gen-will-join? gen) (car gen))
(define (gen-gave-notes? gen) (cadr gen))
(define (gen-set-will-join! gen val) (set-car! gen val))
(define (gen-set-gave-notes! gen val) (set-car! (cdr gen) val))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ������Ϸ���������Ф���˽���Ǥ��롣
;; ��ϥ��֥����μ������ꡢ���ޤ�ͧ�ͤǤ⤢�롣
;; ���������֤ˤʤ롣
;;----------------------------------------------------------------------------
(define (gen-hail     gen player) (say gen "����ˤ��ϡ��¤��ͤ���"))
(define (gen-bye      gen player) (say gen "���褦�ʤ顣"))
(define (gen-default  gen player) (say gen "����Ϥ狼��ޤ���"))
(define (gen-name     gen player) (say gen "��ϥ�����"))
(define (gen-woodsman gen player) (say gen "��������򿹿ͤȸƤּԤ⤤�ޤ���" ))
(define (gen-job      gen player) (say gen "���Ĥƻ�Ϸ�������Ǥ����������������ζФ�򽪤��ޤ��������Ǥϼ�ʬ�Τ���˿����⤭��äƤ��ޤ���" ))
(define (gen-reasons  gen player) (say gen "��ʬ�Τ���ˤǤ���" ))

(define (gen-captain gen player) 
  (say gen "�ǥ�å���Ĺ���Ф���Ƿ������ش����Ƥ��ޤ����⤦�񤤤ޤ�������")
  (if (kern-conv-get-yes-no? player)
      (say gen "ͭǽ���ˤǤ����������Ū�Ǥ���")
      (say gen "��ˤ��ޤ�����λ�̳����󳬤ˤ���ޤ���")))

(define (gen-ambitious   gen player) (say gen "ʿ�¤ʤȤ��ˤϡ��ͤϤĤĤޤ��������ˤϤʤ�ʤ���ΤǤ���"))
(define (gen-culture     gen player) 
  (say gen "�ȼ���ʸ���Ǥ�����������ʸ������äƤ��ޤ�(�ȥ����ʤ��Ȥϰ�ä�)��"
       "�����������ԥ�����ˤ���褦�ˡ�����ϰۤʤ�͡���Ķ����¸�ߤ����ΤǤ���"))
(define (gen-shakespeare gen player)
  (say gen "����ΤäƤ���ΤǤ��������Ф餷����")
  (if (in-player-party? 'ch_kama)
      (say gen "����ϥ��ޤ򸫤�������Ϥ��λ�ͤ��Τ�⤦��ͤǤ�����θ��ϥ��åȤϤ���ʹ���٤��Ǥ���")
      ))

(define (gen-ranger gen player) (say gen "������ϥ��֥������δ֤��ο����襤�ޤ����������ǤϷ���Ū��¸�ߤǤ���"))
(define (gen-wars   gen player) (say gen "�Ϥ�����Ϸ�������Ȥ��ƥ��֥��������襤�ޤ��������������Τ��Ȥǡ��͡���˺��Ƥ��ޤ���"
				     "�͡��ϥ��֥������ä�¸�ߡ��Ԥ���ä���٤�¸�ߤȤߤʤ��Ƥ��ޤ���"))
(define (gen-goblin gen player) (say gen "��̣������²�Ǥ��������ȼ��θ����Ȥ��ޤ�����ʸ������äƤ��ޤ���"
				     "�ͤȻ��Ƥ��ޤ�������궧˽�ǡ���긶��Ū�Ǥ���"
				     "����ʼ�Τ϶���Τǡ����ѻդ�����Ȥ��Ƥ��ޤ���"))
(define (gen-primal gen player) (say gen "�������º�ɤ��Ƥ��ޤ���������������Τ�������Τ��Ȥ��Τ�ޤ���Ǥ�����"
				     "���ǤϿ����֥���ͧ�ͤ����ޤ���ƶ�����֥��Ϥޤ��̤Ǥ�����" ))
(define (gen-cave   gen player) (say gen "ƶ�����֥��ϡ����μԤ���礭�����Ϥ����������������α������������뤳�Ȥ򹥤�Ԥ����Ǥ���"
				     "���ΰǤο������Ӥ���ޤ���ƶ����õ������Ȥ������˵���Ĥ��뤳�ȤǤ������ο��Ͽʹ֤ؤ������ߤ�ǳ���Ƥ��ޤ���" ))

(define (gen-language kgen player)
  (let ((gen (kobj-gob-data kgen)))
    (say kgen "�����Ǥ�����Ͼ������֥�����ä��ޤ����Τꤿ���Ǥ�����")
    (if (kern-conv-get-yes-no? player)
        (if (gen-gave-notes? gen)
            (say kgen "���ñ�콸�ǳؤ�Ǥ��������������ƻ�������������Ƥ���������")
            (begin
              (say kgen "���θ���ˤĤ��ƤޤȤ᤿��ΤǤ���������äƤ���������������˼�ͳ���������Ƥ���������")
              (kern-obj-add-to-inventory player t_goblin_lexicon 1)
              (gen-set-gave-notes! gen #t)))
        (say kgen "����Ǥ��̤ε���ˡ�"))))


(define (gen-practice gen player) (say gen "���֥����ä������򤷤����ΤǤ���С���˥��֥�����ä������Ƥ���������" ))

(define (gen-join gen player)
  (if (gen-will-join? (kobj-gob-data gen))
      (begin
        (say gen "�狼��ޤ�������֤˲ä��ޤ��礦��"
             "������ɬ�פǤ�������Į�����ˤ����ξ����عԤäơ�Ȣ����Τ�Τ���˹Ԥ��ޤ��礦��"
             "�Ǥϲ���ơ�ͧ�衪")
             (join-player gen))
      (say gen "�����������θ��դǻ��̾������äƤ���������")))

;; SAM: Added a few words from the Lexicon which were not defined as responses.
;;      These were (Iki, Lu, Nin)
;;      Also enhanced a few responses such as for (Eh).
;; Added responses having to do with the concepts of Wanderer, Warrior, Wizard, Rogue, Wright.
;; A bit of organization/tidying may still be wanted, to make sure there are no loose ends .

(define (gen-da  gen player) (say gen "�ϡ������ޡ��ȤϿ����֥����̣���ޤ���" ))
(define (gen-gu  gen player) (say gen "�ϡ��������������Ȥ�����̣�Ǥ���" ))
(define (gen-ru  gen player) (say gen "�ϡ������롦�Ȥ�ƶ�����֥����̣���ޤ���" ))
(define (gen-no  gen player) (say gen "�ܡ��Ρ������󡣤Ǥ⥴�֥�󤿤��ϻ��ޡ������ȤȸƤӤޤ���" ))
(define (gen-ki  gen player) (say gen "�ܡ��ϡ�������ϸ����Ǥ���" ))
(define (gen-jo  gen player) (say gen "�ȤƤ⤹�Ф餷�����ȤǤ������֥��ν�����ɬ�פʤ顢��Ϥ��ʤ��������˲ä��Ǥ��礦��"))
(define (gen-cho gen player) (say gen "�ϡ����硦�ȤϿʹ֤��̣���ޤ���" ))
(define (gen-nu  gen player) (say gen "�ϡ��̡����ϥ��֥��θ��դǡֿ���ʪ�פǤ���" ))
(define (gen-ha  gen player) (say gen "�������ϤϹ����ɽ�����դǤ���" ))
(define (gen-tu  gen player) (say gen "�����̤ꡣ�Ĥ�����θ��դǤ���" ))
(define (gen-bo  gen player) (say gen "�������ܡ����Ϥ��ʤ��κ�����Ū�������Τ��ʤ����̣���ޤ���" ))
(define (gen-na  gen player) (say gen "�Ϥ����ܡ��ʤϡֻ䤿���ס��ޤ��ϡְ�²�פǤ����ܡ��ʡ��ޤϿ����֥����̤�ؤ��ޤ���" ))
(define (gen-to  gen player) (say gen "�����̤ꡣ�Ȥ��դ���Ȳ����򤹤�Ԥ�ɽ���ޤ���" ))
(define (gen-ma  gen player) (say gen "�����������ޡ��Ȥ��ڤ����ɽ�����դǤ���" ))
(define (gen-eh  gen player) (say gen "�������������������������ʡ���Ϥ��ʤ��λŻ����ޤ������ϲ��Ǥ������Ȥ�����̣�Ǥ���" ))
(define (gen-iki gen player) (say gen "�ϡ��ܡ����������ϡֻ�ϲȤ����פȤ�����̣�Ǥ���"))

(define (gen-me  gen player) (say gen "�ܡ��ޡ�������Ͽ���ƻ뤷�Ƥ��롢�ޤ��ϱ����줿ƻ��õ���Ƥ��롣�ᡦ�롦������Ĺ���Ѳ����ؤӡ�õ�ᡢ������¤��ͤ�ƻ�Ǥ���"))
(define (gen-ka  gen player) (say gen "�ϡ������ϡ��Ȥ���Τ򡢤����ƥᡦ�����Ϥ���Τ������ͤ�ɽ���ޤ���"))
(define (gen-hi  gen player) (say gen "�ϡ��ҡ��ޡ��Ȥϡּ��ѻաפΤ��ȤǤ��������ơ֥ᡦ�ϡ�������פ���ѻդ������ͤǤ���"))
(define (gen-nin gen player) (say gen "�ϡ��˥󡦥ޡ��ȤϿ��α�̩�Ǥ��������ƥᡦ�ϡ��˥󡦥��Ϥʤ餺�Ԥ������ͤǤ���"))
(define (gen-lu  gen player) (say gen "�ϡ���塦�����ȤϺ��ԤǤ��������ƥᡦ�ϡ���塦�����繩�������ͤǤ���"))

(define (gen-zu       gen player) (say gen "���Ф餷���������ƥ����Ȥ�õ��ԡ��ޤ����¤��ͤΤ��ȤǤ�������ϱԤ��ܤǤ��ʤ��򸫤����ϥ��������奭��"))
(define (gen-meluki   gen player) (say gen "���������ʤ���õ��ԤǤ����⤷���ʤ������Υ��ޤ��������ʤ���֤ˤʤ�ޤ��礦��"))
(define (gen-gunodama gen player) (say gen "���˽�������κ�����Ϳ����줿̾�����̤θ��դǸ����п����֥��θ��դΤ��ȤǤ���"))

(define (gen-nuki knpc kpc)
  (say knpc "����ϥ��֥���ǡֿ���ʪ�פǤ���"))

(define (gen-bonaha gen player) 
  (say gen "���Ф餷��������ϥ��֥��θ��դ�ͧ�ͤǤ������֥��θ��դ��狼�äƤ����褦�Ǥ��͡�")
  (gen-set-will-join! (kobj-gob-data gen) #t))

(define (gen-shroom gen player) (say gen "����ϸŤ������ͧ�ͤǤ������֥������κ������β������ä��ȸ��ä��鿮���ޤ�����"))
(define (gen-maiden gen player) (say gen "�����Ǥ��������©���ڤ餻�Ƽ��μ�ʸ�򾧤��ʤ��顢��������ǵ�������ǥ��֥��������ʤ��ݤ�ƻ���ڤ곫���Ѥ򺣤Ǥ�Ф��Ƥ��ޤ���"
                                   "����γ������ܤ�ĥ���Τ�����ޤ�����"))

(define (gen-thie knpc kpc)
  (say knpc "���Τ�����Ǥϲ������Ԥϸ��ޤ���Ǥ�����"
       "�Ǥ⡢�̤ο��˽��ॴ�֥�󤬡��Ƕ�����Υܥ�˰�ͤǸ������Ԥ򸫤������Ǥ���")
       (quest-data-update 'questentry-thiefrune 'tower 1)
       (quest-data-update-with 'questentry-thiefrune 'bole 1 (quest-notify (grant-party-xp-fn 10)))
       )

(define (gen-kama knpc kpc)
  (if (is-player-party-member? ch_kama)
      (begin
        (say knpc "���ޤϤ��ʤ��˲ä�ä��褦�Ǥ��͡��ܥʥϡ����ޡ�")
        (say ch_kama "���󡣡��ܥʥϡ��ޥ��ȡ�"))
      (begin
        (say knpc "���ޤϥ��֥��μ�ͤǤ�����ȤϤ���Į�γѤǲ�����������˲񤦤��ȤˤʤäƤ����ΤǤ���������ޤ���Ǥ�������Ȳ�ä����Ȥ�����ޤ�����")
        (if (yes? kpc)
            (begin
              (say knpc "�������äƤ��ޤ�������")
              (if (yes? kpc)
                  (say knpc "�Ǥ���ʤ�����˹Ԥ�������")
                  (say knpc "�¿����ޤ�����")))
            (say knpc "�⤷��ä����Τ餻�Ƥ����������������ۤǤ���")))))
            
(define (gen-ruka knpc kpc)
  (say knpc "�륫�Ȥϥ��֥�󤿤��Υ��󥰥ꥹ����ν����θƤ�̾�Ǥ���"
       "���󥰥ꥹ�ο�������������δ֡����֥����ؤȶ��Ω�ƤƤ��ޤ�����"
       "����ؤο��Ĥ�������餱�Ƥ����Ѥ�Ƥ��ޤ��ޤ�����")
  (prompt-for-key)
  (say knpc "���Ǥ�����ϻҶ��򿹤˶�Ť������ʤ������ñ�ʤ���������Ǥ���"
       "���ˤϤ�äȴ��ʤ�Τ����ޤ�����͡�"))

(define (gen-clov knpc kpc)
  (say knpc "�����ӥ����ϥ��֥������������Τ�����Ƴ�����ԤǤ���"
       "�⤷ͧ�ͤΥ��ޤȲ񤨤�С����˴�����ɤ��ʤä���ʹ�����Ȥ��Ǥ��ޤ���")
       (quest-data-update-with 'questentry-rune-f 'kama 1 (quest-notify nil))
       )

(define (gen-band knpc kpc)
  (say knpc "���֥��ã����±�ξ���������Τɤ����ˤ���ȸ��äƤ��ޤ�����"
       "�ǥ�å���Ĺ�Ϥ�äȾܤ������Ȥ��ΤäƤ��뤫�⤷��ޤ���"))

(define gen-conv
  (ifc basic-conv
       ;;;; Goblin root words:
       (method 'bo  gen-bo)  ; My, Myself
       (method 'cho gen-cho) ; Mankind
       (method 'da  gen-da)  ; Abode, World
       (method 'eh  gen-eh)  ; What?
       (method 'gu  gen-gu)  ; Spirit, Ancestor
       (method 'ha  gen-ha)  ; Good, yes, skillful
       (method 'hi  gen-hi)  ; Magic
       (method 'iki gen-iki) ; Go
       (method 'jo  gen-jo)  ; Join
       (method 'ka  gen-ka)  ; Kill
       (method 'ki  gen-ki)  ; Health
       (method 'lu  gen-lu)  ; Change
       (method 'me  gen-me)  ; Forest
       (method 'ma  gen-ma)  ; Duty, Job, Destiny
       (method 'na  gen-na)  ; Your, yourself
       (method 'nin gen-nin) ; Stealth
       (method 'no  gen-no)  ; Name
       (method 'nu  gen-nu)  ; Give birth, Create, Begin
       (method 'ru  gen-ru)  ; Ancient, Primordial, Deep, Cave
       (method 'to  gen-to)  ; Individual
       (method 'tu  gen-tu)  ; No, Bad
       (method 'zu  gen-zu)  ; Watch, Seek

       ;;;; Goblin composite words / phrases:
       (method 'bona gen-bonaha)   ; Friend
       (method 'kama gen-kama)     ; Kama, the goblin friend of Gen
       (method 'nuki gen-nuki)     ; Food
       (method 'ruka gen-ruka)     ; Angriss, the Spider Queen
       (method 'melu gen-meluki)   ; Seeker, Wanderer
       (method 'guno gen-gunodama) ; the language of the Forest Goblins

       ;;;; Responses in human speech:
       ;; Standard responses:
       (method 'default gen-default)
       (method 'hail gen-hail)
       (method 'name gen-name)
       (method 'job  gen-job)
       (method 'join gen-join)
       (method 'bye  gen-bye)

       ;; Having to do with the goblin language:
       (method 'gobl gen-goblin)
       (method 'lang gen-language)
       (method 'prac gen-practice)

       ;; Other responses:
       (method 'admi gen-primal)
       (method 'ambi gen-ambitious)
       (method 'band gen-band)
       (method 'capt gen-captain)
       (method 'deri gen-captain)
       (method 'cave gen-cave)
       (method 'fore gen-job)
       (method 'maid gen-maiden)
       (method 'prim gen-primal)
       (method 'rang gen-ranger)
       (method 'reas gen-reasons)
       (method 'sava gen-primal)

       (method 'cult gen-culture)
       (method 'shak gen-shakespeare)
       (method 'bard gen-shakespeare)  ;; synonyn
       (method 'haml gen-shakespeare)  ;; synonyn

       (method 'shro gen-shroom)
       (method 'thie gen-thie)
       (method 'wars gen-wars)
       (method 'wood gen-woodsman)
       (method 'clov gen-clov)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-gen tag)
  (bind 
   (kern-mk-char tag                 ; tag
                 "������"            ; name
                 sp_human            ; species
                 oc_ranger           ; occ
                 s_old_ranger  ; sprite
                 faction-men         ; starting alignment
                 4 2 4           	 ; str/int/dex
                 pc-hp-off  ; hp bonus
                 pc-hp-gain ; hp per-level bonus
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 3  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'gen-conv           ; conv
                 sch_gen             ; sched
                 'townsman-ai        ; special ai
                 (mk-inventory (list (list 1 t_dagger) 
				     (list 1 t_playbook_hamlet)
				     ))  ; container
                 (list t_armor_leather)                ; readied
                 )
   (gen-mk #f #f)))
