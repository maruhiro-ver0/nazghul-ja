;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define kama-lvl 4)
(define kama-species sp_forest_goblin)
(define kama-occ oc_wrogue)
(define kama-exit-x 6)
(define kama-exit-y 2)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; �Ф�����ϲ�����˼
;;----------------------------------------------------------------------------
(define kama-cell gtl-cell1)
(kern-mk-sched 'sch_kama
               (list 0  0 kama-cell        "sleeping")
               (list 7  0 kama-cell        "idle")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (kama-mk jail-door-tag) (list #f #f jail-door-tag))
(define (kama-gave-food? gob) (car gob))
(define (kama-gave-food! gob) (set-car! gob #t))
(define (kama-joined-once? gob) (cadr gob))
(define (kama-joined-once! gob) (set-car! (cdr gob) #t))
(define (kama-get-jail-door-tag gob) (caddr gob))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ���ޤϿ����֥��μ�ͤ������ǡ������Ф�����ϲ��˼��Ƥ���Ƥ��롣
;; �������ͧ�ͤǡ����ޤϲ񤤤����������Ա��ˤ⹴«���줿��
;; ���֥��줬�����狼��С����ޤ���֤ˤʤ롣
;;----------------------------------------------------------------------------

;; Basics...
(define (kama-default knpc kpc)
  (say knpc "��ȿ�����ʤ�����"))

(define (kama-hail knpc kpc)
  (meet "�Τ��ʤ�������夤���ͻҤΥ��֥��Ȳ�ä���������ͻҤϤʤ����ͤ�����Ǥ���褦���ܤǤ�����򸫤Ƥ��롣��")
  (if (kama-gave-food? (gob knpc))
      (say knpc "�ܥʥϡ�")
      (say knpc "�̥���")
      ))

(define (kama-bye knpc kpc)
  (say knpc "�����ɽ����Ѥ��ʤ��ä�����"))

;; No == Name
(define (kama-no knpc kpc)
  (if (kama-gave-food? (gob knpc))
      (say knpc "����ϼ�ʬ��غ��������ϥ��ޡ�")
      (kama-default knpc kpc)))

;; Me == Job
(define (kama-me knpc kpc)
  (if (not (kama-gave-food? (gob knpc)))
      (kama-default knpc kpc)
      (begin
        (say knpc "�˥�ȡ�����Ϥ��ʤ���غ��������ϥ��ȡ�")
        (if (yes? kpc)
            (say knpc "����Ϥ��ʤ���������")
            (say knpc "����Ϥ��ʤ��򵿤��褦���ܤǾФä�����")))))

;; Jo == Join
(define (kama-jo knpc kpc)
  (define (exit-point)
    (mk-loc (kobj-place knpc)
            kama-exit-x
            kama-exit-y))
  (define (door-still-locked?)
    (let ((kdoor (eval (kama-get-jail-door-tag (gob knpc)))))
      (cond ((null? kdoor) (error "Kama's door tag is undefined!") #t)
            (else
             (let ((gob (kobj-gob kdoor)))
               (or (door-locked? gob)
                   (door-magic-locked? gob)))))))
  (define (rejoin)
    (say knpc "�ϡ�������")
    (join-player knpc)
    (kern-conv-end)
    )
  (define (join-first-time)
    (say knpc "�ϥ��硪�ܥʡ������륫��")
    (say knpc "�ξ��ξ�˿����դ���ϿޤΤ褦�ʤ�Τ������������ƿ�����ü����λ�̮���ܤ������Ϥ����Ʋ��٤�Хİ�������������")
    (quest-data-update-with 'questentry-rune-f 'angriss 1 (quest-notify nil))
    (kama-joined-once! (gob knpc))
    (join-player knpc)
    ;; Improve the player's relations with forest goblins
    (kern-dtable-inc faction-player faction-forest-goblin)
    (kern-dtable-inc faction-player faction-forest-goblin)
    (kern-conv-end)
    )
  (if (is-player-party-member? knpc)
      (say knpc "����Ϻ��Ǥ����ͻҤ����ϥϡġ�")
      (if (kama-joined-once? (gob knpc))
          (rejoin)
          (if (not (kama-gave-food? (gob knpc)))
              (kama-default knpc kpc)
              (if (door-still-locked?)
                  (say knpc "�������˼�����غ��������򤹤��᤿����")
                  (join-first-time)
                  )))))

(define (kama-food knpc kpc)
  (kern-log-msg "����˿�����Ϳ���롩��")
  (define (no-food)
    (say knpc "����Ϥ��ʤ����򤢤�����ؤ�������")
    (kern-conv-end))
  (define (yes-food)
    (kama-gave-food! (gob knpc))
    (say knpc "����Ϥ���򥬥ĥ��Ĥȿ��٤�����"
         "�ϡ��̥�������Ϥ��ʤ���غ��������ϥܥʥϡ�"))
  (if (yes? kpc)
      (if (> (get-food-donation knpc kpc) 0)
          (yes-food)
          (no-food))
      (no-food)))
          
(define (kama-rune knpc kpc)
  (if (not (kama-gave-food? (gob knpc)))
      (kama-default knpc kpc)
      (if (any-in-inventory? kpc rune-types)
          (say knpc "�Τ��ʤ������Ǥ򸫤���ȡ�����԰¤��ˤ��ʤ��������ϥ륫��")
          (say knpc "�����ǤˤĤ����������褦�Ȥ���������Ϻ��Ǥ��Ƥ���褦������"))))

;; Ruka == Rune
;; Having a goblin spout out *sextant coordinates* is just daft. Changing to something descriptive
;; Maybe for the repeat, give a pointed direction based on the parties location on the worldmap? "He points south" or whatever direction is appropriate
(define (kama-ruka knpc kpc)
  (if (kama-joined-once? (gob knpc))
  		(begin
	      (say knpc "�������륫��")
    	  (say knpc "�ξ��ξ�˿����դ���ϿޤΤ褦�ʤ�Τ������������ƿ�����ü����λ�̮���ܤ������Ϥ����Ʋ��٤�Хİ�������������")
    	  (quest-data-update-with 'questentry-rune-f 'angriss 1 (quest-notify nil))
      	)
      (begin
        (say knpc "�������˼�ξ��Τۤ���˴ݤȡ�����ˤĤʤ��ä�����������������ϥ���Τ褦���ä������줫����Ϥ��ʤ��ȼ�ʬ��غ���������γ���ä�������")
        (prompt-for-key)
        (say knpc "�Τɤ������Ϥ��ʤ��˲ä�ꥯ����臘���Ȥ���Ƥ��Ƥ���褦������"))))

;; King Clovis (leader of the human forces in the war against the Goblins, one generation ago.
(define (kama-clov knpc kpc)
  (if (not (kama-gave-food? (gob knpc)))
      (kama-default knpc kpc)  
      (say knpc "����Ϻǽ�Ϥ狼��ʤ��褦���ä�����������Ϥ��ʤ����Ƹ��ä����ϥ륫����������ȡ�")))

(define (kama-leav knpc kpc)
  (if (is-player-party-member? knpc)
      (begin
        (say knpc "���ޡ��ĥ��硩")
        (if (yes? kpc)
            (begin
              (if (kern-char-leave-player knpc)
                  (begin
                    (say knpc "���ޡ�������")
                    (kern-conv-end))
                  (say knpc "���ޡ��ġ�������")))
            (kern-log-msg "����ϰ¿������褦������")))
      (kern-log-msg "����Ϻ��𤷤Ƥ���褦������")))

;; Shakespeare
(define (kama-zukakiguru knpc kpc)
  (begin
    (say knpc "�ϡ����������롪")
    (aside kpc 'ch_gen "�������䤿���ζ��̤δؿ����ȤǤ���")
    (say knpc "����Ϥ��ʤ��κ��ä���Ĥ��򸫤ơ���ä���ȸ���ľ�������ϥ����������������롢���祰�ϡ������ޡ��̡��ϥ���ȡ�")
    (aside kpc 'ch_gen "�����κ�Ԥ��Τä��Ȥ��ζä����������ƤߤƤ���������")
    ))

;; Hameluto == Good/yes/skillful, Destiny change individual (Prince Hamlet)
(define (kama-hameluto knpc kpc)
  (begin
  (say knpc "�ϥ���ȡ��ϡ��Υ��ޤθ��������Ѥ�ä��������ƿ����ʴ�Ĥ��ǺƤӤ��ʤ����������������")
  (aside kpc 'ch_gen "���ʤ���ʹ�����Ƥ���뤽���Ǥ��衪�Υ�����϶�̣�������˸��Ƥ��롣��")
  (prompt-for-key)
  (say knpc "�̥ܥ����ĥܥ�����������塪")
  (aside kpc 'ch_gen "������٤�������̤٤��������줬�������")

  (say knpc "�ܥ����ϥҥᡢ�ʥĥ������ޥʡ�����ޥ���")
  (aside kpc 'ch_gen "�ɤ��餬���⤤�Ǥ���������ƻ�ʱ�̿�ΤĤ֤Ƥ�����Ѥ��뤫��")

  (say knpc "�������ܥᥫ�����������硢���ĥ��硪")
  (aside kpc 'ch_gen "�����꺤��γ���Ω������������򽪤��뤫��")

  (say knpc "����Ϥ��Τޤ�Ĺ���ָ��Ĥ��Τ褦����ϯ�ɤ�Ǹ�ޤ�ʹ��������")
  (if (yes? kpc)
      (say knpc "�Τ��θ塢�ä��ۤ�Ĺ���ָ��³��������")
      (say knpc "�ܥʡ��������ϡ�����ϻߤ᤿������äȸ�ꤿ���褦���ä�����")
      )
  (aside kpc 'ch_gen "���η�γ˿�����ʬ�ϡ����������ƤˤʤäƤ���Ȼפ��ޤ��󤫡�")
  ))

(define kama-conv
  (ifc nil
       (method 'default kama-default)
       (method 'hail kama-hail)
       (method 'bye  kama-bye)
       (method 'leav kama-leav)

       (method 'no   kama-no)
       (method 'me   kama-me)
       (method 'jo   kama-jo)
       (method 'food kama-food)
       (method 'rune kama-rune)
       (method 'ruka kama-ruka)
       (method 'clov kama-clov)

       (method 'shak kama-zukakiguru) ;; synonym
       (method 'bard kama-zukakiguru) ;; synonym
       (method 'zuka kama-zukakiguru)

       (method 'haml kama-hameluto) ;; synonym
       (method 'hame kama-hameluto)
    ))

(define (mk-kama jail-door-tag)
  (bind 
    (kern-mk-char 
     'ch_kama           ; tag
     "����"             ; name
     kama-species         ; species
     kama-occ              ; occ
     s_fgob_civilian  ; sprite
     faction-men      ; starting alignment
     2 0 10            ; str/int/dex
     pc-hp-off  ; hp bonus
     pc-hp-gain ; hp per-level bonus
     0 ; mp off
     0 ; mp gain
     max-health ; hp
     -1                   ; xp
     max-health ; mp
     0
     kama-lvl
     #f               ; dead
     'kama-conv         ; conv
     sch_kama           ; sched
     nil              ; special ai
     nil              ; container
     nil              ; readied
     )
   (kama-mk jail-door-tag)))
