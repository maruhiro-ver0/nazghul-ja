;;----------------------------------------------------------------------------
;; �����륹
;;
;; �ǽ�ϥ��饹�ɥ��μ��ͤ�������˿����������ԤȤʤ롣
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; �ǽ�ϥ��饹�ɥ����ϲ�����˼�ˤ��롣
;; �����ԤȤʤä���ϡ������륹�ϥ����ե꡼���Υ������塼��˽�����
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (valus-mk) (list 'townsman))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; �����륹��������줿��²�ǡ���˥��饹�ɥ��������Ԥˤʤ뤬�������ϲ��δ�
;; �����������Ƥ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (valus-hail knpc kpc)
  (say knpc "�褦���������Τ�̼Ԥ衣")
  )

(define (valus-name knpc kpc)
  (if (player-stewardess-trial-done?)
      (say knpc "��ϥ����륹�����饹�ɥ��������Ԥ���")
      (say knpc "��ϥ����륹�����Ϥ��¤�Τ��������β���������Ͽȿ������˼�򼨤�������")
  ))

(define (valus-job knpc kpc)
  (cond ((player-stewardess-trial-done?)
         (say knpc "���饹�ɥ��ο͡������ϴ����������Ƥ��줿���ڵ�Ȥʤä����������򸫤Ĥ��Ƥ��줿���Ȥ˴��դ��롣"
              "���ϻ�β��ͤ���")
         (prompt-for-key)
         (say knpc "���θ塢��Ͽ����������Ԥ����Ф줿��")
         )
        (else
         (say knpc "�����ο�����ڤ���Ǥ��롣")
         )))

(define (valus-join knpc kpc)
  (if (player-stewardess-trial-done?)
         (say knpc "��������Τ���ε�̳����")
         (say knpc "�դ˿Ҥͤ뤬���ʤ���򳫤���֤˲ä��̤Τ���")
         ))

;; Special
(define (valus-comm knpc kpc)
  (if (player-stewardess-trial-done?)
         (say knpc "����˥��Ϥ褤���ᴱ�ˤʤ�����������ñ�ʤ�ʬ��Ĺ���ä������餽�������Ƥ��롣")
         (say knpc "�����ե꡼�������������ᴱ������������ԤΤ褭���Ǥ��롣�錄���Ϥ����ʤ�ʤ��ä���")
         ))

