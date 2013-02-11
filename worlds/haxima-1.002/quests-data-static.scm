;;----------------------------------------------------
;; this is a collection place for updates to quests
;;
;; the function is an arbitary method call, but the ones here tend to
;; basically boil down to retreiving a bunch of flags from the quest payload
;; and updating the quest via (qst-set-descr! text)
;;
;; the boilerplate at the front of the methods just makes the quest data easily accessible
;; via a tbl-flag? method without needing to go through several level of redirection each time
;;

;;---------------
;; bandits
(define (quest-bandits-update)
  (println "quest-bandits-update")
  (let* ((quest (quest-data-get 'questentry-bandits))
         (quest-tbl (car (qst-payload quest)))
         (header (kern-ui-paginate-text
                  "ú�Ƥ���Ϸ�ͥ��쥴����ˡ����������Ǥ�����±"
                  "����������ߤ�������ޤ줿��"
                  "")))
    (println "quest-tbl:" quest-tbl)
    (define (tbl-flag? tag) 
      (not (null? (tbl-get quest-tbl tag)))
      )
    (qst-set-descr! quest
                    (cond ((tbl-flag? 'done)
                           (kern-ui-paginate-text
                            "�ͥ��Ȥ��Ф����������������������������"
                            ))
                          ((tbl-flag? 'nate-given-to-jailor)
                           (append header
                                   (kern-ui-paginate-text
                                    "���ƾ�������Ф���η�������Ĺ�ǥ�å����Ϥ���"
                                    "�󽷤������ä���"
                                    )))
                          ((tbl-flag? 'captured-nate-and-talked-to-deric)
                           (append header
                                   (kern-ui-paginate-text
                                    "�ͥ��Ȥ��Ф���η�̳���Ϣ��ƹԤ������ƾ�����"
                                    "��������ʤ���Фʤ�ʤ���"
                                    )))
                          ((tbl-flag? 'captured-nate)
                           (append header
                                   (kern-ui-paginate-text 
                                    "��±��Ƭ�ͥ��Ȥ���館�����Ф����Ϣ��ƹԤ���"
                                    "������Ĺ����𤷤ʤ���Фʤ�ʤ���"
                                    )))
                          ((tbl-flag? 'talked-to-deric)
                           (append header
                                   (kern-ui-paginate-text 
                                    "��������Ĺ�Υǥ�å��Ϥ��ޤ�����ˤʤ�ʤ���"
                                    "��������������������ˤ��ʤ��˲ä��褦��̿��"
                                    "������"
                                    )))
                          (else
                           (append header
                                   (kern-ui-paginate-text
                                    "���쥴�������±�Τ��Ȥ��Ф���ǿҤͤ�褦�ˤ�"
                                    "���ä���"
                                    )))
                          )

		)
	))

;;---------------
;; whereami

    (define (quest-whereami-update)
      (let* ((quest (quest-data-get 'questentry-whereami))
             (quest-tbl (car (qst-payload quest)))
             (qp-shard (tbl-get quest-tbl 'shard))
             (qp-wanderer (tbl-get quest-tbl 'wanderer)))

        (qst-set-descr! quest
                        
                        (if (not (null? (tbl-get quest-tbl 'nossifer)))

                            (kern-ui-paginate-text
                             "���ʤ��ϥ����ɤˤ��롣�����Ϲ���ʵ������⤫"
                             "�������ξ��������Ҥ��ä���"
                             ""
                             "�����Ϥˤ��ʤ���Ƴ�����Τϰ���β��Υ��ե�����"
                             "���ä�����Ͽ����θ��ݤ��������������ʬ���Ȥ�"
                             "�����ɤ˸ƤӽФ�ƻ���ۤ����ΤǤ��ä���"
                             ""
                             "����������礬�������������ƥΥ��ե�����ƻ���"
                             "��ΤϤ��ʤ���������"
                             )
                            
                            (append
                             ;;1 where
                             (cond ((null? qp-shard)
                                    (kern-ui-paginate-text
                                     "�����Ĥ��ȡ����ʤ��ϲ��ε�����ʤ����Τ����"
                                     "���ˤ����� "
                                     ""
                                     ))
                                   ((equal? 1 qp-shard)
                                    (kern-ui-paginate-text
                                     "���ʤ��ϸ��Τ�������ˤ��롣�͡��Ϥ����Ϥ򥷥�"
                                     "��ɤȸƤ�Ǥ��롣"
                                     ""
                                     ))
                                   (#t (kern-ui-paginate-text
                                        "���ʤ��ϥ����ɤˤ��롣�����Ϲ���ʵ������⤫"
                                        "�������ξ��������Ҥ��ä���"
                                        ""
                                        ))
                                   )


                             ;; how
                             (if (and (null? qp-wanderer) (null? qp-shard))
                                 (kern-ui-paginate-text "�����Ϥɤ���")
                                 nil
                                 )
                             
                             (cond ((null? qp-wanderer)
                                    (kern-ui-paginate-text
                                     "�ɤΤ褦�ˤ��ơ������Ƥʤ��������褿�Τ���"
                                     "���줫��ɤ�����Ф褤�Τ���"
                                     ))
                                   ((equal? 1 qp-wanderer)
                                    (kern-ui-paginate-text
                                     "�����ˤ⤢�ʤ��Τ褦�ˤ���������ž����������"
                                     "�������褦�����͡��Ϥ��ʤ�����¤��͡פȸƤ֤�"
                                     "������"
                                     ""
                                     "�������ʤ��Ϥ����ˤ��롣���줫��ɤ�����Ф褤"
                                     "�Τ���"
                                     ))
                                   (#t (kern-ui-paginate-text
                                        "���ʤ��Τ褦����������������ž���������¤���"
                                        "�ϡ����Ĥ��礭�ʳ����򤷤��餷����"
                                        ""
                                        "���ʤ��Ϥ����Ϥǲ��򸫤�Τ�������"
                                        ))
                                   )

                             )
                            )
                        )
	))

;;-----------------------
;; calltoarms

(define (quest-calltoarms-update)
	(let* ((quest (quest-data-get 'questentry-calltoarms))
			(quest-tbl (car (qst-payload quest)))
			(header (kern-ui-paginate-text
					"���ʤ�����ƻ�դȸƤФ��Ԥ��顢�Ǥ�������᤯"
					"�񤤤����褦�ˡ��Ȥθ��դ������ä���"
					"")))
		(define (tbl-flag? tag) (not (null? (tbl-get quest-tbl tag))))
		(qst-set-descr! quest
		
(cond ((tbl-flag? 'done)
		(kern-ui-paginate-text
			"�����ɤ��Ϥ򸫼�븭�Ԥΰ�ͤǤ�����ƻ�դζ�"
			"�Ϥ�����줿��"
		))
	((tbl-flag? 'talked)
		(append header
		(kern-ui-paginate-text
			"��ƻ�դȲ�ä������������फ��ϲ��ζ��Ϥ�����"
			"��ʤ��ä���"
		)))
	((tbl-flag? 'tower)
		(append header
		(kern-ui-paginate-text
			"�����Ӥ���ƻ�դ���ˤ��ɤ��夤����������������"
			"�Τ��񤷤�������"
		)))
	((tbl-flag? 'directions)
		(append header
		(kern-ui-paginate-text
			"��ƻ�դ���ϡ��ȥꥰ�쥤�֤��̡������ɤ�����"
			"�μ����Ӥˤ��뤽������"
		)))
	(#t
		(append header
		(kern-ui-paginate-text
			"���ɤ��夯�ޤǤ�ƻ�Τ�Ϻ��Ť�������Ƥ���Ԥ�"
			"�Ҥͤ�Ȥ褤�褦����"
		)))
)

		)
	))

;; give some xp for reaching the tower
(define (quest-calltoarms-tower kplace kplayer)
	(quest-data-update-with 'questentry-calltoarms 'tower 1 (quest-notify (grant-xp-fn 5)))
	)

;;-----------------------
;; thiefrune

;; TODO: make the theft appear not to happen until the player is on the scene, by altering convs based on quest status

(define (quest-thiefrune-update)
	(let* ((quest (quest-data-get 'questentry-thiefrune))
			(quest-tbl (car (qst-payload quest)))
			(header (kern-ui-paginate-text
					"��ƻ�դ��㤫����߽Ф����Ԥ�Ĵ������褦�ˤ���"
					"����������"
					"")))
		(define (tbl-flag? tag) (not (null? (tbl-get quest-tbl tag))))
		(qst-set-descr! quest
		
(cond ((tbl-flag? 'recovered) 
		(append header
		(kern-ui-paginate-text
			"ť�����ɤ��ͤᡢ��ƻ�դ����Ǥ����᤹���Ȥ���"
			"������"
		)))
	((tbl-flag? 'talked)
		(append header
		(kern-ui-paginate-text
			"ť���Υͥ��ߤȤϸ�ĤǤ���������"
		)))
	((tbl-flag? 'den5)
		(append header
		(kern-ui-paginate-text
			"ť���α���Ȥϥܥ�ˤ��ä����Ǹ��櫤����ˤ�"
			"����"
		)))
	((tbl-flag? 'den4)
		(append header
		(kern-ui-paginate-text
			"ť���α���Ȥϥܥ�ˤ��ä����ޤ�3�������ˤ���"
			"�˲᤮�ʤ���"
		)))
	((tbl-flag? 'den3)
		(append header
		(kern-ui-paginate-text
			"ť���α���Ȥϥܥ�ˤ��ä����ޤ�2�������ˤ���"
			"�˲᤮�ʤ���"
		)))
	((tbl-flag? 'den2)
		(append header
		(kern-ui-paginate-text
			"ť���α���Ȥϥܥ�ˤ��ä����ޤ�1�������ˤ���"
			"�˲᤮�ʤ���"
		)))
	((tbl-flag? 'den1)
		(append header
		(kern-ui-paginate-text
			"ť���α���Ȥϥܥ�ˤ��ä����������ϸǤ���"
		)))
	((tbl-flag? 'bole)
		(append header
		(kern-ui-paginate-text
			"^c+mť��^c-�Ͽ����̤ؿʤ���褦����"
			"�ܥ줬�Ǥ⤢�ꤦ�������"
		)))
	((tbl-flag? 'tower)
		(append header
		(kern-ui-paginate-text
			"^c+mť��^c-�ϻ�ƻ����˸����äƿʤ���褦����"
			"�ޤ��Ф����Ĵ�٤�Ȥ褵��������"
		)))
	(#t
		(append header
		(kern-ui-paginate-text
			"^c+mť��^c-�ϥȥꥰ�쥤�֤ؤȸ����ä��褦����"
			"Į�οͤ����������ΤäƤ��뤫�⤷��ʤ���"
		)))
)

		)
	))

;; give some xp for getting through the dungeon
(define (quest-thiefrune-den1 kplace kplayer)
	(quest-data-update 'questentry-thiefrune 'tower 1)
	(quest-data-update 'questentry-thiefrune 'bole 1)
	(quest-data-update-with 'questentry-thiefrune 'den1 1 (quest-notify (grant-party-xp-fn 10)))
	)
(define (quest-thiefrune-den2 kplace kplayer)
	(quest-data-update-with 'questentry-thiefrune 'den2 1 (quest-notify (grant-party-xp-fn 10)))
	)
(define (quest-thiefrune-den3 kplace kplayer)
	(quest-data-update-with 'questentry-thiefrune 'den3 1 (quest-notify (grant-party-xp-fn 10)))
	)
(define (quest-thiefrune-den4 kplace kplayer)
	(quest-data-update-with 'questentry-thiefrune 'den4 1 (quest-notify (grant-party-xp-fn 10)))
	)
(define (quest-thiefrune-den5 kplace kplayer)
	(quest-data-update-with 'questentry-thiefrune 'den5 1 (quest-notify (grant-party-xp-fn 10)))
	)


;;-----------------------
;; runeinfo

;; TODO: runes are unidentified until you check in with abe?

(define (quest-runeinfo-update)
	(let* ((quest (quest-data-get 'questentry-runeinfo))
			(quest-tbl (car (qst-payload quest)))
			(header (kern-ui-paginate-text
				"��ޤ줿���Ǥϡ�ť�����ä��餹��Ƚ���ʰ�̣��"
				"����褦������ƻ�դϤ��ʤ��ˤ��ΰ�̣��Ĵ������"
				"�褦��̿������"
				""
				)))
		(define (tbl-flag? tag) (not (null? (tbl-get quest-tbl tag))))
		(qst-set-descr! quest
		
(cond 
	((tbl-flag? 'done)
		(kern-ui-paginate-text
			"���ʤ��λ��äƤ������Ǥϰ������θ��ΰ�Ĥȸ�"
			"���Ƥ��롣����̤Τɤ����ˤ��뤽�����������"
			"���Ρ����Ԥˤ�ä��������졢�����̡��˱�����"
			"����"
		))
	((tbl-flag? 'gate)
		(append header
		(kern-ui-paginate-text
			"���Ǥϰ������θ��Ȥ�����Ƥ��롣����̤Τ�"
			"�����ˤ��뤽����������ϱ��Ρ����Ԥˤ�ä���"
			"�����졢�����̡��˱����줿��"
		)))
	((tbl-flag? 'keys)
		(append header
		(kern-ui-paginate-text
			"���Ǥϰ������θ��Ȥ�����Ƥ��롣����������"
			"�������̣����Τ��Ϥ狼��ʤ���"
		)))
	((tbl-flag? 'abe)
		(append header
		(kern-ui-paginate-text
			"ϣ��ѻդ�^c+m������^c-�Ȳ񤦤��Ȥ򴫤᤿������Ф���"
			"�ˤ��ơ����ǤΤ��Ȥ򸦵椷�Ƥ��롣"
		)))
	(#t
		(append header
		(kern-ui-paginate-text
			"��ϻϤ�˥��ѡ�����^c+mϣ��ѻ�^c-�˲񤦤Ȥ褤����"
			"����ʤ��ȸ��ä���"
		)))
)

		)
	))


;;-----------------------
;; dragon blood

(define (quest-dragon-update quest)
	(let* ((quest-tbl (car (qst-payload quest)))
			(header (kern-ui-paginate-text
				"ϣ��ѻդ�ε�η����äƤ���и򴹤����ǤΤ���"
				"���򶵤���ȸ��ä���"
				)))
		(define (tbl-flag? tag) (not (null? (tbl-get quest-tbl tag))))
		(qst-set-descr! quest
		
(cond 
	((tbl-flag? 'done)
		(kern-ui-paginate-text
			"ε�η�ȸ򴹤�ϣ��ѻդ������ǤΤ��꤫��ʹ��"
			"����"
		))
	((in-inventory? (car (kern-party-get-members (kern-get-player))) t_dragons_blood 1)
		(append header
		(kern-ui-paginate-text
			""
			"1�ӥ��ε�η줬������ä���"
		)))
	((tbl-flag? 'sea)
		(append header
		(kern-ui-paginate-text
			""
			"��ϲФγ���õ���Τ��Ǥ�褤�Ǥ����ȸ��ä���"
		)))
	(#t
		header
		)
)

		)
	))

;;-----------------------
;; deeps rune

(define (quest-rune-p-update)
	(let* ((quest (quest-data-get 'questentry-rune-p))
			(quest-tbl (car (qst-payload quest))))
		(define (tbl-flag? tag) (not (null? (tbl-get quest-tbl tag))))
		(qst-set-descr! quest
		
(cond 
	((tbl-flag? 'done)
		(kern-ui-paginate-text
			"���Ǥϥ���ݥꥹ�α������ˤ��ä���"
		))
	(#t
		(kern-ui-paginate-text
			"ϣ��ѻդ��饯��ݥꥹ�α������줿���Ǥ��ä�"
			"ʹ������"
			""
			"�������Τϥ���ݥꥹ���ϲ��ˤ����Ĥ��κ֤��ۤ�"
			"�Ƥ��롣���Ǥΰ�Ĥ��Ǥ⿼���֤�����Ƥ����"
			"������"
			""
			"�֤Ĥ�Ϥ��ȥ���٥뤬����з���Ф��������"
			"����������ʤΤϷ����դ��ޤȤ����ͤ�������Τ�"
			"���뤳�Ȥ�����"
		))
)

		)
	))
	
	
;;-----------------------
;; spider rune

(define (quest-rune-f-update)
	(let* ((quest (quest-data-get 'questentry-rune-f))
			(quest-tbl (car (qst-payload quest))))
		(define (tbl-flag? tag) (not (null? (tbl-get quest-tbl tag))))
		(qst-set-descr! quest
		
(cond 
	((tbl-flag? 'done)
		(kern-ui-paginate-text
			"�����ӥ����μ���줿���Ǥ򥯥�ν������󥰥�"
			"�����������줿��"
		))
	((and (tbl-flag? 'angrisslair) (tbl-flag? 'angriss))
		(kern-ui-paginate-text
			"�����ӥ����Ϥ��Ĥ����Ǥ���äƤ�������������"
			"��ϥ��֥������ΤȤ�����줿��"
			""
			"���֥�󤿤����äˤ�ꥢ�󥰥ꥹ�ν��߲Ȥ�Ƴ��"
			"�줿�����ǤϤ����ˤ��ꤽ������"
		))
	((tbl-flag? 'angriss)
		(kern-ui-paginate-text
			"�����ӥ����Ϥ��Ĥ����Ǥ���äƤ�������������"
			"��ϥ��֥������ΤȤ�����줿��"
			""
			"���֥��Υ��ޤ��餽�ξ��μ꤬�����������"
			"����(����?)���������λ�̮���ܤ����ˤ���"
			"��������"
		))
	((tbl-flag? 'kama)
		(kern-ui-paginate-text
			"�����ӥ����Ϥ��Ĥ����Ǥ���äƤ�������������"
			"��ϥ��֥������ΤȤ�����줿��"
			""
			"���֥�󤿤������ι������ΤäƤ���褦�����⤷"
			"���֥��Υ��ޤ򸫤Ĥ��뤳�Ȥ��Ǥ���С�������"
			"�ʤ������"
		))
	((tbl-flag? 'gen)
		(kern-ui-paginate-text
			"�����ӥ����Ϥ��Ĥ����Ǥ���äƤ�������������"
			"��ϥ��֥������ΤȤ�����줿��"
			""
			"���֥�󤿤������ι������ΤäƤ���褦�����ʹ�"
			"����ǤϷ�������Υ����󤬰��֤褯�ΤäƤ�����"
			"����"
		))
	(#t
		(kern-ui-paginate-text
			"�����ӥ����Ϥ��Ĥ����Ǥ���äƤ�������������"
			"��ϥ��֥������ΤȤ�����줿��"
			""
			"���֥�󤿤������ι������ΤäƤ���褦��������"
			"�ɤ�ʹ���Ф��Ф�����"
		))
)

		)
	))
	
(define (quest-rune-f-lair kplace kplayer)
	(if (not (null? (quest-data-getvalue 'questentry-rune-f 'angriss)))
		(quest-data-update-with 'questentry-rune-f 'angrisslair 1 (quest-notify nil))
	))

;;-----------------------
;; void rune

;; todo add more sections? info on voidships, etc?

(define (quest-rune-d-update)
	(let* ((quest (quest-data-get 'questentry-rune-d))
			(quest-tbl (car (qst-payload quest))))
		(define (tbl-flag? tag) (not (null? (tbl-get quest-tbl tag))))
		(qst-set-descr! quest
		
(cond 
	((tbl-flag? 'done)
		(kern-ui-paginate-text
			"�����λ��������Ǥ������줿��"
		))
	(#t
		(kern-ui-paginate-text
			"���������Ǥϵ�������˻��������ꡢ���������Ǥ�"
			"�������Ƥ��뤽������"
		))
)

		)
	))

;;-----------------------
;; pirate rune

(define (quest-rune-c-update)
	(let* ((quest (quest-data-get 'questentry-rune-c))
			(quest-tbl (car (qst-payload quest))))
		(define (tbl-flag? tag) (not (null? (tbl-get quest-tbl tag))))
		(qst-set-descr! quest
		
(cond 
	((tbl-flag? 'done)
		(kern-ui-paginate-text
			"���Ǥ�����夲��줿���ῼ��������Ǽ������"
			"����"
		))
	((tbl-flag? 'shiploc)
		(append
			(kern-ui-paginate-text
			"��±��Ƭ�����ƥ����Ϥ��Ĥ����Ǥ���äƤ�����"
			""
			)
			(kern-ui-paginate-text (string-append "�����ͩ������ξ��[" (number->string merciful-death-x) "," (number->string merciful-death-y) "]������������"))
			(if (tbl-flag? 'shipraise)
				(kern-ui-paginate-text
				""
				"���ϡ��ޥ�ɥ쥤��������ݡ�����������λ��Ĵ"
				"�礷������������������������<Vas Uus Ylem>�μ�"
				"ʸ��Ȥ��а����夲���롣"
				)
				nil
			)
		))
	((tbl-flag? 'info)
		(kern-ui-paginate-text
			"��±��Ƭ�����ƥ����Ϥ��Ĥ����Ǥ���äƤ�����"
			""
			"���ϥ��ѡ�����ͩ��ȤʤäƼ겼��^c+m����^c-�Τ���õ"
			"���Ƥ��롣"
		))
	(#t
		(kern-ui-paginate-text
			"��±��Ƭ�����ƥ����Ϥ��Ĥ����Ǥ���äƤ�����"
		))
)

		)
	))

;;-----------------------
;; pirate quest

(define (quest-ghertie-update)
	(let* ((quest (quest-data-get 'questentry-ghertie))
			(quest-tbl (car (qst-payload quest))))
		(define (tbl-flag? tag) (not (null? (tbl-get quest-tbl tag))))
		(qst-set-descr! quest
		
(cond 
	((tbl-flag? 'done)
		(kern-ui-paginate-text
			"���ĤƳ�±�����ƥ�����ͩ����ѡ����νɤˤ�"
			"��������������Ȱ��������ˡ���������ξ�����"
			(string-append "�뤳�Ȥ��Ǥ����������[" (number->string merciful-death-x) "," (number->string merciful-death-y) "]�ˤ��롣")
		))
	((tbl-flag? 'questinfo)
		(append
			(kern-ui-paginate-text
				"��±�����ƥ�����ͩ����ѡ����νɤˤ��롣��"
				"���������Τ��Ἣʬ��΢�ڤä��겼�������Ĥ��õ"
				"���Ƥ��롣"
				""
				"����åȡ����硼�󡢤����ƥߡ��ˡ��ϥ����ƥ���"
				"�μ겼�ξڤǤ�����ؤ�ȤˤĤ��Ƥ��롣�����ƥ�"
				"���������ݤ����ڵ�Ȥ��ƻ��ؤ������ꡢ����"
				"�ȸ򴹤���������ξ��򶵤���ȸ��ä���"
			)
			(if (and (tbl-flag? 'ring-jorn)
						(tbl-flag? 'ring-meaney)
						(tbl-flag? 'ring-gholet))
				(kern-ui-paginate-text
					""
					"�ɥ���λ��ؤ����Ƽ�����줿��"
				)
				(append
					(cond 
						((tbl-flag? 'ring-gholet)
							(kern-ui-paginate-text
								""
								"����åȤΥɥ���λ��ؤ������줿��"
							))
						((tbl-flag? 'gholet-price)
							(kern-ui-paginate-text
								""
								"����åȤϥ��饹�ɥ����ϲ�ϴ�������Ƥ�"
								"�롣���1�������θ�����ƻ��Ȼ��ؤ�򴹤����"
								"���ä���"
							))
						((tbl-flag? 'gholet-dungeon)
							(kern-ui-paginate-text
								""
								"����åȤϥ��饹�ɥ����ϲ�ϴ�������Ƥ�"
								"�롣"
							))
						((tbl-flag? 'gholet-prison)
							(kern-ui-paginate-text
								""
								"����åȤϤ⤷�����Ƥ���Фɤ�����ϴ���ˤ����"
								"����"
							))
						(#t nil)
					)
					(cond 
						((tbl-flag? 'ring-jorn)
							(kern-ui-paginate-text
								""
								"���硼��Υɥ���λ��ؤ������줿��"
							))
						((tbl-flag? 'jorn-loc)
							(kern-ui-paginate-text
								""
								"���硼����Ф�����򤭲�����ˤ��롣"
							))
						((tbl-flag? 'jorn-forest)
							(kern-ui-paginate-text
								""
								"���硼��Ϲ���ʿ��Τɤ�������±���äƤ��롣"
							))
						(#t nil)
					)
					(cond 
						((tbl-flag? 'ring-meaney)
							(kern-ui-paginate-text
								""
								"�ߡ��ˡ��Υɥ���λ��ؤ������줿��"
							))
						((tbl-flag? 'meaney-loc)
							(kern-ui-paginate-text
								""
								"�ߡ��ˡ��ϥ��ѡ������̤ˤ�����ϱ���Ư���Ƥ�"
								"�롣"
							))
						(#t nil)
					)
				)
			)
		))
	(#t
		(kern-ui-paginate-text
			(string-append(if (tbl-flag? 'ghertieid)
					"��±�����ƥ�����ͩ��"
					"ͩ��")
				(if (tbl-flag? 'ghertieloc)
					"�����ѡ����νɤˤ��롣"
					"�����ѡ����ˤ��롣")
			)
			(if (tbl-flag? 'revenge)
				"�����^c+m����^c-��˾��Ǥ��롣�����������С������\n���ʤ��˶��Ϥ��뤫�⤷��ʤ���"
				(string-append "�ʤ�"
					(if (tbl-flag? 'ghertieid) "���" "����")
					"�ϻ��Ǥ⤽���˵�¤äƤ���Τ���"
				)
			)
		))
)

		)
	))


;;------------------------------------------------------------------------ 
;; Warritrix rune
;; 

(define (quest-rune-l-update)
	(let* ((quest (quest-data-get 'questentry-rune-l))
			(quest-tbl (car (qst-payload quest))))
		(define (tbl-flag? tag) (not (null? (tbl-get quest-tbl tag))))
		(qst-set-descr! quest
		
(cond 
	((tbl-flag? 'done)
		(kern-ui-paginate-text
			"���Ǥ�Ʈ�Τ�˴�������äƤ�����"
		))
	((and (tbl-flag? 'located) (tbl-flag? 'know-hall))
		(kern-ui-paginate-text
			"���Ǥΰ�Ĥ�Ʈ�Τ������⤤�Ƥ��롣"
			"����ϥ����ɤ���ߤˤ��뼺��줿��Ʋ�Ǹ���"
			"���������"
			(string-append
			"�����[" 
			(number->string (loc-x lost-halls-loc)) "," (number->string (loc-y lost-halls-loc))
			"]�ˤ��롣"
			)
		))
	((and (tbl-flag? 'located) (tbl-flag? 'approx-hall))
		(kern-ui-paginate-text
			"���Ǥΰ�Ĥ�Ʈ�Τ������⤤�Ƥ��롣"
			"����ϥ����ɤ���ߤˤ��뼺��줿��Ʋ�Ǹ���"
			"���������"
		))
	((tbl-flag? 'located)
		(kern-ui-paginate-text
			"���Ǥΰ�Ĥ�Ʈ�Τ������⤤�Ƥ��롣"
			"����ϼ���줿��Ʋ�Ǹ��Ĥ��������"
		))
	(#t
		(kern-ui-paginate-text
			"���Ǥΰ�Ĥ�Ʈ�Τ������⤤�Ƥ��롣"
		))
)		

		)
	))

;;-----------------------
;; absalot rune

(define (quest-rune-s-update)
	(let* ((quest (quest-data-get 'questentry-rune-s))
			(quest-tbl (car (qst-payload quest))))
		(define (tbl-flag? tag) (not (null? (tbl-get quest-tbl tag))))
		(qst-set-descr! quest
		
(cond 
	((tbl-flag? 'done)
		(kern-ui-paginate-text
			"���֥���åȤΰ��פ����Ǥ򸫤Ĥ�����"
		))
	((tbl-flag? 'silasinfo)
		(kern-ui-paginate-text
			"�����饹�ϥ��֥���åȤΰ��פ����Ǥ򱣤��Ƥ�"
			"�롣"
		))
	(#t
		(kern-ui-paginate-text
			"���Ǥϥ��֥���åȤΤɤ����ˤ��������"
		))
)

		)
	))

;;-----------------------
;; enchanter rune
;; tracks if the player has gotten the rune back from the enchanter

(define (quest-rune-k-update)
	(let* ((quest (quest-data-get 'questentry-rune-k))
			(quest-tbl (car (qst-payload quest))))
		(define (tbl-flag? tag) (not (null? (tbl-get quest-tbl tag))))
		(qst-set-descr! quest
		
(cond 
	((tbl-flag? 'entrusted-with-rune)
		(kern-ui-paginate-text
			"��ƻ�դϤ��ʤ����μ������Ǥ��¤�����"
		))
	((tbl-flag? 'player-got-rune)
		(kern-ui-paginate-text
			"�μ������Ǥ���ƻ�դΤ�Τ��������Ϥ��ʤ��μ��"
			"��ˤ��롣"
		))
	((tbl-flag? 'ench-should-have-rune)
		(kern-ui-paginate-text
			"�μ������Ǥ���ƻ�դΤ�Τ�����������᤻����"
			"ƻ�դο���������������"
		))
	(#t
		(kern-ui-paginate-text
			"�μ������Ǥ���ƻ�դΤ�Τ���"
		))
)

		)
	))

	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Search for the Wise quest group

(define (quest-wise-init)
	(quest-data-assign-once 'questentry-wise)
	(map (lambda (tag)
		 (if (not (null? (quest-data-getvalue tag 'name)))
			(quest-data-assign-once tag)
		))
		(list 'questentry-enchanter 'questentry-warritrix  'questentry-alchemist
						'questentry-the-man 'questentry-engineer  'questentry-necromancer)
	))

(define (quest-wise-subinit tag)
	(quest-data-update tag 'name 1)
	(if (quest-data-assigned? 'questentry-wise)
		(quest-data-assign-once tag)
	)
	)

;; TODO- merge lost hall location info with rune quest	
(define (quest-warritrix-update)
	(let* ((quest (quest-data-get 'questentry-warritrix))
			(quest-tbl (car (qst-payload quest))))
		(define (tbl-flag? tag) (not (null? (tbl-get quest-tbl tag))))
		(qst-set-descr! quest
		
(cond
	((tbl-flag? 'avenged)
		(kern-ui-paginate-text
			"Ʈ�ΤϤ��λ���ǺǤ����Ѥ���Τ��ä�����������"
			"���ϼ���줿��Ʋ���Ԥ������ˤ���������Ƥ�����"
			""
			"�����΢�ڤä��Ԥ������β��˺ۤ��줿��"
		))
	((tbl-flag? 'found)
		(kern-ui-paginate-text
			"Ʈ�ΤϤ��λ���ǺǤ����Ѥ���Τ��ä�����������"
			"���ϼ���줿��Ʋ���Ԥ������ˤ���������Ƥ�����"
		))
	((tbl-flag? 'slain)
		(cond
			((tbl-flag? 'lost-hall-loc)
				(kern-ui-paginate-text
					"Ʈ�ΤϤ��λ���ǺǤ����Ѥ���Τ��ä�����������"
					"���κ��Ϻ��ϵ�������ˤ��롣"
					""
					"�����˴���Ϥ��ޤ�����줿��Ʋ�ˤ��롣"
					(string-append
					"�����["
					(number->string (loc-x lost-halls-loc)) "," (number->string (loc-y lost-halls-loc))
					"]�ˤ��롣"
					)
				))
			((tbl-flag? 'lost-hall)
				(kern-ui-paginate-text
					"Ʈ�ΤϤ��λ���ǺǤ����Ѥ���Τ��ä�����������"
					"���κ��Ϻ��ϵ�������ˤ��롣"
					""
					"�����˴���Ϥ��ޤ�����줿��Ʋ�ˤ��롣"
				))
			(#t
				(kern-ui-paginate-text
					"Ʈ�ΤϤ��λ���ǺǤ����Ѥ���Τ��ä�����������"
					"���κ��Ϻ��ϵ�������ˤ��롣"
					""
					"�����Ƥ����Ȥ��ϥ��饹�ɥ���Į�˻Ť��Ƥ�����"
				))
		))
	((tbl-flag? 'lost-hall-loc)
		(kern-ui-paginate-text
			"Ʈ�ΤϤ��λ���ǺǤ����Ѥ���Τ������Ϻ���Ǽ�"
			"��줿��Ʋ�˱������Ƥ��롣"
			(string-append
			"�����["
			(number->string (loc-x lost-halls-loc)) "," (number->string (loc-y lost-halls-loc))
			"]�ˤ��롣"
			)
		))
	((tbl-flag? 'lost-hall)
		(kern-ui-paginate-text
			"Ʈ�ΤϤ��λ���ǺǤ����Ѥ���Τ������Ϻ���Ǽ�"
			"��줿��Ʋ�˱������Ƥ��롣"
		))
	((tbl-flag? 'assignment)
		(kern-ui-paginate-text
			"Ʈ�ΤϤ��λ���ǺǤ����Ѥ���Τ������Ϻ���ǥ�"
			"�饹�ɥ���Υ��Ƥ��롣"
		))
	((tbl-flag? 'general-loc)
		(kern-ui-paginate-text
			"Ʈ�ΤϤ��λ���ǺǤ����Ѥ���Τ�����������ʤ�"
			"���饹�ɥ��ˤ��롣"
		))
	((tbl-flag? 'common)
		(kern-ui-paginate-text
			"Ʈ�ΤϤ��λ���ǺǤ����Ѥ���Τ���"
		))
	(#t
		(kern-ui-paginate-text
			"Ʈ�Τϸ��Ԥΰ�ͤ���"
		))
)

		)
	))
