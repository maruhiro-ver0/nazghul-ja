;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Quest Data Table
;;
;; The basic quest data mechanism is based on a tbl of quest information. This allows quests
;; to be created once, then tracked and updated from a central repository.
;; While not suitable for quests generated on the fly, this is a lot more convenient for
;; complex plot based quests. On the fly quests can still interface directly with the
;; quest-sys module.
;;
;; The questadd function here handles creation of quests (it also makes sure the quest is
;; created iff it is needed, so savegames have some chance of updating right)
;;
;; It is inside a let definition, and hence wont work elsewhere. The quest to be added is
;; a quest using qst-mk from the quest-sys module
;;
;; (questadd (qst-mk
;;    "Name of Quest"
;;    'tag-to-refer-to-quest
;;    "Text description of quest, probably using kern-ui-paginate-text"
;;    'function-called-on-quest-assignment  ;; probably 'quest-assign-notify, or nil
;;    'function-called-before-quest-is-displayed  ;; probably nil
;;    'sprite-for-quest
;;    quest-payload
;;	)
;;
;; The various quest-data-* methods assume that quest-payload is a tbl, containing various
;; info possibly including:
;;
;; 		'on-update  a method name that will be called in response to a quest-data-update call
;;		'bonus-xp   a storage space for experience rewards that are accrued before the player
;;					knows about the quest (the xp will increase the rewards given once the
;;					the player knows why they are being given xp)
;;
;;
;; Using quests basically boils down to:
;;      defining the quest here
;;      adding a (quest-data-assign-once 'tag-to-refer-to-quest) at the relevent place in the game code
;;      adding a (quest-data-complete 'tag-to-refer-to-quest)
;;                                   at the relevent place in the game code
;;		
;;		for nicely updating quest information, add the on-update method as described above, and sprinkle
;;      the plot with
;;          (quest-data-update 'tag-to-refer-to-quest 'name-of-quest-flag value-to-set-tag-to)
;;             and
;;          (quest-data-update-with 'tag-to-refer-to-quest 'name-of-quest-flag value-to-set-tag-to
;;                  function-to-perform-if-the-tag-wasnt-already-set-that-way)
;;      a common example of the latter would be giving the party an xp reward:
;;          (quest-data-update-with 'tag-to-refer-to-quest 'name-of-quest-flag value-to-set-tag-to
;;                  (grant-party-xp-fn amount-of-xp-to-share-out))
;;
;;

(let*
	(
		(newtbl (tbl-mk))
		(oldtbl (tbl-get (gob (kern-get-player)) 'questdata))
		(questdata (if (null? oldtbl)
						(begin 
							(tbl-set! (gob (kern-get-player)) 'questdata newtbl)
							newtbl
						)
						oldtbl))
		(questadd (lambda (quest)
			(if (null? (tbl-get questdata (qst-tag quest)))
				(tbl-set! questdata (qst-tag quest) quest)
			)))
	)
	
(questadd (qst-mk 
	"���ʤ����Ȥκ���"
	'questentry-charcreate
	(kern-ui-paginate-text
		"�������̤ˤ�������򤯤�����������Ϥޤ롣 "
		""
		"����Ǥ��ʤ���̾�������Ϥ��롣�����ä��������"
		"ǽ�Ϥ�Ĵ�����뤳�Ȥ�Ǥ��롣 "
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_quest_start
	0
))

(questadd (qst-mk "�����Ϥɤ���"
	'questentry-whereami
	(kern-ui-paginate-text
		"�����Ĥ��ȡ����ʤ��ϲ��ε�����ʤ����Τ����"
		"���ˤ����� "
		""
		"�����Ϥɤ��ʤΤ��� "
		"�ɤΤ褦�ˡ������Ƥʤ��������褿�Τ��� "
		"���򤹤٤��ʤΤ��� "
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_quest_start
	(tbl-build
		'on-update 'quest-whereami-update
		)
	;; 'shard- pc knows about shard(1), cosmology(2)
	;; 'wanderer- pc knows about wanderers(1), potential(2)
	;; 'nossifer- pc knows about N's summoning(3)
))

(questadd (qst-mk "��ƻ�դξ��Ծ�"
	'questentry-calltoarms
	(kern-ui-paginate-text
		"���ʤ�����ƻ�դȸƤФ��Ԥ��顢�Ǥ�������᤯"
		"�񤤤����褦�ˡ��Ȥθ��դ������ä���"
		""
		"���ɤ��夯�ޤǤ�ƻ�Τ�Ϻ��Ť�������Ƥ���Ԥ�"
		"�Ҥͤ�Ȥ褤�褦����"
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_enchanter
	(tbl-build
		'on-update 'quest-calltoarms-update
		'bonus-xp 0
		)
	;; 'directions- pc has directions to tower
	;; 'tower- pc has reached tower
	;; 'talked- pc has talked to the enchanter
	;; 'done- pc has been enlisted
))
	
(questadd (qst-mk "ť�����ɤ�"
	'questentry-thiefrune
	(kern-ui-paginate-text
		"��ƻ�դ��㤫����߽Ф����Ԥ�Ĵ������褦�ˤ���"
		"����������"
		""
		"^c+mť��^c-�ϥȥꥰ�쥤�֤ؤȸ����ä��褦����"
		"Į�οͤ����������ΤäƤ��뤫�⤷��ʤ���"
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_brigand
	(tbl-build
		'on-update 'quest-thiefrune-update
		'bonus-xp 0
		)
	;; '
	;; 'tower- pc has reached tower
	;; 'talked- pc has talked to the enchanter
	;; 'done- pc has been enlisted
))

(questadd (qst-mk "���Ǥ���̩"
	'questentry-runeinfo
	(kern-ui-paginate-text
		"��ޤ줿���Ǥϡ�ť�����ä��餹��Ƚ���ʰ�̣��"
		"����褦������ƻ�դϤ��ʤ��ˤ��ΰ�̣��Ĵ������"
		"�褦��̿������"
		""
		"��ϻϤ�˥��ѡ�����^c+mϣ��ѻ�^c-�˲񤦤�"
		"�褤���⤷��ʤ��ȸ��ä���"
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_runestone_k
	(tbl-build
		'on-update 'quest-runeinfo-update
		'bonus-xp 0
		)
))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; runes questgroup

(questadd (qst-mk "���Ǥ�õ��"
	'questentry-allrunes
	(kern-ui-paginate-text
		"��ƻ�դϼ���줿�Ԥ���������Ū�Τ�������Ǥ�"
		"����Ƥ���ȳο���������˸��Ĥ����뤫�Ϥ���"
		"������������"
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_runestone_group
	(tbl-build
		;;'on-update 'quest-allrunes-update
		'bonus-xp 0
		)
))

;; TODO- alternate path in which the rune is lost?
(questadd (qst-mk "����������"
	'questentry-rune-k
	(kern-ui-paginate-text
		"�μ������Ǥ���ƻ�դΤ�Τ�����������᤻��"
		"��ƻ�դο���������������"
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_runestone_k
	(tbl-build
		'on-update 'quest-rune-k-update
		'entrusted-with-rune 0
		'player-got-rune 0
		'ench-should-have-rune 0
		'bonus-xp 0
		)
))

(questadd (qst-mk "��ʥ������"
	'questentry-rune-p
	(kern-ui-paginate-text
		"ϣ��ѻդ��饯��ݥꥹ�α������줿���Ǥ���"
		"��ʹ������"
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_runestone_r
	(tbl-build
		'on-update 'quest-rune-p-update
		'bonus-xp 0
		)
))

(questadd (qst-mk "��Τ�����"
	'questentry-rune-l
	(kern-ui-paginate-text
		"���Ǥΰ�Ĥ�Ʈ�Τ��ȤˤĤ��Ƥ��롣"
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_runestone_r
	(tbl-build
		'on-update 'quest-rune-l-update
		'bonus-xp 0
		'located 0
		'know-hall 0
		'approx-hall 0
		)
))

(questadd (qst-mk "����줿����"
	'questentry-rune-f
	(kern-ui-paginate-text
		"�����ӥ����Ϥ��Ĥ����Ǥ���äƤ�����������"
		"����ϥ��֥������ΤȤ�����줿��"
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_runestone_r
	(tbl-build
		'on-update 'quest-rune-f-update
		'bonus-xp 0
		)
))

(questadd (qst-mk "�������������"
	'questentry-rune-d
	(kern-ui-paginate-text
		"���������Ǥϵ�������˻��������ꡢ����������"
		"���פ��Ƥ��뤽������"
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_runestone_r
	(tbl-build
		'on-update 'quest-rune-d-update
		'bonus-xp 0
		)
))

(questadd (qst-mk "�Ф��������"
	'questentry-rune-w
	(kern-ui-paginate-text
		"�Фγ��ˤ���ε�Τͤ������ʪ�ˤ����Ǥ򸫤Ĥ�"
		"����"
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_runestone_r
	(tbl-build
		'bonus-xp 0
		)
))

(questadd (qst-mk "���Ҥ��������"
	'questentry-rune-s
	(kern-ui-paginate-text
		"���Ǥ����Ҥο����θť��֥���åȤˤ������"
		"����"
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_runestone_r
	(tbl-build
		'on-update 'quest-rune-s-update
		'bonus-xp 0
		)
))

(questadd (qst-mk "�����������"
	'questentry-rune-c
	(kern-ui-paginate-text
		"���ǤϤ��ĤƳ�±�Υ����ƥ��������äƤ�����"
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_runestone_r
	(tbl-build
		'on-update 'quest-rune-c-update
		'bonus-xp 0
		)
))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; wise questgroup

(questadd (qst-mk "���Ԥ���"
	'questentry-wise
	(kern-ui-paginate-text
		"���Ԥϥ����ɤ��Ϥ��礭�ʱƶ��Ϥ���ļ�ã����"
		"�����Τ���ˤ����򸫤Ĥ��Ф����Ȥ��Բķ����"
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_quest_wise
	(tbl-build
		;;'on-update 'quest-wise-update
		)
))

(questadd (qst-mk "��ƻ��"
	'questentry-enchanter
	(kern-ui-paginate-text
		"��ƻ�դϰ�����μ��Τ�����ѻդǡ����ߤθ��Ԥ�"
		"��ͤ���"
	)
	'quest-assign-subquest
	'quest-status-inprogress
	's_enchanter
	(tbl-build
		;;'on-update 'quest-enchanter-update
		'qparent 'questentry-wise
		)
))

(questadd (qst-mk "ϣ��ѻ�"
	'questentry-alchemist
	(kern-ui-paginate-text
		"ϣ��ѻդϸ��Ԥΰ�ͤ���"
	)
	'quest-assign-subquest
	'quest-status-inprogress
	's_companion_tinker
	(tbl-build
		;;'on-update 'quest-alchemist-update
		'qparent 'questentry-wise
		)
))

(questadd (qst-mk "�ˤ󤲤�"
	'questentry-the-man
	(kern-ui-paginate-text
		"�ˤ󤲤�ϸ��Ԥΰ�ͤ���"
	)
	'quest-assign-subquest
	'quest-status-inprogress
	's_companion_bard
	(tbl-build
		;;'on-update 'quest-the-man-update
		'qparent 'questentry-wise
		)
))

(questadd (qst-mk "����"
	'questentry-engineer
	(kern-ui-paginate-text
		"���դϸ��Ԥΰ�ͤ���"
	)
	'quest-assign-subquest
	'quest-status-inprogress
	's_companion_tinker
	(tbl-build
		;;'on-update 'quest-engineer-update
		'qparent 'questentry-wise
		)
))

(questadd (qst-mk "����ѻ�"
	'questentry-necromancer
	(kern-ui-paginate-text
		"����ѻդϸ��Ԥΰ�ͤ���"
	)
	'quest-assign-subquest
	'quest-status-inprogress
	's_black_mage
	(tbl-build
		;;'on-update 'quest-necromancer-update
		'qparent 'questentry-wise
		)
))

(questadd (qst-mk "Ʈ��"
	'questentry-warritrix
	(kern-ui-paginate-text
		"Ʈ�Τϸ��Ԥΰ�ͤ���"
	)
	'quest-assign-subquest
	'quest-status-inprogress
	's_avatar
	(tbl-build
		'on-update 'quest-warritrix-update
		'qparent 'questentry-wise
		)
		;;'name - knows existance, but no info
		;;'common - basic info
		;;'general-loc - common knowledge info
		;;'assignment - failed to find her
		;;'lost-hall - where she has been sent
		;;'lost-hall-loc - additionally, knows location of hall
		;;'slain - indirect evidence of her fall
		;;'reached - reached location of corpse - used by losthalls mechs
		;;'found - located corpse
		;;'avenged - completed justice quest TODO- pull from that quest info instead
))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(questadd (qst-mk "�ɲ���˴��"
	'questentry-ghertie
	(kern-ui-paginate-text
		"���ѡ����νɤˤ�ͩ����롣�ʤ����Ǥ⤽��"
		"�˵�¤äƤ���Τ���"
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_ghost
	(tbl-build
		'on-update 'quest-ghertie-update
		;; ghertieloc  - gherties loc
		;; ghertieid - ghertie info
		;; revenge	- gherties trigger
		;; questinfo - quest info revealed
		;; meaney-loc - location of meaney
		;; ring-meaney - got ring from meaney
		;; jorn-forest - rough info on jorn
		;; jorn-loc - jorn found
		;; ring-jorn - got ring from jorn
		;; gholet-prison - rough info on gholet
		;; gholet-glasdrin - found gholet
		;; gholet-price - gholets offer for ring
		;; ring-gholet - got ring from gholet
		)
))

(questadd (qst-mk "���ͤ���ε�η�"
	'questentry-dragon
	(kern-ui-paginate-text
		"ϣ��ѻդ�ε�η����äƤ���и򴹤����ǤΤ���"
		"���򶵤���ȸ��ä���"
	)
	'quest-assign-notify
	'quest-dragon-update
	's_dragon_party
	(tbl-build
		)
))

(questadd (qst-mk "��Τ���������"
	'questentry-warrjustice
	(kern-ui-paginate-text
		"Ʈ�Τ�΢�ڤ�ˤ�껦���줿�����κ᤬�ۤ���뤳"
		"�ȤϤʤ��Τ���"
	)
	'quest-assign-subquest
	'quest-status-inprogress
	's_ghost
	(tbl-build
		'on-update 'quest-warrjustice-update
		)
		;;'statue - info about statue
		;;'book - info about journal
		;;'havejournal - found journal
		;;'avenged - completed justice quest
))

(questadd (qst-mk "��±������"
	'questentry-bandits
	(kern-ui-paginate-text
		"ú�Ƥ���Ϸ�ͥ��쥴����ˡ����������Ǥ�����±"
		"����������ߤ�������ޤ줿��"
		""
		"�Ф���η����⤬��������μ�����ˤʤ뤫�⤷��"
		"�ʤ��ȸ���줿��"
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_brigand
	(tbl-build
         'on-update 'quest-bandits-update
         )
))

)

