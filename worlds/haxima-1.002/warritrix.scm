;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define warr-lvl 8)
(define warr-species sp_ghast)
(define warr-occ oc_warrior)

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (warr-mk) (list 3))
(define (warr-must-go? gob) (= 0 (car gob)))
(define (warr-end-conv gob) (set-car! gob (- (car gob) 1)))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; �����å�(Ʈ�ΤȤ����Τ��Ƥ���)�ϡ������Ƥ���Ȥ��ˤ�����ʤ������ȵ���
;; ����ΤǤ��ä��������줿����˴����¦(����줿��Ʋ���˲����줿����)��������
;; ���Ǥ��Ϥˤ�äƱƤˤʤäƤ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (warr-hail knpc kpc)
  (meet "�Ť��ʰҸ��Τ��������˴����ʤ����ܤ����ˤ��롣")
  (say knpc "�褯�褿�ʡ��¤��ͤ衣")
  (quest-data-update 'questentry-warritrix 'found 1)
  (quest-data-icon! 'questentry-warritrix 's_ghost)
  (quest-data-complete 'questentry-warritrix)
  )

(define (warr-name knpc kpc)
  (say knpc "��ϥ����å���¿���μԤˤ�Ʈ�ΤȤ����Τ��Ƥ�����")
  )

(define (warr-join knpc kpc)
  (say knpc "�����Ƥ���Ȥ��˲�äƤ���С�")
  )

(define (warr-job knpc kpc)
  (say knpc "�����˻Ť��뤳�Ȥ������ޤ���Ʊ������")
  (if (yes? kpc)
      (begin
        (say knpc "�����˻Ť��뤿��ˤ��������Τ�ͤФʤ�̡�"
             "��Ϥ���ƶ��������õ�����뤳�Ȥ�̿����줿��"
             "���⤬��ʪ�����Ȥ��襤�Ǽ��̤Ƥ��Ȥ���"
             "����줿�ԤΰŻ��Ԥ��Ԥ������˲�ä��������Ƥߤʻ����줿��"
             "�����Ƥ��졣΢�ڤ�Ԥؤ�������̤����Ƥ���뤫��")
        (yes? kpc)
        (say knpc "������ȳ�ǤϤʤ��󤤤ˤ�äƤ⤿�餵��롣"
             "��򻦤����ԤˤϤ������Ҥ��դ��路����"
             "��ά��ͤ����Ԥϼ���μ��Ӥ򾷤�������"
             "�Ϥ����Ԥϼ���ν��������Ȥ��ˤ��Ϥ򼺤���Τ���"
             "��������ʡ�������⿿�¤����٤�����")
        )
      (say knpc "�����ϲ��⤷�ʤ����Ȥˤ�äƤʤ����Τ���"))
  )

(define (warr-trut knpc kpc)
  (say knpc "���¤���衣���Τ���ˤϾڵ�ɬ�פ���"))

(define (warr-warr knpc kpc)
  (say knpc "¾�μԤ�˫��Τ��뤽��̾�ˤϤ��󤶤ꤷ�Ƥ�����"
       "�����Τ��Ȥ�����С���������������Τ���ΰ�ͤ˲᤮�ʤ��ä��Τ���"))

