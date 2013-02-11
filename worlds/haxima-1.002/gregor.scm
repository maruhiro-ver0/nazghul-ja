;;----------------------------------------------------------------------------
;; gregor.scm - 炭焼き人のグレゴール
;;----------------------------------------------------------------------------
;;----------------------------------------------------------------------------
;; Schedule
;; 
;; 月の門の祭壇 (moongate-clearing.scm)
;; グレゴールの小屋 (gregors-hut.scm).
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_gregor
               (list 0  0  gh-gregors-bed   "sleeping")
               (list 6  0  gh-graveyard     "idle")
               (list 7  0  mgc-roadbend     "idle")
               (list 13 0  gh-table-2       "eating")
               (list 14 0  gh-pasture       "working")
               (list 17 0  gh-table-2       "eating")
               (list 18 0  gh-living-room   "idle")
               (list 20 0  gh-gregors-bed   "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
(define (gregor-mk) (list (mk-quest)))
(define (gregor-quest gob) (car gob))


;;----------------------------------------------------------------------------
;; Conv
;; 
;; グレゴールは炭焼き人の老人で、門の祭壇の近くに住んでいる。
;; 彼は祭壇の近くによくいる。そして孫娘のイリアの世話をしている。
;; 
;; グレゴールはプレイヤーが最初に会うNPCである。そして、初めてプレーする者に多
;; 彩な助けになる応答をする。
;;----------------------------------------------------------------------------

(define (gregor-kill-nate knpc kpc)
  (say knpc "［グレゴールは震える指をネイトに向けた。］お前に渡すものがある。")
  (aside kpc 'ch_nate "［つぶやき］この老いぼれは何を…？")
  (prompt-for-key)
  (say knpc "［彼は巻物を取り出した。］これには多くを支払った。ワシには読めぬが、どう言えばよいかは教わった。")
  (aside kpc 'ch_nate "待て…それは…？")
  (prompt-for-key)
  (say knpc "ゼン・コープ<Xen Corp>！")
  (cast-missile-proc knpc ch_nate t_deathball)
  (aside kpc 'ch_nate "グゲェッ！")
  (prompt-for-key)
  (if (equal? kpc ch_nate)
      (kern-conv-end)
      (say knpc "［彼は振り返った。］このような者といるべきではなかった。人々はあなたについてよからぬ考えを抱くだろう。"))
  )
  

(define (gregor-hail knpc kpc)
  (if (in-player-party? 'ch_nate)
      (gregor-kill-nate knpc kpc)
      (if (in-inventory? kpc t_letter_from_enchanter)
           (say knpc "物を取ってきたようだな。その中に魔道師からの手紙がある。"
                "ここを去る前に武器を装備するのを忘れてはならぬ。"
                "外はとても危険だ！")
           (say knpc "［あなたは白髪まじりの農夫の老人と会った。］\n"
                "ようこそ、迷い人よ。来ると思っていた。"
                "あなたの持ち物は、あの洞窟の中にある。"
                "行って箱を開け、中の物を取ってくだされ。"
                "全てあなたのための物だ。"))
      ))

;; Some prompting with initial commands:
;; 
;; Hmmm...perhaps it would be desirable to have game-UI promts
;; spoken out-of-character, so that the NPCs don't break the game fiction...
(define (gregor-open knpc kpc)
  (say knpc "箱を^c+b開ける^c-のは'o'キーだ。"))

(define (gregor-get knpc kpc)
  (say knpc "'g'キーで置かれたものを^c+b取る^c-ことができる。"))

(define (gregor-read knpc kpc)
  (say knpc "武器や防具は'r'キーで^c+b装備する^c-。"
       "武器は装備していなければ戦いで使うことができない。"))

(define (gregor-camp knpc kpc)
  (say knpc "'k'キーで^c+b休息^c-、荒野で体力を回復できる。"))


(define (gregor-dang knpc kpc)
  (say knpc "とても危険だ！もし回復が必要なら、町の宿が安全な場所だ。"
       "荒野で休息を取ることもできるが、一人で見張りを置かないのは危険だ。"
       "無論、薬や呪文で回復することもできる。"))

(define (gregor-dead knpc kpc)
  (say knpc "そう、悲しいことだ。ワシの娘とその夫は共に…"
       "トロルどもに殺されたのだ。"))

(define (gregor-charcoal knpc kpc)
  (say knpc "炭を町へ持って行き、売る。"
       "それから村の者がワシの所に買いに来る。"))

(define (gregor-hut knpc kpc)
  (say knpc "小屋が南東の森にある。"
       "そこでワシは孫娘と住んでおる。"))

(define (gregor-ench knpc kpc)
  (quest-data-assign-once 'questentry-calltoarms)
  (say knpc "魔道師は賢者の一人だ。"
       "ワシにあなたのような迷い人を探すように言っていた。"
       "魔道師の下に導かねばならぬ。道順を知りたいか？")
  (quest-wise-subinit 'questentry-enchanter)
  (quest-data-update 'questentry-enchanter 'common 1)
  (cond ((yes? kpc)
         (quest-data-update 'questentry-calltoarms 'directions 1)
         (quest-data-update 'questentry-enchanter 'general-loc 1)
         (say knpc "魔道師は西の山の向こうにある沼の塔にいる。"
	      "南へ進み、西の道をたどり、塔にいる警備隊員に尋ねるとよいだろう。")
	  )
         (else 
          (say knpc "そう望むなら。後で方向が必要になったら、「魔道師」と尋ねなさい。")
          )
        ))

(define (gregor-cave knpc kpc)
  (say knpc "この道から南西に分かれた細い道をたどって入りなさい。"
       "そこで箱を開け、中の物を取ってくだされ。"
       "まだ何か聞きたいことがあれば、戻ってから話そう。"))

(define (gregor-ches knpc kpc)
  (say knpc "そのまま進んで、開けて中の物を取ってくだされ。"))

(define (gregor-stuf knpc kpc)
  (say knpc "村の者が供え物をしに来る。またいつの日か迷い人が来ると考えてな。"))

(define (gregor-leav knpc kpc)
  (say knpc "ここを離れたいなら、この道を南へ進めばよい。"))

(define (gregor-band knpc kpc)
  (let ((quest (gregor-quest (kobj-gob-data knpc))))
    (cond ((quest-accepted? quest)
           (say knpc "盗賊どものねぐらは見つかったか？")
           (cond ((yes? kpc)
                  (say knpc "古き神々よ、感謝します！")
                  (quest-done! quest #t)
                  )
                 (else 
                  (say knpc "緑の塔へ行き、盗賊について聞くとよいだろう。")
                  )))
          (else
           (say knpc "盗賊どもが森の中にいるのだ。"
                "やつらはかつてワシの小屋を荒らしに来たことがある。"
                "ワシはやつらと戦ったが、"
                "そのせいで足が悪くなり杖がいるようになった。")
           (prompt-for-key)
           (say knpc "今、ワシには一緒に住んでいる孫娘がいる。"
                "まだ小さな子供だが、そんなことは悪いやつらはお構いなした。"
                "やつらがまた来ることを恐れている。")
           (prompt-for-key)
           (say knpc "このようなことは頼みたくはない。だが、かつて迷い人は村の者を助けたと聞く。ワシを助けてくれんだろうか？")
           (cond ((yes? kpc)
                  (say knpc "ありがとう。"
                       "装備を取ったなら、緑の塔へ行くとよいだろう。"
                       "そこで盗賊のことを尋ねれば"
                       "居場所が分かるかもしれん。")
                  (quest-data-assign-once 'questentry-bandits)
                  (quest-accepted! quest #t)
                  )
                 (else
                  (say knpc "［彼は悲しそうに去った。］")
                  (kern-conv-end)
                  ))))))

(define (gregor-bye knpc kpc)
  (let ((quest (gregor-quest (kobj-gob-data knpc))))
    (cond ((quest-accepted? quest)
           (say knpc "気をつけるのだぞ。"))
          (else
           (say knpc "待ってくれ！頼みがあるのだ。")
           (prompt-for-key)
           (gregor-band knpc kpc)
           ))))

(define (gregor-fore knpc kpc)
  (say knpc "森の深いところに行ってはならぬ。盗賊、クモ、恐ろしいものどもがおる。"))

(define gregor-conv
  (ifc basic-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default (lambda (knpc kpc) (say knpc "それは手助けできんな。")))
       (method 'hail gregor-hail)
       ;;(method 'heal (lambda (knpc kpc) (say knpc "［咳ばらい］孫娘はよく手伝ってくれている。")))
       (method 'bye gregor-bye)
       (method 'job (lambda (knpc kpc) (say knpc "ワシは炭焼き人だ。そしてこの祭壇の管理もしておる。")))
       (method 'join (lambda (knpc kpc) (say knpc "いいや、ワシには別の仕事がある。")))
       (method 'name (lambda (knpc kpc) (say knpc "ワシの名はグレゴールだ。")))

       (method 'open gregor-open)
       (method 'get  gregor-get)

       (method 'cave gregor-cave)
       (method 'ches gregor-ches)

       (method 'stuf gregor-stuf)
       (method 'equi gregor-stuf)  ;; A synonym
       (method 'gear gregor-stuf)  ;; A synonym

       (method 'read gregor-read)
       (method 'dang gregor-dang)

       (method 'camp gregor-camp)
       (method 'kamp gregor-camp) ;; A synonym

       (method 'band gregor-band)
       (method 'leav gregor-leav)

;; SAM -- This response seems to be shadowed by the gregor-band declaration above?
       (method 'band (lambda (knpc kpc) (say knpc "A band of rogues been raiding the shrine "
                                             "when I'm not around. They haven't attacked me, "
                                             "so they're probably just vagabonds, "
                                             "afraid of an old man's cudgel.")))

       (method 'char gregor-charcoal)
       (method 'burn gregor-charcoal)  ;; A synonym

       (method 'daug (lambda (knpc kpc) (say knpc "そう、娘はあと少しで母親のような魔女になれた。"
                                             "才能はあったが、十分に賢者といられなかった。")))
       (method 'dead gregor-dead)
       (method 'ench gregor-ench)
       (method 'folk (lambda (knpc kpc) (say knpc "森と山に農家が散らばっておるのだ。")))
       (method 'fore gregor-fore)
       (method 'wood gregor-fore)
       (method 'gate (lambda (knpc kpc) (say knpc "それがいつ開くのか、"
                                             "そしてその先に何があるのかは、誰も分からぬ。"
                                             "この世界には別の門があると聞いたことがある。"
                                             "だが、それらの話は遠い昔に忘れられてしまった。")))
       (method 'gran (lambda (knpc kpc) (say knpc "ワシにはイリアという名の孫娘がいる。")))
       (method 'help (lambda (knpc kpc) (say knpc "村にはいつも助けを求めている者がいる。"
                                             "ここは大変な場所で、今は大変な時期だ。")))
       (method 'hill (lambda (knpc kpc) (say knpc "トロルどもは常に丘を脅かしていた。"
                                             "このところは特にそうだ。")))
       (method 'husb (lambda (knpc kpc) (say knpc "娘婿はただの農夫だった。"
                                             "なぜトロルどもに襲われたのかは分からん。"
                                             "もしかするとやつらは何者かに丘を追われたのかも知れぬ。")))
       (method 'hut gregor-hut)
       (method 'ilya (lambda (knpc kpc) (say knpc "そう。今は一緒に住んでいる。"
                                             "あの子の両親は死んでしまった。")))

;; SAM: I dont' see any reference to this lake anywhere, commenting this one out for now...
;;       (method 'lake (lambda (knpc kpc) (say knpc "Exit this shrine and ye'll find yourself in a "
;;                                             "hidden valley. Head south and you'll see the Gray Lake "
;;                                             "to the west.")))

       (method 'offe (lambda (knpc kpc) (say knpc "その洞窟の中に箱がある。"
                                             "その中から取ってくだされ。迷い人はほとんど物を持たずにこの世界にくる。"
                                             "そして幾人かはすばらしい行いをした。"
                                             ""
                                             "だから村の者たちは次のために物を置いていくのだ。")
                                             (quest-data-update 'questentry-whereami 'wanderer 2)
       										))
       (method 'pare gregor-dead)
       (method 'plac gregor-hut)

       (method 'shar (lambda (knpc kpc) (say knpc "シャルド？この地をワシらはそう呼んでいる。迷い人よ。")
       				(quest-data-update 'questentry-whereami 'shard 1)
       			))

       (method 'shri (lambda (knpc kpc) (say knpc "この祭壇は門を通ってくる者のためにある。"
                                             "あなたのような迷い人のためにだ。"
                                             "村の者たちは、あなたの旅に必要な物を供え物として置いていくのだ。")
                                             (quest-data-update 'questentry-whereami 'wanderer 1)
       											))

       (method 'spid (lambda (knpc kpc) (say knpc "森の奥には怪物のようなクモがいる。…雄牛ほどの大きさだ！"
					     "アングリスの子供たち、ワシらはそう呼んでいる。")))
       (method 'angr (lambda (knpc kpc) (say knpc "ただの言い伝えだ。"
					     "森の全てのクモの母、"
                                             "子供らを怖がらせ、子供が森に入らない様にするためのものだ。")))

       (method 'town (lambda (knpc kpc) (say knpc "トリグレイブが一番近い町だ。"
					     "南の道に沿っていけば迷うことはないだろう。")))

       (method 'trol (lambda (knpc kpc) (say knpc "トロルは村の者を食う。"
					     "骨を割り、中の髄まで食ってしまうのだ。"
					     "後には何も残されていなかった。")))

       (method 'wand (lambda (knpc kpc) (say knpc "ワシらは門を通って来る者を迷い人と呼んでおる。"
                                             "その者たちがどこから来て、どこへ行くのかは誰も知らぬ。"
                                             "あなたはその長い、長い道のりの初めにいるのだ。")
                                             (quest-data-update 'questentry-whereami 'wanderer 1)
       										))

       (method 'wise (lambda (knpc kpc) (say knpc "賢者は強く、そしてほとんどは善い者だ。"
                                             "彼らはできうる限りこの地を助け、"
					     "そして呪われた者たちから守っている。")))
       (method 'accu (lambda (knpc kpc) 
                       (say knpc "呪われた者？うわさでは力のために魂を売ったらしい。"
                            "もし賢者がいなければ、このシャルドはやつらに踏みにじられるに違いない。")))

       (method 'witc (lambda (knpc kpc) (say knpc "今ではこの付近では魔女はいないようだ。")))
       ))

;;----------------------------------------------------------------------------
;; Ctor
(define (mk-gregor)
  (bind 
   (kern-mk-char 'ch_gregor ; tag
                 "グレゴール"        ; name
                 sp_human            ; species
                 nil                 ; occ
                 s_old_townsman          ; sprite
                 faction-men         ; starting alignment
                 0 10 5              ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 2  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'gregor-conv        ; conv
                 sch_gregor          ; sched
                 'townsman-ai                 ; special ai
                 nil                 ; container
					   (list t_axe
					         t_armor_leather
					         )              ; readied
                 )
   (gregor-mk)
   ))
