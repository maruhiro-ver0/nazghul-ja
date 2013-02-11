;;----------------------------------------------------------------------------
;; 一般的な会話
;;----------------------------------------------------------------------------

;; 基本
(define (generic-hail knpc kpc)
  (say knpc "こんにちは。"))

(define (generic-unknown knpc kpc)
  (say knpc "それは言えない。"))

(define (generic-bye knpc kpc)
  (say knpc "さようなら。")
  (kern-conv-end))

(define (generic-join knpc kpc)
  (say knpc "仲間にはなれない。"))

(define (generic-leav knpc kpc)
  (cond ((is-player-party-member? knpc)
         (cond ((is-only-living-party-member? knpc)
                (say knpc "まず迷い人を蘇生しなければならない…"
                     "それとも死体を奇術師に売ってしまおうか？"))
               (else
                (say knpc "仲間から外れて欲しい？")
                (cond ((yes? kpc)
                       (cond ((kern-char-leave-player knpc)
                              (say knpc "ここで待っているので、気が変わったら話しかけて欲しい。")
                              (kern-conv-end)
                              )
                             (else 
                              (say knpc "今は別れられない！"))))
                      (else
                       (say knpc "気が動転したよ。"))))))
         (else
          (say knpc "あなた達の一員ではない！"))))

