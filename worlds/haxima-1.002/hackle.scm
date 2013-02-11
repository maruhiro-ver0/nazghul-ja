;;----------------------------------------------------------------------------
;; Schedule
;;
;; �ܥ�
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_hackle
               (list 0  0  bole-hackles-hut "idle")
               (list 2  0  bole-bed-hackle "sleeping")
               (list 10 0  bole-hackles-hut "idle")
               (list 20 0  bole-hackles-yard "idle")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (hackle-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;;
;; �ϥå��������ǥܥ�˽���Ǥ��롣
;; ����������ϱ������в�ä����������ˤ�ä��Ǥ��դ��줿��
;; ������������ˤϤޤ����Ť�ǽ�Ϥ����롣
;;----------------------------------------------------------------------------
(define (hackle-trade knpc kpc)
  (say knpc "����Ϥ��줫�������ͧ���Ť��뤳�Ȥ��Ǥ��롣"
       "�������̿�Ϥ��Ȥ˶�����Ҥ��׵᤹�롣�����Ʊ�դ��뤫��")
  (define (hackle-heal)
    (say knpc "����Ϥɤ���Ť��뤫��")
    (let ((kchar (kern-ui-select-party-member)))
      (if (null? kchar)
          (say knpc "����Ϥ�����̤β��򤹤뤫��")
          (let* ((gold (kern-player-get-gold))
                 (pts (- (kern-char-get-max-hp kchar)
                         (kern-char-get-hp kchar))))
            (if (= 0 gold)
                (say knpc "�⤬�ʤ����̿��ʤ������줬��������ˡ��")
                (begin
                  (if (= 0 pts)
                      (say knpc "����Ϥ褯�ʤä�������Ϥ���ˤ��뤳�ȤϤ⤦�ʤ���")
                      (let ((n (min gold pts)))
                        (say knpc "����ϼ��Ť�����")
                        (kern-obj-heal kchar n)
                        (kern-player-set-gold (- gold n))))
                  (say knpc "�̤Τ�����Ť��뤫��")
                  (if (kern-conv-get-yes-no? kpc)
                      (hackle-heal)
                      (say knpc "�ʤ�Ф�����̤Τ�Τ�˾�ࡣ")
                      )))))))
  (if (kern-conv-get-yes-no? kpc)
      (hackle-heal)
      (say knpc "����Ϥ����ƻ��Ԥ���")))
                   
              
        

;; basics...
(define (hackle-default knpc kpc)
  (say knpc "����Ϥ���������Ǥ��ʤ���"))

(define (hackle-hail knpc kpc)
  (if (in-player-party? 'ch_mesmeme)
      (begin
        (say knpc "������ϥ᥹���򸫤�ȶ��ݤǽ̤��ޤä��Ϥ�������������������ä���")
        (aside kpc 'ch_mesmeme "������")
        )
      (say knpc "[���ʤ���ȱ����줿��ǯ�ν����Ȳ�ä���] ���������Ȳ�ä���"
           "��������Ƥ��롪")
  ))

(define (hackle-name knpc kpc)
  (say knpc "����ϥϥå��롣"))

(define (hackle-job knpc kpc)
  (say knpc "����϶��äƤ��롪����������ϼ��ŤǤ��롪"))

(define (hackle-join knpc kpc)
  (say knpc "�������֤ˤϤʤ�ʤ��������������Ӥ򵤤ˤ����Ƥ��롪"))

(define (hackle-bye knpc kpc)
  (say knpc "����Ϥ��褦�ʤ�ȸ��ä���������������Ϥ��줬��äƤ��뤳�Ȥ��ΤäƤ��롪"))


;; other characters & town...
(define (hackle-may knpc kpc)
  (say knpc "����Ϥ��Ĥ������������ϥå���ˤϤ��Ĥ������ڤǤ��롪"))

(define (hackle-kath knpc kpc)
  (say knpc "�֤��夿���������夿���⡪"))

(define (hackle-bill knpc kpc)
  (say knpc "��Ψ�����������Ĥ������ڤο��Ϥ����ͼ���ˤ��������"))

(define (hackle-thud knpc kpc)
  (say knpc "������ϾФ����ä�����������Ϥ���ϴ��ǤϤʤ���"
       "���ͤȤ��ƸƤФ줿�ԡ�����������Ǥ��롣"))

(define (hackle-melv knpc kpc)
  (say knpc "������������Ǥ��롣"))

(define (hackle-bole knpc kpc)
  (say knpc "�ܥ�(Bole)�ǤϤʤ����ۡ���(Hole)�Ǥ��롪����ؤθ��ꡪ������ΤäƤ��롪"))

;; misc...
(define (hackle-mesm knpc kpc)
  (say knpc "����Ϥ����λҶ��Ǥ��롣Ʊ²�μԤȤϸ���������������ʹ�����ʤ���"
       "���������������Ϥ������ͤ�������ˤ��������")
  (aside kpc 'ch_mesmeme "�������ˤ��餺")
  )

(define (hackle-shee knpc kpc)
  (say knpc "�Ӥ������ä�ϵ��"
       "�Ӥ��Ĥ��Ȥ����ɤΤ褦��ϵ���ʤ��뤫��"))

(define (hackle-wood knpc kpc)
  (say knpc "����ϸŤ��ߤ��ڤǤ���򸫤�������ϵ������ʤ��ä���"
       "�����������򹥤ޤʤ������������Ƥ򹥤ޤʤ���"
       "���֥��Ϥ������Ť᤿������������Ϥ��θ��դ��Τ�ʤ���"))

(define (hackle-mad knpc kpc)
  (say knpc "���������������Ҷ��ΤȤ���館���������ƨ������"
       "������������ο���ƨ���٤줿��"))

(define (hackle-gaze knpc kpc)
  (say knpc "�⤷��ä��ʤ顢����Ϥ����ʤ���Ǥ⻦���ʤ���Фʤ�ʤ���"
       "�����Ϥ����ʤ��䤤���������ΤäƤ��롣�����Ƥ��������Ϲ�«���롪")
  (aside kpc 'ch_mesmeme "���԰¤����˽֤��Ƥ��롣��")
)

;; thief quest...
(define (hackle-thie knpc kpc)
  (say knpc "����Ͽ��˶����ʤ餺�Ԥ�������ѻդ���å�ä���"))

(define (hackle-robs knpc kpc)
  (say knpc "�����å�������ξ����ʥͥ��ߤη�������ä���"))

(define (hackle-hole knpc kpc)
  (say knpc "������椬������������\n"
       "��'o'�ˤϷ�(hole)�����롪\n"
       "�������Ʒ�ˤ�'o'�����롪\n"
       "�������ƥͥ���(mouse)�ˤ�ξ�����롪\n"
       "���������\n"
       "������ϹԤ�������\n"
       "����^c+mɽ��^c-���狼�뤫��")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "�ʤ�Ф����^c+mɽ��^c-������򤻤衪")
      (begin
        (say knpc "��������������<Wis Quas>���֤���Ѥϴ�ʪ����äƤ��롣��������������äƤ��ʤ���")))
  )

(define (hackle-reve knpc kpc)
  (say knpc "�ӥ�˷�ϥͥ��ߤ��ɤ��˾ä������ΤäƤ��롪"
       "�����^c+mɽ��^c-��"))

(define (hackle-midd knpc kpc)
  (say knpc "�����������桪"))

(define hackle-conv
  (ifc basic-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default hackle-default)
       (method 'hail hackle-hail)
       (method 'bye  hackle-bye)
       (method 'job  hackle-job)
       (method 'name hackle-name)
       (method 'join hackle-join)

       (method 'trad hackle-trade)
       (method 'buy hackle-trade)
       (method 'sell hackle-trade)
       (method 'heal hackle-trade)

       (method 'bill hackle-bill)
       (method 'kath hackle-kath)
       (method 'red  hackle-kath)
       (method 'bitc hackle-kath)
       (method 'may  hackle-may)
       (method 'melv hackle-melv)
       (method 'thud hackle-thud)
       
       (method 'bole hackle-bole)
       (method 'gaze hackle-gaze)
       (method 'god  hackle-wood)
       (method 'gods hackle-wood)
       (method 'hole hackle-hole)
       (method 'mad  hackle-mad)
       (method 'mesm hackle-mesm)
       (method 'migh hackle-robs)
       (method 'mous hackle-hole)
       (method 'reve hackle-reve)
       (method 'rob  hackle-robs)
       (method 'robs hackle-robs)
       (method 'wrog hackle-robs)
       (method 'wiza hackle-robs)
       (method 'shee hackle-shee)
       (method 'thie hackle-thie)
       (method 'wood hackle-wood)
       (method 'midd hackle-midd)
       (method 'nigh hackle-midd)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-hackle)
  (bind 
   (kern-mk-char 'ch_hackle          ; tag
                 "�ϥå���"          ; name
                 sp_human            ; species
                 nil                 ; occ
                 s_beggar             ; sprite
                 faction-men         ; starting alignment
                 0 0 1            ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 6  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'hackle-conv        ; conv
                 sch_hackle          ; sched
                 'townsman-ai                 ; special ai
                 nil                 ; container
                 nil                 ; readied
                 )
   (hackle-mk)))
