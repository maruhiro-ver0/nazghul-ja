;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ����ݥꥹ�������
;;----------------------------------------------------------------------------
(define doug-bed ke-bed1)
(define doug-mealplace ke-tbl1)
(define doug-workplace ke-hall)
(define doug-leisureplace ke-dine)
(kern-mk-sched 'sch_doug
               (list 0  0 doug-bed          "sleeping")
               (list 11 0 doug-mealplace    "eating")
               (list 12 0 doug-workplace    "working")
               (list 18 0 doug-mealplace    "eating")
               (list 19 0 doug-leisureplace "idle")
               (list 24 0 doug-workplace    "working")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (doug-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; �����饹�ϥ���ݥꥹ������������Ϥλش����ǡ����֥��β���γ��Υ���ݥ�
;; ����������˿ؤ��֤��Ƥ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (doug-hail knpc kpc)
  (say knpc "�Τ��ʤ��ϸ�������Ĥ��������ΤȲ�ä������Ϲ���������ؤ褦������ι�ͤ衣")
  (if (and (in-player-party? 'ch_mesmeme)
           (is-alive? ch_mesmeme))
      (begin
        (say knpc "����ϥ᥹���򸫤����Ϥ����µܤ���館���Τ���")
        (if (yes? kpc)
            (say knpc "������軰�ؤ������Τκ֤β��ˤ��롣"
                 "���������ƽ�ˤ��줬����Ȥϻפ��ʤ���"
                 "�����Ĥ��᤯�������ۤ����褤��")
            (say knpc "����ʤ˻����ʤ餵�줿��Τϸ������Ȥ��ʤ���΢�ڤ�˵���Ĥ���")))))

(define (doug-default knpc kpc)
  (say knpc "����Ϥ狼���"))

(define (doug-name knpc kpc)
  (say knpc "��ϥ����饹��Ĺ�����Υ���ݥꥹ����������Ϥλش�������"))

(define (doug-join knpc kpc)
  (say knpc "�����Ƥ�������������ȡ����Τ褦�ʹͤ��Ϥʤ�����������ˤ⤽�Τ褦�ʤ��Ȥ�Ҥͤ�ʡ�����ʤ����Ͼ�ؤ�����Ф�����"))

(define (doug-job knpc kpc)
  (say knpc "���������Ϥǻش����Ƥ��롣"))

(define (doug-bye knpc kpc)
  (say knpc "������˹Ԥ��Ȥ��ϵ���Ĥ���"))

;; Special
(define (doug-garr knpc kpc)
  (say knpc "���饹�ɥ��ϥ���ݥꥹ�β�ʪ�򲡤����뤿�ᡢ�����������Ϥ��֤��Ƥ��롣���β��ˤ������������Ϥ����롣"))

(define (doug-mons knpc kpc)
  (say knpc "�����ؤˤ���Τϡ��ۤȤ�ɤ����֥��ȥȥ����������Ȥ���Ǥ������ǰ��μԤ�����뤳�Ȥ����롣"))

(define (doug-gobl knpc kpc)
  (say knpc "ƶ�����֥�󤬤����ؤ���ۤ��Ƥ��롣�ۤ�϶�˽������������������"
       "ƶ�����ˤ����̤ϴ��ǤϤʤ������֥��⤤�롣"
       "����ƶ���Υ��֥����礬���������줬�桹�λ��ۤν����ˤʤäƤ��롣"))

(define (doug-trol knpc kpc)
  (say knpc "���֥���¼�θ�����¦�ˤ������Ϣ�����"
       "�����ٰ��ݤ��Ƥ⡢�����˸��̤�ˤʤ롣"
       "�ޤ�Ǵ䤫�����ޤ�Ƥ��뤫�Τ褦����"))

(define (doug-wors knpc kpc)
  (say knpc "�䤬��ä���Ǻǰ��Τ�Ρ��������������ۤϴ��ͤ����������äƤ��롣������ˤ������Τ⤤�롣�פ��Ф����衣����Ͽ̤��ʤ����ؤ����������")
  (kern-conv-end)
  )

(define (doug-kurp knpc kpc)
  (say knpc "����ݥꥹ�ϲ�ʪ�ɤ�����ޤ���Ϥ����ۤ����ݤ��뤳�ȤϤǤ��̤����桹�Ϥ�����Ȥʤ뤳�ȤϤǤ��롣"))

(define (doug-seco knpc kpc)
  (say knpc "�����������Ϥؤϡ���θ�������ؿʤߡ��Ϥ����򲼤��йԤ��롣"))

(define (doug-gaze knpc kpc)
  (say knpc "���������ϰ�̴�������ޤ줿�褦�ʲ�ʪ������Ĺ�����Ԥ�¾������ʪ������ˤ�����ʬ���������碌��ǽ�Ϥ����롣"))

(define doug-conv
  (ifc kurpolis-conv

       ;; basics
       (method 'default doug-default)
       (method 'hail doug-hail)
       (method 'bye doug-bye)
       (method 'job doug-job)
       (method 'name doug-name)
       (method 'join doug-join)

       (method 'garr doug-garr)
       (method 'mons doug-mons)
       (method 'gobl doug-gobl)
       (method 'trol doug-trol)
       (method 'wors doug-wors)
       (method 'kurp doug-kurp)
       (method 'hell doug-kurp)
       (method 'door doug-kurp)
       (method 'seco doug-seco)
       (method 'gaze doug-gaze)
       ))

(define (mk-douglas)
  (bind 
   (kern-mk-char 'ch_douglas        ; tag
                 "�����饹"          ; name
                 sp_human            ; species
                 oc_warrior          ; occ
                 s_companion_paladin ; sprite
                 faction-men         ; starting alignment
                 2 2 1               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 4  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'doug-conv         ; conv
                 sch_doug           ; sched
                 'townsman-ai                 ; special ai
                 nil                 ; container
                 (list t_armor_chain
                       t_chain_coif
                       t_sword
                       ))         ; readied
   (doug-mk)))
