;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ���饹�ɥ��
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_jeff
               (list 0  0  gcj-bed      "sleeping")
               (list 7  0  gs-altar    "idle")
               (list 8  0  ghg-s6      "eating")
               (list 9  0  gc-hall     "working")
               (list 12 0  ghg-s3      "eating")
               (list 13 0  gc-train    "working")
               (list 18 0  ghg-s3      "eating")
               (list 19 0  ghg-hall    "idle")
               (list 21 0  gcj-bed      "sleeping")
               )

;; Make another schedule which will be assigned when Jeffreys resigns after the
;; trial.
(kern-mk-sched 'sch_jeff_resigned
               (list 0 0 kun-road "sleeping")
               (list 9 0 campfire-4 "idle")
               (list 13 0 cantina-5 "idle")
               (list 20 0 kun-road "idle")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (jeff-mk) nil)
               
;;----------------------------------------------------------------------------
;; Conv
;; 
;; �����ե꡼���ϥ��饹�ɥ��������Τ����λ��ᴱ�Ǥ��롣
;; ��ϥ��饹�ɥ��˽���Ǥ��ơ������ǻ�Ƴ�ԡ����ߤ������ԤΥ������ȥꥢ��ľ
;; ����𤷤Ƥ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (jeff-hail knpc kpc)
  (cond	((player-stewardess-trial-done?)
         (say knpc "�¤��ͤ衢���Τ��ȤϤ狼�äƤ��졣���Ʈ�Τ�΢�ڤäƤϤ��ʤ����Ԥ������Τ��Ȥϲ����Τ�ʤ��Τ���"
              "��������Ϥ����Ĥ������Ǵְ�äƤ����Ȼפ�����ǰ����ä��Ȥ��˹�ư���٤����ä���"
              "���饹�ɥ��λ��ᴱ�Ϸ褷�����Ϥ��դäƤϤʤ�ʤ���"
              "�椨�˻�ϼ�Ǥ�����Τ���")
         (aside kpc 'ch_ini "�Τ�ʤ��ä��դ�򤹤�ʡ�����Υҥ�������ᡣ"
                "���˲�ä��Ȥ��ϡ��ɤ��餫���ǤӤ�ޤ��臘���Ȥˤʤ������")
         (kern-conv-end)
         )
        (else
         (say knpc "�Τ��ʤ���Ω�ɤʻѤ������ΤȲ�ä����Ϥ褯������줿��")
         )))

(define (jeff-default knpc kpc)
  (say knpc "���Τ褦�ʤ��Ȥϼ�����Ǥ��ʤ���"))

(define (jeff-name knpc kpc)
  (say knpc "���ᴱ�Υ����ե꡼���Ǥ��롣"))

(define (jeff-join knpc kpc)
  (say knpc "��ˤϤ��Ǥ˻Ż������롣"))

(define (jeff-job knpc kpc)
  (say knpc "���饹�ɥ��������Τ�ش����뤳�Ȥ���"))

(define (jeff-bye knpc kpc)
  (say knpc "����Ф���"))

;; Special
(define (jeff-comm knpc kpc)
  (say knpc "���ᴱ�ϥ��饹�ɥ��Ǥκǹ�̤��򿦤ǡ������Ԥ���Ԥ���"
       "���饹�ɥ��η������ƻ�λش����ˤ��롣"))

(define (jeff-mili knpc kpc)
  (say knpc "���饹�ɥ�����������ԻԤ���"
       "���Ƥλ�̱�ˤ�ʼ��ε�̳�����롣���������ΤȤ����廊��褦�����������δ��ä�����Ƥ���Τ���"))

(define (jeff-pala knpc kpc)
  (say knpc "���饹�ɥ��������ΤϤ��Υ����ɤˤ����ƺ����ޤǤ�ͥ�줿��Τ���"
       "�Ŀͤ�ǽ�ϤϤ�������������ζ������ķ��Ϥ������ޤ��Τ���"))

