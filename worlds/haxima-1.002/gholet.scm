;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define gholet-lvl 4)
(define gholet-species sp_human)
(define gholet-occ nil)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ���饹�ɥ����ϲ��δƹ�
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (gholet-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ����åȤϤ��ĤƤϳ�±�ǡ����ϥ��饹�ɥ����ϲ��δƹ��ˤ��롣
;; ��ϻ��ῼ�����ξ��Ȱ��������Ĥ�ΰ�ͤǡ�˴��Ȥʤä������ƥ���Ĺ������
;; �Τ����ɤ��Ƥ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (gholet-hail knpc kpc)
  (say knpc "�衼����ö�ᤢ��"))

(define (gholet-default knpc kpc)
  (say knpc "���ΤȤ���Ǥ��������줬ö��Τ����ꡪ"))

(define (gholet-name knpc kpc)
  (say knpc "����åȤǤ������Ǥⵤ�ˤ��ʤ��Ǥ���������ö�ᡣ")
  (quest-data-update 'questentry-ghertie 'gholet-dungeon 1))

(define (gholet-join knpc kpc)
  (say knpc "����Ǥ��ä���Ф������Ǥ���äơ��Х��Х������䡪"))

(define (gholet-job knpc kpc)
  (say knpc "���äȡ����������ͤ������䡢���ä���"
       "���ˤ��衢�����Ǹ��Ƥ��̤�ο�����ŷ����������Ǥ�����"))

(define (gholet-bye knpc kpc)
  (say knpc "���򤤤��äǡ�ö�ᡣ"))

;; Tier 2 replies
(define (gholet-cook knpc kpc)
  (say knpc "ͭ̾�ʹ�ڵ����������ͤ��ä��櫓�衪"
       "���ῼ����桢ʹ�������Ȥ��뤫��")
  (if (yes? kpc)
      (say knpc "����������㤢������ͭ̾���äƸ��ä���")
      (say knpc "�������Τ�������ͭ̾���ä���"
           "���ɤ��ʤäƤ뤫�Ϥ狼��ͤ���")))

(define (gholet-merc knpc kpc)
  (say knpc "������������������Ƭ�Ϥ��Ф餷�������ä���"
       "�����ƥ����äƤ����"))

(define (gholet-gher knpc kpc)
  (say knpc "���������ä��������ꤤ��Ƭ�Ϥ��ͤ���"))

(define (gholet-voca knpc kpc)
  (say knpc "���������줬���ޤǤǰ��ֳڤʻŻ��Ǥ�����"))

(define (gholet-mean knpc kpc)
  (say knpc "�ߡ��ˡ��Υ������Ȥ�Ĺ�������Ȳ�äƤͤ��ʡ�"
       "���ϱ����äƤ��ʹ�������ʤ���"))

(define (gholet-jorn knpc kpc)
  (say knpc "�����������Ĥ������ˤ�٤��衢ö�ᡣ"
       "�������Ϥ��Τޤޤˤ��Ƥ����ʤ衣"))

(define (gholet-dog knpc kpc)
  (say knpc "�����򤭲�����ǿ��Ƥ��ʹ�����ʤ���")
  (quest-data-update 'questentry-ghertie 'jorn-loc 1))

;; Quest-related
(define (gholet-ring knpc kpc)

  (if (not (in-inventory? knpc t_skull_ring_g))
      (say knpc "���ء����λ��ء�")
      (begin

        (define (take-picklocks)
          (if (< (num-in-inventory kpc t_picklock) 12)
		(begin
		(quest-data-update-with 'questentry-ghertie 'gholet-price 1 (quest-notify nil))
              (say knpc "�����ࡢ�������꤬����ʤ���ö�ᡣ"
                   "������ƻ��­��ͤ��衣"
                   "�Ǥ⤳�λ��ؤϼ���֤��ˤ��Ƥ����衣")
		   )
              (begin
                (say knpc "�����������󤿤ϻ��äƤ������ϽФƤ�����"
                     "���ޤ����ä������ޤ����ä������������ؤ�ڤ���Ǥ��졢ö�ᡪ")
                (kern-obj-remove-from-inventory kpc t_picklock 12)
                (kern-obj-add-to-inventory knpc t_picklock 12)
                (kern-obj-remove-from-inventory knpc t_skull_ring_g 1)
		(skullring-g-get nil kpc)
		)))

        (say knpc "���������θŤ��֥Ĥ����ڤ��Ƥ��礦���ͤ������"
             "�����ĤΤ����ˤ������ͤ���"
             "�����Ĥϳ�������������ؤ���ˤ���"
             "���������ͤ������ߤ�������")
        (if (yes? kpc)
            (begin
              (say knpc "���ˤ���ʤ衣������"
                   "�����Ĥ������ˤ�������ʪ����"
                   "�Ǥ⡢�������Ȥ򤹤�С��������Ȥˤʤä��֤äƤ��롣"
                   "��������ö�ᡩ")
              (if (yes? kpc)
                  (begin
                    (say knpc "�����󤽤������ʤ���ö�ᡪ"
                         "�����Ļ�����Ĥäƥ�Ĥ衪"
                         "������ƻ��1��������������ƻ��1����������Х����ĤϤ��󤿤Υ�����"
                         "�ɤ��衩")
                    (if (yes? kpc)
                        (take-picklocks)
                        (begin
			(quest-data-update-with 'questentry-ghertie 'gholet-price 1 (quest-notify nil))
                          (say knpc "���줬���λ��ؤ����ʤ���"
                               "ʧ�����ˤʤä���ޤ���Ƥ��졣")
                          (kern-conv-end))))
                  (begin
                    (say knpc "���ä��鵢��ʤ衣")
                    (kern-conv-end))))
            (say knpc "�����㤴���㤤���䤬�äơ�"
                 "���λ��ؤΤ���ˤ������褿�Τ��ΤäƤ�����")))))
      
(define gholet-conv
  (ifc basic-conv

       ;; basics
       (method 'default gholet-default)
       (method 'hail gholet-hail)
       (method 'bye  gholet-bye)
       (method 'job  gholet-job)
       (method 'name gholet-name)
       (method 'join gholet-join)
       
       ;; other responses
       (method 'cook gholet-cook)
       (method 'merc gholet-merc)
       (method 'gher gholet-gher)
       (method 'voca gholet-voca)
       (method 'ring gholet-ring)

       (method 'mean gholet-mean)
       (method 'jorn gholet-jorn)
       (method 'dog  gholet-dog)
       ))

(define (mk-gholet)
  (bind 
   (kern-char-force-drop
   (kern-mk-char 
    'ch_my           ; tag
    "����å�"             ; name
    gholet-species         ; species
    gholet-occ              ; occ
    s_brigand     ; sprite
    faction-men      ; starting alignment
    1 0 3            ; str/int/dex
    0 0              ; hp mod/mult
    0 0              ; mp mod/mult
    max-health; hp
    -1                   ; xp
    max-health ; mp
    0
    gholet-lvl
    #f               ; dead
    'gholet-conv         ; conv
    nil              ; sched
    nil              ; special ai
    ;;..........container (and contents)
    (mk-inventory
              (list
               (list 1 t_skull_ring_g)
               ))
    nil              ; readied
    )
   #t)
  (gholet-mk)))
