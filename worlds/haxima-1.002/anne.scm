;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define anne-lvl 4)
(define anne-species sp_human)
(define anne-occ oc_wizard)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ����ݥꥹ�������Τκ�
;;----------------------------------------------------------------------------
(define anne-bed ph-bed2)
(define anne-mealplace ph-tbl2)
(define anne-workplace ph-medik)
(define anne-leisureplace ph-dine)
(kern-mk-sched 'sch_anne
               (list 0  0 anne-bed          "sleeping")
               (list 7  0 anne-mealplace    "eating")
               (list 8  0 anne-workplace    "working")
               (list 12 0 anne-mealplace    "eating")
               (list 13 0 anne-workplace    "working")
               (list 18 0 anne-mealplace    "eating")
               (list 19 0 anne-leisureplace "idle")
               (list 22 0 anne-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (anne-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ����ͤ�����ѻդν����ǡ���դȤ��ƥ��饹�ɥ���Ư���Ƥ��롣
;; ����ϸ��ߤϥ���ݥꥹ�������Τκ֤�Ǥ̳�ˤĤ��Ƥ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (anne-name knpc kpc)
  (say knpc "����ͤȸƤФ�Ƥ��ޤ���"))

(define (anne-job knpc kpc)
  (say knpc "���饹�ɥ��ΰ�դǤ������Ť�ɬ�פǤ�����")
  (if (yes? kpc)
      (anne-trade knpc kpc)))

(define (anne-trade knpc kpc)
  (if (trade-services knpc kpc
                      (list
                       (svc-mk "����" 30 heal-service)
                       (svc-mk "����" 30 cure-service)
                       (svc-mk "����" 100 resurrect-service)))
      (begin
        (say knpc "¾�˲���ɬ�פǤ�����")
        (anne-trade knpc kpc))
      (begin
        (say knpc "¾�˲���ɬ�פǤ�����")
        (if (kern-conv-get-yes-no? kpc)
            (anne-trade knpc kpc)
            (say knpc "������ˡ�")))))

(define (anne-medik knpc kpc)
  (say knpc "�襤�ǽ��Ĥ��������Τ��Ť��Ƥ��ޤ���¾�οͤμ��Ť�Ԥ��ޤ��������ɬ�פǤ�����"))

(define (anne-kurp knpc kpc)
  (say knpc "�����Ϸи��������ͤˤϤĤ餤���Ǥ����ʤ�пʤ�ۤɤҤɤ��ʤ�ޤ���"))

(define anne-conv
  (ifc kurpolis-conv

       ;; basics
       (method 'job anne-job)
       (method 'name anne-name)
       
       ;; trade
       (method 'trad anne-trade)
       (method 'heal anne-trade)
       (method 'pric anne-trade)

       (method 'medi anne-medik)
       (method 'kurp anne-kurp)
       ))

(define (mk-anne)
  (bind 
   (kern-mk-char 
    'ch_anne           ; tag
    "�����"           ; name
    anne-species         ; species
    anne-occ              ; occ
    s_companion_wizard     ; sprite
    faction-men      ; starting alignment
    1 3 2            ; str/int/dex
    0 0              ; hp mod/mult
    0 0              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    anne-lvl
    #f               ; dead
    'anne-conv         ; conv
    sch_anne           ; sched
    'townsman-ai              ; special ai
    nil              ; container
    (list t_sword
					         t_armor_leather
					         )               ; readied
    )
   (anne-mk)))