;; 賢者
(define (basic-ench knpc kpc)
  (say knpc "魔道師は魔法使いの賢者だ。"
       "湿地帯の塔に住んでいる。方向を知りたいか？")
  (quest-wise-subinit 'questentry-enchanter)
  (quest-data-update 'questentry-enchanter 'general-loc 1)
  (if (yes? kpc)
      (let ((kplace (get-place knpc)))
        (cond ((equal? kplace p_westpass)
               (say knpc "はしごを下りると東側への道に行ける。"
                    "そこにいる騎士が道を知っているだろう。"))
              ((equal? kplace p_eastpass)
               (say knpc "道を東に進むとトリグレイブだ。そこで聞くとよいだろう。"))
              ((equal? kplace p_trigrave)
                (quest-data-update 'questentry-calltoarms 'directions 1)
               (say knpc "道を北へ行くと湿地帯だ。"))
              (else 
               (say knpc "湿地帯は北西にある。"))
        ))))

;; 町
(define (basic-trig knpc kpc)
  (say knpc "トリグレイブは西の二つの川が合流する場所にある小さな町だ。"))

(define (basic-gree knpc kpc)
  (say knpc "警備隊本部の緑の塔は森の奥深くにある。"
       "方向を知りたいか？")
  (if (yes? kpc)
      (let ((kplace (get-place knpc)))
        (cond ((equal? kplace p_westpass)
               (say knpc "道を東に進み、森に入る。"
                    "小道が見えたら、それをたどっていけばよいだろう。"))
              ((equal? kplace p_eastpass)
               (say knpc "このはしごを下り、西側への道で警備隊員に尋ねなさい。"))
              ((equal? kplace p_trigrave)
               (say knpc "道を東に進み山に入ると東側への道だ。"
                    "そこで聞くとよいだろう。"))
              ((equal? kplace p_enchanters_tower)
               (say knpc "南へ行くとトリグレイブだ。そこで聞くとよいだろう。"))
              ((equal? kplace p_oparine)
               (say knpc "北へ行くとトリグレイブだ。そこで聞くとよいだろう。"))
              ((equal? kplace p_moongate_clearing)
               (say knpc "道を南へ進むと交差点があるので、西へ進む。"
                    "道が北へ向かったらそのまま進み、東の森へ入るとよいだろう。"))
              (else 
               (say knpc "森の中央にある。"))
              ))))

(define (basic-bole knpc kpc)
  (say knpc "ボレの村は森の北にある山脈の谷間にある。"
       "方向を知りたいか？")
  (if (yes? kpc)
      (let ((kplace (get-place knpc)))
        (cond ((equal? kplace p_westpass)
               (say knpc "ここから北東にある。山脈をたどって行くとよいだろう。"))
              ((equal? kplace p_eastpass)
               (say knpc "このはしごを下り、西側への道で警備隊員に尋ねなさい。"))
              ((equal? kplace p_trigrave)
               (say knpc "道を東に進み山に入ると東側への道だ。"
                    "そこで聞くとよいだろう。"))
              ((equal? kplace p_green_tower)
               (say knpc "北の森を抜け、山脈のふもとまで進む。"
                    "その後、少し東へ向かうと行けるだろう。"))
              ((equal? kplace p_enchanters_tower)
               (say knpc "南へ行くとトリグレイブだ。そこで聞くとよいだろう。"))
              (else 
               (say knpc "森の北にある山脈のふもとにあると思う。"))
              ))))
              
(define (basic-absa knpc kpc)
  (say knpc "巨大で堕落した町アブサロットは、その罪で崩壊した。"))

(define (basic-opar knpc kpc)
  (say knpc "オパーリンは南西の深い湾の近くにある。"
       "方向を知りたいか？")
  (if (yes? kpc)
      (let ((kplace (get-place knpc)))
        (cond ((equal? kplace p_westpass)
               (say knpc "はしごを下り、道を西にたどるとよいだろう。"))
              ((equal? kplace p_eastpass)
               (say knpc "道を西にたどるとよいだろう。"))
              ((equal? kplace p_trigrave)
               (say knpc "道を西にたどり、そのあと海までずっと南に進むとよいだろう。"))
              ((equal? kplace p_green_tower)
               (say knpc "南の道をたどり、そのあと西へ行くと西側への道だ。そこで警備隊員に尋ねるとよいだろう。"))
              ((equal? kplace p_enchanters_tower)
               (say knpc "南にトリグレイブがある。そこで尋ねるとよいだろう。"))
              ((equal? kplace p_glasdrin)
               (say knpc "南に進むとよいだろう。"))
              ((equal? kplace p_oparine)
               (say knpc "ここがそうだ！"))
              (else 
               (say knpc "南海岸のどこかにある。"))
              ))))

(define (basic-east knpc kpc)
  (say knpc "Eastpass guards the eastern pass into the River Plain. Do you need directions?")
  (if (yes? kpc)
      (let ((kplace (get-place knpc)))
        (cond ((equal? kplace p_westpass)
               (say knpc "Take the ladder down, you'll come out in Eastpass."))
              ((equal? kplace p_eastpass)
               (say knpc "You're here already."))
              ((equal? kplace p_trigrave)
               (say knpc "Follow the road east and you'll run right into it."))
              ((equal? kplace p_green_tower)
               (say knpc "Travel west through the woods, then follow the road west to Westpass and ask there."))
              ((equal? kplace p_enchanters_tower)
               (say knpc "Go south to Trigrave and ask there."))
              ((equal? kplace p_glasdrin)
               (say knpc "Take the road south as far as you can and ask there."))
              ((equal? kplace p_oparine)
               (say knpc "Take the road north to Trigrave and ask there."))
              (else 
               (say knpc "It's by the mountains west of the Great Forest."))
              ))))

(define (basic-west knpc kpc)
  (say knpc "Westpass guards the western pass into the Great Forest. Do you need directions?")
  (if (yes? kpc)
      (let ((kplace (get-place knpc)))
        (cond ((equal? kplace p_westpass)
               (say knpc "This is it."))
              ((equal? kplace p_eastpass)
               (say knpc "Take the ladder down and you'll come out in it."))
              ((equal? kplace p_trigrave)
               (say knpc "Follow the road east and ask in Eastpass."))
              ((equal? kplace p_green_tower)
               (say knpc "Travel west through the woods, then follow the road west."))
              ((equal? kplace p_enchanters_tower)
               (say knpc "Go south to Trigrave and ask there."))
              ((equal? kplace p_glasdrin)
               (say knpc "Take the road south as far as you can."))
              ((equal? kplace p_oparine)
               (say knpc "Take the road north to Trigrave and ask there."))
              (else 
               (say knpc "Follow the road east from Trigrave."))
              ))))

(define (basic-glas knpc kpc)
  (say knpc "グラスドリンは聖騎士たちの城塞都市だ。方向を知りたいか？")
  (if (yes? kpc)
      (let ((kplace (get-place knpc)))
        (cond ((equal? kplace p_westpass)
               (say knpc "この道を東へ行き、そのあと北へ行けばよいだろう。"))
              ((equal? kplace p_eastpass)
               (say knpc "東へ行き、西側への道で聞くとよいだろう。"))
              ((equal? kplace p_trigrave)
               (say knpc "東へ行き、東側への道で聞くとよいだろう。"))
              ((equal? kplace p_green_tower)
               (say knpc "西の森を抜けると道が見える。それを北に進むとよいだろう。"))
              ((equal? kplace p_enchanters_tower)
               (say knpc "東へ進み山道を抜け、川をたどればよいだろう。"))
              ((equal? kplace p_oparine)
               (say knpc "北の道を進むとトリグレイブだ。そこで聞くとよいだろう。船があれば海岸線を北に進むと行けるだろう。"))
              (else 
               (say knpc "北西の島の海岸の近くにある。"))
              ))))

(define (basic-fens knpc kpc)
  (say knpc "湿地帯は北西にある。"))

(define (basic-kurp knpc kpc)
  (say knpc "クロポリスは地下の古代遺跡だ。"
       "入り口は北の山脈のどこかにある。"))

(define (basic-lost knpc kpc)
  (say knpc "失われた殿堂？吟遊詩人の歌の中でしか聞いたことがない。"
       "本当はどこにあるのかは知らない。"))

;; establishments
(define (basic-whit knpc kpc)
  (say knpc "白き牡鹿荘は緑の塔にある。"))

;; quests
(define (basic-thie knpc kpc)
  (say knpc "泥棒のことはわからない。"))

(define (basic-rune knpc kpc)
  (say knpc "石版のことはよく知らない。賢者に聞けばよいかもしれない。"))

(define (basic-wise knpc kpc)
	(say knpc "賢者はこのシャルドに大きな影響を与えている者たちだ。彼らの名前を知りたいか？")
	(if (yes? kpc)
		(begin
			(say knpc "魔道師、死霊術師、錬金術師、にんげん、技師、そして闘士だ。")
			(map quest-wise-subinit
				(list 'questentry-enchanter 'questentry-warritrix  'questentry-alchemist
						'questentry-the-man 'questentry-engineer  'questentry-necromancer)
			)
		)
	))

(define (basic-shar knpc kpc)
  (say knpc "シャルドとはこの世界の呼び名だ。")
  (quest-data-update 'questentry-whereami 'shard 1)
  )

(define (basic-peni knpc kpc)
  (say knpc "半島とは我々のいるシャルドの端のことだ。"))

(define (basic-warr knpc kpc)
  (say knpc "闘士は戦士の賢者だ。会いたいのであればグラスドリンへ行けばよいだろう。")
  (quest-wise-subinit 'questentry-warritrix)
  (quest-data-update 'questentry-warritrix 'general-loc 1)
  )

(define (basic-engi knpc kpc)
  (say knpc "技師はこの地で最も優れた職人だと聞いたことがある。"
       "しかし、それ以上のことは知らない。")
       (quest-wise-subinit 'questentry-engineer)
       (quest-data-update 'questentry-engineer 'common 1)
       )

(define (basic-man knpc kpc)
  (say knpc "にんげんはならず者の頂点だ。どこにいるのか誰も知らない。"
       "変装して旅をしているとうわさされている。")
       (quest-wise-subinit 'questentry-the-man)
       (quest-data-update 'questentry-the-man 'common 1)
       )

(define (basic-alch knpc kpc)
  (say knpc "錬金術師は賢者の職人で、薬のことは何でも知っている。"
       "オパーリンで会えるだろう。")
       (quest-wise-subinit 'questentry-alchemist)
       (quest-data-update 'questentry-alchemist 'general-loc 1)
       )

(define (basic-necr knpc kpc)
  (say knpc "死霊術師は死の魔法を操る賢者の魔法使いだ。"
       "彼は隠された洞窟に住んでいるらしい。")
       (quest-wise-subinit 'questentry-necromancer)
       (quest-data-update 'questentry-necromancer 'general-loc 1)
       )

(define (basic-drag knpc kpc)
  (say knpc "凶暴な竜が東の海岸近くを通る船を脅かしていると聞いた。"))

(define (basic-fire knpc kpc)
  (say knpc "火の海？東の火山のある島のことだ。"))

(define basic-conv
  (ifc '()
       ;; fundamentals
       (method 'hail generic-hail)
       (method 'default generic-unknown)
       (method 'bye generic-bye)
       (method 'join generic-join)
       (method 'leav generic-leav)
       
       ;; wise
       (method 'ench basic-ench)
       (method 'wise basic-wise)
       (method 'warr basic-warr)
       (method 'man basic-man)
       (method 'engi basic-engi)
       (method 'alch basic-alch)
       (method 'necr basic-necr)

       ;; towns & regions
       (method 'absa basic-absa)
       (method 'bole basic-bole)
       (method 'gree basic-gree)
       (method 'trig basic-trig)
       (method 'lost basic-lost)
       (method 'opar basic-opar)
       (method 'fens basic-fens)
       (method 'shar basic-shar)
       (method 'peni basic-peni)
       (method 'kurp basic-kurp)
       (method 'glas basic-glas)
       (method 'fire basic-fire)

       ;; establishments
       (method 'whit basic-whit)

       ;; quests
       (method 'thie basic-thie)
       (method 'rune basic-rune)

       ;; monsters
       (method 'drag basic-drag)

       ))

;; Helper(s)
(define (say knpc . msg) (kern-conv-say knpc msg))
(define (yes? kpc) (kern-conv-get-yes-no? kpc))
(define (no? kpc) (not (kern-conv-get-yes-no? kpc)))
(define (reply? kpc) (kern-conv-get-reply kpc))
(define (ask? knpc kpc . msg)
  (kern-conv-say knpc msg)
  (kern-conv-get-yes-no? kpc))
(define (prompt-for-key)
  (kern-log-msg "<何かキーを押すと続ける>")
  (kern-ui-waitkey))
(define (meet msg)
  (kern-log-msg msg))
(define (get-gold-donation knpc kpc)
  (let ((give (kern-conv-get-amount kpc))
        (have (kern-player-get-gold)))
    (cond ((> give have)
           (say knpc "代金が足りない！")
           0)
          (else
           (kern-player-set-gold (- have give))
           give))))
(define (get-food-donation knpc kpc)
  (let ((give (kern-conv-get-amount kpc))
        (have (kern-player-get-food)))
    (cond ((> give have)
           (say knpc "代金が足りない！")
           0)
          (else
           (kern-player-set-food (- have give))
           give))))
(define (working? knpc)
  (string=? "working" (kern-obj-get-activity knpc)))

;; Not really an aside in the theatrical sense, this routine causes a party
;; member to interject something into the conversation. kpc is the character
;; being conversed with, mem-tag is either nil or the party member who should
;; do the interjection. If mem-tag is nil then a party member (other than the
;; speaker) will be chosen at random. msg is the text of the comment. If kpc is
;; the only member of the party then the aside will not do anything.
(define (aside kpc kchar-tag . msg)
  ;;(println msg)
  (if (null? kchar-tag)
      (let ((members (filter (lambda (kchar)
                               (not (eqv? kchar kpc)))
                             (kern-party-get-members (kern-get-player)))
                     ))
        (if (not (null? members))
            (let ((kchar (random-select members)))
              (say kchar msg)
              #t)
            #f)
        )
      (if (in-player-party? kchar-tag)
          (begin
            (kern-conv-say (eval kchar-tag) msg)
            #t)
          #f)
      ))
         
;;----------------------------------------------------------------------------
;; 冒険
;;----------------------------------------------------------------------------
(define (mk-quest) (list #f #f #f))
(define (quest-offered? qst) (car qst))
(define (quest-accepted? qst) (cadr qst))
(define (quest-done? qst) (caddr qst))
(define (quest-offered! qst val) (set-car! qst val))
(define (quest-accepted! qst val) (set-car! (cdr qst) val))
(define (quest-done! qst val) (set-car! (cddr qst) val))


;;----------------------------------------------------------------------------
;; 警備隊員との会話
;;----------------------------------------------------------------------------
(define (ranger-ranger knpc kpc)
  (say knpc "警備隊は町と荒野の境界を守っている。"
       "我々は前線を監視し、できるかぎり賢者を助力している。"))

(define (ranger-wise knpc kpc)
  (say knpc "警備隊は賢者と非公式な提携を結んでいる。"
       "賢者達は我々に援助ともてなしを与え、そのかわりに我々は情報を提供している。"
       "時には我々は賢者達の伝言や偵察の任務を受ける。"))

(define (ranger-join knpc kpc)
  (cond ((has? kpc t_ranger_orders 1)
         (say knpc "命令書を見せてください…了解。しばらくの間、同行いたします。")
         (take kpc t_ranger_orders 1)
         (join-player knpc)
         ;; NOTE: the following only permits one ranger at a time to join the
         ;; player!
         (kern-tag 'ch_ranger_merc knpc)
         (give kpc t_arrow 20)
         (kern-conv-end)
         )
        (else
         (say knpc "残念ですが警備の仕事があります。"))))

(define (ranger-band knpc kpc)
  (say knpc "問題を起こした者たちが森に逃げ込むのだ。"
       "森には常に無法者がいる。"))

(define ranger-conv
  (ifc basic-conv
       (method 'join ranger-join)
       (method 'rang ranger-ranger)
       (method 'wise ranger-wise)
       (method 'band ranger-band)
       ))


;; Knight conversation -- used by Lord Froederick's troops
(define knight-conv basic-conv)

;; グラスドリン
(define (glasdrin-warr knpc kpc)
  (if (player-found-warritrix?)
      (say knpc "みな彼女の死を悲しんでいる。")
      (say knpc "闘士はこの時代で最も狡猾な戦士だ。彼女が今どこにいるのかは知らない。統治者かジェフリーズ司令官に聞けばよいだろう。")
  	)
  	(quest-data-update 'questentry-warritrix 'general-loc 1)
  )

(define (glasdrin-stew knpc kpc)
  (if (player-stewardess-trial-done?)
      (say knpc "統治者だった彼女の名は呪われたものとなった。新しい統治者はかつての司令官ヴァルスだ。")
      (say knpc "統治者はこの町とグラスドリンの領土を守っている。普段は本部にいる。")))

(define (glasdrin-jeff knpc kpc)
  (if (player-stewardess-trial-done?)
      (say knpc "よく言っても、ジェフリーズが司令官として指揮下の者を守る義務を怠った。"
           "悪く言えば彼は闘士への裏切りに協力した。"
           "我々の新しい司令官はジャニスだ。")
      (say knpc "ジェフリーズはグラスドリンの軍の司令官だ。普段は本部にいる。")
      ))

(define (glasdrin-kurp knpc kpc)
         (say knpc "北の橋を渡り、山脈を東に沿って行くと、"
              "北の谷間に見えるだろう。"))
(define (glasdrin-cita knpc kpc)
  (say knpc "本部は北側の砦の中にある。"))
(define (glasdrin-ghol knpc kpc)
  (say knpc "逮捕された泥棒がゴレットという名前だったと思う。砦の地下の監獄で確かめるとよいだろう。")
   (quest-data-update 'questentry-ghertie 'gholet-dungeon 1)
   )
(define (glasdrin-kurp knpc kpc)
  (say knpc "現在クロポリスの迷宮には部隊のほとんどがいる。山脈をたどって西へ行くと峡谷に入り口が見つかるだろう。"))

(define (glasdrin-glas knpc kpc)
  (say knpc "グラスドリンは聖騎士の町だ。"))

(define (glasdrin-pala knpc kpc)
  (say knpc "グラスドリンの聖騎士はこのあたりで最も強力な軍隊だ。"))

(define glasdrin-conv
  (ifc basic-conv
       (method 'warr glasdrin-warr)
       (method 'stew glasdrin-stew)
       (method 'jeff glasdrin-jeff)
       (method 'kurp glasdrin-kurp)
       (method 'cita glasdrin-cita)
       (method 'ghol glasdrin-ghol)
       (method 'kurp glasdrin-kurp)
       (method 'glas glasdrin-glas)
       (method 'pala glasdrin-pala)
       (method 'jani 
               (lambda (knpc kpc) 
                 (if (player-stewardess-trial-done?)
                      (say knpc "軍評議会はジャニスをジェフリーズの後任として司令官に選出した。")
                      (say knpc "ジェフリーズは有能な司令官だ。だが、それは補佐のジャニスのおかげだというのは誰でも知っている。"))))
       (method 'valu
               (lambda (knpc kpc)
                 (if (player-stewardess-trial-done?)
                     (say knpc "ヴァルスの潔白が前統治者の日記で明らかになった。"
                          "彼に関する嘘を信じてしまったことは恥ずかしいことだ。"
                          "私たちは彼を新しい統治者に選出した。")
                     (say knpc "ヴァルスは恥じるべき行いで投獄された。"
                          "本当に残念だ。彼は尊敬される将校だった。"))))
       ))

;; Kurpolis
(define kurpolis-conv
  (ifc basic-conv
       ))

;; Green Tower
(define (gt-gobl knpc kpc)
  (say knpc "ゴブリン戦争以降、ずっと不安定な休戦状態にある。彼らは時々商売のためこの町に来る。だが、森で会ったときは気をつけなければならない。"))
(define (gt-towe knpc kpc)
  (say knpc "この町の名前は中央にある古い塔からとったもので、今は警備隊の本部だ。"))
(define (gt-ruin knpc kpc)
  (say knpc "古い遺跡はこの町の南西の角にある。"))
(define (gt-band knpc kpc)
  (say knpc "盗賊のことはデリック隊長に聞けばよいだろう。"
       "その問題に取り組んでいる者の一人だ。"))


(define green-tower-conv
  (ifc basic-conv
       (method 'gree
               (lambda (knpc kpc)
                 (say knpc "そう、この町の名前は中央にある古い塔からとったものだ。")))
       (method 'gobl gt-gobl)
       (method 'towe gt-towe)
       (method 'ruin gt-ruin)
       (method 'band gt-band)
       ))

;; Trigrave
(define trigrave-conv
  (ifc basic-conv
       (method 'thie 
               (lambda (knpc kpc) 
                 (say knpc "泥棒のことはわからない。グベンは旅人とよく話しているので何か知っているかもしれない。")))
       ))

;;----------------------------------------------------------------------------
;; 店員

;; Indices into the merchant message list
(define merch-closed           0)
(define merch-buy              1)
(define merch-sell             2)
(define merch-trade            3)
(define merch-sold-something   4)
(define merch-sold-nothing     5)
(define merch-bought-something 6)
(define merch-bought-nothing   7)
(define merch-traded-something 8)
(define merch-traded-nothing   9)

(define (conv-trade knpc kpc menu msgs catalog)
  (println "conv-trade: " (kern-obj-get-activity knpc))
  ;;(println "conv-trade: " menu msgs catalog)
  (if (and (not (string=? "working" (kern-obj-get-activity knpc)))
           (not (null? (list-ref msgs merch-closed))))
      (say knpc (list-ref msgs merch-closed) 
           "今は"
           (cond ((string=? (kern-obj-get-activity knpc) "idle") "休憩")
                 ((string=? (kern-obj-get-activity knpc) "eating") "食事")
                 ((string=? (kern-obj-get-activity knpc) "drunk") "飲んでいる最")
                 ((string=? (kern-obj-get-activity knpc) "commuting") "移動")
                 (else (kern-obj-get-activity knpc)))
           "中だ。")
      (cond ((string=? menu "buy")
             (say knpc (list-ref msgs merch-buy))
             (if (kern-conv-trade knpc kpc "buy" catalog)
                 (say knpc (list-ref msgs merch-sold-something))
                 (say knpc (list-ref msgs merch-sold-nothing))))
            ((string=? menu "sell")
             (say knpc (list-ref msgs merch-sell))
             (if (kern-conv-trade knpc kpc "sell" catalog)
                 (say knpc (list-ref msgs merch-bought-something))
                 (say knpc (list-ref msgs merch-bought-nothing))))
            (else
             (say knpc (list-ref msgs merch-trade))
             (if (kern-conv-trade knpc kpc "trade" catalog)
                 (say knpc (list-ref msgs merch-traded-something))
                 (say knpc (list-ref msgs merch-traded-nothing))))
            )))

;; 辞書
(kern-dictionary
	"２つ"	"two"	"２つ"
	"６ニン"	"six"	"６人"
	"８ツ"	"eigh"	"８つ"
	"アイ"	"love"	"愛"
	"アイコトバ"	"pass"	"合言葉"
	"アイツラ"	"them"	"あいつら"
	"アイナゴ"	"inag"	"アイナゴ"
	"アカ"	"red"	"赤"
	"アク"	"evil"	"悪"
	"アクマ"	"demo"	"悪魔"
	"アケ"		"open"	"開け"
	"アケル"	"open"	"開ける"
	"アシ"	"leg"	"足"
	"アソブ"	"play"	"遊ぶ"
	"アソンデ"	"play"	"遊んで"
	"アタリ"	"loca"	"あたり"
	"アツメル"	"coll"	"集める"
	"アナ"	"hole"	"穴"
	"アビガイル"	"abig"	"アビガイル"
	"アブサロット"	"absa"	"アブサロット"
	"アラワス"	"reve"	"表す"
	"アレ"	"that"	"あれ"
	"アロペクス"	"alop"	"アロペクス"
	"アングリス"	"angr"	"アングリス"
	"アンサツシャ"	"assa"	"暗殺者"
	"イアル"	"earl"	"イアル"
	"イキ"		"iki"	"イキ"
	"イキカタ"	"ways"	"生き方"
	"イクツカ"	"more"	"いくつか"
	"イケニエ"	"sacr"	"生贄"
	"イシ"	"medi"	"医師"
	"イシン"	"isin"	"イシン"
	"イセキ"	"ruin"	"遺跡"
	"イニ"	"ini"	"イニ"
	"イヌ"	"dog"	"犬"
	"イノチ"	"life"	"命"
	"イマシメ"	"vigi"	"戒め"
	"イリア"	"ilya"	"イリア"
	"イリグチ"	"entr"	"入り口"
	"ウエ"	"hung"	"飢え"
	"ウゴキダシタ"	"wake"	"動き出した"
	"ウタ"	"song"	"歌"
	"ウデ"	"arm"	"腕"
	"ウミ"	"sea"	"海"
	"ウミヘビ"	"sea"	"海ヘビ"
	"ウラギラレ"	"betr"	"裏切られ"
	"ウラギラレタ"	"betr"	"裏切られた"
	"ウラギリ"	"betr"	"裏切り"
	"ウル"		"sell"	"売る"
	"ウロツイテイタ"	"skul"	"うろついていた"
	"ウン"	"luck"	"運"
	"エー"		"eh"	"エー"
	"エイブ"	"abe"	"エイブ"
	"エンジェラ"	"ange"	"エンジェラ"
	"オード"	"ord"	"オード"
	"オオカミ"	"wolf"	"狼"
	"オオザケ"	"drun"	"大酒"
	"オカ"		"hill"	"丘"
	"オカアサン"	"momm"	"お母さん"
	"オカシク"	"stra"	"おかしく"
	"オカシナ"	"woma"	"おかしな"
	"オジイサン"	"gran"	"おじいさん"
	"オジカ"	"stag"	"牡鹿"
	"オスカー"	"osca"	"オスカー"
	"オソレ"	"afra"	"恐れ"
	"オッカサン"	"gher"	"おっかさん"
	"オット"	"husb"	"夫"
	"オトウサン"	"dadd"	"お父さん"
	"オトメ"	"maid"	"乙女"
	"オノ"		"axe"	"斧"
	"オパーリン"	"opar"	"オパーリン"
	"オンドリ"	"chan"	"オンドリ"
	"オンナ"	"lady"	"女"
	"カ"		"ka"	"カ"
	"カイ"		"stor"	"階"
	"カイシュウシャ"	"conv"	"改宗者"
	"カイゾク"	"pira"	"海賊"
	"カイブツ"	"mons"	"怪物"
	"カウ"		"buy"	"買う"
	"カギ"	"key"	"鍵"
	"カギアケドウグ"	"pick"	"鍵開け道具"
	"カケテイマシタ"	"wore"	"掛けていました"
	"カナモノ"	"iron"	"金物"
	"カマ"	"kama"	"カマ"
	"カミ"		"god"	"神"
	"カミガミ"	"gods"	"神々"
	"カルシファクス"	"kalc"	"カルシファクス"
	"カルビン"	"calv"	"カルビン"
	"カルヴィン"	"calv"	"カルヴィン"
	"カワル"	"chan"	"変わる"
	"カンシュ"	"jail"	"看守"
	"ガーティー"	"gher"	"ガーティー"
	"ガンタイ"	"patc"	"眼帯"
	"キ"		"ki"	"キ"
	"キエタ"	"vani"	"消えた"
	"キケン"	"dang"	"危険"
	"キコリ"	"wood"	"木こり"
	"キシ"	"shor"	"岸"
	"キズ"	"scar"	"傷"
	"キソク"	"rule"	"規則"
	"キノコ"	"shro"	"キノコ"
	"キャク"	"clie"	"客"
	"キャスリン"	"kath"	"キャスリン"
	"キュウソク"	"camp"	"休息"
	"キョウカイ"	"bord"	"境界"
	"キョウクン"	"less"	"教訓"
	"キョウボウ"	"sava"	"凶暴"
	"キョジン"	"gint"	"巨人"
	"キライ"	"hate"	"嫌い"
	"ギシ"		"engi"	"技師"
	"ギセイ"	"sacr"	"犠牲"
	"クスリ"	"poti"	"薬"
	"クソ"		"shit"	"クソ"
	"クモ"		"spid"	"クモ"
	"クルッテイル"	"mad"	"狂っている"
	"クロービス"	"clov"	"クロービス"
	"クロシンジュ"	"blac"	"黒真珠"
	"クロポリス"	"kurp"	"クロポリス"
	"グ"		"gu"	"グ"
	"グト"		"guto"	"グト"
	"グノダマ"	"guno"	"グノダマ"
	"グベン"	"gwen"	"グベン"
	"グラスドリン"	"glas"	"グラスドリン"
	"グレゴール"	"greg"	"グレゴール"
	"グン"	"mili"	"軍"
	"ケイビ"	"patr"	"警備"
	"ケイビタイ"	"rang"	"警備隊"
	"ケイムショ"	"pris"	"刑務所"
	"ケガ"	"affl"	"怪我"
	"ケモノ"	"brut"	"獣"
	"ケン"	"swor"	"剣"
	"ケンジャ"	"wise"	"賢者"
	"ゲイザー"	"gaze"	"ゲイザー"
	"ゲンゴ"	"lang"	"言語"
	"ゲンシテキ"	"prim"	"原始的"
	"コウコウ"	"sail"	"航行"
	"コウニン"	"repl"	"後任"
	"コクウ"	"void"	"虚空"
	"コクウセン"	"void"	"虚空船"
	"コジ"	"orph"	"孤児"
	"コッキョウ"	"bord"	"国境"
	"コヤ"		"hut"	"小屋"
	"コレ"	"this"	"これ"
	"コロス"	"kill"	"殺す"
	"コロソウ"	"kill"	"殺そう"
	"コワガラナイ"	"afra"	"怖がらない"
	"ゴフ"	"char"	"護符"
	"ゴブリン"	"gobl"	"ゴブリン"
	"ゴホウシ"	"blow"	"ご奉仕"
	"ゴホン"	"coug"	"ゴホン"
	"ゴレット"	"ghol"	"ゴレット"
	"サイアク"	"wors"	"最悪"
	"サイショ"	"firs"	"最初"
	"サイダン"	"shri"	"祭壇"
	"サイダン"	"shri"	"祭壇"
	"サイラス"	"sila"	"サイラス"
	"サカズキ"	"jugs"	"杯"
	"サカバ"	"tave"	"酒場"
	"サガシタ"	"sear"	"探した"
	"サヨナラ"	"bye"	"さよなら"
	"サンダリング"	"sund"	"サンダリング"
	"シ"	"dead"	"死"
	"シェークスピア"	"shak"	"シェークスピア"
	"シェイクスピア"	"shak"	"シェイクスピア"
	"シキ"		"comm"	"指揮"
	"シゴト"	"job"	"仕事"
	"シゴトガナイ"	"luck"	"仕事がない"
	"シシ"	"lion"	"獅子"
	"シジン"	"bard"	"詩人"
	"シタイ"	"want"	"したい"
	"シッチ"	"fens"	"湿地"
	"シッチタイ"	"fens"	"湿地帯"
	"シヌ"		"die"	"死ぬ"
	"シハイ"	"domi"	"支配"
	"シミン"	"civi"	"市民"
	"シャルド"	"shar"	"シャルド"
	"シュウジン"	"pris"	"囚人"
	"シュウドウジョ"	"num"	"修道女"
	"シュウドウソウ"	"brot"	"修道僧"
	"シュウヨウショ"	"pris"	"収容所"
	"シュウヨウジョ"	"pris"	"収容所"
	"シュウリヤ"	"tink"	"修理屋"
	"シュゴ"	"ward"	"守護"
	"シュゴノジュモン"	"ward"	"守護の呪文"
	"シュゴシャ"	"keep"	"守護者"
	"シュジン"	"innk"	"主人"
	"シュルーム"	"shro"	"シュルーム"
	"ショウカク"	"prom"	"昇格"
	"ショウコ"	"evid"	"証拠"
	"ショウバイ"	"deal"	"商売"
	"ショクジ"	"supp"	"食事"
	"ショクニン"	"wrig"	"職人"
	"ショクニン"	"wrig"	"職人"
	"ショクリョウ"	"food"	"食料"
	"シリョウジュツシ"	"necr"	"死霊術師"
	"シレイカン"	"comm"	"司令官"
	"シロキ"	"whit"	"白き"
	"シロキオジカ"	"whit"	"白き牡鹿"
	"シンエン"	"deep"	"深淵"
	"シンジツ"	"trut"	"真実"
	"シンセキ"	"cous"	"親戚"
	"シンデ"	"dead"	"死んで"
	"シンデン"	"shri"	"神殿"
	"シンヨウ"	"trus"	"信用"
	"ジイン"	"temp"	"寺院"
	"ジェイク"	"jake"	"ジェイク"
	"ジェス"	"jess"	"ジェス"
	"ジェフリーズ"	"jeff"	"ジェフリーズ"
	"ジェン"	"gen"	"ジェン"
	"ジゴク"	"hell"	"地獄"
	"ジダイ"	"age"	"時代"
	"ジヒ"	"merc"	"慈悲"
	"ジム"	"jim"	"ジム"
	"ジャ"	"ja"	"ジャ"
	"ジャアク"	"wick"	"邪悪"
	"ジャニス"	"jani"	"ジャニス"
	"ジュウニ"	"twel"	"十二"
	"ジュウニン"	"inha"	"住人"
	"ジュモン"	"spel"	"呪文"
	"ジョ"		"jo"	"ジョ"
	"ジョーン"	"jorn"	"ジョーン"
	"ジョウホウ"	"news"	"情報"
	"スウハイ"	"hono"	"崇拝"
	"スベキコト"	"ques"	"すべきこと"
	"スミヤキ"	"char"	"炭焼き"
	"ズ"		"zu"	"ズ"
	"ズカキグル"	"zuka"	"ズカキグル"
	"セイキシ"	"pala"	"聖騎士"
	"セイギ"	"just"	"正義"
	"セイサン"	"sacr"	"聖餐"
	"セイト"	"stud"	"生徒"
	"セイハイ"	"holy"	"聖杯"
	"セキニン"	"onus"	"責任"
	"セキバン"	"rune"	"石版"
	"セレネ"	"sele"	"セレネ"
	"センセイ"	"doc"	"先生"
	"センソウ"	"wars"	"戦争"
	"センチョウ"	"capt"	"船長"
	"セントウ"	"warm"	"戦闘"
	"ゼン"	"good"	"善"
	"ゼンセン"	"outp"	"前線"
	"ソウビ"	"equi"	"装備"
	"ソナエモノ"	"offe"	"供え物"
	"タイエキ"	"reti"	"退役"
	"タイマツ"	"torc"	"松明"
	"タカラ"	"fort"	"宝"
	"タスケ"	"help"	"助け"
	"タタカッテ"	"batt"	"戦って"
	"タテ"	"shie"	"盾"
	"タノシイ"	"fun"	"楽しい"
	"タビノキシ"	"knig"	"旅の騎士"
	"タビビト"	"trav"	"旅人"
	"タベモノ"	"food"	"食べ物"
	"タメニ"	"reas"	"ために"
	"タンケン"	"dagg"	"短剣"
	"ダ"		"da"	"ダ"
	"ダイ１"	"firs"	"第１"
	"ダイ２"	"seco"	"第２"
	"ダイ３"	"thir"	"第３"
	"ダイイチ"	"firs"	"第一"
	"ダイキン"	"pay"	"代金"
	"ダイサン"	"thir"	"第三"
	"ダイショウ"	"fail"	"代償"
	"ダイスキ"	"love"	"大好き"
	"ダイニ"	"seco"	"第二"
	"ダシテ"	"free"	"出して"
	"ダンナ"	"husb"	"旦那"
	"チェスター"	"ches"	"チェスター"
	"チエ"	"wit"	"知恵"
	"チカ"	"unde"	"地下"
	"チカラ"	"powe"	"力"
	"チシキ"	"know"	"知識"
	"チチ"	"dadd"	"父"
	"チノウ"	"int"	"知能"
	"チュウトンチ"	"garr"	"駐屯地"
	"チョ"		"cho"	"チョ"
	"チリョウ"	"heal"	"治療"
	"ツ"		"tu"	"ツ"
	"ツキ"	"moon"	"月"
	"ツキサス"	"spit"	"突き刺す"
	"ツクル"	"make"	"作る"
	"ツグナイ"	"pena"	"償い"
	"ツミノナイ"	"inno"	"罪のない"
	"ツレ"	"thin"	"連れ"
	"テ"	"hand"	"手"
	"テキ"	"enem"	"敵"
	"テシタ"	"crew"	"手下"
	"テツダイ"	"chor"	"手伝い"
	"テンショク"	"voca"	"天職"
	"デニス"	"denn"	"デニス"
	"デリック"	"deri"	"デリック"
	"デンドウ"	"lost"	"殿堂"
	"ト"		"to"	"ト"
	"トウ"		"towe"	"塔"
	"トウシ"	"warr"	"闘士"
	"トウゾク"	"band"	"盗賊"
	"トウチシャ"	"stew"	"統治者"
	"トコロ"	"plac"	"所"
	"トシ"	"civi"	"都市"
	"トッテ"	"get"	"取って"
	"トモ"		"kind"	"友"
	"トリグレイブ"	"trig"	"トリグレイブ"
	"トリデ"	"fort"	"砦"
	"トリヒキ"	"trad"	"取り引き"
	"トル"		"get"	"取る"
	"トロル"	"trol"	"トロル"
	"ドウキョニン"	"inn"	"同居人"
	"ドウクツ"	"cave"	"洞窟"
	"ドウブツ"	"anim"	"動物"
	"ドク"	"pois"	"毒"
	"ドチャク"	"nati"	"土着"
	"ドリス"	"dori"	"ドリス"
	"ドレイ"	"slav"	"奴隷"
	"ドロボウ"	"thie"	"泥棒"
	"ドン"	"thud"	"ドン"
	"ナ"		"na"	"ナ"
	"ナカマ"	"join"	"仲間"
	"ナマエ"	"name"	"名前"
	"ナラズモノ"	"wrog"	"ならず者"
	"ニクンデ"	"hate"	"憎んで"
	"ニゲ"		"jink"	"逃げ"
	"ニゲラレナイ"	"esca"	"逃げられない"
	"ニゲル"	"esca"	"逃げる"
	"ニッキ"	"diar"	"日記"
	"ニン"		"nin"	"ニン"
	"ニンゲン"	"man"	"にんげん"
	"ニンム"	"erra"	"任務"
	"ヌ"		"nu"	"ヌ"
	"ヌキ"	"nuki"	"ヌキ"
	"ヌマ"	"fen"	"沼"
	"ネズミ"	"mous"	"ネズミ"
	"ノ"		"no"	"ノ"
	"ノア"	"noor"	"ノア"
	"ノウフ"	"farm"	"農夫"
	"ノウリョク"	"skil"	"能力"
	"ノガレル"	"esca"	"逃れる"
	"ノシファー"	"noss"	"ノシファー"
	"ノミモノ"	"drin"	"飲み物"
	"ノム"	"drin"	"飲む"
	"ノロイ"	"curs"	"呪い"
	"ノロワレタモノ"	"accu"	"呪われた者"
	"ハ"		"ha"	"ハ"
	"ハカ"	"grav"	"墓"
	"ハコ"		"ches"	"箱"
	"ハシリ"	"run"	"走り"
	"ハジ"	"sham"	"恥じ"
	"ハックル"	"hack"	"ハックル"
	"ハナシ"	"stor"	"話"
	"ハナス"	"talk"	"話す"
	"ハムレット"	"haml"	"ハムレット"
	"ハメリュト"	"hame"	"ハメリュト"
	"ハンギャク"	"rebe"	"反逆"
	"ハンシタ"	"rebe"	"反した"
	"ハントウ"	"peni"	"半島"
	"バート"	"bart"	"バート"
	"バイニン"	"sell"	"売人"
	"バルス"	"valu"	"バルス"
	"バレ"	"vale"	"バレ"
	"パーシー"	"perc"	"パーシー"
	"パーシバル"	"perc"	"パーシバル"
	"パスカ"	"pusk"	"パスカ"
	"ヒ"		"hi"	"ヒ"
	"ヒカリ"	"enli"	"光"
	"ヒツジ"	"shee"	"羊"
	"ヒト"	"men"	"人"
	"ヒトビト"	"peop"	"人々"
	"ヒトリ"	"alon"	"独り"
	"ヒドイ"	"nast"	"酷い"
	"ヒドラ"	"hydr"	"ヒドラ"
	"ヒノウミ"	"fire"	"火の海"
	"ヒミツ"	"secr"	"秘密"
	"ヒヤク"	"reag"	"秘薬"
	"ビクトリア"	"vict"	"ビクトリア"
	"ビョウイン"	"hosp"	"病院"
	"ビル"	"bill"	"ビル"
	"ビンショウ"	"dex"	"敏捷"
	"フィン"	"fing"	"フィン"
	"フクシュウ"	"reve"	"復讐"
	"フシ"	"unde"	"不死"
	"フショウ"	"crip"	"負傷"
	"フセイジツ"	"fail"	"不誠実"
	"フセグ"	"guar"	"防ぐ"
	"フタツ"	"two"	"二つ"
	"フテキセツ"	"unna"	"不適切"
	"フネ"	"ship"	"船"
	"フルイ"	"old"	"古い"
	"ブルヌ"	"brun"	"ブルヌ"
	"ブルンデガード"	"brun"	"ブルンデガード"
	"ブンカ"	"cult"	"文化"
	"ブンメイ"	"civi"	"文明"
	"ヘイエキ"	"tour"	"兵役"
	"ヘイワ"	"peac"	"平和"
	"ヘッタ"	"hung"	"減った"
	"ヘヤ"	"room"	"部屋"
	"ヘンリー"	"henr"	"ヘンリー"
	"ホール"	"hole"	"ホール"
	"ホウカイ"	"ruin"	"崩壊"
	"ホンブ"	"cita"	"本部"
	"ボ"		"bo"	"ボ"
	"ボウケンシャ"	"adve"	"冒険者"
	"ボウレイ"	"ghos"	"亡霊"
	"ボナハ"	"bona"	"ボナハ"
	"ボレ"		"bole"	"ボレ"
	"マ"		"ma"	"マ"
	"マキモノ"	"scro"	"巻物"
	"マゴムスメ"	"gran"	"孫娘"
	"マジュツシ"	"wiza"	"魔術師"
	"マジョ"	"witc"	"魔女"
	"マズシイ"	"poor"	"貧しい"
	"マチ"		"town"	"町"
	"マッテ"	"expe"	"待って"
	"マドウシ"	"ench"	"魔道師"
	"マホウ"	"mage"	"魔法"
	"マホウジン"	"roun"	"魔法陣"
	"マホウツカイ"	"wiza"	"魔法使い"
	"マヨイビト"	"wand"	"迷い人"
	"マヨナカ"	"nigh"	"真夜中"
	"ミーニー"	"mean"	"ミーニー"
	"ミツケル"	"find"	"見つける"
	"ミドリノトウ"	"gree"	"緑の塔"
	"ムカシ"	"old"	"昔"
	"ムスメ"	"daug"	"娘"
	"ムラ"		"folk"	"村"
	"ムレ"	"hord"	"群れ"
	"メ"		"me"	"メ"
	"メイ"		"may"	"メイ"
	"メイキュウ"	"dung"	"迷宮"
	"メリュキ"	"melu"	"メリュキ"
	"メルビン"	"melv"	"メルヴィン"
	"メルヴィン"	"melv"	"メルヴィン"
	"モウモク"	"blin"	"盲目"
	"モクテキ"	"aspi"	"目的"
	"モノ"	"stuf"	"物"
	"モリ"		"wood"	"森"
	"モン"		"gate"	"門"
	"ヤ"		"arro"	"矢"
	"ヤア"		"hail"	"やあ"
	"ヤシン"	"ambi"	"野心"
	"ヤッカイ"	"trou"	"やっかい"
	"ヤッツ"	"eigh"	"八つ"
	"ヤマイ"	"sick"	"病"
	"ヤメル"	"quit"	"辞める"
	"ヤワラカ"	"soft"	"柔らか"
	"ユウレイ"	"haun"	"幽霊"
	"ユビワ"	"ring"	"指輪"
	"ヨクボウ"	"desi"	"欲望"
	"ラクシマニ"	"luxi"	"ラクシマニ"
	"リア"	"lia"	"リア"
	"リッチ"	"lich"	"リッチ"
	"リャクダツ"	"sack"	"略奪"
	"リュ"		"lu"	"リュ"
	"リュウ"	"drag"	"竜"
	"リョウイキ"	"real"	"領域"
	"リョウシン"	"pare"	"両親"
	"リョウド"	"real"	"領土"
	"リョウホウ"	"both"	"両方"
	"リョウリ"	"cook"	"料理"
	"リョウリニン"	"cook"	"料理人"
	"リンジン"	"neig"	"隣人"
	"ル"		"ru"	"ル"
	"ルカ"	"ruka"	"ルカ"
	"ルミス"	"lumi"	"ルミス"
	"レイ"	"spir"	"霊"
	"レキシ"	"hist"	"歴史"
	"レンキンジュツシ"	"alch"	"錬金術師"
	"レンシュウ"	"prac"	"練習"
	"ロイヤルケープ"	"cape"	"ロイヤルケープ"
	"ロウ"	"cell"	"牢"
	"ロクニン"	"six"	"六人"
	"ワカレル"	"leav"	"別れる"
	"ワスレラレタ"	"forg"	"忘れられた"
	"ワッテ"	"chop"	"割って"
	"ワンリョク"	"stre"	"腕力"
	"ヴァルス"	"valu"	"ヴァルス"
	"ヴァレ"	"vale"	"ヴァレ"
	"ヴィクトリア"	"vict"	"ヴィクトリア"
	"木"		"tree"	"木"
	"目"		"eye"	"目"
	"火"		"fire"	"火"
)
