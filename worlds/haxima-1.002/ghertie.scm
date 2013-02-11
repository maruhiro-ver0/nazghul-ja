;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ���ѡ����
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_ghertie
               (list 0  0  cheerful-room-3      "idle")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (ghertie-mk) 
  (list (mk-quest)))

(define (ghertie-quest gob) (car gob))



;;----------------------------------------------------------------------------
;; Conv
;; 
;; �����ƥ����Ͻ����γ�±����Ĺ�ǡ���������������ǳ����˴��ȤʤäƤ��롣
;; ����ϥ��ѡ����νɤ˽Ф롣
;;----------------------------------------------------------------------------

;; Quest...
(define (ghertie-give-instr knpc kpc)
  (say knpc "�������μ겼�ϥɥ���ΰ��ΤĤ�������줿���ؤ�ȤˤĤ��Ƥ��롣"
       "����򳰤����ȤϤǤ��ʤ���"
       "���硼�󡢥���åȡ������ƥߡ��ˡ��Ϥޤ������Ƥ��롣"
       "���λ��ؤ���ä��褤�����줬�������ξ�����"
       "���θ夳�����������˱����롣")
	(quest-data-update-with 'questentry-ghertie 'questinfo 1 (quest-notify nil))
)

(define (ghertie-update-quest knpc kpc)
  (let ((nrem (- 3 (num-in-inventory kpc t_skull_ring))))
    (if (= nrem 0)
        (begin
          (say knpc "�����Ͽ뤲��줿������ǵ٤��ġ�"
               "���ῼ������[" merciful-death-x "," merciful-death-y "]��̲�äƤ��롣"
               "��������ϳ�����ˤ��롣�ɤ���ä�������Τ��Ϥ������������"
               "����������ʾФ��ȶ��˾ä���ä�����")
			(quest-data-update-with 'questentry-rune-c 'shiploc 1 (quest-notify nil))
			(quest-data-assign-once 'questentry-ghertie)
			(quest-data-update-with 'questentry-ghertie 'done 1 (grant-party-xp-fn 20))
			 (kern-conv-end)
          (kern-obj-remove knpc)
          (kern-map-set-dirty))
        (begin
          (say knpc "�ޤ����ؤ�" nrem "��­��ʤ���"
               "�������λؼ���˺�줿�Τ���")
           (if (kern-conv-get-yes-no? kpc)
               (begin
                 (say knpc "���ޤ����겼���ä��鲥�껦���Ƥ��������ʡ�")
                 (ghertie-give-instr knpc kpc))
               (say knpc "�ʤ�ʤ���֤����äƤ��롩"
                    "�⤷������̤����ʤ���С������κ��򤢤����μ�ǲ��껦���Ƥ�뤫��ʡ�"))))))

;; Basics...
(define (ghertie-hail knpc kpc)
  (let ((quest (ghertie-quest (kobj-gob-data knpc))))
		(quest-data-update 'questentry-ghertie 'ghertieloc 1)
		(quest-data-assign-once 'questentry-ghertie)
    (display "quest:")(display quest)(newline)
    (if (quest-accepted? quest)
        (ghertie-update-quest knpc kpc)        
        (say knpc "�Τ��ʤ��Ϲӡ������Ѥν�����ͩ��Ȳ�ä�����"
             "����������⤹��ȤϤ����ٶ��������ϵ��������������"))))

(define (ghertie-default knpc kpc)
  (say knpc "����ʤ��Ȥ��ä��Ƥ�󤸤�ͤ���"))

(define (ghertie-name knpc kpc)
	(quest-data-update 'questentry-ghertie 'ghertieid 1)
  (say knpc "�����ȥ롼�ɤ���"))

(define (ghertie-join knpc kpc)
  (say knpc "�������Ϥ�����ʱ��Υ��ʤ���"))

(define (ghertie-job knpc kpc)
  (say knpc "�����Ƥ�Ȥ��ϳ�±���ä������Ϥ���������ͩ�����"))

(define (ghertie-bye knpc kpc)
  (if (quest-accepted? (ghertie-quest (kobj-gob-data knpc)))
      (say knpc "�᤯���ߤ����餷�Ƥ��졪")
      (say knpc "��ʬ�μ겼�򿮤���ʡ�")))

;; Pirate...
(define (ghertie-pira knpc kpc)
  (say knpc "���γ��ߤǲ�ǯ�ⳤ±���äơ��������ߤ�������"
       "������±�򼭤�����롢�겼��΢�ڤ�줿��"
       "�ߤ�ʤ�������©�Ҥߤ����˻פäƤ��Τˤ������Τ餺�ᡪ"))

(define (ghertie-betr knpc kpc)
  (say knpc "��ȴ�����������򿲤Ƥ���֤˻���������å�äƤ��ä��Τ���"))

(define (ghertie-ship knpc kpc)
  (say knpc "�ֻ��ῼ����׹��®�������Τ��������ä���"
       "�����ꤤ�����Ϥʤ��͡��������Ƥʤ��ʤꡢ�⤦���⤫�⽪������"
       "������������������å�ä��겼�����Ф˵����ͤ���"))

(define (ghertie-haun knpc kpc)
  (say knpc "������Υ����ʤ��Τ���"
       "΢�ڤä��겼�Ϥ��������Ť��˻��Ǥ������ʤ��ȹͤ��Ƥ�����"
       "�������ۤϼ����Ǥ������ɤ餻����������ۤ��ɤ����Ȥ��Ǥ��ʤ��Τ���"
       "�ե��ۤϤ����������μ������Τ�ʤ��Τ���"))

(define (ghertie-curs knpc kpc)
  (say knpc "�������ϼ�ʬ�����˼����򤫤�����"
       "�⤷��ޤ줿�鼫ʬ��ư���������������褦�ˤ���"
       "���γ�����Ϥ������������ΤäƤ���ġ�"))

(define (ghertie-grav knpc kpc)
  (say knpc "�ʤ�����ʤ���ʤ��"))

(define (ghertie-reve knpc kpc)
  (let ((quest (ghertie-quest (kobj-gob-data knpc))))
    (if (quest-accepted? quest)
        (say knpc "���������ޤ��������������������ä���"
             "���򥴥��㥴������äƤ��롩")
        (begin
          (say knpc "��������䤿���ܤǤ��ʤ��򸫤�����"
               "���ޤ��Ϥ������λ������������ߤ������դ���ä���"
               "���ߤ����餹����˼���ߤ��Ƥ����Τ���")
	(quest-data-update 'questentry-ghertie 'revenge 1)
          (if (kern-conv-get-yes-no? kpc)
              (begin
                (say knpc "�겼���������Ȱ���������櫓����ͤ���"
                     "�����ۤ����õ�����������ͤ����ʤ��ۤ�������"
                     "�����Ĥä��ۤ򸫤Ĥ��Ф�������"
                     "��������Ф������������ɤ��ˤ��뤫�����Ƥ����"
                     "����Ϥ������������ʡ�")
                (if (kern-conv-get-yes-no? kpc)
                    (begin
                      (say knpc "������Ω�����ह�٤��Ԥ衣")
                      (quest-accepted! quest #t)
                      (ghertie-give-instr knpc kpc))
                    (say knpc "��ñ�˷��󤷤ʤ��ΤϤ������Ȥ���"
                         "������ˤä��ۤ򤳤����Ԥ�³���뤳�Ȥˤʤ뤫��ʡ�")))
              (begin
                (say knpc "�ʤ�ڡ����������ʡ��Х���Ϻ��")
                (kern-conv-end)))))))

(define (ghertie-fort knpc kpc)
  (say knpc "�⡢���С���ˡ��ʪ�����˳�����������Ǥ���")
	(quest-data-assign-once 'questentry-rune-c)
	)

(define ghertie-conv
  (ifc basic-conv

       ;; basics
       (method 'default ghertie-default)
       (method 'hail ghertie-hail)
       (method 'bye ghertie-bye)
       (method 'job ghertie-job)
       (method 'name ghertie-name)
       (method 'join ghertie-join)
       
       ;; special
       (method 'pira ghertie-pira)
       (method 'betr ghertie-betr)
       (method 'crew ghertie-betr)
       (method 'ship ghertie-ship)
       (method 'haun ghertie-haun)
       (method 'curs ghertie-curs)
       (method 'grav ghertie-grav)
       (method 'fort ghertie-fort)
       (method 'reve ghertie-reve)

       ))

(define (mk-ghertie)
  (bind 
   (kern-mk-char 'ch_ghertie           ; tag
                 "�����ƥ���"            ; name
                 sp_ghast            ; species
                 oc_warrior                 ; occ
                 s_ghost               ; sprite
                 faction-men         ; starting alignment
                 0 0 0               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 6  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'ghertie-conv         ; conv
                 sch_ghertie           ; sched
                 nil                 ; special ai
                 nil                 ; container
                 nil                 ; readied
                 )
   (ghertie-mk)))
