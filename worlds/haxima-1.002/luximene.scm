;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define lux-lvl 7)
(define lux-species sp_ghast)
(define lux-occ oc_wizard)

;;----------------------------------------------------------------------------
;; Schedule
;;
;; �Ф������
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (lux-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; �饯���ޥˤϥ�å�(������Ƭ��������Ƥ��ƤӽФ����)�ǡ�����ݥꥹ�ΰ���
;; �ˤ�����ʪ�ˤ���ۤ��Ƥ��롣��ϥ����ɤ����������줷������ʲ����ä�����
;; ���ƺǸ�ˤϸ��ԤȤ����Τ���褦�ˤʤ�Ԥ����ˤ�ä��ݤ��줿��
;;----------------------------------------------------------------------------

;; Basics...
(define (lux-hail knpc kpc)
  (say knpc "�Τ��ʤ��ϻ��դ�ǳ����ƤȲ�ä����ϲ���˾�ߤ���"
       "�ह�٤��Ԥ衣"))

(define (lux-default knpc kpc)
  (say knpc "��λ��֤�̵�̤ˤ���ʡ�"))

(define (lux-name knpc kpc)
  (say knpc "��ϰ���ʥ饯���ޥˡ����������β��Ǥ��롣"))

(define (lux-rune knpc kpc)
  (say knpc "��������������𤵤줿�褦�˸���������"
       "����ϰ��������������뤿�ᡢ���Ԥˤ�äƺ��줿Ȭ�Ĥθ��ΰ�Ĥ���"))

(define (lux-gate knpc kpc)
  (say knpc "���줾��θ��ˤϼ��Ԥ����ꡢ�ߤ��˲񤦤��Ȥ�ػߤ���Ƥ�����"
       "�����Ƥ��������ϰ����Ѥ���Ƥ�������ϼ��Ԥ���")
  (if (yes? kpc)
      (begin
        (say knpc "�ʤ�Фʤ���Ϥ������ǤΤ��Ȥ���ʹ���Τ�����μ�ϲ������ʤ��ä��Τ���")
        (if (yes? kpc)
            (say knpc "����ϰ��դ򤳤�ƾФä�������ϲ��򤫤��ȻפäƤ���Τ���"
                 "�����פäƤ���Ԥ��򤫤ʤΤ����������Ǥ�������Ǥθ������λ�������Ǥθ��Ǥ��롪")
            (say knpc "���ǤϿͤ�����������˺�줿���夫��Ϥޤ롣")))
      (begin
        (say knpc "��ͤ���")
        (if (yes? kpc)
            (say knpc "���λह�٤�����Ǥ���ͤ����⼫�餬������Τβ��ͤ��Τ�ʤ���")
            (say knpc "�ʤ����϶������Ǥ��ˤ����Ȥ����Τ���"
                 "���λ���ν����϶ᤤ������")))))

(define (lux-age knpc kpc)
  (say knpc "������礬�������줿�Ȥ�����ѻդ����λ���Ͻ���ä���"
       "���줬�桢���Υ����ɤ����������줷���ԡ��饯���ޥˤλ���λϤޤ���ä���"
       "��θ�λ��ۼԤ������ۤ����Ȥ˰����ʤꡢ�Ĥ��˲���������ҤȤʤä���"
       "�����Ƽ���줿���塢���κ����Ϥޤä���"
       "�礤�ʤ���̩���Τꤿ������")
  (if (yes? kpc)
      (say knpc "�ʤ�������褦���Ǹ�μ��Ԥ衣")
      (say knpc "\n�������˶������Ф���������������\n"
           "����������Τ�Ǥ������Ǹ�μ��Ԥ衪"))
  (say knpc "������礬�����줿�Ȥ�������줿����Ͻ����Ǥ�����"))

(define (lux-keep knpc kpc)
  (say knpc "��ϺǸ�μ��Ԥ������Ǥ��ˤ������ΰ�̣���Τ롣"
       "�������Ƥ����Ǥ��򤬼��٤���Τ������Ƥ��μ����ˤ��뤫��")
  (if (yes? kpc)
      (say knpc "�����ʤΤ��ʡ�����·��ʤ������ϳ����ʤ���")
      (say knpc "õ���Ф�����ͤ�̾������Ԥ��ѿ���������ߤ���"
           "�������༫�Ȥ򡢤ǤϤʤ���")))

(define (lux-wise knpc kpc)
  (say knpc "���ԡ�����ϾФä�����\n"
       "����λ��ۼԤ�ȿ�դ���Ԥ����衪\n"
       "\n"
       "��ΤΥ���������\n"
       "�����μԤϲ�η����Ǥ��餫��\n"
       "�������Ƽ���η���Ψ����\n"
       "��ѻդΥ�����ա�\n"
       "�����μԤ�ȿ�ռԤ�ش���\n"
       "�������Ʋ���Žѻդ����˻������ä�\n"
       "�ʤ餺�ԤΥʡ��ȥϥå�����\n"
       "�����μԤ���ͤϤ郎Ũ���̤�\n"
       "����������̩����ϩ�򸫤Ĥ��Ф���\n"
       "���ͤΥ��������ɡ�\n"
       "�����μԤϤ郎�֤��ܺ�����Ԥ�\n"
       "��������������\n"
       "\n"
       "������̤ˤ�ؤ�餺�����ϻह�٤����ˤ��ä���"
       "\n")
  (say knpc "\n����Ϥ��ʤ�����Ԥ��ܤǸ�������\n"
       "��������̾���Τ�̤���")
  (if (yes? kpc)
      (say knpc "�ʤ�ж�ò���衣�郎�����")
      (begin
	(say knpc
	     "\n������䤿���ܤ��ܤ�ǵ���������\n"
	     "���������λ���θ��ԤȸƤФ��Ԥ�����ٻ�����������Τ��ʡ�\n"
	     "���Τ褦�ʤĤޤ�̼Ԥ��Τ�̡�\n"
	     "��졢�ह�٤���Τ衪")
	(kern-conv-end)
	))
  )

(define (lux-accu knpc kpc)
  (say knpc "����줿�ԡ�\n"
       "���줾��λ���ˤϡ����Τ褦���Ϥ����ԡ�"
       "���Τ褦�ʷٶ��ƻ����ä��Ǥ蘆��ʤ��Ԥ����롣\n"
       "\n"
       "����Ԥ��Ǥܤ��졢"
       "�ޤ�����ԤϿ����Ϥ�����¾������ˤ��롣\n"
       "\n"
       "����Ϥޤ��˴�����Τ褦�ʤ�ΤǤ��롣")
  )


(define lux-conv
  (ifc basic-conv

       ;; basics
       (method 'default lux-default)
       (method 'hail lux-hail)
       (method 'name lux-name)

       (method 'rune lux-rune)
       (method 'key  lux-rune) ;; A synonym

       (method 'demo lux-gate) ;; A synonym
       (method 'gate lux-gate)

       (method 'wise lux-wise)
       (method 'accu lux-accu)

       (method 'age  lux-age)
       (method 'keep lux-keep)

       ))

(define (mk-luximene)
  (bind 
   (kern-mk-char 
    'ch_lux           ; tag
    "�饯���ޥ�"          ; name
    lux-species         ; species
    lux-occ              ; occ
    s_ghost     ; sprite
    faction-men      ; starting alignment
    0 0 0            ; str/int/dex
    0 0              ; hp mod/mult
    0 0              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    lux-lvl
    #f               ; dead
    'lux-conv         ; conv
    nil           ; sched
    nil              ; special ai
    nil              ; container
    nil              ; readied
    )
   (lux-mk)))

(define (mk-lich-king)
  (let ((kchar 
         (bind 
          (kern-char-force-drop
           (kern-mk-char 
            'ch_lich_king           ; tag
            "��å��β�" ; name
            sp_lich         ; species
            oc_wizard              ; occ
            s_lich     ; sprite
            faction-monster      ; starting alignment
            10 10 10            ; str/int/dex
            10 1              ; hp mod/mult
            0  0              ; mp mod/mult
            max-health ; hp
            -1                   ; xp
            max-health ; mp
            0
            8
            #f               ; dead
            nil              ; conv
            nil             ; sched
            'lich-ai        ; special ai
            (mk-inventory
             (list (list 1 t_morning_star)
                   (list 1 t_armor_chain_4)
                   (list 1 t_chain_coif_4)
                   (list 100 t_gold_coins)
                   (list 3 t_mana_potion)
                   (list 3 t_heal_potion)
                   (list 1 t_lich_skull)
                   (list 1 t_lichs_blood)
                   ))
            nil              ; readied
            )
           #t)
          (lux-mk))))
    (map (lambda (eff) (kern-obj-add-effect kchar eff nil))
         undead-effects)
    kchar))