(define (valus-pet knpc kpc)
  (say knpc "���֥���åȤθ塢����ϻ�˻�̱�λ����Ǥ����碌����"
       "�����ơ����ȥȥ��Ȥ���Ŭ�ڤʹ԰٤ˤĤ��ƻ�����񤷤���")
  (aside kpc 'ch_ini "�ȥ�����ʬ���������ä��Ȼפ�����")
  )

(define (valus-trol knpc kpc)
  (say knpc "���Ȥ����Ф褫�ä��Τ����������Υȥ�뤿���Ϥ��ڤ��ߤ��ΤäƤ����Τ�����������䤫�˾Фä�����")
  (prompt-for-key)
  (say knpc "�����������̤Ϥ��Ƥ���������ϻ���������¿���ο����Ԥä���"
       "��Ǥ�������Ԥϴ�̯�ʾ�������Ǥ��������ʤä���"
       "��ͳ�Ϥ狼��ʤ���������ϻ䤬��������˴��Ĥ��뤳�Ȥ���äƤ�����")
  )

(define (valus-absa knpc kpc)
  (say knpc "ͧ�衢������Ϲ���������줿�Ԥ˴ؤ��뤿�老�ȤϤȤ⤫����"
       "���֥���åȤ���ѻդ����Ϥ��ޤ�ˤ⶯�ϤˤʤäƤ�����"
       "���ᴱ�ϳ�������θ����������ΤäƤ��롣")
  )

(define (valus-isin knpc kpc)
  (say knpc "���������Ǥϡ����Υ�����ν���ѻդϤۤܰ�ͤ���Ĥη����Ǥ��餫������������"
       "�ȥ�����ޥ�η��ϴ������������졢����Į��˺���줿��")
  (prompt-for-key)
  (say knpc "���饹�ɥ��η��ϺǸ�ˤ�����˾���������������»���ν��礵�Τ��ᡢ������Ū���˴�������򤨤ʤ��ä���"
       "�桹�϶�����˺��ƤϤʤ�ʤ���")
  )

(define (valus-less knpc kpc)
  (say knpc "������Ȥ��襤�������������ϡ���ѻդ������Ϥ�Ϳ�������ƤϤʤ�ʤ��Ȥ������Ȥ���"
       "�����ơ��⤷�����ʤäƤ����̤����襤��ĩ��ǤϤʤ�ʤ���"
       "�ʤ����ξ������ʤ���Фʤ�ʤ��ä��Τ�����Ͼ�˵���˻פäƤ��롣")
  )

;; new....
(define (valus-stew knpc kpc)
  (if (player-stewardess-trial-done?)
      (say knpc "�䤬�����ԤȤʤä��������μ��դ��Ѥ�������")
      (say knpc "���ζ��ä����������ǥ��饹�ɥ����������������")
      ))

(define (valus-poli knpc kpc)
  (say knpc "�����Ԥ���Ū��¾�����Ƥ����ˤ��ƤǤ⼫�Ȥθ��Ϥ��������Ȥ���")
  )

(define (valus-chan knpc kpc)
  (say knpc "��ΰ��֤δؿ����ϰ��������ꡢ�����ƥ��饹�ɥ��ˤ����ۤ���")
  )

(define (valus-domi knpc kpc)
  (if (ask? knpc kpc "Į��񤬼���ΰ������ݾ㤹��ͣ���ƻ�ϡ�¾����ۤ��뤳�ȤǤ��롣����Ʊ�դ��뤫��")
      (say knpc "��������ͥ�줿��Ƴ�Ԥʤ�ï�Ǥ��ΤäƤ��롣�����Ƽ���ι��Ǥ⶯�Ϥʤ�Τˤ��뤿���臘�Τ���")
      (say knpc "�⤷¾��Į���桹��궯�Ϥˤʤ�в桹�ϻ��ۤ���������"
           "�����ԤȤ��ơ���ˤϤ�����˻ߤ��뤿���ư������Ǥ������Τ���")
      ))

(define valus-conv
  (ifc glasdrin-conv

       ;; basics
       (method 'hail valus-hail)
       (method 'job  valus-job)
       (method 'name valus-name)
       (method 'valu valus-name)
       (method 'join valus-join)

       (method 'absa valus-absa)
       (method 'chan valus-chan)
       (method 'civi valus-absa)
       (method 'comm valus-comm)
       (method 'dog  valus-pet)
       (method 'domi valus-domi)
       (method 'drun valus-trol)
       (method 'isin valus-isin)
       (method 'jeff valus-comm)
       (method 'less valus-less)
       (method 'pet  valus-pet)
       (method 'poli valus-poli)
       (method 'reti (lambda (knpc kpc) (say knpc "���Ĥƻ�ϥ��饹�ɥ��λ��ᴱ���ä���")))
       (method 'ruin valus-poli)
       (method 'secu valus-domi)
       (method 'stab valus-domi)
       (method 'stew valus-stew)
       (method 'trol valus-trol)
       (method 'unna valus-trol)
       ))

(define (mk-valus)
  (bind 
   (kern-mk-char 'ch_valus       ; tag
                 "�����륹"          ; name
                 sp_human            ; species
                 oc_warrior          ; occ
                 s_fallen_paladin ; sprite
                 faction-glasdrin         ; starting alignment
                 2 1 1               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 5  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'valus-conv         ; conv
                 nil           ; sched
                 'townsman-ai                 ; special ai
                 nil                 ; container
                 (list t_armor_chain
                       t_chain_coif
                       t_sword
                       ))         ; readied
   (valus-mk)))
