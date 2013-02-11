;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define nossifer-x 16)
(define nossifer-y 6)
(define noss-lvl 20)
(define noss-species sp_balron)
(define noss-occ oc_wizard)

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (noss-mk) (list #f))
(define (noss-spoke? gob) (car gob))
(define (noss-spoke! gob) (set-car! gob #t))

;;----------------------------------------------------------------------------
;; Conv
;;----------------------------------------------------------------------------

;; Basics...
(define (noss-hail knpc kpc)
  (say knpc "�Ĥ��˲�ϸƤӽФ��줿���������٤줿ȳ��ï��Ϳ���Ƥ���褦����"))

(define (noss-default knpc kpc)
  (say knpc "��θ��դ�̵�̤ˤ���򤫼Ԥϻह�٤���"))

(define (noss-name knpc kpc)
  (say knpc "̲���ԡ��Υ��ե����ʤꡣ"))

(define (begin-last-battle knpc kpc)
  (say knpc "���������˾�����뤳�ȤϤʤ���"
       "��αʱ���դ��������Ǥ�����")
  (kern-being-set-base-faction knpc faction-demon)
  (kern-conv-end))

(define (noss-job knpc kpc)
  (say knpc "���������˺�Ѥ�⤿�餹�Ԥʤꡣ̿���뤿�ᰭ���ƤӽФ���ѻդΤ��Ȥ�ʹ�������Ȥ�������")
  (yes? kpc)
  (say knpc "��Ϥ��Τ���˿ͤ�ƤӽФ��������줬����ä��Ȥ����顩")
  (kern-log-msg "��ϾФä����������β���ν�����Ω�����᤿��")
  (say knpc "���ƻ�򳫤����������ܤ򽪤�����"
       "����˫����Ϳ���褦��")
  (quest-data-update 'questentry-whereami 'nossifer 1)
  (kern-being-set-base-faction knpc faction-demon)
  (kern-conv-end))

(define (noss-bye knpc kpc)
  (say knpc "�ޤ������äϽ���äƤ���̡�")
  (prompt-for-key)
  (noss-job knpc kpc))

(define noss-conv
  (ifc nil

       ;; basics
       (method 'default noss-default)
       (method 'hail noss-hail)
       (method 'bye noss-bye)
       (method 'job noss-job)
       (method 'name noss-name)

       ))

(define (noss-ai kchar)
  (warlock-ai kchar))

(define (mk-nossifer)
  (let ((kchar (bind 
                 (kern-mk-char 
                  'ch_nossifer           ; tag
                  "�Υ��ե���"             ; name
                  noss-species         ; species
                  noss-occ              ; occ
                  s_balron          ; sprite
                  faction-men      ; starting alignment
                  20 5 20            ; str/int/dex
                  0 5              ; hp mod/mult
                  0 2              ; mp mod/mult
                  max-health ; hp
                  0                   ; xp
                  max-health ; mp
                  0
                  noss-lvl
                  #f               ; dead
                  'noss-conv       ; conv
                  nil           ; sched
                  'noss-ai  ; special ai
                  nil              ; container
                  (list
                   t_flaming_sword
                   t_armor_plate
                   ))
                (noss-mk))))
    (map (lambda (eff) (kern-obj-add-effect kchar eff nil))
         demon-effects)
    (kern-obj-add-effect kchar ef_charm_immunity nil)
    kchar
    ))
