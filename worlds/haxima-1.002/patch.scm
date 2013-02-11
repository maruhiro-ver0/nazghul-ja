;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ���饹�ɥ��
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_patch
               (list 0  0  gdp-bed "sleeping")
               (list 7  0  ghg-s1  "eating")
               (list 8  0  gh-ward "working")
               (list 11 0  ghg-s1  "eating")
               (list 12 0  gh-ward "working")
               (list 17 0  ghg-s1  "eating")
               (list 18 0  gc-hall "idle")
               (list 21 0  gdp-hut "idle")
               (list 22 0  gdp-bed "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (patch-mk) (list 'townsman))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ���饹�ɥ��˽���Ϸ�ͤ���ѻդǡ���դȤ���Ư���Ƥ��롣
;; ��ϴ��Ӥ򤷤Ƥ��ơ��ִ��Ӥ������פȤ����Τ��Ƥ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (patch-hail knpc kpc)
  (say knpc "�Τ��ʤ��ϴ��Ӥ򤷤���������ѻդ�Ϸ�ͤȲ�ä�����"
       "����ˤ��ϡ�ι������"))

(define (patch-default knpc kpc)
  (say knpc "����ϼ�����Ǥ��ʤ��ʡ�"))

(define (patch-name knpc kpc)
  (say knpc "�͡��ϻ����Ӥ������ȸƤ�Ǥ��롣"))

(define (patch-join knpc kpc)
  (say knpc "�����䡣�����ˤ���Τ����̳������¤��ͤ衣"))

(define (patch-job knpc kpc)
  (say knpc "�����±���Ư���Ƥ��롣���Ť�ɬ�פ��͡�")
  (if (kern-conv-get-yes-no? kpc)
      (patch-trade knpc kpc)
      (say knpc "ɬ�פʤȤ��˼��Ť��褦��")))

(define (patch-bye knpc kpc)
  (say knpc "���������ˡ�"))

;; Trade...
(define (patch-trade knpc kpc)
  (if (trade-services knpc kpc
                      (list
                       (svc-mk "����" 30 heal-service)
                       (svc-mk "����" 30 cure-service)
                       (svc-mk "����" 100 resurrect-service)))
      (begin
        (say knpc "¾�˲������뤳�Ȥ����뤫�͡�")
        (patch-trade knpc kpc))
      (begin
        (say knpc "¾�˲������뤫�͡�")
        (if (kern-conv-get-yes-no? kpc)
            (patch-trade knpc kpc)
            (say knpc "�������")))))
  
;; Patch...
(define (patch-patc knpc kpc)
  (say knpc "����ݥꥹ�����ܤ򼺤ä��������ϤȤƤ�Ť��Τ�������ɬ�פʤ��ä��Τ���"
       "����ϸ�����ۤ����ܤ򥦥��󥯤�������"))

(define (patch-kurp knpc kpc)
  (say knpc "�����Τ��µܤ��������äƤ��롣"
       "�����ơ��㤤����ʼ��˽����Ƥ����Ȥ��ϡ������ˤ����Τ���"))

(define (patch-tour knpc kpc)
  (say knpc "���ƤΥ��饹�ɥ��λ�̱��ʼ��ε�̳�����롣"
       "��ϰ�դ��ä���"))

(define (patch-medi knpc kpc)
  (say knpc "��դϼ��Ťε��Ѥ�Ĺ������ѻդ���"
       "���Ƥ������Τ�����ˤ��襤��ٱ礹�뤿���դ��ä�äƤ��롣"
       "��Ʈ�δ��÷���������롣���������û������ٻȤä���������"))

(define (patch-dagg knpc kpc)
  (say knpc "��������û����ϻ��������⤭���Ĥ��ˤ����Ȥä��ġ�"
       "������֤ǥ������������Τ���"))

(define (patch-dung knpc kpc)
  (say knpc "��ʪ�����Ͽ�ʥ�����ޤ�롣�ۤ餬�Ͼ��������˻ߤ�ʤ���Фʤ�ʤ���"
       "�����פ�������")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "�����̤ꡪ�����������ΤϤ�����������֤�����֤�������Ƥ���Τ���"
           "�µܤǽ�����ɬ�פʤ�����õ���ʤ���������ˤϰ�դ����롣")
      (say knpc "���ۥ���餬�ܤ��ļˤ˵��äƤ��ޤ�����")))

(define (patch-doc knpc kpc)
  (say knpc "��ϰ�դ������Ť�ɬ�פ��͡�")
  (if (kern-conv-get-yes-no? kpc)
      (patch-trade knpc kpc)
      (say knpc "�������������ɬ�פˤʤä��餳���±�����ʤ�����"
           "���Τ褦�������Ԥ��襤�Ǥɤ�����ܥ�ܥ�ˤʤ뤫������ΤäƤ��롪")))

(define (patch-hosp knpc kpc)
  (say knpc "�����������饹�ɥ��������ΤϾ����äƤ��롣"
       "������������Ԥ�¼���µ��μԤ�Ǥ롣"))

;; Townspeople...

(define patch-conv
  (ifc glasdrin-conv

       ;; basics
       (method 'default patch-default)
       (method 'hail patch-hail)
       (method 'bye  patch-bye)
       (method 'job  patch-job)
       (method 'name patch-name)
       (method 'join patch-join)
       
       ;; trade
       (method 'trad patch-trade)
       (method 'heal patch-trade)
       (method 'cure patch-trade)
       (method 'resu patch-trade)
       (method 'help patch-trade)

       ;; patch
       (method 'patc patch-patc)
       (method 'kurp patch-kurp)
       (method 'tour patch-tour)
       (method 'medi patch-medi)
       (method 'dagg patch-dagg)
       (method 'dung patch-dung)
       (method 'doc  patch-doc)
       (method 'hosp patch-hosp)
       (method 'outp patch-dung)

       ;; town & people

       ))

(define (mk-patch)
  (bind 
   (kern-mk-char 'ch_patch           ; tag
                 "����"              ; name
                 sp_human            ; species
                 oc_wizard           ; occ
                 s_companion_wizard  ; sprite
                 faction-glasdrin         ; starting alignment
                 1 3 0               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 6            ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'patch-conv         ; conv
                 sch_patch           ; sched
                 'townsman-ai                 ; special ai
                 (mk-inventory (list (list 1 t_staff)))                 ; container
                 (list t_dagger)                 ; readied
                 )
   (patch-mk)))
