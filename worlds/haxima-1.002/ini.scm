;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ���饹�ɥ��
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_ini
               (list 0  0  gi-bed      "sleeping")
               (list 5  0  gs-altar    "idle")
               (list 6  0  gc-train    "working")
               (list 12 0  ghg-s2      "eating")
               (list 13 0  gc-hall     "working")
               (list 18 0  ghg-s2      "eating")
               (list 19 0  ghg-hall    "idle")
               (list 21 0  gi-bed      "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (ini-mk) (list 'townsman #f))
(define (ini-will-join? ini) (cadr ini))
(define (ini-will-join! ini) (set-car! (cdr ini) #t))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ���ˤ��������������Τǡ����饹�ɥ��˽���Ǥ��롣
;; ���Ʈ�Τιͤ�����¤ǡ�����ΰŻ����Ƥ����Ԥ��Ф����ܤ�򴶤��Ƥ��롣
;; ���ˤ���֤ˤʤ롣
;;----------------------------------------------------------------------------

;; Basics...
(define (ini-hail knpc kpc)
  (say knpc "�Τ��ʤ���ͫݵ�����������ΤȲ�ä����Ϥ䤢��"))

(define (ini-default knpc kpc)
  (say knpc "�狼��̡�"))

(define (ini-notyet knpc kpc)
  (say knpc "���̿ͤˤϤ��Τ��Ȥ��ä��٤��Ǥʤ��ȹͤ��Ƥ��롣"))

(define (ini-name knpc kpc)
  (say knpc "�����ʥ������������ϥ��ˤȸƤ�Ǥ��롣"))

(define (ini-join knpc kpc)
  (if (is-player-party-member? knpc)
      (say knpc "���Ǥ���֤��������Ԥ�����")
      (let ((ini (kobj-gob-data knpc)))
        (if (ini-will-join? ini)
            (begin
              (say knpc "���꤬�Ȥ����Τ�Ӥꤷ�Ƥ�����֤Ϥʤ���Ʈ�Τ�õ���Ф�����")
              (kern-conv-end)
              (join-player knpc))
            (say knpc "�Τ���©�������Τ�Ǥ̳������Τ���")
            ))))
        
(define (ini-lost knpc kpc)
   (let ((ini (kobj-gob-data knpc)))
     (if (ini-will-join? ini)
			(begin
  			(say knpc "����줿��Ʋ��������������Ϥ뤫�󤯤�ƶ������"
  				"����["
           (loc-x lost-halls-loc) ","
           (loc-y lost-halls-loc) "]�ޤǹҹԤ���и��Ĥ��������")
			(quest-data-update-with 'questentry-rune-l 'know-hall 1 (quest-notify nil))
			(quest-data-update 'questentry-warritrix 'lost-hall-loc 1)
			)
  			(say knpc "����줿��Ʋ�ϤȤƤ���ʾ�������Ť��ʤ��ۤ���������"))))
     		
(define (ini-cave knpc kpc)
   (let ((ini (kobj-gob-data knpc)))
     (if (ini-will-join? ini)
     		(begin
     			(say knpc "����줿��Ʋ�Ϥ��켫�Τ�����ƶ������ˤ��롣")
     			(say knpc (if (is-player-party-member? knpc) "" "") "ƶ�����̤ˤ����糬�ʤ򸫤Ĥ��ʤ���Фʤ�ʤ�������")
     			(say knpc "�µܤν��ͤˤϵ���Ĥ��ʤ���Фʤ�ʤ���")
     			)
     		(ini-notyet knpc kpc))))
     		
(define (ini-inha knpc kpc)
   (let ((ini (kobj-gob-data knpc)))
     (if (ini-will-join? ini)
     		(begin
     			(say knpc "��������ͤ�ȥ��ν��Ĥ����������뤿�Ӥˡ��桹�Ϥ�������ݤ��褦�Ȥ��Ƥ�����")
     			(say knpc (if (is-player-party-member? knpc) "" "") "Ĺ���줷���襤��������٤�������")
     			)
     		(ini-notyet knpc kpc))))

(define (ini-stair knpc kpc)
   (let ((ini (kobj-gob-data knpc)))
     (if (ini-will-join? ini)
     		(begin
     			(say knpc "�̤Τɤ����˳��ʤ����뤳�Ȥ��ΤäƤ��롣�������󤯤��鸫�������ʤΤǡ����Τʰ��֤Ϥ狼��ʤ���")
     			)
     		(ini-notyet knpc kpc))))
     			
(define (ini-job knpc kpc)
  (say knpc "�����Τ������������ޤꤳ�λŻ��������ǤϤʤ���"))

(define (ini-bye knpc kpc)
  (say knpc "����Ф���"))

(define (ini-warr knpc kpc)
  (cond ((player-stewardess-trial-done?)
                (say knpc "�����ϲ̤����줿������ä�����λ���ᤷ�ळ�Ȥ��Ǥ��롣" ))
	((player-found-warritrix?)
                (if (ask? knpc kpc "�����Ԥ��Ϥ�����������������������̤�ƻ�����롣���Ť�ƻ������ƻ����ʹ����������")
                    (say knpc "���饹�ɥ�����������������롣"
                         "������������ǤƤФ���Į�ǺǤ�Ť������ƤӽФ����Ȥ��Ǥ��롣�����ƺۤ����Ϥޤ�Τ���"
                         "�����������Ԥ��й��Ǥ�������ξڵ�ʤ����ǤäƤϤʤ�ʤ����ڵ򤬤ʤ��Ƥ�����˲桹���ۤ���������")
                    (say knpc "�����Ԥ򤳤Τޤޤˤ��ƤϤ����ʤ���ï����������ʤ���Фʤ�ʤ���")))
	((quest-data-assigned? 'questentry-wise)
		 (say knpc "����Ͼ����ضڤ򿭤Ф������ϲ��������������Τ���"
		      "Ʈ�ΤϤ��ä����˲�����鷺�˹ԤäƤ��ޤä���"
		      "���ᴱ�Ϻ������ܺ��������٤�����������ϲ��⤻�����̤�����˵������Ƥ��롣"
		      "����ͽ�������롣���ʤ��������õ���Ƥ���Τ���")
		 (if (kern-conv-get-yes-no? kpc)
		     (begin
		       (say knpc "������֤˲ä����ߤ�����"
		            "��ʥ�Τ��ȤϤ褯�ΤäƤ��롣��Ϥ���Ǥ̳�˽����Ƥ���Τ���"
		            "������ष�Ƥ����դ�̤����̸¤ꡢ����ʳ���̿��˽����Ĥ��Ϥʤ���")
		       (ini-will-join! (kobj-gob-data knpc)))
		     (say knpc "ï���������Ԥ��٤����������ˤ���Ԥϳ�������礭�ʼڤ꤬���롣")))
	(else
		(say knpc "Ʈ�Τ˲񤤤����Τ���")
		(if (kern-conv-get-yes-no? kpc)
			(begin
				(say knpc "����˲񤦤ΤϺ���������Ϸ����˽ФƤ���Τ��Ȼפ���")
				(say knpc "�⤷���ʤ����ޤ����������ΤǤ���С��������äƤ������Τ餻�褦��")
			)
		))
	))

;; Paladin...
(define (ini-pala knpc kpc)
  (say knpc "��Ϥ��λŻ���̿�򤫤��Ƥ�������������ɤ������ΤǤϤʤ���"
       "�襤���٤˵�ʬ�������ʤ�Τ��������ΤȤ���α�ޤ�褦�˸����뤬��"
       "������Ȥʤ���Ω�������ߤ�������Ǥ�����"
       "�����켭���Ǥ�������¾�˲����Ǥ����������"))

(define (ini-quit knpc kpc)
  (say knpc "�Ǥ��������������褦�ˤ��Ƥ��롣���򤷤��顢�ȥꥰ�쥤�֤ζ᤯�����Ϥ��㤤��������Υ��褦�ȻפäƤ��롣"
       "���Τ褦�ʤ��ȤФ���ͤ��Ƥ��롣Ĺ���Կʤ�ʤ����Ф�����餱�ο��ðŤʿ�ʥ��̲�뤳�Ȥ�ʤ���"
       "�������֤���ʪ�˿������ܤ��Ф�뤳�Ȥ�ʤ���"))

;; Townspeople...
(define (ini-glas knpc kpc)
  (say knpc "ͫݵ�ʽ���������פ�̤���")
  (kern-conv-get-yes-no? kpc)
  (say knpc "�Ф���عԤ����򸫤Ƥ������Ȥ��Ĥ�ͤ��Ƥ��롣"))

(define (ini-ange knpc kpc)
  (say knpc "���ޤ���ʤ���������ƶ�����֥���û�����ͤ��ɤ��Τ���٤����������Ȥ����롣"))

(define (ini-spit knpc kpc)
  (say knpc "�֤Ǥ��̾�����������Ʊ��������ä���"
       "ƶ�����֥��Ȥ��襤�ǳھ��ȻפäƤ����Ȥ������줿��ͤ��鶦�˿ɤ�����������Ӥ���"
       "���ΤȤ��ϴ�ʤ��ä���"))

(define (ini-patc knpc kpc)
  (say knpc "���̿�β��ͤ���"))

(define (ini-life knpc kpc)
  (say knpc "��ϰ��ٻ����줿�褦�ʤ�Τ�����ʥ��������Ƥ����Ȥ��Τ��Ȥ���"
       "�桹�ΰ�դ򻦤�����ε��Τ����⤫�����������Ĥ��줭�äƤ�����"
       "���ΤȤ���̲��Υȥ��ν��Ĥ�����¤�����Ǥ��ޤä��Τ���")
  (prompt-for-key)
  (say knpc "���Ϥ������ܳФ᤿��"
       "���̿��������ä����������Ĥ����±��Ǵ��������򸫾夲�Ƥ�����"
       "�����¾�������Ĥä��ԤϤ��ʤ���"))

(define ini-conv
  (ifc glasdrin-conv

       ;; basics
       (method 'default ini-default)
       (method 'hail ini-hail)
       (method 'bye  ini-bye)
       (method 'job  ini-job)
       (method 'name ini-name)
       (method 'join ini-join)

       (method 'warr ini-warr)
       (method 'pala ini-pala)
       (method 'quit ini-quit)
       (method 'glas ini-glas)
       (method 'ange ini-ange)
       (method 'spit ini-spit)
       (method 'dagg ini-spit)
       (method 'patc ini-patc)
       (method 'life ini-life)
       
       (method 'lost ini-lost)
       (method 'hall ini-lost)
       (method 'cave ini-cave)
       (method 'entr ini-cave)
       (method 'stai ini-stair)
       (method 'nort ini-stair)
       ;(method 'deep ini-stair)
       (method 'deep ini-lost)
       (method 'grea ini-stair)
       (method 'inha ini-inha)
       (method 'bewa ini-inha)
       (method 'dung ini-inha)
       
       ))
       
(define (mk-ini)
  (bind 
   (kern-mk-char 'ch_ini           ; tag
                 "����"            ; name
                 sp_human            ; species
                 oc_warrior          ; occ
                 s_companion_paladin ; sprite
                 faction-glasdrin         ; starting alignment
                 5 0 5               ; str/int/dex
                  pc-hp-off  ; hp bonus
                  pc-hp-gain ; hp per-level bonus
                  0 ; mp off
                  0 ; mp gain
                 max-health -1 max-health 0 3  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'ini-conv         ; conv
                 sch_ini           ; sched
                 'townsman-ai                 ; special ai
                 nil                 ; container
                 (list t_armor_chain
                       t_chain_coif
                       t_halberd
                       ))         ; readied
   (ini-mk)))
