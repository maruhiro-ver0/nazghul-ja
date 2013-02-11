;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define meaney-lvl 6)
(define meaney-species sp_human)
(define meaney-occ nil)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ���ѡ����ζ᤯�ε��ϱ�
;;----------------------------------------------------------------------------
(define meaney-bed poorh-bed1)
(define meaney-mealplace poorh-sup1)
(define meaney-workplace poorh-hall)
(define meaney-leisureplace poorh-dining)
(kern-mk-sched 'sch_meaney
               (list 0  0 meaney-bed          "sleeping")
               (list 5  0 meaney-mealplace    "eating")
               (list 6  0 meaney-workplace    "working")
               (list 12 0 meaney-mealplace    "eating")
               (list 13 0 meaney-workplace    "working")
               (list 18 0 meaney-mealplace    "eating")
               (list 19 0 meaney-leisureplace "idle")
               (list 21 0 meaney-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (meaney-mk) (list 0 #t))
(define (meaney-get-donated meaney) (car meaney))
(define (meaney-donated? meaney) (> (meaney-get-donated meaney) 
                                    0))
(define (meaney-donate! meaney q) (set-car! meaney (+ (car meaney) q)))
(define (meaney-has-ring meaney) (cadr meaney))
(define (meaney-remove-ring meaney) (set-car! (cdr meaney) #f))

(define (meaney-on-death knpc)
	(if  (meaney-has-ring (kobj-gob-data knpc))
		(kern-obj-put-at (kern-mk-obj t_skull_ring_m 1) (kern-obj-get-location knpc))
	))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; �ߡ��ˡ��Ͻ���ϩ���Ĥ���η�ǡ����ѡ����ζ᤯�ε��ϱ��˽���Ǥ��롣
;; ��Ϥ��Ĥƻ��ῼ�����ξ��Ȱ��γ�±���ä���
;; ������˴��Ȥʤä������ƥ���Ĺ�������Τ����ɤ��Ƥ��롣
;;----------------------------------------------------------------------------

;; ����
(define (meaney-hail knpc kpc)
  (say knpc "���ʤ��򴿷ޤ��ޤ���ι������"))

(define (meaney-default knpc kpc)
  (say knpc "����Ϥ��������Ǥ��ޤ���"))

(define (meaney-name knpc kpc)
  (say knpc "��ƻ�ΤΥߡ��ˡ��Ǥ���")
  (quest-data-update 'questentry-ghertie 'meaney-loc 1))

(define (meaney-join knpc kpc)
  (say knpc "��ˤ��Ϥ����ԤȲ���򤷤��Ԥؤε�̳������ޤ���"))

(define (meaney-job knpc kpc)
  (say knpc "���ε��ϱ���"
       "�¤μԡ��Ϥ����ԤΤ����Ư���Ƥ��ޤ���"))

(define (meaney-bye knpc kpc)
  (say knpc "���褦�ʤ顣"))

;; Second-tier responses
(define (meaney-get-donation knpc kpc)
  (define (rejected)
    (cond ((> (kern-player-get-gold) 0)
           (say knpc "�����Ǥ������ǤϤޤ��ΤȤ��ˡ�������ᤷ�������ؤ����������")
           (kern-conv-end))
          (else
           (say knpc "���ʤ���ɬ�פ��⤷��ޤ���"))))
  (let ((meaney (kobj-gob-data knpc)))
    (if (not (meaney-donated? meaney))
        (begin
          (say knpc "�Ϥ����ԤΤ�����դ򤪴ꤤ�Ǥ��ޤ�����")
          (if (kern-conv-get-yes-no? kpc)
              (let ((q (get-gold-donation knpc kpc)))
                (if (> q 0)
                    (begin
                      (say knpc "ι�����˽�ʡ���졪"
                           "���ʤ��ιԤ��ϵ��������Ǥ��礦��")
                      (meaney-donate! meaney q))
                    (rejected)))
              (rejected))))))

(define (meaney-poor knpc kpc)
  (say knpc "���ε��ϱ��Ǥ�̤˴�ͤȸɻ���ٱ礷�Ƥ��ޤ���"
       "���ʤ��Ͻ�����ɬ�פǤ�����")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "�ʤ�д��ǿ����򾯤�ʬ��Ϳ���ޤ��礦��")
      (meaney-get-donation knpc kpc)))

(define (meaney-sick knpc kpc)
  (say knpc "�������褿�Ԥ�ɬ�פʤ��ï�Ǥ⼣�Ť��ޤ������Ť�ɬ�פǤ�����")
  (if (kern-conv-get-yes-no? kpc)
      (meaney-trade knpc kpc)
      (meaney-get-donation knpc kpc)))

(define (meaney-brot knpc kpc)
  (say knpc "��Ͻ���ϩ���Ĥ���η�Ǥ���"
       "���ζ��Ĥ��¤��ͤΥǡ��ӥ��ˤ�ꡢ7�����ʾ������Ϥ����͡���ߤ��������Ω����ޤ�����"))

;; Trade...
(define (meaney-trade knpc kpc)
  (if (trade-services knpc kpc
                      (list
                       (svc-mk "���ϲ���" 0 heal-service)
                       (svc-mk "����" 0 cure-service)
                       ))
      (begin
        (say knpc "¾�˼��Ť�ɬ�פʿͤϤ��ޤ�����")
        (meaney-trade knpc kpc))
      (begin
        (say knpc "¾�˲���ɬ�פǤ�����")
        (if (kern-conv-get-yes-no? kpc)
            (meaney-trade knpc kpc)
            (meaney-get-donation knpc kpc)))))

;; Town & Townspeople

;; Quest-related
(define (meaney-pira knpc kpc)
	(quest-data-update 'questentry-ghertie 'meaney-loc 1)
	(say knpc "��������Ϥ��ĤƤϳ�±�Ǥ��������ä��ΤΤ��ȤǤ���"
		"���ä�����Υ����ƥ����ȶ��˻��ῼ�����˾�äƤ��ޤ�����"
		"���Ϥ��ν����Ȥ����Ϥ����ͤ����˿����������Ƥ��ޤ���"))

(define (meaney-gher knpc kpc)
  (say knpc "�����ƥ����ϻ䤿���겼���²�Τ褦�ˤ��Ĥ��äƤ���ޤ�����"
       "Ʊ�����ƼϤʤ�άå�Ԥǡ�ʶ���ʤ����ޤǤ⤢��ޤ�����"
       "����ϻ�̤٤����ä��Ǥ��礦��"
       "������������������©�Ҥ����ˤ�äƤʤ����٤��ǤϤ���ޤ���Ǥ�����"))

(define (meaney-pena knpc kpc)
  (say knpc "��Ͽ�¿���κ���Ȥ��������Ƥ�������οͤη��ή���ޤ�����"
       "�����Ĺ��΢�ڤꡢ�����Ƶդ�΢�ڤ��ޤ�����"))

(define (meaney-betr knpc kpc)
  (say knpc "�겼�����Ƕ��Ť���Ĺ�򻦤���å�ä���Τ�ʬ���ޤ�����"
       "��ʬ�������������ʤ���С�����ϼ�ʬ���������򻦤������Ȼפ�����Ǥ����ΤǤ���"
       "�ǽ��ͧ�������͡������ƻ�ϼ�����ǲ��ˤʤäƤ���֤�����򻦳����ޤ�����"
       "��������������äƤߤ�ȡ����ϻ䤿�����֤��ƹԤäƤ��ޤä��ΤǤ���"))

(define (meaney-firs knpc kpc)
  (say knpc "�ǽ��ͧ�ϥ��硼��Ȥ���̾�ΰ��ޤǤ���"
       "���Ǥ���ι���ʿ��Τɤ�������±���äƤ����ʹ���ޤ�����"
       "�Ф����ʹ���Ф褤���⤷��ޤ���")
       (quest-data-update 'questentry-ghertie 'jorn-forest 1))

(define (meaney-cook knpc kpc)
  (say knpc "����åȤϻ��������ɤ�����ϴ����������ޤ�Ƥ���Ǥ��礦��"
       "�Ǹ�˲�ä��ΤϿ�����ˤ�����ˬ�줿�Ȥ��Ǥ�����"
       "����ī���ܤ��Ф������Ȣ�θ���������Ƥ��ޤ�����"
       "������Ȣ����϶��Ǥ�����")
       (quest-data-update 'questentry-ghertie 'gholet-prison 1)
       )

(define (meaney-ring knpc kpc)
  (if (not (meaney-has-ring (kobj-gob-data knpc)))
      (say knpc "�⤦���μ���줿���ؤϸ������ʤ���ΤǤ���")
      (begin
        (say knpc "�Ϥ�����ϥ����ƥ�����©�ҡ����ῼ�����λ��ؤ�Ĥ��Ƥ��ޤ���"
             "��������Ͽͻ����γ�±�ʤΤǤ���")
        (prompt-for-key)
        (say knpc "���������ˤ��Ȥ����Ϥ��褿�¤��ͤΥ�Ȥϡ����η��ˤ�ä�������ܤ��������Ǥ���"
              "����Ǻᤷ�Ƥ���ޤ�����")
        (if (yes? kpc)
            (begin
              (say knpc "���η��ǹԤäƤ����������и�ϤǤ��Ƥ��ޤ��������Ƭ�򲼤�������")
              (kern-conv-end))
            (begin
              (say knpc "���ʤ��ϻ��ῼ��������"
                    "���������������λ��ؤ��̤��Ȥ������Τ���ˤϤ��λؤ��̤�ʤ���Фʤ�ޤ���"
                    "��ˤϤ��λؤ��ڤ���Ȥ�ͦ���Ϥ���ޤ��󡣤��ʤ�����äƤ���ޤ�����")
              (if (yes? kpc)
                  (begin
                    (say knpc "�Τ��ʤ�����μ��Ĥ��ߡ����᤯�ؤ��ڤ���Ȥ�������"
                          "�������á�����ǻ�ϼ��������������ޤ�����"
                          "���꤬�Ȥ��������ޤ����¤��͡�"
                          "�⤷���������伣�Ť�ɬ�פʤ顢��Ϥ��ʤ��Τ���˹Ԥ��ޤ���")
			(skullring-m-get nil kpc)
			(meaney-remove-ring (kobj-gob-data knpc))
                    )
                  (say knpc "��Ϥ��ΰ�������Τ���������줿���ΤǤ���")))))))

(define meaney-conv
  (ifc basic-conv

       ;; basics
       (method 'default meaney-default)
       (method 'hail meaney-hail)
       (method 'bye  meaney-bye)
       (method 'job  meaney-job)
       (method 'name meaney-name)
       (method 'join meaney-join)
       
       ;; trade
       (method 'trad meaney-trade)
       (method 'buy  meaney-trade)
       (method 'sell meaney-trade)

       ;; town & people

       ;; other responses
       (method 'poor meaney-poor)
       (method 'dest meaney-poor)
       (method 'sick meaney-sick)
       (method 'heal meaney-sick)
       (method 'affl meaney-sick)
       (method 'brot meaney-brot)
       (method 'hous meaney-job)

       ;; pirate quest replies
       (method 'pira meaney-pira)
       (method 'gher meaney-gher)
       ;(method 'ma   meaney-gher)
       (method 'capt meaney-gher)
       (method 'pena meaney-pena)
       (method 'betr meaney-betr)
       (method 'firs meaney-firs)
       (method 'cook meaney-cook)
       (method 'ring meaney-ring)
       (method 'skul meaney-ring)
       (method 'ghol meaney-cook)
       (method 'jorn meaney-firs)
       ))

(define (mk-meaney)
	(let ((knpc
    (kern-mk-char 
     'ch_meaney           ; tag
     "�ߡ��ˡ�"           ; name
     meaney-species         ; species
     meaney-occ              ; occ
     s_companion_shepherd  ; sprite
     faction-men      ; starting alignment
     1 2 1            ; str/int/dex
     0 0              ; hp mod/mult
     0 0              ; mp mod/mult
     max-health ; hp
     -1                   ; xp
     max-health ; mp
     0
     meaney-lvl
     #f               ; dead
     'meaney-conv         ; conv
     sch_meaney           ; sched
     'townsman-ai              ; special ai

     ;;..........container (and contents)
     (mk-inventory
      (list
       (list 1 t_dagger)
       ))
     nil              ; readied
     )))
 (kern-char-force-drop knpc #t)
  (bind knpc (meaney-mk))
  (kern-obj-add-effect knpc 
           ef_generic_death
           'meaney-on-death)
	  knpc) )
  