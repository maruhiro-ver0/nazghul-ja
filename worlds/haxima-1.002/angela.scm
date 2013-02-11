;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;;
;; In Glasdrin.
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_ange
               (list 0  0  ga-bed "sleeping")
               (list 6  0  ghg-s2     "eating")
               (list 7  0  gpi-counter       "working")
               (list 11 0  ghg-s2     "eating")
               (list 12 0  gpi-counter       "working")
               (list 17 0  ghg-s2     "eating")
               (list 18 0  gpi-counter "working")
               (list 23 0  ga-bed "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (ange-mk) (list 'townsman))

;;----------------------------------------------------------------------------
;; Conv
;;
;; ���󥸥���Ͻɲ��־��ɡפμ�ν����ǡ�����Իԥ��饹�ɥ��˽���Ǥ��롣
;; ����Ͼ��ʤ������¿�������Ǥ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (ange-hail knpc kpc)
  (say knpc "�Τ��ʤ���̥��Ū�ʽ����Ȳ�ä����Ϥ褦��������ä��㤤�ޤ�����ι������"))

(define (ange-default knpc kpc)
  (say knpc "��ǰ�Ǥ����狼��ޤ���"))

(define (ange-name knpc kpc)
  (say knpc "��ϥ��󥸥���Ǥ������ʤ��ϡ�")
  (let ((name (kern-conv-get-string kpc)))
    (say knpc "�񤨤Ƥ��줷���Ǥ���" name 
         "�͡����饹�ɥ����ںߤ�ڤ���Ǥ���������")))

(define (ange-join knpc kpc)
  (say knpc "�������Ϥ褷�Ƥ�����������ǯ�����Ϥ褭�����ԤǤ�������"
       "�⤦���᤿�ΤǤ���"))

(define (ange-job knpc kpc)
  (say knpc "���饹�ɥ��νɲ��򤷤Ƥ���ޤ���"
       "������ɬ�פʤ餪�����դ�����������"))

(define (ange-bye knpc kpc)
  (say knpc "���褦�ʤ顢ι�������ޤ����餷�Ƥ���������"))

