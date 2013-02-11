;;----------------------------------------------------------------------------
;; This is the special statue that stands in the courtyard of Glasdrin. When
;; attacked, it speaks. This requires two objects: an object with a type in
;; order to support the 'attack interface, and a character type to have the
;; conversation. The illusion is that they are both the same object.
;;----------------------------------------------------------------------------

(define (soj-strike kobj kpc)
  (let ((kchar (mk-talking-statue)))
    (kern-obj-put-at kchar (kern-obj-get-location kobj))
    (kern-conv-begin kchar)
    (kern-obj-remove kchar)
    ))


(mk-obj-type 't_statue_of_justice "�Ť�����" s_headless_w_sword_statue layer-mechanism
             (ifc nil
                  (method 'xamine (lambda (knpc kpc)
                                    (kern-log-msg "�������Τ�����ǤơפȤ����ä������ä�ʸ�Ϥ���ޤ�Ƥ��롣")))
                  (method 'attack soj-strike)
                  ))

(define (soj-accuse knpc kpc)
  (say knpc "��ȯ�����Τ�ï����")
  (let ((kchar (ui-target (kern-obj-get-location kpc) 19 obj-is-char?)))
    (cond ((null? kchar)
           (say knpc "��ȯ���겼���뤫��")
           (cond ((yes? kpc)
                  (say knpc "�����衣�ڡ����������򵯤����Ԥ衣"
                       "�ڤ���Τ����Ƥ���Ȥ��˸����Ǥ�����")
                  (unrest-curse-apply-new kpc 'insect-party-l1)
                  (kern-conv-end))
                 (else
                  (soj-accuse knpc kpc))
                 ))
          (else
           (say knpc "�ʤ���ΤϳΤ���" (kern-obj-get-name kchar) "����")
           (cond ((no? kpc)
                  (soj-accuse knpc kpc))
                 (else
                  (say knpc (kern-obj-get-name kchar) "�衣���" (kern-obj-get-name kpc) "�˹�ȯ���줿��")
                  (soj-get-evidence knpc kpc kchar)
                  ))
           ))
    ))

(define (soj-get-evidence knpc kpc kchar)
  (say knpc (kern-obj-get-name kpc) "�衣���ξڵ�򼨤���")
  (let ((ktype (kern-ui-select-item kpc)))
    (cond ((null? ktype)
           (say knpc "�̤ξڵ�Ϥ��뤫��")
           (cond ((no? kpc)
                  (shake-map 15)
                  (say knpc "�ԳΤ��ʾڵ��¾�μԤ��ʤ����Ԥϡ����ڤκ��Ʊ���Ǥ��롣"
                       "��������η��˽褹��")
                  ;; todo: implement exile
                  (make-enemies knpc kpc)
                  (kern-obj-relocate kpc
                                     (kern-place-get-location (loc-place (kern-obj-get-location knpc)))
                                     nil)
                  (kern-conv-end)
                  )
                 (else (soj-get-evidence knpc kpc kchar))
                 ))
          ((or (not (equal? ktype t_stewardess_journal))
              (not (defined? 'ch_steward))
              (not (equal? kchar ch_steward)))
           (say knpc "�����Ϥ��ξڵ���̤���Ǥ�����")
           (log-dots 10 1000)
           (say knpc "���ξڵ�Ǥ��Խ�ʬ�Ǥ��롣")
           (prompt-for-key)
           (soj-get-evidence knpc kpc kchar)
           )
          (else
           (say knpc "�����Ϥ��ξڵ���̤���Ǥ�����")
           (log-dots 10 1000)
           (say knpc (kern-obj-get-name kchar) "�衣���΢�ڤ�κ���Ȥ�������ؤ�ȳ�ϻ����"
                "�����Ƥ���̾�ϱʱ�˼�����Ǥ�����")
           (aside kpc 'ch_ini "�Ĥ�����������")
           (kern-being-set-current-faction kchar faction-monster)
           (quest-data-update-with 'questentry-warritrix 'avenged 1 (quest-notify (grant-party-xp-fn 200)))

           (if (defined? 'ch_jeffreys)
           		(begin
               		(kern-char-set-sched ch_jeffreys sch_jeff_resigned)
               		(kern-obj-set-sprite ch_jeffreys s_fallen_paladin)
               	)
               )

           (if (defined? 'ch_valus)
           		(begin
               		(kern-char-set-sched ch_valus sch_jeff)
               		(kern-obj-set-sprite ch_valus s_companion_paladin)
               	)
               )

           (kern-conv-end)
           ))
    ))
           
                  

(define (soj-hail knpc kpc)
  (say knpc "�������������Τ���")
  (cond ((no? kpc)
         (say knpc "������м����衣������Ư���ԤϽä���������衣"
              "�ä����٤ޤ��̤Ǥ�����")
         (unrest-curse-apply-new kpc 'wolf-party-l2)
         (kern-conv-end))
        (else
         (say knpc "���¤��ä��������餺�м����衣��ߡ����ڡ���ȿ��΢�ڤ��¾�μԤ��ʤ��뤫��")
         (cond ((no? kpc) 
                (say knpc "�������ʿ���������衣���������٤�̵��̣�˲���ǤĤʡ�")
                (kern-conv-end))
               (else
                (say knpc "�ٹ𤹤롪�θǤ���ڵ�ʤ���¾�μԤ��ʤ���Ԥϡ����ڤκ���Ȥ��Ƥ���Τ�Ʊ���Ǥ��롣������ȳ������Ǥ�����"
                     "�����������ʤ��뤫��")
                (cond ((no? kpc)
                       (say knpc "���¤����ʤ�ʿ���������������ƾڵ�򽸤�衣����¾�μԤ˺���夻��ʤ����٤Ȳ���ǤĤʡ�")
                       (kern-conv-end))
                      (else
                       (say knpc "�����β��˾������롪")
                       (shake-map 5)
                       (soj-assemble-everyone (kern-obj-get-location knpc))
                       (soj-accuse knpc kpc))
                      ))
               ))
        ))

(define (soj-assemble-everyone loc)
  (define (assemble townsfolk)
    (kern-map-repaint)
    (if (not (null? townsfolk))
        (assemble (filter notnull? 
                          (map (lambda (kchar)
                                 (cond ((in-range? loc 2 kchar) nil)
                                       (else
                                        (pathfind kchar loc)
                                        kchar)))
                               townsfolk)))))
  (assemble (filter (lambda (kchar)
                      (let ((gob (gob kchar)))
                        (and (not (null? gob))
                             (pair? gob)
                             (eq? 'townsman (car gob)))))
                    (kern-place-get-beings (loc-place loc))))
  )

(define soj-conv
  (ifc basic-conv
       (method 'hail soj-hail)
       ))

(define (soj-ai knpc)
  #t)

(define (mk-talking-statue)
  (let ((kchar 
         (kern-mk-char 
          'ch_soj           ; tag
          "��������"        ; name
          sp_statue         ; species
          nil              ; occ
          s_headless_w_sword_statue     ; sprite
          faction-glasdrin      ; starting alignment
          0 0 0            ; str/int/dex
          0 0              ; hp mod/mult
          0 0              ; mp mod/mult
          1000 ; hp
          0                   ; xp
          0 ; mp
          0
          9                ; lvl
          #f               ; dead
          'soj-conv         ; conv
          nil           ; sched
          'soj-ai              ; special ai
          nil              ; container
          nil              ; readied
          )))
    (kern-char-set-known kchar #t)
    kchar))
