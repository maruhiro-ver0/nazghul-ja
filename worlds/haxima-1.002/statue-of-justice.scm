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


(mk-obj-type 't_statue_of_justice "古い石像" s_headless_w_sword_statue layer-mechanism
             (ifc nil
                  (method 'xamine (lambda (knpc kpc)
                                    (kern-log-msg "「正義のために打て」という消えかかった文章が刻まれている。")))
                  (method 'attack soj-strike)
                  ))

(define (soj-accuse knpc kpc)
  (say knpc "告発されるのは誰か？")
  (let ((kchar (ui-target (kern-obj-get-location kpc) 19 obj-is-char?)))
    (cond ((null? kchar)
           (say knpc "告発を取り下げるか？")
           (cond ((yes? kpc)
                  (say knpc "呪われよ。軽々しく騒ぎを起こす者よ。"
                       "軽きものが寝ているときに現れるであろう。")
                  (unrest-curse-apply-new kpc 'insect-party-l1)
                  (kern-conv-end))
                 (else
                  (soj-accuse knpc kpc))
                 ))
          (else
           (say knpc "訴えるのは確かに" (kern-obj-get-name kchar) "か？")
           (cond ((no? kpc)
                  (soj-accuse knpc kpc))
                 (else
                  (say knpc (kern-obj-get-name kchar) "よ。汝は" (kern-obj-get-name kpc) "に告発された。")
                  (soj-get-evidence knpc kpc kchar)
                  ))
           ))
    ))

(define (soj-get-evidence knpc kpc kchar)
  (say knpc (kern-obj-get-name kpc) "よ。その証拠を示せ。")
  (let ((ktype (kern-ui-select-item kpc)))
    (cond ((null? ktype)
           (say knpc "別の証拠はあるか？")
           (cond ((no? kpc)
                  (shake-map 15)
                  (say knpc "不確かな証拠で他の者を訴えた者は、偽証の罪と同じである。"
                       "汝を追放の刑に処す。")
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
           (say knpc "正義はその証拠で量られるであろう。")
           (log-dots 10 1000)
           (say knpc "この証拠では不十分である。")
           (prompt-for-key)
           (soj-get-evidence knpc kpc kchar)
           )
          (else
           (say knpc "正義はその証拠で量られるであろう。")
           (log-dots 10 1000)
           (say knpc (kern-obj-get-name kchar) "よ。汝は裏切りの罪を犯した。汝への罰は死だ。"
                "そしてその名は永遠に呪われるであろう。")
           (aside kpc 'ch_ini "ついに正義が！")
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
  (say knpc "汝は正義を求めるものか？")
  (cond ((no? kpc)
         (say knpc "しからば呪われよ。不正を働く者は獣の中で生きよ。"
              "獣は汝を休ませぬであろう。")
         (unrest-curse-apply-new kpc 'wolf-party-l2)
         (kern-conv-end))
        (else
         (say knpc "真実を話せ、しからずば呪われよ。盗み、偽証、違反、裏切りで他の者を訴えるか？")
         (cond ((no? kpc) 
                (say knpc "しからば平穏に生きよ。そして二度と無意味に我を打つな。")
                (kern-conv-end))
               (else
                (say knpc "警告する！確固たる証拠なしで他の者を訴える者は、偽証の罪を犯しているのと同じである。そして罰せられるであろう。"
                     "今、本当に訴えるか？")
                (cond ((no? kpc)
                       (say knpc "真実を求めるなら平穏に生き、そして証拠を集めよ。だが他の者に罪を着せるなら二度と我を打つな。")
                       (kern-conv-end))
                      (else
                       (say knpc "正義の下に召集する！")
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
          "正義の像"        ; name
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
