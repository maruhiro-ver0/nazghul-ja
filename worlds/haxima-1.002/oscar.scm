;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;;
;; ���ѡ����
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_oscar
               (list 0  0  oparine-innkeepers-bed "sleeping")
               (list 8  0  bilge-water-seat-3     "eating")
               (list 9  0  cheerful-counter       "working")
               (list 12 0  bilge-water-seat-3     "eating")
               (list 13 0  cheerful-counter       "working")
               (list 21 0  bilge-water-seat-3     "eating")
               (list 22 0  bilge-water-hall       "idle")
               (list 23 0  oparine-innkeepers-bed "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (oscar-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;;
;; ���������ϥ��ѡ����νɲ��Ǥ��롣��ϱ������ڤε�­�򤷤Ƥ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (oscar-hail knpc kpc)
  (say knpc "�Τ��ʤ��ϱ����ʡ��ڤε�­���ˤȲ�ä����Ϥ���ä��㤤�ġ�"))

(define (oscar-default knpc kpc)
  (say knpc "�Τ�ޤ���͡�"))

(define (oscar-name knpc kpc)
  (say knpc "�ɲ��Υ�����������"))

(define (oscar-join knpc kpc)
  (say knpc "�䤬���Ƥ⤸��ޤˤʤ��������ġ�"))

(define (oscar-job knpc kpc)
  (say knpc "�ɲ�����"
       "�������פ�褦�ˤϸ����ʤ�����"
       "�⤷�פ�ʤ���äƤ��졣"))

(define (oscar-bye knpc kpc)
  (say knpc "�ɤ��⡣"))

