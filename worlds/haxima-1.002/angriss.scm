;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define angriss-lvl 20)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ���󥰥ꥹ�ν��߲�
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (angriss-mk)
  (list #f (mk-quest)))

(define (angriss-quest angriss) (cadr angriss))
(define (angriss-spoke? angriss) (car angriss))
(define (angriss-spoke! angriss) (set-car! angriss #t))

;;----------------------------------------------------------------------------
;; Conv
;;
;; ���󥰥ꥹ�ϥ��⤿���ν����ǡ����󥰥ꥹ�ν��߲Ȥˤ��롣
;; ���꿼�������ʿ������۷��Τ�ΤǤ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (angriss-hail knpc kpc)
  (say knpc "�����ޤ������餫��\n"
       "���������Τ衡����������\n"
       "���Ҥ��फ"))

(define (angriss-default knpc kpc)
  (say knpc "���֤������������Τ褦��ȿ�����ʤ��ä�����"))

(define (angriss-name knpc kpc)
  (say knpc "�ͤˤϥ��󥰥ꥹ\n"
       "���֥��ˤϥ륫\n"
       "�ȥ��ˤϥҥ֥�ߥΥ�\n"))

(define (angriss-join knpc kpc)
  (say knpc "������Ȳ񤨤ɤ�\n"
       "��������Τϵۤ���\n"
       "���ȿͤϤ��Τ褦�ʤ��"))

(define (angriss-job knpc kpc)
  (say knpc "����"))

(define (angriss-bye knpc kpc)
  (say knpc "��ϸ��λ��ۤ�\n"
       "�ƤӽФ��줷��Ρ����ɤ��失��ΤǤ����\n"
       "�����뤬�褤\n"))


(define (angriss-soft knpc kpc)
  (say knpc "�Ť��磻������Ȥ�\n"
       "�ͤ���ƺ���٤������Ͽͤ�\n"
       "�٤����磻������"))

(define (angriss-hung knpc kpc)
  (say knpc "����\n"
       "�������ή�����\n"
       "��Ϲ�λ��ȤȤ��"))

(define (angriss-men knpc kpc)
  (say knpc "���ȸؤ餷����\n"
       "���Ƚ��餫�����\n"
       "���ȴŤ��򤫤�"))

(define (angriss-gobl knpc kpc)
  (say knpc "Ǧ��­�μ��\n"
       "�������ʤ⤬��\n"
       "�Ĥ��ˤ�Ĺ��̲��"))

(define (angriss-trol knpc kpc)
  (say knpc "�Ф��ꤲ������Ǥ�\n"
       "���������Ĥ�����\n"
       "���Ĥؤ��Ѥ��"))

(define (angriss-choose knpc kpc)
  (say knpc "���ؤ�������Τ�����")
  (let ((kchar (kern-ui-select-party-member))
        (quest (angriss-quest (kobj-gob-data knpc))))
    (if (null? kchar)
        (begin
          (say knpc "�����Ƥ����֤����ä���")
          (harm-relations knpc kpc)
          (harm-relations knpc kpc)
          (kern-conv-end))
        (if (is-dead? kchar)
            (begin
              (say knpc "���������򾪤ϵ�ࡪ\n"
                   "�ǡ����ԡ�����ϻष���졪\n"
                   "¾��������")
              (kern-conv-end))
            (begin
              (say knpc "�����������줿\n")
              (if (not (quest-done? quest))
                  (quest-done! quest #t))
              (kern-char-leave-player kchar)
              (kern-being-set-base-faction kchar faction-none)
              (improve-relations knpc kpc)
              (kern-conv-end))))))


(define (angriss-rune knpc kpc)
  (let ((quest (angriss-quest (kobj-gob-data knpc))))
    (if (quest-done? quest)
        (begin
          (say knpc "���Ť���̩\n"
               "�Ϲ��ؤθ�\n"
               "��Τ�Τʤ�")
          (kern-obj-remove-from-inventory knpc t_rune_f 1)
          (kern-obj-add-to-inventory kpc t_rune_f 1)
          (rune-basic-quest 'questentry-rune-f s_runestone_f)
         )
        (say knpc "���õ��ʪ�򾪤��Τ�\n"
             "�����ޤ���\n"
             "�����Ǿ���������"))))

(define (angriss-sacr knpc kpc)

  (define (player-alone?)
    (< (num-player-party-members) 
       2))

  (let ((quest (angriss-quest (kobj-gob-data knpc))))

    (define (refused)
      (say knpc "����������ä���\n"
           "�����ܤ꤫���ƨ�����褦\n"
           "��������뤳�ȤϤǤ��̤Ǥ���")
      (harm-relations knpc kpc)
      (harm-relations knpc kpc)
      (kern-conv-end))

    (define (offer-quest)
      (display "offer-quest")(newline)
      (if (player-alone?)
          (begin
            (say knpc "���Ĥ��衡����ʤ�\n"
                 "�򤫼Ԥ�������ߡ������Ф�\n"
                 "����򤫤ʤ�Τ�\n"
                 "�ΡĤɤ����롩��")
            (if (kern-conv-get-yes-no? kpc)
                (begin
                  (quest-accepted! quest)
                  (improve-relations knpc kpc)
                  (improve-relations knpc kpc))
                (refused)))
          (begin
            (say knpc "�����椫��\n"
                 "��ͤε���������\n"
                 "����м�ͳ�ˤʤ�\n"
                 "�ΡĤɤ����롩��")
            (if (kern-conv-get-yes-no? kpc)
                (angriss-choose knpc kpc)
                (refused)))))
            
    (if (quest-done? quest)
        (say knpc "����������뤲��줿")
        (if (quest-accepted? quest)
            (if (player-alone?)
                (say knpc "��ϰ�ͤʤ�\n"
                     "��館���ह�٤�����\n"
                     "�����Ϥ�����")
                (choose-victim))
            (offer-quest)))))


(define (angriss-hono knpc kpc)
  (say knpc "���Ͽ��Ҥ���\n"
       "�����Ƶ����򡡾���Ϳ����\n"
       "�����餺��ƨ˴���फ"))

(define angriss-conv
  (ifc basic-conv

       ;; basics
       (method 'default angriss-default)
       (method 'hail angriss-hail)
       (method 'bye angriss-bye)
       (method 'job angriss-job)
       (method 'name angriss-name)
       (method 'join angriss-join)
       
       (method 'soft angriss-soft)
       (method 'hung angriss-hung)
       (method 'rune angriss-rune)
       (method 'men angriss-men)
       (method 'gobl angriss-gobl)
       (method 'trol angriss-trol)
       (method 'sacr angriss-sacr)
       (method 'hono angriss-hono)
       ))

(define (angriss-ai kchar)
  (if (angriss-spoke? (kobj-gob-data kchar))
      (spider-ai kchar)
      (begin
        (angriss-spoke! (kobj-gob-data kchar))
        (kern-conv-begin kchar))))

(define (mk-angriss)
  (bind 
   (kern-char-force-drop
    (kern-mk-char 
     'ch_angriss         ; tag
     "���󥰥ꥹ"        ; name
     sp_queen_spider     ; species
     nil                 ; occ
     s_purple_spider     ; sprite
     faction-spider ; starting alignment
     20 0 20             ; str/int/dex
     10 5                ; hp mod/mult
     10 5                ; mp mod/mult
     max-health ;;..current hit points
     -1 ;;...........current experience points
     max-health ;;..current magic points
     0
     angriss-lvl
     #f                  ; dead
     'angriss-conv       ; conv
     nil                 ; sched
     'angriss-ai          ; special ai
     
     ;;..........container (and contents)
     (mk-inventory (list (list 1 t_rune_f)))
     nil                 ; readied
     )
    #t)
    (angriss-mk)))
