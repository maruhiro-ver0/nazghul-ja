;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define joel-lvl 3)
(define joel-species sp_human)
(define joel-occ nil)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ���֥���åȤ������
;;----------------------------------------------------------------------------
(define joel-bed (list 'p_gate_to_absalot 8 9 1 1))
(define joel-mealplace joel-bed)
(define joel-workplace (list 'p_gate_to_absalot 7 10 5 5))
(define joel-leisureplace joel-workplace)
(kern-mk-sched 'sch_joel
               (list 0  0 joel-bed          "sleeping")
               (list 5  0 joel-mealplace    "eating")
               (list 6  0 joel-workplace    "working")
               (list 12 0 joel-mealplace    "eating")
               (list 13 0 joel-workplace    "working")
               (list 18 0 joel-mealplace    "eating")
               (list 19 0 joel-leisureplace "idle")
               (list 21 0 joel-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (joel-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ���票������Ѥʵ�����ǡ����֥���åȤ�Į���˲����줿����������Ҥ򤷤���
;; �餷�Ƥ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (joel-hail knpc kpc)
  (kern-log-msg "���ʤ������Ѥʵ�����Ȳ�ä���")
  (say knpc "�褪��")
  )

(define (joel-default knpc kpc)
  (say knpc "�狼���ʤ���������"))

(define (joel-name knpc kpc)
  (say knpc "���票�롣"))

(define (joel-join knpc kpc)
  (say knpc "����䡣"))

(define (joel-job knpc kpc)
  (say knpc "�����äȤ롣ʿ�¤Ǥ������ä���"))

(define (joel-peac knpc kpc)
  (say knpc "���������������ϥ��֥���åȤ��Τ��������"))

(define (joel-absa knpc kpc)
  (say knpc "������ꤿ���Τ���")
  (if (yes? kpc)
      (say knpc "���Ȥ������Ϲ��ۤ����äѤ����롣")
      (say knpc "���줬������")))

(define (joel-nast knpc kpc)
  (say knpc "�����������Ի�μԡ���Ϥ狼��ͤ���"
       "�����Τ�����ǿ��Ĥ����������������顢�����ϤҤǤ�����ä���"))

(define (joel-fest knpc kpc)
  (say knpc "���饹�ɥ�󤫤��褿�����Τ��������֥���åȤ��˲�������"
	"�ͤ����ʤ��ʤä����ʪ�ɤ⤬���äƤ����Τ�����"))
	
(define (joel-gaze knpc kpc)
  (say knpc "����������硣���ĤǤ�¾���ۤ���ۤǤ���Τ�����"
       "�����Ĥ��ʤ��ȡ����ᤨ������ˤʤ뤾��"))
	   
(define (joel-unde knpc kpc)
  (say knpc "ͩ�����������Τꤿ���ͤ���"))

(define (joel-bye knpc kpc)
  (say knpc "���㤢�ʤ���"))

(define joel-conv
  (ifc basic-conv

       ;; basics
       (method 'default joel-default)
       (method 'hail joel-hail)
       (method 'bye joel-bye)
       (method 'job joel-job)
       (method 'name joel-name)
       (method 'join joel-join)

       (method 'peac joel-peac)
       (method 'nice joel-peac)
       (method 'absa joel-absa)
       (method 'nast joel-nast)
       (method 'stuf joel-nast)
       (method 'mons joel-nast)
       (method 'fest joel-fest)
       (method 'pala joel-fest)
       (method 'unde joel-unde)
       (method 'gaze joel-gaze)	   
       ))

(define (mk-joel)
  (bind 
   (kern-mk-char 
    'ch_joel           ; tag
    "���票��"         ; name
    joel-species         ; species
    joel-occ              ; occ
    s_companion_shepherd     ; sprite
    faction-men      ; starting alignment
    1 0 1            ; str/int/dex
    0 0              ; hp mod/mult
    0 0              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    joel-lvl
    #f               ; dead
    'joel-conv         ; conv
    sch_joel           ; sched
    'townsman-ai              ; special ai
    nil              ; container
    (list t_staff
					         )              ; readied
    )
   (joel-mk)))
