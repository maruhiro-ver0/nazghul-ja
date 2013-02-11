;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define mouse-start-lvl 8)

;;----------------------------------------------------------------------------
;; Schedule
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (mouse-mk) (list #t))
(define (mouse-first-meeting? mouse) (car mouse))
(define (mouse-set-first-meeting! mouse val) (set-car! mouse val))
(define (mouse-talked)
	(quest-data-update-with 'questentry-thiefrune 'talked 1 (quest-notify (grant-party-xp-fn 10)))
	)


(define (mouse-meet-first-time knpc kpc)

  (define (mouse-disappear)
    (say knpc "���äȷ���衢�⤦�񤤤����ʤ��ä��ʡ�")
    (kern-obj-add-effect knpc ef_invisibility nil)
    (kern-conv-end kpc)
    )

  (define (mouse-query)
    (say knpc "�䤢���֤����Υѥ��꤫����")
    (if (yes? kpc)
        (mouse-disappear)
        (begin
        	(say knpc "�ҥ������Ӥä��ꤷ���衣")
        	(mouse-talked)
        )
    ))

  (define (mouse-gratitude)
    (say knpc "����ڥ����贶�դ��ޤ����֤����ϻ�����"
         "���󤿡��褯��äƤ��줿�ʡ�")
         (mouse-talked)
         )

  (define (kathryn-speech)
    (say ch_kathryn "�Х��ʿͤ͡�ť���ν�ޤǰ��⤷�Ƥ����ʤ�ơ�")
    (kern-obj-set-conv ch_kathryn nil)
    (kern-being-set-base-faction ch_kathryn faction-monster))

  (define (thud-speech)
    (say ch_thud "ť������������������������������")
    (kern-obj-set-conv ch_thud nil)
    (kern-being-set-base-faction ch_thud faction-monster))

  (define (open-gate)
    (open-moongate (mk-loc (loc-place (kern-obj-get-location knpc)) 7 2)))
  
  (define (warp-in-kathryn kgate)
    (warp-in ch_kathryn 
             (kern-obj-get-location kgate)
             south
             faction-monster))

  (define (warp-in-thud kgate)
    (warp-in ch_thud 
             (kern-obj-get-location kgate)
             west
             faction-monster))

  (mouse-set-first-meeting! (kobj-gob-data knpc) #f)
  (if (defined? 'ch_kathryn)
      (if (is-alive? ch_kathryn)
          (if (is-player-party-member? ch_kathryn)

              ;; kathryn is alive in the party (if thud is defined then he must
              ;; be in the party, too; see kathryn.scm)
              (begin
                (kern-char-leave-player ch_kathryn)
                (kathryn-speech)
                (if (defined? 'ch_thud)
                    (begin
                      (if (is-alive? ch_thud)
                          (thud-speech))
                      (kern-char-leave-player ch_thud)))
                (mouse-disappear))

              ;; kathryn is alive but not in the party so gate her in, and
              ;; thud, too, if he's alive
              (let ((kgate (open-gate))
                    (use-thud? (and (defined? 'ch_thud)
                                    (is-alive? ch_thud))))
                (kern-sleep 1000)
                (warp-in-kathryn kgate)
                (if use-thud?
                    (warp-in-thud kgate))
                (kathryn-speech)
                (if use-thud?
                    (thud-speech))
                (kern-sleep 1000)
                (close-moongate kgate)
                (mouse-disappear)))

          ;; kathryn is dead
          (if (is-player-party-member? ch_kathryn)

              ;; but in the party so remove her and thud, too, if he's defined
              (begin
                (kern-char-leave-player ch_kathryn)
                (if (defined? 'ch_thud)
                    (if (is-alive? ch_thud)
                        (begin
                          (thud-speech)
                          (kern-char-leave-player ch_thud)
                          (mouse-disappear))
                        (begin
                          (kern-char-leave-player ch_thud)
                          (mouse-gratitude)))
                    (mouse-gratitude)))

              ;; kathryn is dead but not in the party (since she is not in the
              ;; party, thud cannot be either)
              (mouse-query)))

      ;; kathryn is undefined (so she could never have been in the party, and
      ;; thus neither could thud)
      (mouse-query)))

;;----------------------------------------------------------------------------
;; Conv
;;----------------------------------------------------------------------------
(define (mouse-hail knpc kpc)
  (let ((mouse (kobj-gob-data knpc)))
    (if (mouse-first-meeting? mouse)
        (mouse-meet-first-time knpc kpc)
        (begin
        	(say knpc "��������ˤ��ϡ��ؤؤá�")
   	        (mouse-talked)
	    )
        )))

(define (mouse-default knpc kpc)
  (say knpc "�����ɤ����ʡ�"))

(define (mouse-name knpc kpc)
  (say knpc "�ͥ��ߤǤ���"))

(define (mouse-join knpc kpc)
  (say knpc "�����ʤ�����Ʊ��Ȥˤϸ����Ƥʤ�������ؤء�"))

(define (mouse-job knpc kpc)
  (say knpc "������ʪ��Ľ���뤳�ȡ�"))


(define (mouse-coll knpc kpc)
  (say knpc "ť���ȸƤֿͤ⤤�롣"))

(define (mouse-thie knpc kpc)
  (say knpc "�Ƕ�ޤǤϤ����Ż����ä��ͤ���"
       "�����ߤ���ʪ������С������������뤿��ˤ��ä��˶��ʧ�ä���"
       "�ǡ������Ѥ��֤����˸ۤ�줿�����"))

(define (mouse-lady knpc kpc)
  (say knpc "�����֤����Ϥ��ä��򤢤�ʪ��������뤿��˸ۤä������θ塢��ȸ򴹤��뤿��˲�ä���"
       "�����ޤǤϤ褯���뤳�Ȥ����狼�����"
       "�Ǥ⡢���ν��϶��ʧ�������ˡ����ä��򻦤����Ȥ��������"))

(define (mouse-kill knpc kpc)
  (say knpc "�֤����ȥ��Ĥ��겼���ƼϤʤ��ä���"
       "�����Ĥ���ݤ������Ȥ����ϴ��դ���衣�����������Ĥ餬ñ�ȤǤ�ä��ΤǤϤʤ��������롣"
       "���Τ�����ʤ����ǤȤ�����Ф��ʤ��¤ꤺ�ä�����줽������"))

(define (mouse-rune knpc kpc)
  (if (not (in-inventory? knpc t_rune_k))
      (say knpc "����Ϥ⤦���󤿤����������ͧ�衪")
      (begin

        (define (give-rune gold)
          (let* ((pgold (kern-player-get-gold)))
            (if (> pgold gold)
                (kern-obj-add-gold kpc (- 0 gold))
                (let ((price (min pgold gold)))
                  (say knpc "���äȡ��⤬­��ʤ��ʡ�"
                       "ʧ����ʬ����������äƤ�������")
                  (kern-obj-add-gold kpc (- 0 price)))))
          (kern-obj-remove-from-inventory knpc t_rune_k 1)
          (kern-obj-add-to-inventory kpc t_rune_k 1)
          (quest-data-update-with 'questentry-thiefrune 'recovered 1 (quest-notify (grant-party-xp-fn 50)))
          )
        
        (say knpc "�֤����Τ���˼�����줿�������Ǥϡ��ǽ��ʹ�����Ȥ����餺�äȤ�ä������Ȥ˲᤮�ʤ��ä���"
             "���줬���ʤΤ���狼��ʤ���"
             "���㤤�����ʤǤ��󤿤���äƤ�����ɤ������500�����")
        (if (kern-conv-get-yes-no? kpc)
            (give-rune 500)
            (begin
              (say knpc "�������֤�����������Ƥ��ä��ڤ꤬���뤫��ʡ�250��Ϥɤ�����")
              (if (kern-conv-get-yes-no? kpc)
                  (give-rune 250)
                  (begin
                    (say knpc "��������ʤ�����ͧ�衣100�硩")
                    (if (kern-conv-get-yes-no? kpc)
                        (give-rune 100)
                        (begin
                          (say knpc "50��")
                          (if (kern-conv-get-yes-no? kpc)
                              (give-rune 50)
                              (begin
                                (say knpc "�狼�ä������äƤ�������Ǥ����ʡ�")
                                (if (kern-conv-get-yes-no? kpc)
                                    (give-rune 0)
                                    (begin
                                      (say knpc "���Τ�衪"
                                           "���Ф�������äƹԤäƤ��졪"
                                           "�����äȱ󤯤ء�")
                                      (give-rune (- 0 100))))))
                          )))))))))
      
(define (mouse-bye knpc kpc)
  (say knpc "�����Ϥʤ������⤦���٤Ȳ񤤤����ʤ��͡�"))

(define (mouse-alopex knpc kpc)
  (say knpc "����ڥ������������Ť�ť���ο�����"
       "����ʹ������"))

(define mouse-conv
  (ifc nil
       (method 'default mouse-default)
       (method 'hail mouse-hail)
       (method 'bye mouse-bye)
       (method 'job mouse-job)
       (method 'name mouse-name)
       (method 'join mouse-join)

       (method 'coll mouse-coll)
       (method 'kill mouse-kill)
       (method 'lady mouse-lady)
       (method 'rune mouse-rune)
       (method 'thie mouse-thie)
       (method 'alop mouse-alopex)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-mouse)
  (bind 
   (kern-char-force-drop
    (kern-char-arm-self
     (kern-mk-char 
      'ch_mouse ;;..tag
      "�ͥ���" ;;....name
      sp_human ;;.....species
      nil ;;..........occupation
      s_brigand ;;.....sprite
      faction-men ;;..faction
      0 ;;............custom strength modifier
      0 ;;............custom intelligence modifier
      6 ;;............custom dexterity modifier
      2 ;;............custom base hp modifier
      2 ;;............custom hp multiplier (per-level)
      1 ;;............custom base mp modifier
      1 ;;............custom mp multiplier (per-level)
      max-health ;;..current hit points
      -1 ;;...........current experience points
      max-health ;;..current magic points
      0
      mouse-start-lvl  ;;..current level
      #f ;;...........dead?
      'mouse-conv ;;...conversation (optional)
      nil ;;..........schedule (optional)
      nil ;;..........custom ai (optional)
      
      ;;..........container (and contents)
      (mk-inventory
       (list
        (list 1 t_rune_k)
        (list 1 t_armor_leather)
        (list 1 t_leather_helm)
        (list 1 t_sword)
        (list 1 t_bow)
        (list 50 t_arrow)))
      
      nil ;;..........readied arms (in addition to the container contents)
      nil ;;..........hooks in effect
      ))
    #t)
   (mouse-mk)))
