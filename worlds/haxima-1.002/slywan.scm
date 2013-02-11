;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define slywan-lvl 2)
(define slywan-species sp_human)
(define slywan-occ oc_wrogue)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ��ʪ��¼������
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_slywan
               (list 0 0 kun-road "working")
               (list 2 0 campfire-2 "sleeping")
               (list 9 0 cantina-9 "idle")
               (list 14 0 black-market "idle")
               (list 17 0 cantina-9 "idle")
               (list 23 0 kun-road "working")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (slywan-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ���饤����ť��(�����̾�ͤǤ���)�ǡ���ʪ��¼������˽���Ǥ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (slywan-hail knpc kpc)
  (kern-log-msg "���ʤ����ؤ��㤤�ˤȲ�ä���")
  (say knpc "�褪��")
  )

(define (slywan-default knpc kpc)
  (say knpc "����ϸ��򤹤����Ǧ�ӾФ��򤷤�����")
  )

(define (slywan-name knpc kpc)
  (say knpc "���饤��󡢲��Ǥ�ɤ�����")
  )

(define (slywan-join knpc kpc)
  (say knpc "�����ʡ�ͧ�衣")
  )

(define (slywan-job knpc kpc)
  (say knpc "����Ȥ�������狼�����")
  )

(define (slywan-bye knpc kpc)
  (let ((q (min (kern-player-get-gold)
                (kern-dice-roll "1d20"))))
    (take-player-gold q)
    (kern-obj-add-to-inventory knpc t_gold_coins q)
    (say knpc "�ޤ��ʡ�")
    ))

(define (slywan-this knpc kpc)
  (say knpc "�����Ƥ������"))

(define (slywan-that knpc kpc)
  (say knpc "�����Ƥ������"))

(define (slywan-bust knpc kpc)
  (say knpc "���äȡ��Ԥ��ʤ��Ƥϡ�")
  (kern-obj-add-effect knpc ef_invisibility nil)
  (kern-char-set-fleeing knpc #t)
  (kern-being-set-current-faction knpc faction-outlaw)
  (kern-conv-end)
  )

(define (slywan-thie knpc kpc)
  (say knpc "�ʤˡ����줬���ޥ����饫�ͤ������äơ�")
  (if (yes? kpc)
      (begin
        (say knpc "�ܤäƤ롩")
        (if (yes? kpc)
            (slywan-bust knpc kpc)
            (say knpc "�����Ĥؤäء������󤽤�����ʡ������ʡ����Ĥ���ʤ��ä���")))
      (say knpc "�褫�ä��ʡ������ϤҤɤ�Į����ï�⿮�����㤤���ʤ���")))

(define slywan-conv
  (ifc nil

       ;; basics
       (method 'default slywan-default)
       (method 'hail slywan-hail)
       (method 'bye  slywan-bye)
       (method 'job  slywan-job)
       (method 'name slywan-name)
       (method 'join slywan-join)

       (method 'this slywan-this)
       (method 'that slywan-that)
       (method 'bust slywan-bust)
       (method 'thie slywan-thie)
       (method 'gold slywan-thie)
       (method 'stol slywan-thie)
       ))

(define (mk-slywan)
  (bind 
   (kern-char-force-drop
   (kern-mk-char 
    'ch_slywan           ; tag
    "���饤���"         ; name
    slywan-species         ; species
    slywan-occ              ; occ
    s_brigand     ; sprite
    faction-men      ; starting alignment
    1 0 4            ; str/int/dex
    0  ; hp bonus
    0 ; hp per-level bonus
    0 ; mp off
    1 ; mp gain
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    slywan-lvl
    #f               ; dead
    'slywan-conv         ; conv
    sch_slywan           ; sched
    'townsman-ai              ; special ai
    (mk-inventory nil) ;; container
    (list t_sword
					         t_armor_leather
					         )               ; readied
    )
   #t)
   (slywan-mk)))
