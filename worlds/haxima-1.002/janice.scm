;;----------------------------------------------------------------------------
;; ����˥�
;;
;; �ǽ�ϥ����ե꡼�����ᴱ���亴��������Ƚ�θ����θ�Ǥ�����Ф���롣
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_jan
               (list 0  0  gjan-bed    "sleeping")
               (list 6  0  gc-hall     "working")
               (list 7  0  ghg-s6      "eating")
               (list 8  0  gc-hall     "working")
               (list 11 0  ghg-s3      "eating")
               (list 12 0  gc-hall     "working")
               (list 17 0  ghg-s3      "eating")
               (list 18 0  g-fountain  "idle")
               (list 20 0  gjan-bed    "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (jan-mk) (list 'townsman))

;;----------------------------------------------------------------------------
;; Conv
;;----------------------------------------------------------------------------

;; Basics...
(define (jan-hail knpc kpc)
  (say knpc "����ˤ��ϡ�ι������")
  )

(define (jan-name knpc kpc)
  (if (player-stewardess-trial-done?)
      (say knpc "���ᴱ�Υ���˥��Ǥ���")
      (say knpc "����˥��Ǥ���")
      ))

(define (jan-job knpc kpc)
  (if (player-stewardess-trial-done?)
      (say knpc "���饹�ɥ��η���ش����Ƥ��ޤ���")
      (say knpc "�����ե꡼�����ᴱ���亴�򤷤Ƥ���ޤ���")
      ))

;; Special
(define (jan-comm knpc kpc)
  (if (player-stewardess-trial-done?)
      (say knpc "��ϥ����ե꡼�������ᴱ�θ�Ǥ�Ȥ������Ф���ޤ�����")
      (say knpc "�����ե꡼�����ᴱ��ͭǽ�ʻ�Ƴ�ԤǤ���")
      ))

(define (jan-repl knpc kpc)
  (if (player-stewardess-trial-done?)
      (say knpc "���Ĺ�����饹�ɥ��Ǥη��򤬡����Τ褦����̾���ǽ���ä��Τ��Ѥ����������ȤǤ���")
      (say knpc "�ɤ�������̣�Ǥ�����")
      ))

(define (jan-mili knpc kpc)
  (say knpc "���饹�ɥ��η��ϡ����ߤϥ���ݥꥹ�ȹ񶭤η�����ԤäƤ��ޤ���"
       "���ߤ�������֤ǤϤ���ޤ���"))

(define (jan-bord knpc kpc)
  (say knpc "���ߤϥȥꥰ�쥤�֤��Ф���Ȥδط����ɹ��Ǥ������ٲ����դ뤳�ȤϤǤ��ޤ���")
  )

;; Townspeople...

(define jan-conv
  (ifc glasdrin-conv

       ;; basics
       (method 'hail jan-hail)
       (method 'job  jan-job)
       (method 'name jan-name)
       (method 'jani jan-name)

       (method 'comm jan-comm)
       (method 'jeff jan-comm)
       (method 'mili jan-mili)
       (method 'repl jan-repl)
       (method 'bord jan-bord)
       ))

(define (mk-janice)
  (bind 
   (kern-mk-char 'ch_janice       ; tag
                 "����˥�"        ; name
                 sp_human            ; species
                 oc_warrior          ; occ
                 s_cloaked_female ; sprite
                 faction-glasdrin         ; starting alignment
                 2 1 1               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 5  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'jan-conv         ; conv
                 sch_jan           ; sched
                 'townsman-ai                 ; special ai
                 nil                 ; container
                 (list t_armor_chain
                       t_chain_coif
                       t_sword
                       ))         ; readied
   (jan-mk)))
