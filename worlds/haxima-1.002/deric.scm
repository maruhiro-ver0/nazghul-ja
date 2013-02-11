;;----------------------------------------------------------------------------
;; Schedule
;; 
;; �Ф���
;;----------------------------------------------------------------------------
(define (mk-zone x y w h) (list 'p_green_tower x y w h))
(kern-mk-sched 'sch_deric
               (list 0  0 (mk-zone 17  4  1   1)  "sleeping")
               (list 6  0 (mk-zone 30 30  5   5)  "working")
               (list 12  0 (mk-zone 52 54  1   1)  "eating")
               (list 13  0 (mk-zone 30 30  5   5)  "working")
               (list 18  0 (mk-zone 52 54  1   1)  "eating")
               (list 19  0 (mk-zone 30 30  5   5)  "working")
               (list 21  0 (mk-zone 13  2  4   4)  "idle")
               (list 22  0 (mk-zone 17  4  1   1)  "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (deric-mk tell-secret?) (list tell-secret? (mk-quest)))
(define (deric-tell-secret? deric) (car deric))
(define (deric-set-tell-secret! deric) (set-car! deric #t))
(define (deric-bandit-quest deric) (cadr deric))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; �ǥ�å����Ф���η�����Ĺ�Ǥ��롣
;;----------------------------------------------------------------------------

(define (deric-name knpc kpc)
  (say knpc "��ϥǥ�å���Ĺ��������λ��ᴱ�Ǥ��롣���ʤ�ȿ������褤��"))

(define (deric-job knpc kpc)
  (say knpc "�������ش����뤳�ȤǤ��롣�����ƻ�ˤϤ���礭����Ū�����롣"
       "��ϼ�ʬ��ǽ�Ϥǻش������ϰ̤˾��ͤ᤿���������������ʤ��뤿��ˤϡ�"
       "ï������̤Τ��Ԥ��ʤ���Фʤ�ʤ�������"))

(define (deric-health knpc kpc)
  (say knpc "��Ϸ򹯤��Τ�ΤǤ��롪"))

(define (deric-rangers knpc kpc)
  (say knpc "������������Ϥ��ι���ʿ���ʿ�¤�����̳����äƤ��롣"
       "ˡ���餻�����֥��ɤ��ƻ뤹��ʤɤ���"
       "�������������ϩ��ݻ�����Τ�桹�λŻ�����"
       "��ʬ���ȤΤ��Ȥ�����С��桹�ϻ����Ψ�Τ�Ȥ��Ф餷���Ż��򤷤Ƥ��롣"
       "��������������Ư���˴��դ��Ƥ��롣�γ��Ф餤��"))

(define (deric-two knpc kpc)
  (say knpc "��γ��ΤۤȤ�ɤ��ɸ���������"
       "���γ��ϲ�ļ���ʼ�ˡ���˼�ʤɤ���"
       "���Ϸ�̳��ˤʤäƤ��롣"
       "���γ��ˤ�ͩ�����ȹͤ��Ƥ���Ԥ⤤��褦����"))

(define (deric-haunted knpc kpc)
  (say knpc "���γ��ˤ�ͩ�����ȸ����Ԥ����롣����̯��ʪ����ʹ�������Ȥ����롣"
       "�ɤα��������顢����褦�ʡ����ĤΤ褦������������"
       "����ͩ��ʤɸ������Ȥ��ʤ���"
       "�������Ϥ���ʤ�Τ϶���ʤ���"))

(define (deric-gen knpc kpc)
  (say knpc "̾�⤭���ԡ����������Ǥʤ����ʡ�"
       "��Υ��֥������Ǥγ����Ϸ�����δ֤Ǥ�����ȤʤäƤ��롣�����ƸŶ��ԤκǸ�������Ĥ�ΰ�ͤǤ⤢�롣"
       "���Ǥ��Τ�Ĵ�ҤϤ褵����������"
       "�������μԤˤʤäƤ��ޤä����ɤ�������̣���狼���������"))

(define (deric-native knpc kpc)
  (say knpc "��������Ͽ���̱���Ĥޤ꿹���֥��ν������������Ƥ��롣"
       "�������ब�桹��ȿ�տ�����äƤ���ȵ��äƤ���ΤǤϤʤ���"
       "�⤷�Ǥ���ʤ顢������������������ʤ��������Ȥ���פäƤ��롣"
       "����������������Բ�ǽ������"
       ))

(define (deric-shroom knpc kpc)
  (say knpc "���񤷤��̤�����������ǽ�Ϥ��������뤬�����������ʤ���"
       "����Į������������򤷤Ƥ��롣"))

(define (deric-abe knpc kpc)
  (say knpc "�㤤�Ѥ�ä��ˤ����Ѥ��ԤȤ�����ꡢ��̯�ʡġ��̤θ������򤹤�ȡĤ��ޤ�������ʡ�"
       "�Ȥˤ����������Ĥ�Į�������ΰ��פ�Ĵ�٤Ƥ��롣"
       "��Ω�޽�ۤ��ɤ�����Ư���Ƥ���Τ�����"))


(define (deric-tower knpc kpc)
  (say knpc "����������Į������ˤ��롢�Ф���ȸƤФ�������"
       "��������λش���Ǥ��ꡢ������������Ǥ��롣"
       "���Ф餷����ʪ����"
       "���줬�Ť���ΰ��פξ�˷��Ƥ�줿��Τ����ΤäƤ��뤫��")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "���򤤤Ȼפ�󤫡���ˤϾܤ����Ϥ狼��ʤ�����"
           "��ä��Τꤿ���ʤ顢�����֤����⤷������ȥ���롼����ä��Ȥ褤���⤷���")
      (say knpc "��������������ϡ����ĤƤ��ä����������ΰ����ˤ����ʤ���"
           "�����֤Ȥ�����ԤΤ��Ȥ򿮤���ʤ顢����Ǥ��ޤä���������"
           "���Ǥ���Ĥγ������ĤäƤ��ʤ���")))

(define (deric-ambition knpc kpc)
  (say knpc "�����̤ꡣ��ˤ�������ꡢ�����ǧ��뤳�Ȥ򶲤�ʤ���"
       "�ͤ������ļԤ��԰¤˻פ�������ޤ������ʤɤʤˤ�ʤ���"
       "̵����Ϻ����ϰ̤ˤ��ɤ��夯����������ʤ��Ȥϲ��⤷�Ƥ��ʤ���"
       "��Ϥ��ΰ�����ȿ��ο����Ǥ������Ƥ��롣���ˤ�������뤫��")
  (if (kern-conv-get-yes-no? kpc)
      (begin
        (say knpc "���������λ��Ϥ褤����Ϥ��Ĥ��������ˤʤꤿ����"
             "��ˤϤ��ε��񤬤���Ȼפ�����")
        (if (kern-conv-get-yes-no? kpc)
            (begin
              (say knpc "�狼�äƤ��롪���Τ��Ȥ��Ѥ��Ƥ���櫓�ǤϤʤ�����"
                   "�Ԥ�ƶ���Ϥ���ļԤΤ褦����"
                   "���ˤ�����̩�򶵤��褦��")
              (deric-set-tell-secret! (kobj-gob-data knpc)))
            (say knpc "�ξФ��Ϥ��ޤʤ����ո������ʤ��褦���ʡ�"
                 "���Ф줷�ԤϤ褯�פ��ʤ���Τ���")))
      (say knpc "�Τ���©��¿���μԤɤ��̵���ͤ˿�����ϲ�񤷤Ƥ��롣"
           "���������ΰ�ͤǤʤ����Ȥ���Ǥ��롪")))

(define (deric-secret knpc kpc)
  (if (deric-tell-secret? (kobj-gob-data knpc))
      (say knpc "����ϲ��ˤϱ����줿��ϩ�����롣"
           "���ΤϤ�����ߤ�ơ�����ν����������졣"
           "����ɤ���̩���⤬���롪"
           "���Τ��ᤫ�Ϥ狼��ʤ����ʡ�")
      (say knpc "�����ͤʤ褽�Ԥ��ä����Ȥϲ���ʤ���")))

(define (deric-afraid knpc kpc)
  (say knpc "�������������Ͼ�ʪ�Υۥ֥��֥�����"
       "���䡢�ۥ֥��֥�󤬾�ʪ�ζ��줫��"
       "�������礦�ᡢ�Ф����������󤷤��פ��Ф��ʤ���"))

(define (deric-prison knpc kpc)
  (say knpc "���������ȤƤ⶯�Ǥʡ����ߡ����ͤϰ�ͤ������ʤ���"
       "���Τ�����򤦤�Ĥ��Ƥ��������֥�����"
       "��˽�ʽäȸ����ۤ��ˤʤ���"
       "��Ϥ����Ĥ򶲤줿��Ϥ��ʤ����γ��Ф餤��"))

(define (deric-gobl knpc kpc)
  (say knpc "�����ʤ�Ĥ�����ޤ����������ˤ�Ĥ�Į�������ޤ��ơ���̳����������Ǥ�ä����ʡ�"))

(define (deric-brute knpc kpc)
  (say knpc "�ȤƤ⵿�路���Ԥ���������ʪ����äƤ��ʤ��ä��Τǡ����餫�˾�����褿�ΤǤϤʤ���"
       "�����ƶ��̸줬�����ä��ʤ��ä���"
       "���䡢����ɤ��������ä����Ȥ��ʤ��ä��������ࡢ�ϲ��ˤ���о������ä��褦�ˤʤꤽ���ʤ�Τ�����"
       "���򤿤����Ǥ���Τ��ͤ��ߤ�ʤ���С�"))

(define (deric-default knpc kpc)
  (say knpc "�̤Τ��Ȥ�ʹ���Ƥ��졪"))

;; Scan the player party looking for mercs
                         

(define (deric-hail knpc kpc)

  (define (get-ranger-merc)
    (let ((mercs (filter (lambda (kchar)
                           (kbeing-is-npc-type? kchar 'ranger))
                         (kern-party-get-members (kern-get-player)))))
      (cond ((null? mercs) nil)
            (else
           (car mercs)))))

  (define (rm-ranger-merc)
    (let ((kmerc (get-ranger-merc)))
      (if (not (null? kmerc))
          (begin
            (prompt-for-key)
            (say knpc "��Ͻ�󤹤���������ƹ������ʤ���Фʤ�ʤ���")
            (kern-char-leave-player kmerc)
            ))))

  (cond ((in-player-party? 'ch_nate)
         (say knpc "��±��Ƭ����館���褦���ʡ�"
              "�ϲ��η�̳��δǼ���Ϥ������ƾ�����������äƤ���Τ���")
         (rm-ranger-merc)
         (quest-data-update-with 'questentry-bandits 'captured-nate-and-talked-to-deric 1 (quest-notify nil))
         )        
        ((has? kpc t_prisoner_receipt 1)
         (say knpc "��±��ݣ�θ�����¦���ɤ���ä����Ȥϡ���ε���������Ͽ�ˤʤ�Ǥ�����"
              "�����󽷤��Ϥ�����")
         (give-player-gold 100)
         (kern-char-add-experience kpc 64)
         (take kpc t_prisoner_receipt 1)
         (quest-done! (deric-bandit-quest (kobj-gob-data knpc)) #t)
         (rm-ranger-merc)
         (quest-data-update-with 'questentry-bandits 'done 1 (grant-party-xp-fn 30))
         (quest-data-complete 'questentry-bandits)
         )
        (else
         (say knpc "�褯�褿�ʡ�")
         )))

(define (deric-bye knpc kpc)
  (say knpc "�ޤ��񤪤���"))

(define (deric-thie knpc kpc)
  (say knpc "�դࡣ��ޤ����äΤ褦�ʥ��֥���ť�����ä��˰㤤�ʤ���"
       "�������ۤϷ�̳�������������̤ä��̤ذ�ͤǸ������Ԥ������Ȥ������Ϥ��ä�������Ū�ϤϤ狼���"
       "�̤ˤϥܥ줷���ʤ����ʡ�")
       (quest-data-update 'questentry-thiefrune 'tower 1)
       (quest-data-update-with 'questentry-thiefrune 'bole 1 (quest-notify (grant-party-xp-fn 10)))
       )

(define (deric-accu knpc kpc)
  (say knpc "�������Ǹ����뤬�����Τ�����˼���줿�ԤϤ��ʤ���"))


(define (deric-band knpc kpc)
  (let ((quest (deric-bandit-quest (kobj-gob-data knpc))))
    (cond ((quest-done? quest) 
           (say knpc "�䤬��±��Ƭ����館������ˤϡ�����ʾ������ϵ�����ʤ��Ǥ�����"
                "�����󷯤Τ���������"
                "������̿�����ΤϤ��λ����"
                "�γ�ʧ����"))
          ((quest-accepted? quest)
           (say knpc "���ο��Τɤ�������±�α���Ȥ����롣"
                "õ��³���뤳�Ȥ���������Ƭ���������ˤ���Ϣ��Ƥ���Τ���")
           )
          (else
           (say knpc "��±�������ʹ�����Τ��ʡ�"
                "��������Ĥ�α���ȤϤ��ο��Τɤ����ˤ��롣"
                "���äȰ����ʤ�䤬��Ĥ����ݤ��˹Ԥ�������"
                "���������ΤäƤΤȤ��ꡢ�������Ϥ��ʤ���")
           (prompt-for-key)
           (say knpc
                "�����Ƥ��졣����ͦ����������"
                "�⤷��±��Ƭ����館��������Ϣ����褿�ʤ顢���Ƿ��˾޶��Ϳ���褦��"
                "�ɤ���������")
           (if (yes? kpc)
               (begin
                 (quest-accepted! quest #t)
                 (say knpc "���Ф餷�������ˤϽ�����ɬ�פ�����\n"
                      "����Ϥ��ʤ���������ʸ����Ϥ�������\n"
                      "����̿���ϡ�������λش����򷯤˰��Ū�˾��Ϥ����Τ���"
                      "������ΰ�ͤ���֤˲ä��褦�˸������ޤ���")
                 (give kpc t_ranger_orders 1)
                 (quest-data-update-with 'questentry-bandits 'talked-to-deric 1 (quest-notify nil))
                 )
               (say knpc "���Τ褦�����٤Ǥϡ��ɸ��Ϸ褷�������ʤ��Ǥ�����")))
          )))
                       

(define deric-conv
  (ifc green-tower-conv
       (method 'abe        deric-abe)
       (method 'afra       deric-afraid)
       (method 'ambi       deric-ambition)
       (method 'aspi       deric-ambition)
       (method 'band       deric-band)
       (method 'brut       deric-brute)
       (method 'bye        deric-bye)
       (method 'comm       deric-rangers)
       (method 'default    deric-default)
       (method 'die        deric-ambition)
       (method 'gen        deric-gen)
       (method 'hail       deric-hail)
       (method 'haun       deric-haunted)
       (method 'heal       deric-health)
       (method 'job        deric-job)
       (method 'name       deric-name)
       (method 'nati       deric-native)
       (method 'pris       deric-prison)
       (method 'prom       deric-ambition)
       (method 'rang       deric-rangers)
       (method 'secr       deric-secret)
       (method 'shro       deric-shroom)
       (method 'skul       deric-brute)
       (method 'stor       deric-two)
       (method 'thie       deric-thie)
       (method 'towe       deric-tower)
       (method 'two        deric-two)
       (method 'gobl       deric-gobl)
))                

(define (mk-deric tag)
  (bind 
   (kern-mk-char tag                 ; tag
                 "�ǥ�å�"          ; name
                 sp_human            ; species
                 nil                 ; occ
                 s_ranger_captain   ; sprite
                 faction-men         ; starting alignment
                 1 3 2               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 4  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'deric-conv        ; conv
                 sch_deric          ; sched
                 'townsman-ai        ;; special ai
                 nil                 ; container
                 (list  t_sword_2
					         t_armor_leather_2
					         t_leather_helm_2
					         )                  ; readied
                 )
   (deric-mk #f)))
