;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ���ѡ����
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_fing
               (list 0  0  sea-witch-bay        "idle")
               (list 6  0  sea-witch-shore      "idle")
               (list 8  0  sea-witch-bay        "idle")
               (list 20 0  sea-witch-shore      "idle")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (fing-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; �ե���ϥ˥������������ǡ���²�β��ҤǤ��롣
;; ��ϡ�������ʹ֤ν����ꥢ�ζ᤯�ˤ��뤿�ᡢ���ѡ����˽���Ǥ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (fing-hail knpc kpc)
  (say knpc "�Τ��ʤ��ϥ˥������Ȳ�ä����Ϥ���ˤ��ϡ�Φ�ο͡�"))

(define (fing-default knpc kpc)
  (say knpc "�⤷������ȡ��̤�Φ�οͤʤ��ΤäƤ��뤫�⤷��ޤ���"))

(define (fing-name knpc kpc)
  (say knpc "��ϥե���Ǥ���"))

(define (fing-join knpc kpc)
  (say knpc "���δߤ���Υ��뤳�ȤϤǤ��ʤ��ΤǤ���"))

(define (fing-job knpc kpc)
  (say knpc "��Ϥ���ë�Ĥ��������οͤβ��ҤǤ���"))

(define (fing-bye knpc kpc)
  (say knpc "���褦�ʤ顢Φ�ο͡�"))

;; Shores...
(define (fing-shor knpc kpc)
  (say knpc "��ϰ�����ͤ�¦�ˤ��뤿�ᡢ���δߤ�Υ���櫓�ˤϤ����ʤ��ΤǤ���"))

(define (fing-love knpc kpc)
  (say knpc "�������ʤ��顢��ΰ�����ͤ�Φ��Υ��뤳�Ȥ��Ǥ��ʤ��ΤǤ���"
       "����ϳ��οͤβ����Ǥ���"
       "���ڤ����¡������Ƽ��Ȥμ����ˤ⤫����餺��˾��ΤƤƤ��ʤ��ΤǤ���"))

(define (fing-sea knpc kpc)
  (say knpc "���β��ˤϤ�������β��񡢤�������ΰ��ס�ƶ����"
       "��������������Ƥ��Ф餷������������ޤ�����ˡ�Ȥ���"
       "ʼ�Τ��϶�������ʪ�����ޤ�����ʬ�򳲤��뤫�⤷��ޤ��󤬡�"
       "�������٤�ȴ������ϤϤȤƤ�����Ǥ��礦�͡�"
       ))

(define (fing-curs knpc kpc)
  (say knpc "����ϳ��οͤ�����Ǥ���"))

;; Townspeople...
(define (fing-opar knpc kpc)
  (say knpc "���ʤ����Τ褦��Φ�οͤˤϤ褤����Ȼפ��ޤ���"))

(define (fing-gher knpc kpc)
  (say knpc "�䤿��������򲼤���޻����Ƥ��ޤ�����"
       "�������᤯�����ȹӡ���������"
       "��ȸ��ޤ����褦�ʽ����Ǥ�����"
       "����μ겼�ϡ��ɤ�����Ỵ�ʺǴ���뤲���褦�Ǥ���"))

(define (fing-crew knpc kpc)
  (say knpc "�����ƥ����μ겼�������ؤ�����ʤ�ޤ�����"
       "�����ƾ�Φ�������٤���äƤ��뤳�ȤϤ���ޤ���Ǥ�����"
       "��������⼺���ޤ�����"))

(define (fing-alch knpc kpc)
  (say knpc "��ΰ������ͤȤ褯�ä��Ƥ��ޤ��������ʤϤ��Ƥ��ޤ���"
       "��Ϥ��ޤ�ˤ�Ф�Ȥ����äƤ��ơ��ɤ�ʤۤ���������ε������ܤˤϸ����ʤ�����Ǥ���"))

(define (fing-osca knpc kpc)
  (say knpc "��Τ��Ȥ��Τ�ޤ���"))

(define (fing-henr knpc kpc)
  (say knpc "ͦ����Φ�οͤ���ʹ���ޤ�����"))

(define (fing-bart knpc kpc)
  (say knpc "���֥��Ϥ��ޤ긫�����Ȥ�����ޤ������ϳ��򶲤�Ƥ���Ȼפ��ޤ���"
       "��ϥ��֥��δ֤Ǥ��Ѥ��ԤǤ��礦��"))


(define fing-conv
  (ifc nil

       ;; basics
       (method 'default fing-default)
       (method 'hail fing-hail)
       (method 'bye fing-bye)
       (method 'job fing-job)
       (method 'name fing-name)
       (method 'join fing-join)
       
       ;; Shores
       (method 'shor fing-shor)
       (method 'love fing-love)
       (method 'sea fing-sea)
       (method 'deep fing-sea)
       (method 'bay  fing-sea)
       (method 'curs fing-curs)

       ;; town & people
       (method 'opar fing-opar)
       (method 'alch fing-alch)
       (method 'gher fing-gher)
       (method 'crew fing-crew)
       (method 'osca fing-osca)
       (method 'henr fing-henr)
       (method 'bart fing-bart)
       (method 'lia  fing-love)

       ))

(define (mk-fing)
  (bind 
   (kern-mk-char 'ch_fing           ; tag
                 "�ե���"           ; name
                 sp_nixie           ; species
                 oc_warrior         ; occ
                 s_nixie_civilian    ; sprite
                 faction-men         ; starting alignment
                 1 2 0               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 3  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'fing-conv         ; conv
                 sch_fing           ; sched
                 'townsman-ai                 ; special ai
                 (mk-inventory (list (list 10 t_spear)))                ; container
                 nil                 ; readied
                 )
   (fing-mk)))
