;;----------------------------------------------------------------------------
;; Schedule
;;
;; ���쥴����ξ���
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_ilya
               (list 0  0  gh-ilyas-bed   "sleeping")
               (list 6  0  gh-stable      "working")
               (list 7  0  gh-kitchen     "working")
               (list 12 0  gh-table-1     "eating")
               (list 13 0  gh-pasture     "working")
               (list 15 0  gh-all         "idle")
               (list 17 0  gh-table-1     "eating")
               (list 18 0  gh-living-room "idle")
               (list 20 0  gh-ilyas-bed   "sleeping"))

;;----------------------------------------------------------------------------
;; Gob
;;
;; ���ꥢ�˴ؤ��������ϡ�����β�²�򻦤����ȥ�뤫��ƨ�����Ȥ����Ȥ��֤�˺��
;; ���ϤΤ̤�����ߤ�õ�����ȤǤ��롣�����Υե饰�������gob�˳�Ǽ����롣
;;----------------------------------------------------------------------------
(define (ilya-mk gave-quest? finished-quest?) 
  (list gave-quest? finished-quest?))
(define (ilya-gave-quest? ilya) (car ilya))
(define (ilya-quest-done? ilya) (cadr ilya))
(define (ilya-give-quest ilya) (set-car! ilya #t))
(define (ilya-finish-quest ilya) (set-car! (cdr ilya) #t))

;;----------------------------------------------------------------------------
;; �ѥ���
;;
;; Puska -- ilya's stuffed horse toy -- is a quest item. Nothing special about
;; it really but it is unique and needs its own object type. The object itself
;; is declared in the p_abandoned_cellar constructor. But the type declaration
;; needs to be in a file that is reloaded, so here is as good a place as any.
;;----------------------------------------------------------------------------
(define puska-ifc
  (ifc '()
       (method 'get (lambda (kobj getter)
                      (kern-log-msg "�Ҷ����ʤ�������Τ˰㤤�ʤ���")
                      (kobj-get kobj getter)))))

(mk-obj-type 't_puska "�ϤΤ̤������" s_toy_horse layer-item puska-ifc)

;;----------------------------------------------------------------------------
;; Quest
;;
;; This is a single response in Ilya's conversation. I've called it our here
;; separately to make it obvious.
;;----------------------------------------------------------------------------
(define (ilya-quest knpc kpc)
  (let ((ilya (kobj-gob-data knpc)))
    (display ilya)(newline)
    (if (ilya-gave-quest? ilya)

        ;; yes - gave quest already
        (if (ilya-quest-done? ilya)
            (say knpc "�ѥ����Ϻ��ȤäƤ⹬����")
            (begin
              (say knpc "�ѥ����ϸ��Ĥ��ä���")
              (if (kern-conv-get-yes-no? kpc)

                  ;; yes - puska found
                  (begin 
                    (say knpc "�֤��Ƥ���롩")
                    (if (kern-conv-get-yes-no? kpc)

                        ;; yes - ilya may have puska
                        (if (kern-obj-has? kpc t_puska)

                            ;; yes - player has puska
                            (begin
                              (kern-obj-remove-from-inventory kpc t_puska 1)
                              (say knpc "�����������衢�ѥ�����"
                                   "�⤦�¿��衣������Ͽ����֤ä����Ϥ��꤬�Ȥ������餬�Ǥ���Ф�������ɡ�"
                                   "�Ԥäơ��������äƤ��äơ���ˡ�Ȥ����Ȥ���Τ��äơ����줵�󤬸��äƤ������Ĥ����Ȥ��Ϥ��Ĥ��äƤ����Ρ�")
                              (ilya-finish-quest ilya)
                              (kern-obj-add-to-inventory kpc nightshade 23)
                              )

                            ;; no - puska not in player inventory
                            (begin
                              (say knpc "�ε㤭�ʤ���Ϥ��ʤ�����ʤ���")
                              (kern-conv-end)))

                        ;; no - ilya can't have puska
                        (begin
                          (say knpc "��ͤˤʤä�����ˡ�Ȥ��ˤʤ롪"
                               "�����Ƥ��ʤ���ä�ú�ˤ��Ƥ��Ρ�")
                          (kern-conv-end))))

                  ;; no - didn't find her yet
                  (begin
                    (say knpc "����ξ��Ϥ��ܤ��Ƥ롩")
                    (if (kern-conv-get-yes-no? kpc)
                        (say knpc "���äȤ����ˤ���Ρ�")
                        (say knpc "���عԤäƻ�ƻ���̤ꡢ�̤˵֤˹Ԥ��Ф���Ρ�"))))))

        ;; no - didn't give quest yet
        (begin
          (say knpc "�ѥ����ϻ���ϤΤ̤�����ߤʤΡ��Ǥ�ʤ����Ƥ��ޤä���"
               "���Ĥ����鶵���Ƥ���롩")
          (if (kern-conv-get-yes-no? kpc)
              (begin
                (say knpc "�������¦�ؤ�ƻ���̤ε֤ˤ���"
                     "�ȥ��˵���Ĥ��ơ�")
                (ilya-give-quest ilya))
              (begin
                (say knpc "�ѥ������ä��ꤷ���顢��ͤˤʤä��Ȥ������ʤ��򸫤Ĥ���")
                (kern-conv-end)))))))

(define (ilya-join knpc kpc)
  (say knpc "��Ҷ��ʤΤˡ��ѤʤΡ�")
  )

;;----------------------------------------------------------------------------
;; ưʪ
;;
;; Ilya has an odd relationship with spiders. She'll teach the player a spell
;; to ward off spiders if he plays along. Spiders will dominate the woods
;; around the Abandoned Farm (Ilya's old home). In fact, I intend to have them
;; locked in a battle with the trolls the first time the player enters the
;; Abandoned Farm. I'm planning on having a "great mother" spider known around
;; these parts as Angril or Angriss, perhaps she was one of Ilya's pets as a
;; child - I'm not sure how I want to play that one out yet.
;;----------------------------------------------------------------------------
(define (ilya-animals knpc kpc)
  (say knpc "�Ӥȡ�ǭ�Υ��㡼��ȡ��ܤ���äƤ���Ρ�"
       "ưʪ�Ϲ�����")
  (if (kern-conv-get-yes-no? kpc)

      ;; yes - the player likes animals
      (begin
        (say knpc "�ɤ�ưʪ��������")
        (let ((fav (kern-conv-get-string kpc)))
          (if (or (string=? fav "spider") (string=? fav "����"))

              ;; yes - the player's favorite animal is spiders
              (begin
                (say knpc "��⡪�ɤ�����н����ʤ����ΤäƤ���Ρ�"
                     "�������ߤ�����")
                (if (kern-conv-get-yes-no? kpc)

                    ;; yes - the player wants to learn the spider ward
                    (say knpc "��ñ������λ�����Ǥ򺮤��ơ�"
                         "���󡦥��󡦥٥å�<An Xen Bet>�Ⱦ�����Ρ�")

                    ;; no - the player does not want to learn the spider ward
                    (say knpc "�������Ǥ�����ͤ򽱤����Ȥ⤢��Τ衣")))
                    

              ;; no - the player's favorite animal is NOT spiders
              (say knpc "��ϥ��⤬������"))))

      ;; no - the player does not like animals
      (say knpc "�ݤ��ʤ��衪")))

(define (ilya-fire knpc kpc)
  (say knpc "�Ф򤪤����Τϴ�ñ�ʤΡ��������β���򺮤��ơ�"
       "β���ĳ��Ϥɤ���"
       "�����ƥ��������ե��<Vas Flam>�ȸ����Ρ�"))

(define (ilya-died knpc kpc)
  (say knpc "�ȥ�뤬����򽱤ä��Ρ�"
       "���줵��ϻ���ϲ����˱�������"
       "�����ƥȥ�뤬���Ƥ���֤�ȴ���Ф�����"
       "�Ǥ⡢�ѥ�����˺��Ƥ��ޤä��ġ�"))

;;----------------------------------------------------------------------------
;; Conv
;;----------------------------------------------------------------------------
(define ilya-conv
  (ifc basic-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default (lambda (knpc kpc) (say knpc "�Τ�ʤ���")))
       (method 'hail (lambda (knpc kpc) (say knpc "����ˤ��ϡ�")))
       (method 'bye (lambda (knpc kpc) (say knpc "�Х��Х���")))
       (method 'job (lambda (knpc kpc) (say knpc "����������μ������򤷤Ƥ���Ρ�")))
       (method 'name (lambda (knpc kpc) (say knpc "���ꥢ��")))
       (method 'age (lambda (knpc kpc) (say knpc "8�С�")))
       (method 'chor (lambda (knpc kpc) (say knpc "ưʪ�����ä򤷤��ꡢ�Ф򤪤������ꡢ���������ꤹ��Ρ�")))
       (method 'anim ilya-animals)
       (method 'gran (lambda (knpc kpc) (say knpc "���㤵��Ȥ��줵�󤬻��Ǥ��ޤä����顢����������Ƚ���Ǥ���Ρ�")))
       (method 'died ilya-died)
       (method 'dead ilya-died)
       (method 'trol (lambda (knpc kpc) (say knpc "�ȥ������������ͤˤʤä���ߤ�ʻ����Ƥ��ޤ�������")))
       (method 'hate (lambda (knpc kpc) (say knpc "���Ĥ���ˡ�Ȥ��ˤʤäơ�������ʤ����Ĥ�򻦤��Ƥ��ޤ�������"
                                              "�ޤ�Ʊ�����Ȥ������äƤ��ݤ���ʤ��")))
       (method 'afra (lambda (knpc kpc) (say knpc "�ϲ����ˤ���Ȥ��ݤ��ä���"
                                                "���㤵��Ȥ��줵�󤬥ȥ��˿��٤�줿�Ȥ�����������ʹ��������"
                                                "���ޤ���ǡϤ⤷���Ĥ��äƤ��顢���ä�Ʊ���褦�˿��٤��Ƥ����ġ�")))
       (method 'momm (lambda (knpc kpc) (say knpc "���줵��Ϥ⤦���ʤ����ФΤ��������򶵤��Ƥ��줿���Ȥ�פ��Ф���"
                                               "�ȥ�뤬���äƤ����Ȥ�����ɤ��ǳ�䤷�Ƥ����")))
       (method 'dadd (lambda (knpc kpc) (say knpc "���㤵��Ϥ⤦���ʤ���"
                                               "�ȥ�����ä����ɡ��ɤ����뤳�Ȥ�Ǥ��ʤ��ä���")))
       (method 'pusk ilya-quest)
       (method 'home (lambda (knpc kpc) (say knpc "��ã��������̤���ˤϿ������ä��Ρ�")))
       (method 'spid (lambda (knpc kpc) (say knpc "���Τ�����ο��ˤϥ��⤬�������󤤤�äơ����������󤬸��äƤ���")))
       (method 'wood (lambda (knpc kpc) (say knpc "��������ʤäơ����������󤬸��äƤ���")))
       
       (method 'fire ilya-fire)
       (method 'hi ilya-fire)
       (method 'vas ilya-fire)
       (method 'flam ilya-fire)
       (method 'greg (lambda (knpc kpc) (say knpc "��Τ���������衣")))
       (method 'join ilya-join)
       ))