(define (warr-evid knpc kpc)
  (say knpc "�ʤ餺�Ԥ�¾���������Ȥ�����Τ�õ�����Ȥ�Ĺ���Ƥ��롣"
       "�����Ƥ������ƤΤʤ餺�Ԥ�ĺ�����ˤ󤲤����")
       (quest-wise-subinit 'questentry-the-man)
       (quest-data-update 'questentry-the-man 'common 1)
       )

(define (warr-wise knpc kpc)
  (say knpc "���Ԥ��Ǥ蘆��ʬ�Ǥ��줿��"
       "����줿�ԤϤ褯��ä���Τ���"))

(define (warr-bye knpc kpc)
  (if (warr-must-go? (gob knpc))
      (begin
        (say knpc "�⤦�񤦤��ȤϤʤ��������¤��ͤ衣")
        (kern-log-msg "��Ͼä���ä���")
        (kern-obj-remove knpc))
      (begin
        (say knpc "ʹ���������Ȥ�����ʹ��������")
        (if (yes? kpc)
            (say knpc "�⤦�����Ԥ��ͤФʤ�̡������ؤȸƤФ�Ƥ���Τ���")
            (say knpc "�ʤ�Ф⤦����������α�ޤäƤ��褦��")
            )
        (warr-end-conv (gob knpc)))))

;; Quest-related
(define (warr-rune knpc kpc)
  (say knpc "���ޤ������Ǥ򽸤�Ƥ���Τ��ʡ�������Ū�Ϥ狼��̤���"
       "������ǯ���δ֤�̾�⤭�����ӥ��������̾�Ť��οƤ�������ä����Ǥ�����⤤�Ƥ�����"))

(define (warr-clov knpc kpc)
  (say knpc "�����ӥ��������Ǥ�����⤤�Ƥ�����"
       "��ϥ��֥������Ǥ��襤��̿����Ȥ������������Ǥ�õ���Ƥ��뤫��")
  (if (yes? kpc)
  		(begin
      (say knpc "�⤷�ɤ��ˤ��뤫�ΤäƤ���Ԥ�����Ȥ���С�����ϥ��֥�����"
           "�Ф���عԤ��������õ�������^c+m�����ӥ�^c-�Τ��Ȥ�Ҥͤʤ�����")
       	(quest-data-update 'questentry-rune-f 'gen 1)
        (quest-data-assign-once 'questentry-rune-f)
           )
      (say knpc "�⤷õ���Ĥ��ʤ顢����˿Ҥͤʤ�����"
           "���Ƥλ����Ԥ�Ʊ���褦�˵����ؤȰ����󤻤��Ƥ��롣Ĺ���֤����ˤϤ����ʤ���"
           ))
  )

(define (warr-just knpc kpc)
  (say knpc "������ñ�ʤ���ɸ�˲᤮���������٤��������⡢���ۤ⡢���Ĥ�ɬ�פȤ��ʤ���"
       "���������Ǥ��ʤ���ɸ����"))

(define (warr-absa knpc kpc)
  (say knpc "�����ԤϤ���������줿�Ԥν����򹭤�Ƥ��뤳�Ȥ���¤�"
       "��˥��֥���åȤ��˲�����褦̿������"
       "�������Ϥؤμ�������˼���줿�ԤξڤǤϤʤ��Τ���")
  (yes? kpc)
  (say knpc "�����ʤΤǤ����ʡ�")
  )

(define (warr-void knpc kpc)
  (say knpc "���Ƥ���ϵ������¤��ͤǤ��롣"))

(define (warr-assa knpc kpc)
  (say knpc "���ϻ䤿�����Ԥ������Ƥ�����"
       "��������뤳�Ȥ��ΤäƤ���Τϡ����饹�ɥ��������ԤȻ��ᴱ�Υ����ե꡼���ʳ��Ϥ��ʤ��ˤ�ؤ�餺����"))

(define (warr-jeff knpc kpc)
  (say knpc "��Τ褦�ʼ㤤���ι⵮�ʹԤ��ϡ��Ф�ȤäƤ���β���ǵ����򼺤ä���"
       "��ͺ�������ˤ�ä����Ԥ���ʤ�С�ʳƮ����̤ۤ����ޤ��褤��"))

(define (warr-powe knpc kpc)
  (say knpc 
       "�������Τ�Ũ�Ȥߤʤ��Ԥ����Ϸ褷�ƽ�ʬ���Ϥ����뤳�ȤϤǤ��ʤ���"
       "������������Τ�̼ԤϷ��Τ���Ǥ�����Ϥ߼��Τ���"))

(define warr-conv
  (ifc basic-conv

       ;; basics
       (method 'hail warr-hail)
       (method 'bye  warr-bye)
       (method 'job  warr-job)
       (method 'name warr-name)
       (method 'join warr-join)
       
       (method 'rune warr-rune)
       (method 'clov warr-clov)
       (method 'just warr-just)
       (method 'absa warr-absa)
       (method 'stew warr-absa)
       (method 'warr warr-warr)
       (method 'evid warr-evid)
       (method 'wise warr-wise)
       (method 'void warr-void)
       (method 'trut warr-trut)
       (method 'assa warr-assa)
       (method 'jeff warr-jeff)
       (method 'powe warr-powe)
       ))

(define (mk-warritrix)
  (bind 
   (kern-mk-char 
    'ch_warr           ; tag
    "Ʈ��"             ; name
    warr-species         ; species
    warr-occ              ; occ
    s_ghost     ; sprite
    faction-men      ; starting alignment
    10 0 10            ; str/int/dex
    5 2              ; hp mod/mult
    5 2              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0  ;; AP_per_turn
    warr-lvl
    #f               ; dead
    'warr-conv         ; conv
    nil              ; schedule
    nil              ; special ai
    nil              ; container
    nil              ; readied
    )
   (warr-mk)))