(define (jeff-skil knpc kpc)
  (say knpc "��������"
       "̿��Τ�ȿ�ʼ��Ʈ�Τ��ݤȤʤä��臘���饹�ɥ��������Τ��Ԥ�뤳�ȤϤʤ���"))

(define (jeff-warr knpc kpc)
  (cond ((player-found-warritrix?)
         (if (ask? knpc kpc "�Υ��ۥ�Ϥ��������Թ��ʤ��Ȥ����桹�Ϥߤ�����λ���ᤷ��Ǥ��롣"
                   "���������⤬���Ǥ����Τ������Ƚ�Ǥˤ����Ĥ�θ�꤬���ä�����ǤϤʤ���������"
                   "�����פ�̤���")
             (say knpc "�����̤��������ϲ桹����κǹ�μԤˤⵯ���ꤦ�롣�����뷳�λ�Ƴ�Ԥ⼺�Ԥ��Ȥ���ǽ�������롣"
                  "�����Ƥ����̿�˴ؤ�뤳�Ȥ������ޤ̤�����˻�����Τ�������Ф���")
             (if (ask? knpc kpc "������櫤��ä��ȤǤ���������Τ���")
                 (say knpc "�äˤʤ�̡�����������Ф褤�Τ���"
                      "�⤷����������ΤǤ���С������Ԥ˸������褤��"
                      "����������򵯤����ΤǤ���С���ʼ�����ޤ��򤳤�Į�����ɤ��Ф��Ǥ�����"
                      "�ºݤˤϺ�����Ω�����Τ��Ǥ�褤�Τ�����")
                 (say knpc "��������襤�Ǥϴְ㤤�������ꤦ�롣���ˤ�Ũ�ȸ���ä�ͧ�򻦤����Ȥ⤢�롣"
                      "����Ĥ��뤳�Ȥ��ʡ�ͧ�衣����Ф���")
                 ))
         (kern-conv-end)
         )
	 ((quest-data-assigned? 'questentry-wise)
         (say knpc "Ʈ�Ρ����λ���ǺǤ����Ѥ�¿�ͤ���Τ�������������"
              "����������ʬ���ܤ⤢���ˤ��ݤ����������ä������ݤ���Ѥ򸫤����Ȥ����롣"
              "���ߤϤ���Ǥ̳�ο����Ǥ��롣")
              (quest-data-update 'questentry-warritrix 'assignment 1)
         )
	 (else
         (say knpc "Ʈ�Ρ����λ���ǺǤ����Ѥ�¿�ͤ���Ρ���������������"
              "����������ʬ���ܤ⤢���ˤ��ݤ����������ä������ݤ���Ѥ򸫤����Ȥ����롣"
              "���ߤϷ����˽ФƤ��롣")
              (quest-data-update 'questentry-warritrix 'general-loc 1)
         )
	 ))

(define (jeff-warr-ready subfn)
	(if (quest-data-assigned? 'questentry-wise)
		(subfn)
		(jeff-default knpc kpc)
		))

(define (jeff-erra knpc kpc)
	(jeff-warr-ready (lambda ()
  (say knpc "����Ͼ����񤷤����ʴ�򤷤�����"
       "���������������������Ϣ�졢����줿��Ʋ�ظ����ä���"
       "��̯�ʤ��Ȥˤ��줫�鲿��Ϣ���ޤ��ʤ��Τ���"
       "�̾�ʤ��ܺ����Ф��Ȥ�����������Ϥ���˳䤱�����⤬���ʤ���")
      (quest-data-update-with 'questentry-rune-l 'located 1 (quest-notify nil)) 
      (quest-data-update 'questentry-warritrix 'lost-hall 1)
       )))

(define (jeff-sear knpc kpc)
	(jeff-warr-ready (lambda ()
	(say knpc "����Ϥ���Ω�ä�����Ʈ�Τ��ܺ��˳䤱������Ϥ��ʤ���"
	   "���餹�롣���˻�����Τ���")
  (kern-conv-end)
  (if (is-player-party-member? ch_ini)
      (say ch_ini "���ԤΤˤ��������롣"
           "�����õ���ͤС�"))
  )))

;; Townspeople...
(define (jeff-glas knpc kpc)
  (say knpc "���Ǥ�Į���饹�ɥ��Ͽ�ά�Ԥˤ�äƴ���뤳�ȤϤʤ��Ǥ�����"))

(define (jeff-ange knpc kpc)
  (say knpc "���󥸥���ϺǤ��鵷����������ͥ������������"))

(define (jeff-patc knpc kpc)
  (say knpc "���ӤϷи�˭���ʰ�դǡ��桹���±��α�Ĺ����"))

(define (jeff-stew knpc kpc)
  (say knpc "�����ԤΥ������ȥꥢ�Ϥ褯���νŤߤ��Ѥ��Ƥ��롣"))

(define (jeff-ini knpc kpc)
  (say knpc "�����ʥ����������ޤ�ʤ������Τǡ�ͥ�줿�δ�����"))

(define (jeff-jess knpc kpc)
  (say knpc "�����������뤤��������"
       "�����ƶ줷������������ꡢ������Τ��ڤ����褦�˸����롣"))

(define (jeff-ches knpc kpc)
  (say knpc "�桹������Ϥ򼺤äƤ��ޤä���"
       "������������Ϻ��Ǥ�桹������Ƥ���롣"))

(define (jeff-lost knpc kpc)
  (say knpc "����줿��Ʋ�ϤȤƤ���ʽ�������̿ͤιԤ��Ȥ���ǤϤʤ���"
       "�����˶�Ť��ƤϤʤ�̤����Ǥϼ��餹�롪")
  (kern-conv-end)
  (if (is-player-party-member? ch_ini)
	(begin
      (say ch_ini "�Ƥ���ʡ�����줿��Ʋ�ξ����ΤäƤ��롣"
           "����["
           (loc-x lost-halls-loc) ","
           (loc-y lost-halls-loc) "]�ޤǹҹԤ���и��Ĥ��������")
	   (quest-data-update-with 'questentry-rune-l 'know-hall 1 (quest-notify nil))
	   (quest-data-update 'questentry-warritrix 'lost-hall-loc 1)
	   )
	   )
  )

(define jeff-conv
  (ifc glasdrin-conv

       ;; basics
       (method 'default jeff-default)
       (method 'hail jeff-hail)
       (method 'bye  jeff-bye)
       (method 'job  jeff-job)
       (method 'name jeff-name)
       (method 'join jeff-join)

       (method 'comm jeff-comm)
       (method 'jeff jeff-comm)
       (method 'jani (lambda (knpc kpc) (say knpc "����亴���Υ���˥�����ѲȤȤ��Ʒפ��Τ�ʤ��ۤɽ��פǤ��롣")))
       (method 'mili jeff-mili)
       (method 'pala jeff-pala)
       (method 'warr jeff-warr)
       (method 'erra jeff-erra)
       (method 'glas jeff-glas)
       (method 'ange jeff-ange)
       (method 'lost jeff-lost)
       (method 'patc jeff-patc)
       (method 'stew jeff-stew)
       (method 'vict jeff-stew)  ;; A synonym
       (method 'ini  jeff-ini)
       (method 'inag jeff-ini)
       (method 'jess jeff-jess)
       (method 'ches jeff-ches)
       ))

(define (mk-jeffreys)
  (bind 
   (kern-mk-char 'ch_jeffreys       ; tag
                 "�����ե꡼��"     ; name
                 sp_human            ; species
                 oc_warrior          ; occ
                 s_companion_paladin ; sprite
                 faction-glasdrin         ; starting alignment
                 2 1 1               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 5  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'jeff-conv         ; conv
                 sch_jeff           ; sched
                 'townsman-ai                 ; special ai
                 nil                 ; container
                 (list t_armor_chain
                       t_chain_coif
                       t_sword
                       ))         ; readied
   (jeff-mk)))
