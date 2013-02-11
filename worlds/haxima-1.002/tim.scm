;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define tim-start-lvl 4)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; In the Tower of Brundegart (p_brundegardt_tower_4), locked outside.
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (tim-mk) (list #f #f))
(define (tim-caught? gob) (car gob))
(define (tim-caught! gob) (set-car! gob #t))
(define (tim-met? gob) (cadr gob))
(define (tim-met! gob) (set-car! (cdr gob) #t))

;;----------------------------------------------------------------------------
;; Conv
;;
;; �ƥ�������ӤΤʤ��������򤿤餷�����������ˤǡ��֥��ǥ����ɤ���γ���
;; �����Ƥ��롣
;; 
;; ���ĤƤ���(����)��õ��ԤǤ��ä���������Τϥ���ե���(�Ȥ���ʢ���������
;; ��)��å��졢��������ϥ֥�̤��ܤȤ��ܿ����˲����줿��
;;----------------------------------------------------------------------------
(define (tim-hail knpc kpc)
  (meet "���ʤ��Ϥ����򤿤餷�����ӤΤ��������ˤȲ�ä���")
  (say knpc "�ܤ򸫤Ƥ����Τ���"))

(define (tim-eye knpc kpc)
  (say knpc "�ܤ򸫤뤳�Ȥǻ�����Ϥ������Τ������ʤ������Ϥ����Ԥ���")
  (cond ((yes? knpc)
         (say knpc "������ͧ�衣����ʤ����Ƥ��ޤä��Τ���"))
        (else
         (say knpc "�򤫤ʡ�")
         (kern-conv-end))))

(define (tim-key knpc kpc)
  (say knpc "��θ����������λ����Ԥ����äƤ�����"
       "��ҤΤ褦��Ļ�ˡ��ǽ���Ӥ�å��졢���˸���å��줿�Τ���"))

(define (tim-arm knpc kpc)
  (say knpc "�֤��⤤�Ƥ���Ȥ����䤬���Ф줿��"
       "�����ƿ���Ϳ���뤿�ᤳ���˱��Ф줿�Τ���"))

(define (tim-name knpc kpc)
  (say knpc "�Τ�ʤ��դ�򤹤�ʡ�"
       "������ǽ�μԤ��Τ�̼Ԥʤɤ��ʤ��������ɬ������"))

(define (tim-job knpc kpc)
  (say knpc "�����������Τθ���⤿�餹�Ԥ���"))

(define (tim-enli knpc kpc)
  (say knpc "�����̤�Ǥ��롪�ܤ����ܡġ�����ۻ��Τ褦�ˤ������ޤꡢ�㤭�ʤ���Ĥ֤䤤������")
  (kern-conv-end))

(define (tim-lion knpc kpc)
  (say knpc "��������Ĥ򤢤��̤��ޤä����ϸ����Τ�����"
       "�⤦�������Ӥ�����褿�Τ������Ϥ���ʤ�ʢ��������Ƥ���Τ�����������"))

(define tim-conv
  (ifc nil
       (method 'hail tim-hail)
       (method 'eye  tim-eye)
       (method 'me  tim-eye)
       (method 'key  tim-key)
       (method 'arm  tim-arm)
       (method 'name tim-name)
       (method 'job  tim-job)
       (method 'enli tim-enli)
       (method 'lion tim-lion)
       ))


;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-tim)
  (bind 
   (kern-char-arm-self
    (kern-mk-char 
     'ch_tim ;;..........tag
     "�ƥ���" ;;.......name
     sp_human ;;.....species
     oc_wizard ;;.. .occupation
     s_wizard ;;..sprite
     faction-men ;;..faction
     +1 ;;...........custom strength modifier
     0 ;;...........custom intelligence modifier
     +1 ;;...........custom dexterity modifier
     +1 ;;............custom base hp modifier
     +1 ;;............custom hp multiplier (per-level)
     0 ;;............custom base mp modifier
     0 ;;............custom mp multiplier (per-level)
     max-health ;;..current hit points
     -1  ;;...........current experience points
     max-health ;;..current magic points
     0
     tim-start-lvl  ;;..current level
     #f ;;...........dead?
     'tim-conv ;;...conversation (optional)
     nil ;;sch_tim ;;.....schedule (optional)
     nil ;;..........custom ai (optional)
     nil ;;..............container (and contents)
     nil ;;.........readied arms (in addition to the container contents)
     nil ;;..........hooks in effect
     ))
   (tim-mk)))
