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
                  "炭焼きの老人グレゴールに、森の厄介事である盗賊"
                  "から助けて欲しいと頼まれた。"
                  "")))
    (println "quest-tbl:" quest-tbl)
    (define (tbl-flag? tag) 
      (not (null? (tbl-get quest-tbl tag)))
      )
    (qst-set-descr! quest
                    (cond ((tbl-flag? 'done)
                           (kern-ui-paginate-text
                            "ネイトを緑の塔に送り込んだ。後は彼らの問題だ。"
                            ))
                          ((tbl-flag? 'nate-given-to-jailor)
                           (append header
                                   (kern-ui-paginate-text
                                    "収容証明書を緑の塔の警備隊隊長デリックに渡し、"
                                    "報酬を受け取った。"
                                    )))
                          ((tbl-flag? 'captured-nate-and-talked-to-deric)
                           (append header
                                   (kern-ui-paginate-text
                                    "ネイトを緑の塔の刑務所に連れて行き、収容証明書"
                                    "を受け取らなければならない。"
                                    )))
                          ((tbl-flag? 'captured-nate)
                           (append header
                                   (kern-ui-paginate-text 
                                    "盗賊の頭ネイトを捕らえた。緑の塔へ連れて行き、"
                                    "警備隊長に報告しなければならない。"
                                    )))
                          ((tbl-flag? 'talked-to-deric)
                           (append header
                                   (kern-ui-paginate-text 
                                    "警備隊隊長のデリックはあまり助けにならなかっ"
                                    "た。しかし、彼は部下にあなたに加わるように命令"
                                    "した。"
                                    )))
                          (else
                           (append header
                                   (kern-ui-paginate-text
                                    "グレゴールは盗賊のことを緑の塔で尋ねるようにと"
                                    "言った。"
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
                             "あなたはシャルドにいる。そこは広大な虚空に浮か"
                             "ぶ世界の小さな断片だった。"
                             ""
                             "この地にあなたを導いたのは悪魔の王ノシファーで"
                             "あった。彼は数々の現象を引き起こし、自分自身を"
                             "シャルドに呼び出す道を築いたのであった。"
                             ""
                             "今、悪魔の門が開いた。そしてノシファーの道を遮"
                             "るのはあなただけだ…"
                             )
                            
                            (append
                             ;;1 where
                             (cond ((null? qp-shard)
                                    (kern-ui-paginate-text
                                     "気がつくと、あなたは過去の記憶もなく見知らぬ世"
                                     "界にいた。 "
                                     ""
                                     ))
                                   ((equal? 1 qp-shard)
                                    (kern-ui-paginate-text
                                     "あなたは見知らぬ世界にいる。人々はこの地をシャ"
                                     "ルドと呼んでいる。"
                                     ""
                                     ))
                                   (#t (kern-ui-paginate-text
                                        "あなたはシャルドにいる。そこは広大な虚空に浮か"
                                        "ぶ世界の小さな断片だった。"
                                        ""
                                        ))
                                   )


                             ;; how
                             (if (and (null? qp-wanderer) (null? qp-shard))
                                 (kern-ui-paginate-text "ここはどこ？")
                                 nil
                                 )
                             
                             (cond ((null? qp-wanderer)
                                    (kern-ui-paginate-text
                                     "どのようにして、そしてなぜここに来たのか？"
                                     "これからどうすればよいのか？"
                                     ))
                                   ((equal? 1 qp-wanderer)
                                    (kern-ui-paginate-text
                                     "以前にもあなたのようにこの世界に転がり込んだ者"
                                     "がいたようだ。人々はあなたを「迷い人」と呼ぶら"
                                     "しい。"
                                     ""
                                     "今、あなたはここにいる。これからどうすればよい"
                                     "のか？"
                                     ))
                                   (#t (kern-ui-paginate-text
                                        "あなたのように突然この世界に転がり込んだ迷い人"
                                        "は、かつて大きな活躍をしたらしい。"
                                        ""
                                        "あなたはこの地で何を見るのだろうか？"
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
					"あなたは魔道師と呼ばれる者から、できるだけ早く"
					"会いに来るように、との言葉を受け取った。"
					"")))
		(define (tbl-flag? tag) (not (null? (tbl-get quest-tbl tag))))
		(qst-set-descr! quest
		
(cond ((tbl-flag? 'done)
		(kern-ui-paginate-text
			"シャルドの地を見守る賢者の一人である魔道師の協"
			"力を得られた。"
		))
	((tbl-flag? 'talked)
		(append header
		(kern-ui-paginate-text
			"魔道師と会った。しかし、彼からは何の協力も得ら"
			"れなかった。"
		)))
	((tbl-flag? 'tower)
		(append header
		(kern-ui-paginate-text
			"湿地帯の魔道師の塔にたどり着いた。しかし、入る"
			"のは難しそうだ。"
		)))
	((tbl-flag? 'directions)
		(append header
		(kern-ui-paginate-text
			"魔道師の塔は、トリグレイブの北、シャルドの西部"
			"の湿地帯にあるそうだ。"
		)))
	(#t
		(append header
		(kern-ui-paginate-text
			"たどり着くまでの道のりは祭壇を管理している者に"
			"尋ねるとよいようだ。"
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
					"魔道師は塔から盗み出した者を調査するようにあな"
					"たに頼んだ。"
					"")))
		(define (tbl-flag? tag) (not (null? (tbl-get quest-tbl tag))))
		(qst-set-descr! quest
		
(cond ((tbl-flag? 'recovered) 
		(append header
		(kern-ui-paginate-text
			"泥棒を追い詰め、魔道師の石版を取り戻すことがで"
			"きた。"
		)))
	((tbl-flag? 'talked)
		(append header
		(kern-ui-paginate-text
			"泥棒のネズミとは交渉できそうだ。"
		)))
	((tbl-flag? 'den5)
		(append header
		(kern-ui-paginate-text
			"泥棒の隠れ家はボレにあった。最後の罠を突破し"
			"た。"
		)))
	((tbl-flag? 'den4)
		(append header
		(kern-ui-paginate-text
			"泥棒の隠れ家はボレにあった。まだ3階を突破した"
			"に過ぎない。"
		)))
	((tbl-flag? 'den3)
		(append header
		(kern-ui-paginate-text
			"泥棒の隠れ家はボレにあった。まだ2階を突破した"
			"に過ぎない。"
		)))
	((tbl-flag? 'den2)
		(append header
		(kern-ui-paginate-text
			"泥棒の隠れ家はボレにあった。まだ1階を突破した"
			"に過ぎない。"
		)))
	((tbl-flag? 'den1)
		(append header
		(kern-ui-paginate-text
			"泥棒の隠れ家はボレにあった。だが守りは固い。"
		)))
	((tbl-flag? 'bole)
		(append header
		(kern-ui-paginate-text
			"^c+m泥棒^c-は森を北へ進んだようだ。"
			"ボレが最もありうる場所だ。"
		)))
	((tbl-flag? 'tower)
		(append header
		(kern-ui-paginate-text
			"^c+m泥棒^c-は山道を東に向かって進んだようだ。"
			"まず緑の塔で調べるとよさそうだ。"
		)))
	(#t
		(append header
		(kern-ui-paginate-text
			"^c+m泥棒^c-はトリグレイブへと向かったようだ。"
			"町の人たちが何か知っているかもしれない。"
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
				"盗まれた石版は、泥棒の話からすると重大な意味が"
				"あるようだ。魔道師はあなたにその意味を調査する"
				"ように命じた。"
				""
				)))
		(define (tbl-flag? tag) (not (null? (tbl-get quest-tbl tag))))
		(qst-set-descr! quest
		
(cond 
	((tbl-flag? 'done)
		(kern-ui-paginate-text
			"あなたの持っている石版は悪魔の門の鍵の一つと言"
			"われている。門は北のどこかにあるそうだ。それは"
			"遠い昔、賢者によって封印され、鍵は別々に隠され"
			"た。"
		))
	((tbl-flag? 'gate)
		(append header
		(kern-ui-paginate-text
			"石版は悪魔の門の鍵とも言われている。門は北のど"
			"こかにあるそうだ。それは遠い昔、賢者によって封"
			"印され、鍵は別々に隠された。"
		)))
	((tbl-flag? 'keys)
		(append header
		(kern-ui-paginate-text
			"石版は悪魔の門の鍵とも言われている。だが、それ"
			"が何を意味するのかはわからない。"
		)))
	((tbl-flag? 'abe)
		(append header
		(kern-ui-paginate-text
			"錬金術師は^c+mエイブ^c-と会うことを勧めた。彼は緑の塔"
			"にいて、石版のことを研究している。"
		)))
	(#t
		(append header
		(kern-ui-paginate-text
			"彼は始めにオパーリンの^c+m錬金術師^c-に会うとよいかも"
			"しれないと言った。"
		)))
)

		)
	))


;;-----------------------
;; dragon blood

(define (quest-dragon-update quest)
	(let* ((quest-tbl (car (qst-payload quest)))
			(header (kern-ui-paginate-text
				"錬金術師は竜の血を持ってくれば交換で石版のあり"
				"かを教えると言った。"
				)))
		(define (tbl-flag? tag) (not (null? (tbl-get quest-tbl tag))))
		(qst-set-descr! quest
		
(cond 
	((tbl-flag? 'done)
		(kern-ui-paginate-text
			"竜の血と交換で錬金術師から石版のありかを聞い"
			"た。"
		))
	((in-inventory? (car (kern-party-get-members (kern-get-player))) t_dragons_blood 1)
		(append header
		(kern-ui-paginate-text
			""
			"1ビンの竜の血が手に入った。"
		)))
	((tbl-flag? 'sea)
		(append header
		(kern-ui-paginate-text
			""
			"彼は火の海で探すのが最もよいであろうと言った。"
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
			"石版はクロポリスの奥深くにあった。"
		))
	(#t
		(kern-ui-paginate-text
			"錬金術師からクロポリスの奥に埋もれた石版の話を"
			"聞いた。"
			""
			"「聖騎士はクロポリスの地下にいくつかの砦を築い"
			"ている。石版の一つが最も深い砦に埋もれているの"
			"だ。」"
			""
			"「つるはしとシャベルがあれば掘り出せるだろう。"
			"だが、問題なのは君に付きまとう何人もの聖騎士が"
			"いることだ。」"
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
			"クロービス王の失われた石版をクモの女王アングリ"
			"スから手に入れた。"
		))
	((and (tbl-flag? 'angrisslair) (tbl-flag? 'angriss))
		(kern-ui-paginate-text
			"クロービス王はかつて石版を持っていた。しかしそ"
			"れはゴブリン戦争のとき失われた。"
			""
			"ゴブリンたちの話によりアングリスの住み家に導か"
			"れた。石版はそこにありそうだ。"
		))
	((tbl-flag? 'angriss)
		(kern-ui-paginate-text
			"クロービス王はかつて石版を持っていた。しかしそ"
			"れはゴブリン戦争のとき失われた。"
			""
			"ゴブリンのカマからその場所の手がかりを得た。"
			"何か(クモ?)が森の南、東の山脈と接する所にあり"
			"そうだ。"
		))
	((tbl-flag? 'kama)
		(kern-ui-paginate-text
			"クロービス王はかつて石版を持っていた。しかしそ"
			"れはゴブリン戦争のとき失われた。"
			""
			"ゴブリンたちがその行方を知っているようだ。もし"
			"ゴブリンのカマを見つけることができれば、助けに"
			"なるだろう。"
		))
	((tbl-flag? 'gen)
		(kern-ui-paginate-text
			"クロービス王はかつて石版を持っていた。しかしそ"
			"れはゴブリン戦争のとき失われた。"
			""
			"ゴブリンたちがその行方を知っているようだ。人間"
			"の中では警備隊員のジェンが一番よく知っていそう"
			"だ。"
		))
	(#t
		(kern-ui-paginate-text
			"クロービス王はかつて石版を持っていた。しかしそ"
			"れはゴブリン戦争のとき失われた。"
			""
			"ゴブリンたちがその行方を知っているようだ。だが"
			"どう聞き出せばいい？"
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
			"虚空の寺院の石版を手に入れた。"
		))
	(#t
		(kern-ui-paginate-text
			"言い伝えでは虚空の中に寺院があり、そこに石版が"
			"供えられているそうだ。"
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
			"石版を引き上げられた慈悲深い死号の中で手に入れ"
			"た。"
		))
	((tbl-flag? 'shiploc)
		(append
			(kern-ui-paginate-text
			"海賊の頭ガーティーはかつて石版を持っていた。"
			""
			)
			(kern-ui-paginate-text (string-append "彼女の幽霊は船の場所[" (number->string merciful-death-x) "," (number->string merciful-death-y) "]を明かした。"))
			(if (tbl-flag? 'shipraise)
				(kern-ui-paginate-text
				""
				"船は、マンドレイク、血の苔、そして蜘蛛の糸を調"
				"合し、ヴァス・ウース・イェム<Vas Uus Ylem>の呪"
				"文を使えば引き上げられる。"
				)
				nil
			)
		))
	((tbl-flag? 'info)
		(kern-ui-paginate-text
			"海賊の頭ガーティーはかつて石版を持っていた。"
			""
			"今はオパーリンで幽霊となって手下を^c+m復讐^c-のため探"
			"している。"
		))
	(#t
		(kern-ui-paginate-text
			"海賊の頭ガーティーはかつて石版を持っていた。"
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
			"かつて海賊ガーティーの幽霊がオパーリンの宿にい"
			"た。彼女の復讐と引き換えに、沈んだ船の場所を知"
			(string-append "ることができた。それは[" (number->string merciful-death-x) "," (number->string merciful-death-y) "]にある。")
		))
	((tbl-flag? 'questinfo)
		(append
			(kern-ui-paginate-text
				"海賊ガーティーの幽霊がオパーリンの宿にいる。彼"
				"女は復讐のため自分を裏切った手下の生き残りを探"
				"している。"
				""
				"ゴレット、ジョーン、そしてミーニーはガーティー"
				"の手下の証である指輪を身につけている。ガーティ"
				"ーは彼らを倒した証拠として指輪を受け取り、それ"
				"と交換で沈んだ宝の場所を教えると言った。"
			)
			(if (and (tbl-flag? 'ring-jorn)
						(tbl-flag? 'ring-meaney)
						(tbl-flag? 'ring-gholet))
				(kern-ui-paginate-text
					""
					"ドクロの指輪を全て手に入れた。"
				)
				(append
					(cond 
						((tbl-flag? 'ring-gholet)
							(kern-ui-paginate-text
								""
								"ゴレットのドクロの指輪を手に入れた。"
							))
						((tbl-flag? 'gholet-price)
							(kern-ui-paginate-text
								""
								"ゴレットはグラスドリンの地下牢に捕らわれてい"
								"る。彼は1ダースの鍵開け道具と指輪を交換すると"
								"言った。"
							))
						((tbl-flag? 'gholet-dungeon)
							(kern-ui-paginate-text
								""
								"ゴレットはグラスドリンの地下牢に捕らわれてい"
								"る。"
							))
						((tbl-flag? 'gholet-prison)
							(kern-ui-paginate-text
								""
								"ゴレットはもし生きていればどこかの牢獄にいるだ"
								"ろう。"
							))
						(#t nil)
					)
					(cond 
						((tbl-flag? 'ring-jorn)
							(kern-ui-paginate-text
								""
								"ジョーンのドクロの指輪を手に入れた。"
							))
						((tbl-flag? 'jorn-loc)
							(kern-ui-paginate-text
								""
								"ジョーンは緑の塔の白き牡鹿荘にいる。"
							))
						((tbl-flag? 'jorn-forest)
							(kern-ui-paginate-text
								""
								"ジョーンは広大な森のどこかで盗賊をやっている。"
							))
						(#t nil)
					)
					(cond 
						((tbl-flag? 'ring-meaney)
							(kern-ui-paginate-text
								""
								"ミーニーのドクロの指輪を手に入れた。"
							))
						((tbl-flag? 'meaney-loc)
							(kern-ui-paginate-text
								""
								"ミーニーはオパーリンの北にある救貧院で働いてい"
								"る。"
							))
						(#t nil)
					)
				)
			)
		))
	(#t
		(kern-ui-paginate-text
			(string-append(if (tbl-flag? 'ghertieid)
					"海賊ガーティーの幽霊"
					"幽霊")
				(if (tbl-flag? 'ghertieloc)
					"がオパーリンの宿にいる。"
					"がオパーリンにいる。")
			)
			(if (tbl-flag? 'revenge)
				"彼女は^c+m復讐^c-を望んでいる。それを手伝えば、彼女は\nあなたに協力するかもしれない。"
				(string-append "なぜ"
					(if (tbl-flag? 'ghertieid) "彼女" "それ")
					"は死んでもそこに居座っているのか？"
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
			"石版は闘士の亡骸が持っていた。"
		))
	((and (tbl-flag? 'located) (tbl-flag? 'know-hall))
		(kern-ui-paginate-text
			"石版の一つは闘士が持ち歩いている。"
			"彼女はシャルドの南海岸にある失われた殿堂で見つ"
			"かるだろう。"
			(string-append
			"それは[" 
			(number->string (loc-x lost-halls-loc)) "," (number->string (loc-y lost-halls-loc))
			"]にある。"
			)
		))
	((and (tbl-flag? 'located) (tbl-flag? 'approx-hall))
		(kern-ui-paginate-text
			"石版の一つは闘士が持ち歩いている。"
			"彼女はシャルドの南海岸にある失われた殿堂で見つ"
			"かるだろう。"
		))
	((tbl-flag? 'located)
		(kern-ui-paginate-text
			"石版の一つは闘士が持ち歩いている。"
			"彼女は失われた殿堂で見つかるだろう。"
		))
	(#t
		(kern-ui-paginate-text
			"石版の一つは闘士が持ち歩いている。"
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
			"アブサロットの遺跡の石版を見つけた。"
		))
	((tbl-flag? 'silasinfo)
		(kern-ui-paginate-text
			"サイラスはアブサロットの遺跡に石版を隠してい"
			"る。"
		))
	(#t
		(kern-ui-paginate-text
			"石版はアブサロットのどこかにあるだろう。"
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
			"魔道師はあなたに知識の石版を預けた。"
		))
	((tbl-flag? 'player-got-rune)
		(kern-ui-paginate-text
			"知識の石版は魔道師のものだが、今はあなたの手の"
			"中にある。"
		))
	((tbl-flag? 'ench-should-have-rune)
		(kern-ui-paginate-text
			"知識の石版は魔道師のものだ。それを取り戻せば魔"
			"道師の信頼を得られるだろう。"
		))
	(#t
		(kern-ui-paginate-text
			"知識の石版は魔道師のものだ。"
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
			"闘士はこの時代で最も狡猾な戦士だった。だが、彼"
			"女は失われた殿堂で待ち伏せにあい殺されていた。"
			""
			"彼女を裏切った者は正義の下に裁かれた。"
		))
	((tbl-flag? 'found)
		(kern-ui-paginate-text
			"闘士はこの時代で最も狡猾な戦士だった。だが、彼"
			"女は失われた殿堂で待ち伏せにあい殺されていた。"
		))
	((tbl-flag? 'slain)
		(cond
			((tbl-flag? 'lost-hall-loc)
				(kern-ui-paginate-text
					"闘士はこの時代で最も狡猾な戦士だった。だが、彼"
					"女の魂は今は虚空の中にある。"
					""
					"彼女の亡骸はいまだ失われた殿堂にある。"
					(string-append
					"それは["
					(number->string (loc-x lost-halls-loc)) "," (number->string (loc-y lost-halls-loc))
					"]にある。"
					)
				))
			((tbl-flag? 'lost-hall)
				(kern-ui-paginate-text
					"闘士はこの時代で最も狡猾な戦士だった。だが、彼"
					"女の魂は今は虚空の中にある。"
					""
					"彼女の亡骸はいまだ失われた殿堂にある。"
				))
			(#t
				(kern-ui-paginate-text
					"闘士はこの時代で最も狡猾な戦士だった。だが、彼"
					"女の魂は今は虚空の中にある。"
					""
					"生きていたときはグラスドリンの町に仕えていた。"
				))
		))
	((tbl-flag? 'lost-hall-loc)
		(kern-ui-paginate-text
			"闘士はこの時代で最も狡猾な戦士だ。今は作戦で失"
			"われた殿堂に遠征している。"
			(string-append
			"それは["
			(number->string (loc-x lost-halls-loc)) "," (number->string (loc-y lost-halls-loc))
			"]にある。"
			)
		))
	((tbl-flag? 'lost-hall)
		(kern-ui-paginate-text
			"闘士はこの時代で最も狡猾な戦士だ。今は作戦で失"
			"われた殿堂に遠征している。"
		))
	((tbl-flag? 'assignment)
		(kern-ui-paginate-text
			"闘士はこの時代で最も狡猾な戦士だ。今は作戦でグ"
			"ラスドリンを離れている。"
		))
	((tbl-flag? 'general-loc)
		(kern-ui-paginate-text
			"闘士はこの時代で最も狡猾な戦士だ。彼女は普段は"
			"グラスドリンにいる。"
		))
	((tbl-flag? 'common)
		(kern-ui-paginate-text
			"闘士はこの時代で最も狡猾な戦士だ。"
		))
	(#t
		(kern-ui-paginate-text
			"闘士は賢者の一人だ。"
		))
)

		)
	))
