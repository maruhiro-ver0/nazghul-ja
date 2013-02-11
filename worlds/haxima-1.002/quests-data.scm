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
	"あなた自身の作成"
	'questentry-charcreate
	(kern-ui-paginate-text
		"部屋の北にある月の門をくぐると冒険が始まる。 "
		""
		"途中であなたの名前を入力する。像に話しかけると"
		"能力を調整することもできる。 "
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_quest_start
	0
))

(questadd (qst-mk "ここはどこ？"
	'questentry-whereami
	(kern-ui-paginate-text
		"気がつくと、あなたは過去の記憶もなく見知らぬ世"
		"界にいた。 "
		""
		"ここはどこなのか？ "
		"どのように、そしてなぜここに来たのか？ "
		"何をすべきなのか？ "
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

(questadd (qst-mk "魔道師の招待状"
	'questentry-calltoarms
	(kern-ui-paginate-text
		"あなたは魔道師と呼ばれる者から、できるだけ早く"
		"会いに来るように、との言葉を受け取った。"
		""
		"たどり着くまでの道のりは祭壇を管理している者に"
		"尋ねるとよいようだ。"
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
	
(questadd (qst-mk "泥棒を追え"
	'questentry-thiefrune
	(kern-ui-paginate-text
		"魔道師は塔から盗み出した者を調査するようにあな"
		"たに頼んだ。"
		""
		"^c+m泥棒^c-はトリグレイブへと向かったようだ。"
		"町の人たちが何か知っているかもしれない。"
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

(questadd (qst-mk "石版の秘密"
	'questentry-runeinfo
	(kern-ui-paginate-text
		"盗まれた石版は、泥棒の話からすると重大な意味が"
		"あるようだ。魔道師はあなたにその意味を調査する"
		"ように命じた。"
		""
		"彼は始めにオパーリンの^c+m錬金術師^c-に会うと"
		"よいかもしれないと言った。"
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

(questadd (qst-mk "石版を探せ"
	'questentry-allrunes
	(kern-ui-paginate-text
		"魔道師は呪われた者が恐ろしい目的のために石版を"
		"集めていると確信した。先に見つけられるかはあな"
		"たしだいだ。"
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
(questadd (qst-mk "手の中の石版"
	'questentry-rune-k
	(kern-ui-paginate-text
		"知識の石版は魔道師のものだ。それを取り戻せば"
		"魔道師の信頼を得られるだろう。"
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

(questadd (qst-mk "深淵の石版"
	'questentry-rune-p
	(kern-ui-paginate-text
		"錬金術師からクロポリスの奥に埋もれた石版の話"
		"を聞いた。"
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_runestone_r
	(tbl-build
		'on-update 'quest-rune-p-update
		'bonus-xp 0
		)
))

(questadd (qst-mk "戦士の石版"
	'questentry-rune-l
	(kern-ui-paginate-text
		"石版の一つは闘士が身につけている。"
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

(questadd (qst-mk "失われた石版"
	'questentry-rune-f
	(kern-ui-paginate-text
		"クロービス王はかつて石版を持っていた。しかし"
		"それはゴブリン戦争のとき失われた。"
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_runestone_r
	(tbl-build
		'on-update 'quest-rune-f-update
		'bonus-xp 0
		)
))

(questadd (qst-mk "虚空の中の石版"
	'questentry-rune-d
	(kern-ui-paginate-text
		"言い伝えでは虚空の中に寺院があり、そこに石版"
		"が祭られているそうだ。"
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_runestone_r
	(tbl-build
		'on-update 'quest-rune-d-update
		'bonus-xp 0
		)
))

(questadd (qst-mk "火の中の石版"
	'questentry-rune-w
	(kern-ui-paginate-text
		"火の海にある竜のねぐらの宝物庫で石版を見つけ"
		"た。"
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_runestone_r
	(tbl-build
		'bonus-xp 0
		)
))

(questadd (qst-mk "廃墟の中の石版"
	'questentry-rune-s
	(kern-ui-paginate-text
		"石版は廃墟の真下の古アブサロットにあるだろ"
		"う。"
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_runestone_r
	(tbl-build
		'on-update 'quest-rune-s-update
		'bonus-xp 0
		)
))

(questadd (qst-mk "海の中の石版"
	'questentry-rune-c
	(kern-ui-paginate-text
		"石版はかつて海賊のガーティーが持っていた。"
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

(questadd (qst-mk "賢者たち"
	'questentry-wise
	(kern-ui-paginate-text
		"賢者はシャルドの地で大きな影響力を持つ者達だ。"
		"勝利のためには彼らを見つけ出すことが不可欠だ。"
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_quest_wise
	(tbl-build
		;;'on-update 'quest-wise-update
		)
))

(questadd (qst-mk "魔道師"
	'questentry-enchanter
	(kern-ui-paginate-text
		"魔道師は偉大で知識のある魔術師で、現在の賢者の"
		"一人だ。"
	)
	'quest-assign-subquest
	'quest-status-inprogress
	's_enchanter
	(tbl-build
		;;'on-update 'quest-enchanter-update
		'qparent 'questentry-wise
		)
))

(questadd (qst-mk "錬金術師"
	'questentry-alchemist
	(kern-ui-paginate-text
		"錬金術師は賢者の一人だ。"
	)
	'quest-assign-subquest
	'quest-status-inprogress
	's_companion_tinker
	(tbl-build
		;;'on-update 'quest-alchemist-update
		'qparent 'questentry-wise
		)
))

(questadd (qst-mk "にんげん"
	'questentry-the-man
	(kern-ui-paginate-text
		"にんげんは賢者の一人だ。"
	)
	'quest-assign-subquest
	'quest-status-inprogress
	's_companion_bard
	(tbl-build
		;;'on-update 'quest-the-man-update
		'qparent 'questentry-wise
		)
))

(questadd (qst-mk "技師"
	'questentry-engineer
	(kern-ui-paginate-text
		"技師は賢者の一人だ。"
	)
	'quest-assign-subquest
	'quest-status-inprogress
	's_companion_tinker
	(tbl-build
		;;'on-update 'quest-engineer-update
		'qparent 'questentry-wise
		)
))

(questadd (qst-mk "死霊術師"
	'questentry-necromancer
	(kern-ui-paginate-text
		"死霊術師は賢者の一人だ。"
	)
	'quest-assign-subquest
	'quest-status-inprogress
	's_black_mage
	(tbl-build
		;;'on-update 'quest-necromancer-update
		'qparent 'questentry-wise
		)
))

(questadd (qst-mk "闘士"
	'questentry-warritrix
	(kern-ui-paginate-text
		"闘士は賢者の一人だ。"
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

(questadd (qst-mk "宿屋の亡霊"
	'questentry-ghertie
	(kern-ui-paginate-text
		"オパーリンの宿には幽霊がいる。なぜ死んでもそこ"
		"に居座っているのか？"
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

(questadd (qst-mk "価値ある竜の血"
	'questentry-dragon
	(kern-ui-paginate-text
		"錬金術師は竜の血を持ってくれば交換で石版のあり"
		"かを教えると言った。"
	)
	'quest-assign-notify
	'quest-dragon-update
	's_dragon_party
	(tbl-build
		)
))

(questadd (qst-mk "戦士たちの正義"
	'questentry-warrjustice
	(kern-ui-paginate-text
		"闘士は裏切りにより殺された。この罪が裁かれるこ"
		"とはないのか？"
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

(questadd (qst-mk "盗賊の問題"
	'questentry-bandits
	(kern-ui-paginate-text
		"炭焼きの老人グレゴールに、森の厄介事である盗賊"
		"から助けて欲しいと頼まれた。"
		""
		"緑の塔の警備隊がこの問題の手助けになるかもしれ"
		"ないと言われた。"
	)
	'quest-assign-notify
	'quest-status-inprogress
	's_brigand
	(tbl-build
         'on-update 'quest-bandits-update
         )
))

)

