;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;;
;; �ȥꥰ�쥤��
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_gwen
               (list 0  0  trigrave-gwens-bed        "sleeping")
               (list 8  0  trigrave-tavern-table-1a  "eating")
               (list 9  0  trigrave-inn-counter      "working")
               (list 13 0  trigrave-tavern-table-1d  "eating")
               (list 14 0  trigrave-inn-counter      "working")
               (list 20 0  trigrave-tavern-table-1a  "eating")
               (list 21 0  trigrave-inn-counter      "working")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (gwen-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;;
;; ���٥�Ͻɲ��μ�ͤǡ�ͥ������¿�������Ǥ��롣
;;----------------------------------------------------------------------------
(define (gwen-trade knpc kpc)
  (if (not (string=? "working" (kern-obj-get-activity knpc)))
      (say knpc "���Ź�������Ƥ���Ȥ�����Ƥ���������"
           "�ɲ��ֳ�����ȷ�פϤ���Į�������ˤ���ޤ���"
           "����9���˳����ơ��������Ź���ޤ���")
      (let ((door (eval 'trigrave-inn-room-1-door)))
        ;; is the room still open?
        (if (not (door-locked? (kobj-gob door)))
            ;; yes - remind player
            (say knpc "���ʤ��Τ������Ϥ⤦�����Ƥ��ޤ���")
            ;; no - ask if player needs a room
            (begin
              (say knpc "���������������ѤǤ�����")
              (if (kern-conv-get-yes-no? kpc)
                  ;; yes - player wants a room
                  (begin
                    (say knpc 
                         "����϶��" trigrave-inn-room-price "�硢"
                         "����Į�ˤ���֡����٤Ǥ������Ǥ��ޤ���"
                         "������Ǥ�����")
                    (if (kern-conv-get-yes-no? kpc)
                        ;; yes - player agrees to the price
                        (let ((gold (kern-player-get-gold)))
                          ;; does player have enough gold?
                          (if (>= gold trigrave-inn-room-price)
                              ;; yes - player has enough gold
                              (begin
                                (kern-player-set-gold 
                                 (- gold 
                                    trigrave-inn-room-price))
                                (say knpc "1�漼�Ǥ�������ä���ɤ�����")
                                (send-signal knpc door 'unlock)
                                (kern-conv-end)
                                )
                              ;; no - player does not have enouvh gold)
                              (say knpc "��ǰ�Ǥ������⤬­��ޤ���")))
                        ;; no - player does not agree to the price
                        (say knpc 
                             "��������ɤ��ɤϡ�����Ⱦ��ˤϤ���ޤ���衪")))
                  ;; no - player does not want a room
                  (say knpc "�ޤ��ε���ˤɤ�����")))))))

(define (gwen-thie knpc kpc)
  (say knpc "�Ф��㤫��Ƕ��褿�Ҥ�����λ�ƻ�ǤȤƤ�ޤ��Ǥ���ͤ򸫤������Ǥ��衣�Ф���Τ������ʹ���Ƥߤ�Ф褤���⤷��ޤ���")
  (quest-data-update-with 'questentry-thiefrune 'tower 1 (quest-notify (grant-party-xp-fn 10)))
  )

(define (gwen-news knpc kpc)
  (say knpc "��ƻ�դ��������פʤ�Τ�ʤ����������Ǥ��衣"))

(define gwen-conv
  (ifc basic-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default (lambda (knpc kpc) 
                          (say knpc "��ǰ�ʤ��餪�������Ǥ��ޤ���")))
       (method 'hail
               (lambda (knpc kpc)
                 (kern-print "�Τ��ʤ��ϳ����������夿̥��Ū�ʽ����Ȳ�ä���"
                             "���Υ٥�ȤˤϺ٤�Ĺ��^c+m��^c-�������롣��\n")
                 (say knpc "�褦������ι������")))
       (method 'bye (lambda (knpc kpc) (say knpc "���꤬�Ȥ��������ޤ�����")))
       (method 'job 
               (lambda (knpc kpc) 
                 (say knpc "�ȥꥰ�쥤�֤νɲ��򤷤Ƥ���ޤ���")
                 (gwen-trade knpc kpc)))
       (method 'name (lambda (knpc kpc) (say knpc "��ϥ��٥�Ǥ���")))
       (method 'trad gwen-trade)
       (method 'join 
               (lambda (knpc kpc) 
                 (say knpc "���ι�Ϥ⤦�����ޤ�����"
                      "�Ǥ⡢��Ͷ�����꤬�Ȥ��������ޤ���")))
       (method 'chan
               (lambda (knpc kpc)
                 (say knpc "���Τ�Ĵ�ҼԤ����ʤϼ��ˤ��ޤ���"
                      "���٤��ʤ�������ߤ����˿�ä���������äƤ��ޤ���")))
       (method 'civi 
               (lambda (knpc kpc) 
                 (say knpc "���Τ�����Τ��Ȥ��ä��ԻԤοͤϤ��ޤꤤ�ޤ���")))
       (method 'earl
               (lambda (knpc kpc)
                 (say knpc "��Ũ�ʡ��Ǥ�ʪ˺��η㤷����Ϸ�ͤǤ���"
                      "��ϻ�νɤ����Ź���ڤ����ꤷ�Ƥޤ���")))
       (method 'enem 
               (lambda (knpc kpc) (say knpc "���ʤ��ˤϴط��Τʤ����ȤǤ���")))
       (method 'esca 
               (lambda (knpc kpc)
                 (say knpc "�⤷��Ũ���Ѥ���٤��Ԥ�����Ȥ򱣤������ʤ顢"
                      "���Υ����ɤ�˺���줿�Ϥ���ɤ����Ϥʤ��Ǥ��礦��")))
       (method 'inn  
               (lambda (knpc kpc)
                 (say knpc "�ɲ��ϳڤ����Ż��Ǥ���"
                            "ι�ͤ��鿧�����ä�ʹ���ޤ����顣")))
       (method 'jim
               (lambda (knpc kpc)
                 (say knpc "�ϥ󥵥�ʡ��Ǥ⾯���Ӥäݤ��ͤǤ���"
                      "������ü�����결��Ĥ�Ǥޤ���")))
       (method 'news gwen-news)
       (method 'stor gwen-news)
       (method 'room gwen-trade)
       (method 'sham 
               (lambda (knpc kpc) (say knpc "���ʤ��ˤϴط��Τʤ����ȤǤ���")))
       (method 'swor
               (lambda (knpc kpc) 
                 (say knpc "ͧ�ͤ�������������ΤǤ���")))
       (method 'tave
               (lambda (knpc kpc)
                 (say knpc "���۵����աפϤ���Į����¦�ˤ���ޤ���")))
       (method 'thie gwen-thie)
       (method 'trig 
               (lambda (knpc kpc) 
                 (say knpc "�������ԻԤ���Υ�줿������Į�Ǥ���"
                      "��������οͤ�ƨ��뤿��ˤ����ˤ��ޤ���")))

       ))
