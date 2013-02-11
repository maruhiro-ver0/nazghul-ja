;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define thud-start-lvl  6)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; �ܥ�
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_thud
               (list 0  0  bole-bedroom-thud "idle")
               (list 9  0  bole-dining-hall  "idle")
               (list 10 0  bole-courtyard   "idle")
               (list 12 0  bole-dining-hall   "idle")
               (list 23 0  bole-bedroom-thud "idle")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (thud-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; �ɥ�ϥ��㥹�����ѿ����ǡ����Ϥ��Τ������ť��������Ȼפ����ܥ��α�ޤ�
;; �Ƥ��롣¿����¾���о��ʪ�ϥɥ��Ⱦʬ�Ͽʹ֤ǥ������η줬ή��Ƥ��롢�ޤ�
;; �����(���Ԥ��줿���ޤ��Ϻ��줿)�ȹͤ��Ƥ���ġ�
;; 
;; �ɥ����֤ˤʤ�(������΢�ڤ�)��
;; ��ϥ��㥹������֤ǡ��������֤˲ä������ä�롣
;;----------------------------------------------------------------------------
(define (thud-hail knpc kpc)
  (say knpc "�Τ��ʤ������ˤ���ΤϳΤ��˥������ΰ�������"
       "��Ĺ��3�᡼�ȥ������ꡢ�Ұ�Ū����"
       "����ܤ�٤�Ƥ��ʤ���ˤ�������"))

(define (thud-default knpc kpc)
  (say knpc "����ΰҰ�Ū���ܤ�ư���ʤ��ä�����"))

(define (thud-name knpc kpc)
  (say knpc "�ɥ�ϡ���������������"))

(define (thud-join knpc kpc)
  (if (is-player-party-member? ch_kathryn)
      (begin
        (say knpc "�Υ��㥹���Ȥ��ʤ��򸫤�ȡ������������Ʊ�դ�������")
        (kern-char-join-player knpc)
        (kern-conv-end))
      (say knpc "����Ϥ����Фä�����")))

(define (thud-job knpc kpc)
  (say knpc "�ɥ�ϡ������Τ����繥����"))

(define (thud-kathryn knpc kpc)
  (say knpc "�ɥ�ϡ������ʤ���"))

(define (thud-thud knpc kpc)
  (say knpc "���Τ��Ȥ����������Ρ������ȡ����������ɥ�ϡ������Ρ����ǡ����򡡤ۤ��뤾����"))

(define (thud-thief knpc kpc)
  (say knpc "������ܤ�Ф�����ť���ϡ��ɥ�򡡤��ޤ������ɥ�ϡ�ť���򡡸��Ĥ��롪�ɥ�ϡ�ť���򡡻�����"))

(define (thud-find knpc kpc)
  (say knpc "����Ͼ�������夤�����֤����ʽ�����ť���򡡸��Ĥ��롣��ť���ϡ����졡���ʤ���"))

(define (thud-red-lady knpc kpc)
  (say knpc "����϶������ܤĤ��Ǥ��ʤ��򸫤����֤����ʽ����顡Υ���"))

(define thud-conv
  (ifc nil
       (method 'default thud-default)
       (method 'hail thud-hail)
       (method 'bye 
               (lambda (knpc kpc) 
                 (say knpc "����Ϥ��󤶤ꤷ���ܤǤ��ʤ������Τ򸫤Ƥ�������")))
       (method 'job  thud-job)
       (method 'name thud-name)
       (method 'join thud-join)

       (method 'find thud-find)
       (method 'kath thud-kathryn)
       (method 'kill thud-job)
       (method 'lady thud-red-lady)
       (method 'love thud-job)
       (method 'red  thud-red-lady)
       (method 'thie thud-thief)
       (method 'thud thud-thud)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-thud)
  (bind 
    (kern-char-arm-self
     (kern-mk-char 
      'ch_thud ;;.....tag
      "�ɥ�" ;;.......name
      sp_troll ;;.....species
      oc_warrior ;;...occupation
      s_troll ;;......sprite
      faction-men ;;..faction
      4 ;;............custom strength modifier
      0 ;;............custom intelligence modifier
      2 ;;............custom dexterity modifier
      2 ;;............custom base hp modifier
      1 ;;............custom hp multiplier (per-level)
      0 ;;............custom base mp modifier
      0 ;;............custom mp multiplier (per-level)
      max-health;;..current hit points
      -1  ;;...........current experience points
      max-health ;;..current magic points
      0
      thud-start-lvl  ;;..current level
      #f ;;...........dead?
      'thud-conv ;;...conversation (optional)
      sch_thud ;;.....schedule (optional)
      'townsman-ai ;;..........custom ai (optional)
      nil ;;..........container (and contents)
      ;;.........readied arms (in addition to the container contents)
      (list
       t_2h_axe
       t_iron_helm
       t_armor_plate
       )
      nil ;;..........hooks in effect
      ))
   (thud-mk)))