;; Trade...
(define (ange-trade knpc kpc)
  (if (not (string=? "working" (kern-obj-get-activity knpc)))
      (say knpc "�������䤬�ɤˤ���Ȥ�����ޤ����Ƥ���������"
           "�־��ɡפϸ���7��������11���ޤǳ����Ƥ��ޤ���"
           "�ޤ���ǲ񤤤ޤ��礦��")
      (let ((door (eval 'glasdrin-inn-room-1-door)))
        ;; is the room still open?
        (if (not (door-locked? (kobj-gob door)))
            ;; yes - remind player
            (say knpc "1�漼��Į��Υ���ޤǤϤ��ʤ��������Ǥ���")
            ;; no - ask if player needs a room
            (begin
              (say knpc "��������ɬ�פǤ�����")
              (if (kern-conv-get-yes-no? kpc)
                  ;; yes - player wants a room
                  (begin
                    (say knpc 
                         "���" glasdrin-inn-room-price "��Ǥ���"
                         "Į��Ф�ޤǤϤ��ʤ��������Ǥ���"
                         "������Ǥ�����")
                    (if (kern-conv-get-yes-no? kpc)
                        ;; yes - player agrees to the price
                        (let ((gold (kern-player-get-gold)))
                          ;; does player have enough gold?
                          (if (>= gold glasdrin-inn-room-price)
                              ;; yes - player has enough gold
                              (begin
                                (say knpc "���꤬�Ȥ��������ޤ�����������1�漼�Ǥ���"
                                     "����ä���ɤ�����")
                                (kern-player-set-gold 
                                 (- gold 
                                    glasdrin-inn-room-price))
                                (send-signal knpc door 'unlock)
                                (kern-conv-end)
                                )
                              ;; no - player does not have enouvh gold)
                              (say knpc "��������ǰ�Ǥ������⤬­��ޤ���"
                                   "�����Ԥ����餼�Ҥ���������������" )))
                        ;; no - player does not agree to the price
                        (say knpc "��ޤäƤ���������Ȥ��줷���ΤǤ�����"
                             "�����������ͤǤ��͡�")))
                  ;; no - player does not want a room
                  (say knpc "��������ǰ�Ǥ���"
                       "�Ѥ�ä������ͤǤ��͡�"
                       "�ޤ��ε���ˤɤ�����")))))))

;; Inn...
(define (ange-inn knpc kpc)
  (say knpc "���ɤϤ��Ф餷���ɤȻפäƤ���ޤ���"))

(define (ange-adve knpc kpc)
  (say knpc "�ΤäƤ��뤫�⤷��ޤ��󤬡����ƤΥ��饹�ɥ���̱�ˤ�ʼ��ε�̳������ޤ���"
       "��Ϥ��Ĥ��������˽�°���Ƥ��ơ������������Τ�Ʊ�Ԥ��Ƥ��ޤ�����"))

(define (ange-patr knpc kpc)
  (say knpc "�褤Ǥ̳�Ǥ��������β��οؤϤ��Ф餷����ΤǤ�����"
       "�Ǥ⡢��ͤν�������Ƥ���̵���ˤ���ޤ�����"))

(define (ange-gint knpc kpc)
  (say knpc "��ͤϻѤϿʹ֤Ȼ��Ƥ��ޤ����������Ƭ����Ĥ���ޤ���"
       "���Ĥƻ��ˤ����̤ˤ��ޤ����������饹�ɥ��η����Τ�������ƶ�����ɤ���뤳�Ȥ��Ǥ��ޤ�����"
       "���ϺǤ⶧˽�Ƕ���٤�¸�ߤǤ���"
       "��ͤ�����������Τ��Ф���Τ褦���ꤲ�Ĥ���Τ򸫤����Ȥ�����ޤ���"))

;; Townspeople...
(define (ange-glas knpc kpc)
  (say knpc "���饹�ɥ��Ϥ��Ф餷��Į�Ǥ��������פ��ޤ��󤫡�")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "�ޤä����Ǥ���")
      (say knpc "ι����Ǥ��Ф餷��Į�򤤤��Ĥ⸫�Ƥ����ΤǤ��礦�͡�"
           "��Ϥ���Į�򰦤��Ƥ��ޤ��������ϻ�βȤǤ���")))

(define (ange-patc knpc kpc)
  (say knpc "���������Ϥ��Τ�����ǺǤ�ͥ�줿��դǤ���"
       "�����Ҥɤ��ʤ���С��Ƕ�˴���ʤä��ͤ��������뤳�Ȥ�Ǥ��ޤ���"))

(define ange-conv
  (ifc glasdrin-conv

       ;; basics
       (method 'default ange-default)
       (method 'hail ange-hail)
       (method 'bye ange-bye)
       (method 'job ange-job)
       (method 'name ange-name)
       (method 'join ange-join)
       
       ;; trade
       (method 'trad ange-trade)
       (method 'room ange-trade)
       (method 'buy ange-trade)
       (method 'sell ange-trade)

       ;; inn
       (method 'inn  ange-inn)
       (method 'adve ange-adve)
       (method 'gint ange-gint)
       (method 'patr ange-patr)

       ;; town & people
       (method 'glas ange-glas)
       (method 'patc ange-patc)

       ))

(define (mk-angela)
  (bind 
   (kern-mk-char 'ch_angela          ; tag
                 "���󥸥���"        ; name
                 sp_human            ; species
                 nil                 ; occ
                 s_townswoman        ; sprite
                 faction-glasdrin         ; starting alignment
                 0 1 0               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 3  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'ange-conv          ; conv
                 sch_ange            ; sched
                 'townsman-ai                 ; special ai
                 (mk-inventory (list (list 1 t_dagger)))                 ; container
                 (list t_dagger
					         )                  ; readied
                 )
   (ange-mk)))