;; Trade...
(define (oscar-trade knpc kpc)
  (if (not (string=? "working" (kern-obj-get-activity knpc)))
      (say knpc "�ɲ���������Ʊ��͡פϸ���9��������9���ޤǳ����Ƥ��롣���������Ǥ��ʤ�����"
           "���ΤȤ��ϸ����Ƥ��졣")
      (let ((door (eval 'oparine-inn-room-1-door)))
        ;; is the room still open?
        (if (not (door-locked? (kobj-gob door)))
            ;; yes - remind player
            (say knpc "�����Ϥ⤦�����Ƥ��롣")
            ;; no - ask if player needs a room
            (begin
              (say knpc "�������פ�Τ���")
              (if (kern-conv-get-yes-no? kpc)
                  ;; yes - player wants a room
                  (begin
                    (say knpc 
                         "���" oparine-inn-room-price "�����"
                         "����Į�ˤ���¤ꡢ���٤Ǥ������Ǥ��롣"
                         "����Ǥ�������")
                    (if (kern-conv-get-yes-no? kpc)
                        ;; yes - player agrees to the price
                        (let ((gold (kern-player-get-gold)))
                          ;; does player have enough gold?
                          (if (>= gold oparine-inn-room-price)
                              ;; yes - player has enough gold
                              (begin
                                (say knpc "1�漼����"
                                     "�Ǥⵤ������ʤ������͡�"
                                     "���餫������äƤ����������"
                                     "ʸ��ϸ���ʤ��Ǥ���衣")
                                (kern-player-set-gold 
                                 (- gold 
                                    oparine-inn-room-price))
                                (send-signal knpc door 'unlock)
                                (kern-conv-end)
                                )
                              ;; no - player does not have enouvh gold)
                              (say knpc "��ǰ������ߤ�­��ʤ��ʡ�"
                                   "�ΤäƤ��̤ꡢ�����ϵ��ϱ��ǤϤʤ���" )))
                        ;; no - player does not agree to the price
                        (say knpc 
                             "�狼�äƤ��衣")))
                  ;; no - player does not want a room
                  (say knpc "���������͡�"
                       "�Ҹ����ʹ���Ƥߤ���������")))))))

;; Inn...
(define (oscar-inn knpc kpc)
  (say knpc "�����ۤ�����̾���ˤ��������"
       "�Ѥ������Ȥϻפ�ʤ���������������ˤ��ƤⱿ��������"))

(define (oscar-luck knpc kpc)
  (say knpc "���νɤ�̾���Τ褦��˴�3�漼�ˤ�������"
       "��������±��˴����ܤ餻�����ʤ���")
	(quest-data-assign-once 'questentry-ghertie)
	(quest-data-update 'questentry-ghertie 'ghertieloc 1))

(define (oscar-ghost knpc kpc)
  (say knpc "�����ƥ����Ȥ����Ҥ�3�漼�Ǽ�ʬ�μ겼�˻����줿��"
       "����˴��ޤ����뤫��3�漼���ߤ��Ф��ʤ������"
       "�����ʧ�ä��ߤ����͡�")
	(quest-data-update 'questentry-ghertie 'ghertieid 1)
	(quest-data-update 'questentry-ghertie 'ghertieloc 1)
	(quest-data-assign-once 'questentry-ghertie))

;; Leg...
(define (oscar-leg knpc kpc)
  (say knpc "�����ˤʤꤿ���ä�������Ǥ�ï��ۤäƤ���ʤ��ä���"
       "�����������餷��������褦�ˡ���ʬ��­���ڤ���Ȥ��������"
       "�Ǥ�ۤäƤ���ʤ��ä�������­�򼺤ä���������"))

;; Townspeople...
(define (oscar-opar knpc kpc)
  (say knpc "�����Ϲ�Į����"
       "�ҤΤۤȤ�ɤ�����ߤꤿ�����̤ظ�����ι�ͤ���"))

(define (oscar-gher knpc kpc)
  (say knpc "�����ƥ����϶�������±���ä���"
       "��ʬ�μ겼�˻����졢���Ⱥ�����å��줿�����")
	(quest-data-assign-once 'questentry-ghertie))

(define (oscar-alch knpc kpc)
  (say knpc "���Ź�ϼ��ΤȤʤ�ˤ��롣"
       "���Ĥ�褯�狼��ʤ��¸��ǻȤ�ʪ��õ���Ƥ��롣"))

(define (oscar-bart knpc kpc)
  (say knpc "�С��ȤϤ���ƻ�Τ��礦�ɸ�������Ź��¤�����ͤ���"
       "��ˤʤ�Ȥ��Ĥ����̤˰���Ǥ��롣�ȤƤ⤸��ʤ����Ĥ��Ƥ����ʤ���"))

(define (oscar-seaw knpc kpc)
  (say knpc "��������ϤȤƤ⤭�줤�������ͤ��򤱤Ƥ��롣"
       "����ϻ��̵�뤷�Ƥ��롣��������"))

(define (oscar-henr knpc kpc)
  (say knpc "��ʪ���������������ĤΤ褦�ˤ����Фʤ�ʤ���"))

(define oscar-conv
  (ifc basic-conv

       ;; basics
       (method 'default oscar-default)
       (method 'hail oscar-hail)
       (method 'bye  oscar-bye)
       (method 'job  oscar-job)
       (method 'name oscar-name)
       (method 'join oscar-join)
       
       ;; trade
       (method 'trad oscar-trade)
       (method 'room oscar-trade)
       (method 'buy  oscar-trade)
       (method 'sell oscar-trade)

       ;; inn
       (method 'inn  oscar-inn)
       (method 'luck oscar-luck)
       (method 'ghos oscar-ghost)
       (method 'pira oscar-ghost)
       (method 'leg  oscar-leg)

       ;; town & people
       (method 'opar oscar-opar)
       (method 'alch oscar-alch)
       (method 'gher oscar-gher)
       (method 'ghas oscar-gher)
       (method 'henr oscar-henr)
       (method 'bart oscar-bart)
       (method 'sea  oscar-seaw)
       (method 'witc oscar-seaw)
       (method 'lia  oscar-seaw)

       ))

(define (mk-oscar)
  (bind 
   (kern-mk-char 'ch_oscar           ; tag
                 "��������"          ; name
                 sp_human            ; species
                 nil                 ; occ
                 s_townsman          ; sprite
                 faction-men         ; starting alignment
                 1 1 0               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 1  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'oscar-conv         ; conv
                 sch_oscar           ; sched
                 'townsman-ai        ; special ai
                 nil                 ; container
                 (list t_dagger)     ; readied
                 )
   (oscar-mk)))
