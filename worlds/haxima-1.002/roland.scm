;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (roland-mk free? joined? greeted?) (list free? joined? greeted?))
(define (roland-is-free? knpc) (car (kobj-gob-data knpc)))
(define (roland-joined? knpc) (cadr (kobj-gob-data knpc)))
(define (roland-greeted? knpc) (caddr (kobj-gob-data knpc)))
(define (roland-set-free! knpc) (set-car! (kobj-gob-data knpc) #t))
(define (roland-set-joined! knpc) (set-car! (cdr (kobj-gob-data knpc)) #t))
(define (roland-set-greeted! knpc) (set-car! (cddr (kobj-gob-data knpc)) #t))

(define roland-greetings
  (list
   "����ˤ��ϡ�"
   "�⤷���¤����¡�"
   ))

;;----------------------------------------------------------------------------
;; Custom AI
;; 
;; This AI controls Roland until he is freed. It constantly tries to pathfind
;; to the prison exit. Once it gets outside the cell it sets the "freed" flag
;; and resorts to the default kernel AI.
;;----------------------------------------------------------------------------
(define (roland-exit-point knpc)
  (mk-loc (kobj-place knpc)
          (rect-x slimey-cavern-prison-cell-exit)
          (rect-y slimey-cavern-prison-cell-exit)))

(define (roland-ai knpc)
  (define (out-of-cell?)
    (not (loc-in-rect? (kern-obj-get-location knpc)
                       slimey-cavern-prison-cell)))
  (define (try-to-escape)
    (kern-log-enable #f)
    (pathfind knpc (roland-exit-point knpc))
    (kern-log-enable #t))
  (define (set-free)
    (roland-set-free! knpc)
    (kern-char-set-ai knpc nil)
    (kern-being-set-base-faction knpc faction-men)
    )
  (or (roland-greeted? knpc)
      (and (any-player-party-member-visible? knpc)
           (begin
             (taunt knpc nil roland-greetings)
             (roland-set-greeted! knpc))))
  (if (out-of-cell?)
      (set-free knpc)
      (try-to-escape)))

;; Note: (can-pathfind? ...) will pathfind through the locked door nowadays, so
;; it cannot be relied on. Let's just let Roland try to get out and he'll know
;; he's free.
(define (roland-is-or-can-be-free? knpc)
  (roland-is-free? knpc))

(define (roland-join-player knpc)
  (or (roland-joined? knpc)
      (begin
        (join-player knpc)
        (roland-set-joined! knpc #t))))

;;----------------------------------------------------------------------------
;; Conv
;;
;; �����ɤ�ι�ε��Τǡ������ӥ����˻Ť��Ƥ�����
;; ��Ϻ��Ǥ�Ǵ�ݤ�ƶ����ϴ����館���Ƥ��롣
;; �����ɤ���֤ˤʤ롣
;;----------------------------------------------------------------------------
(define (roland-join knpc kpc)
  (if (is-player-party-member? knpc)
      (say knpc "������������֤ˤʤäƤ��롣��Ƴ���������졪")
      (if (roland-joined? knpc)
          (begin
            (say knpc "�Ƥ���֤˲ä�ä����Ȥ�̾���˻פ���")
            (join-player knpc)
            (kern-conv-end)
            )
          (if (roland-is-or-can-be-free? knpc)
              ;; yes - will the player accept his continued allegiance to
              ;; Froederick?
              (begin
                (say knpc "�������Ƥ��줿���Ȥ˴��դ��롪���ʤ���̿�β��ͤ������ʤ�����֤˲ä�ꤿ�����ɤ���������")
                (if (yes? kpc)
                    (begin
                      (say knpc "���ɤ˻פ���"
                           "�ʤ餺�Ԥ����ϻ�γ������ʪ��å�ä���"
                           "���Τ�����ˤ���Ϥ�����")
                      (roland-join-player knpc))
                    (say knpc "���ᤷ�����ˡϤ���˾��ʤ顣")))
              (say knpc "ϴ���Ĥ�������Ƥ��ޤä��Τ�����������Ф��ơ�"
                   "��֤ˤ��Ƥ������졣")
              ))))
  
(define roland-conv
  (ifc basic-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default 
               (lambda (knpc kpc) 
                 (say knpc "��ǰ�ʤ��顢����ϼ�����Ǥ������ˤʤ���")))
       (method 'hail 
               (lambda (knpc kpc) 
                 (if (roland-joined? knpc)
                     (say knpc "�Ǥ���ʤ餢�ʤ��Τ�����������������")
                     (roland-join knpc kpc))))

       (method 'bye (lambda (knpc kpc) (say knpc "���褦�ʤ顣")))
       (method 'job 
               (lambda (knpc kpc) 
                 (say knpc "ι�ε��Τ���")))
       (method 'name (lambda (knpc kpc) (say knpc "��ϥ����ɤ���")))
       (method 'join roland-join)

       (method 'cell
               (lambda (knpc kpc)
                 (say knpc "������ƻ�񤬤������򳫤����롣"
                      "�����Ǥʤ���С���򳫤����ʸ�򾧤��Ƥ������졣")))
       (method 'clov
               (lambda (knpc kpc)
                 (say knpc "��ϲ����ݤ줿����������äƤ����Τ���"
                      "���Ȼ��Ũ���Ԥ������˲񤤡����򼺤ä���"
                      "���λ�������Ƥ����ä������Ϲ��˰����������̴�򸫤���"
                      "�ܤ��Ф��ȡ���������±��ˤ����Τ���")))
       (method 'free
               (lambda (knpc kpc)
                 (say knpc "�Ԥ������ˤ���������ƶ����Ͷ������Ƥ��ޤä��Τ���"
                      "�ۤ�ϻ�򤳤�ϴ���Ĥ����ᡢ�������׵ᤷ�Ƥ��롣")))
       (method 'pick
               (lambda (knpc kpc)
                 (say knpc "��±�Ͼ�˸�����ƻ�����äƤ��롣")))
       (method 'spel
               (lambda (knpc kpc)
                 (say knpc "��ʸ����ѻդ�ʹ���Ƥ������졣")))
       (method 'trig 
               (lambda (knpc kpc) 
                 (say knpc "�ȥꥰ�쥤�֤��̤�ƻ���򺹤���Ȥ���ˤ��뾮����Į����"
                      "�����ˤ�Ĺ����ˤ����롣")))
       (method 'knig 
               (lambda (knpc kpc)
                 (say knpc "��ϥ��֥������Τ������ӥ����˻Ť��Ƥ�����"
                      "���褬����ꡢ��ϲ����褦�ˤʤä���")
                 ))
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-roland)
  (bind 
    (kern-mk-char 
     'ch_roland          ; tag
     "������"        ; name
     sp_human            ; species
     oc_warrior          ; occ
     s_knight            ; sprite
     faction-prisoner    ; starting alignment
     6 0 6               ; str/int/dex
     pc-hp-off           ; hp bonus
     pc-hp-gain          ; hp per-level bonus
     0                   ; mp off
     0                   ; mp gain
     max-health          ; hp
     -1                  ; xp
     max-health          ; mp
     0                   ; ap
     3                   ; lvl
     #f                  ; dead
     'roland-conv        ; conv
     nil                 ; sched
     'roland-ai          ; special ai
     nil                 ; container
     nil                 ; readied
     )
    (roland-mk #f #f #f)))
