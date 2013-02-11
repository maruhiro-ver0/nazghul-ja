;;----------------------------------------------------------------------------
;; Schedule
;; 
;; 緑の塔
;;----------------------------------------------------------------------------
(define (mk-zone x y w h) (list 'p_green_tower x y w h))
(kern-mk-sched 'sch_gen
               (list 0  0  (mk-zone 2  13 1  1)  "sleeping")
               (list 4  0  (mk-zone 3  12 3  3)  "eating")
               (list 5  0  gt-woods  "idle")
               (list 10 0  (mk-zone 26 27 2  12) "idle")
               (list 12 0  (mk-zone 49 54 1  1)  "eating")
               (list 13 0  (mk-zone 49 3  7  2)  "idle")
               (list 14 0  (mk-zone 7  20 5  5)  "idle")
               (list 18 0  (mk-zone 49 54 1  1)  "eating")
               (list 19 0  (mk-zone 3  12 3  3)  "idle")
               (list 0  0  (mk-zone 2  13 1  1)  "sleeping")
               )

;; ----------------------------------------------------------------------------
;; ジェンのゴブリン単語集
;; ----------------------------------------------------------------------------
(mk-reusable-item 
 't_goblin_lexicon "ゴブリン語単語集" s_lexicon norm
 (lambda (klexicon kuser)
   (kern-ui-page-text
   "ゴブリン語単語集"
   "これはゴブリン語を学ぶ助けとするために書かれた"
   "ものである。役立つことを望む。"
   "−ジェン"
   ""
   "ボ……私の、私自身"
   "チョ…人間"
   "ダ……家、世界"
   "エー…「何？」"
   "グ……魂、祖先"
   "ハ……良い、はい、巧みな"
   "ヒ……呪術"
   "イキ…行く、〜で"
   "ジョ…加わる"
   "カ……殺す、壊れる、終わる"
   "キ……健康、生命力、力"
   "リュ…交換、変化、変身"
   "マ……森、隠された道"
   "メ……役目、仕事、運命"
   "ナ……あなたの、あなた自身"
   "ヌ……生む、作る、始まる"
   "ノ……名前"
   "ニン…隠された"
   "ル……古代、原始、深い、洞窟"
   "ト……者"
   "ツ……いいえ、悪い"
   "ズ……見る、探す"
   )))

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (gen-mk will-join? gave-notes?) (list will-join? gave-notes?))
(define (gen-will-join? gen) (car gen))
(define (gen-gave-notes? gen) (cadr gen))
(define (gen-set-will-join! gen val) (set-car! gen val))
(define (gen-set-gave-notes! gen val) (set-car! (cdr gen) val))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ジェンは警備隊員で緑の塔に住んでいる。
;; 彼はゴブリンの知識があり、カマの友人でもある。
;; ジェンは仲間になる。
;;----------------------------------------------------------------------------
(define (gen-hail     gen player) (say gen "こんにちは、迷い人さん。"))
(define (gen-bye      gen player) (say gen "さようなら。"))
(define (gen-default  gen player) (say gen "それはわかりません。"))
(define (gen-name     gen player) (say gen "私はジェン。"))
(define (gen-woodsman gen player) (say gen "そう、私を森人と呼ぶ者もいます。" ))
(define (gen-job      gen player) (say gen "かつて私は警備隊員でした。しかし、その勤めを終えました。今では自分のために森を歩き回っています。" ))
(define (gen-reasons  gen player) (say gen "自分のためにです。" ))

(define (gen-captain gen player) 
  (say gen "デリック隊長は緑の塔で警備隊を指揮しています。もう会いましたか？")
  (if (kern-conv-get-yes-no? player)
      (say gen "有能な男ですが、少々野心的です。")
      (say gen "塔にいます。彼の事務所は二階にあります。")))

(define (gen-ambitious   gen player) (say gen "平和なときには、人はつつましく謙虚にはならないものです。"))
(define (gen-culture     gen player) 
  (say gen "独自の文化ですが、本当の文化を持っています(トロルや首なしとは違って)。"
       "シェイクスピアの中にあるように、それは異なる人々を超えて存在するものです。"))
(define (gen-shakespeare gen player)
  (say gen "彼を知っているのですか！すばらしい！")
  (if (in-player-party? 'ch_kama)
      (say gen "［彼はカマを見た。］彼はその詩人を知るもう一人です！彼の語るハムレットはぜひ聞くべきです！")
      ))

(define (gen-ranger gen player) (say gen "警備隊はゴブリン戦争の間この森で戦いましたが、今では形式的な存在です。"))
(define (gen-wars   gen player) (say gen "はい。私は警備隊員としてゴブリン戦争で戦いました。一世代前のことで、人々は忘れています。"
				     "人々はゴブリンを劣った存在、敗れ去り消えるべき存在とみなしています。"))
(define (gen-goblin gen player) (say gen "興味深い種族です。彼らは独自の言語を使いますが、文字を持っていません。"
				     "人と似ていますが、より凶暴で、より原始的です。"
				     "彼らの兵士は狂戦士で、呪術師は恍惚としています。"))
(define (gen-primal gen player) (say gen "私は彼らを尊敬しています。しかし、戦争のころは彼らのことを知りませんでした。"
				     "今では森ゴブリンの友人がいます。洞窟ゴブリンはまた別ですが…" ))
(define (gen-cave   gen player) (say gen "洞窟ゴブリンは、森の者より大きくて力が強く、この世界の奥深くで生きることを好む者たちです。"
				     "彼らの闇の神は生贄を求めます。洞窟を探検するときは彼らに気をつけることです。彼らの心は人間への憎しみで燃えています。" ))

(define (gen-language kgen player)
  (let ((gen (kobj-gob-data kgen)))
    (say kgen "そうです。私は少しゴブリン語を話せます。知りたいですか？")
    (if (kern-conv-get-yes-no? player)
        (if (gen-gave-notes? gen)
            (say kgen "私の単語集で学んでください。そして私を相手に練習してください。")
            (begin
              (say kgen "彼らの言語についてまとめたものです。受け取ってください。私を相手に自由に練習してください。")
              (kern-obj-add-to-inventory player t_goblin_lexicon 1)
              (gen-set-gave-notes! gen #t)))
        (say kgen "それでは別の機会に。"))))


(define (gen-practice gen player) (say gen "ゴブリンと話す練習をしたいのであれば、私にゴブリン語で話しかけてください！" ))

(define (gen-join gen player)
  (if (gen-will-join? (kobj-gob-data gen))
      (begin
        (say gen "わかりました。仲間に加わりましょう。"
             "装備が必要です。この町の西にある私の小屋へ行って、箱の中のものを取りに行きましょう。"
             "では改めて。友よ！")
             (join-player gen))
      (say gen "いいえ。森の言葉で私の名前を言ってください。")))

;; SAM: Added a few words from the Lexicon which were not defined as responses.
;;      These were (Iki, Lu, Nin)
;;      Also enhanced a few responses such as for (Eh).
;; Added responses having to do with the concepts of Wanderer, Warrior, Wizard, Rogue, Wright.
;; A bit of organization/tidying may still be wanted, to make sure there are no loose ends .

(define (gen-da  gen player) (say gen "ハ！ダ・マ・トは森ゴブリンを意味します。" ))
(define (gen-gu  gen player) (say gen "ハ！ダ・グは世界という意味です。" ))
(define (gen-ru  gen player) (say gen "ハ！ダ・ル・トは洞窟ゴブリンを意味します。" ))
(define (gen-no  gen player) (say gen "ボ・ノ・ジェン。でもゴブリンたちは私をマ・ズ・トと呼びます。" ))
(define (gen-ki  gen player) (say gen "ボ・ハ・キ！私は元気です。" ))
(define (gen-jo  gen player) (say gen "とてもすばらしいことです！ゴブリンの助けが必要なら、彼はあなたの冒険に加わるでしょう。"))
(define (gen-cho gen player) (say gen "ハ！チョ・トは人間を意味します。" ))
(define (gen-nu  gen player) (say gen "ハ！ヌ・キはゴブリンの言葉で「食べ物」です。" ))
(define (gen-ha  gen player) (say gen "ええ。ハは肯定を表す言葉です。" ))
(define (gen-tu  gen player) (say gen "その通り。ツは否定の言葉です。" ))
(define (gen-bo  gen player) (say gen "そう、ボ・グはあなたの魂、霊的な世界のあなたを意味します。" ))
(define (gen-na  gen player) (say gen "はい。ボ・ナは「私たち」、または「一族」です。ボ・ナ・マは森ゴブリン一般を指します。" ))
(define (gen-to  gen player) (say gen "その通り。トを付けると何かをする者を表します。" ))
(define (gen-ma  gen player) (say gen "そう、カ・マ・トは木こりを表す言葉です。" ))
(define (gen-eh  gen player) (say gen "エー？ああ、そう、エー・ナ・メはあなたの仕事、または役割は何ですか？という意味です。" ))
(define (gen-iki gen player) (say gen "ハ！ボ・イキ・ダは「私は家へ戻る」という意味です。"))

(define (gen-me  gen player) (say gen "ボ・マ・ズ、私は森を監視している、または隠された道を探している。メ・ル・キは成長、変化、学び、探求、それは迷い人の道です！"))
(define (gen-ka  gen player) (say gen "ハ！カ・ハ・トは戦士を、そしてメ・カ・ハは戦士の生き様を表します！"))
(define (gen-hi  gen player) (say gen "ハ！ヒ・マ・トは「呪術師」のことです。そして「メ・ハ・ズ・ル」は魔術師の生き様です！"))
(define (gen-nin gen player) (say gen "ハ！ニン・マ・トは森の隠密です。そしてメ・ハ・ニン・ズはならず者の生き様です！"))
(define (gen-lu  gen player) (say gen "ハ！リュ・ダ・トは作る者です。そしてメ・ハ・リュ・ダは大工の生き様です！"))

(define (gen-zu       gen player) (say gen "すばらしい！そしてズ・トは探求者、または迷い人のことです。［彼は鋭い目であなたを見た。］イキ・メリュキ？"))
(define (gen-meluki   gen player) (say gen "そう。あなたは探求者です。もしあなたがグノダマを習得したなら仲間になりましょう。"))
(define (gen-gunodama gen player) (say gen "森に住む祖先の魂から与えられた名前、別の言葉で言えば森ゴブリンの言葉のことです。"))

(define (gen-nuki knpc kpc)
  (say knpc "それはゴブリン語で「食べ物」です。"))

(define (gen-bonaha gen player) 
  (say gen "すばらしい！それはゴブリンの言葉で友人です。ゴブリンの言葉がわかってきたようですね。")
  (gen-set-will-join! (kobj-gob-data gen) #t))

(define (gen-shroom gen player) (say gen "彼女は古くからの友人です。ゴブリン戦争の頃は戦場の乙女だったと言ったら信じますか？"))
(define (gen-maiden gen player) (say gen "本当です！彼女が息を切らせて守護の呪文を唱えながら、月明かりで輝く手斧でゴブリンの部隊をなぎ倒し道を切り開く姿を今でも覚えています。"
                                   "彼女の活躍は目を見張るものがありました。"))

(define (gen-thie knpc kpc)
  (say knpc "このあたりでは怪しい者は見ませんでした。"
       "でも、北の森に住むゴブリンが、最近北東のボレに一人で向かう者を見たそうです。")
       (quest-data-update 'questentry-thiefrune 'tower 1)
       (quest-data-update-with 'questentry-thiefrune 'bole 1 (quest-notify (grant-party-xp-fn 10)))
       )

(define (gen-kama knpc kpc)
  (if (is-player-party-member? ch_kama)
      (begin
        (say knpc "カマはあなたに加わったようですね。ボナハ　カマ！")
        (say ch_kama "ウン。　ボナハ　マズト。"))
      (begin
        (say knpc "カマはゴブリンの狩人です。彼とはこの町の角で何日か前の夜に会うことになっていたのですが、現れませんでした。彼と会ったことがありますか？")
        (if (yes? kpc)
            (begin
              (say knpc "何か困っていましたか？")
              (if (yes? kpc)
                  (say knpc "できるなら助けに行きたい！")
                  (say knpc "安心しました！")))
            (say knpc "もし会ったら知らせてください。少し心配です。")))))
            
(define (gen-ruka knpc kpc)
  (say knpc "ルカとはゴブリンたちのアングリス、死の女神の呼び名です。"
       "アングリスの神官たちは戦争の間、ゴブリンを死へと駆り立てていました。"
       "彼女への信仰は戦争に負けてから廃れてしまいました。")
  (prompt-for-key)
  (say knpc "今では彼女は子供を森に近づけさせないための単なる言い伝えです。"
       "森にはもっと危険なものがいますからね。"))

(define (gen-clov knpc kpc)
  (say knpc "クロービス王はゴブリン戦争で聖騎士たちを導いた者です。"
       "もし友人のカマと会えれば、彼の亡骸がどうなったか聞くことができます。")
       (quest-data-update-with 'questentry-rune-f 'kama 1 (quest-notify nil))
       )

(define (gen-band knpc kpc)
  (say knpc "ゴブリン達は盗賊の小屋が南か西のどこかにあると言っていました。"
       "デリック隊長はもっと詳しいことを知っているかもしれません。"))

(define gen-conv
  (ifc basic-conv
       ;;;; Goblin root words:
       (method 'bo  gen-bo)  ; My, Myself
       (method 'cho gen-cho) ; Mankind
       (method 'da  gen-da)  ; Abode, World
       (method 'eh  gen-eh)  ; What?
       (method 'gu  gen-gu)  ; Spirit, Ancestor
       (method 'ha  gen-ha)  ; Good, yes, skillful
       (method 'hi  gen-hi)  ; Magic
       (method 'iki gen-iki) ; Go
       (method 'jo  gen-jo)  ; Join
       (method 'ka  gen-ka)  ; Kill
       (method 'ki  gen-ki)  ; Health
       (method 'lu  gen-lu)  ; Change
       (method 'me  gen-me)  ; Forest
       (method 'ma  gen-ma)  ; Duty, Job, Destiny
       (method 'na  gen-na)  ; Your, yourself
       (method 'nin gen-nin) ; Stealth
       (method 'no  gen-no)  ; Name
       (method 'nu  gen-nu)  ; Give birth, Create, Begin
       (method 'ru  gen-ru)  ; Ancient, Primordial, Deep, Cave
       (method 'to  gen-to)  ; Individual
       (method 'tu  gen-tu)  ; No, Bad
       (method 'zu  gen-zu)  ; Watch, Seek

       ;;;; Goblin composite words / phrases:
       (method 'bona gen-bonaha)   ; Friend
       (method 'kama gen-kama)     ; Kama, the goblin friend of Gen
       (method 'nuki gen-nuki)     ; Food
       (method 'ruka gen-ruka)     ; Angriss, the Spider Queen
       (method 'melu gen-meluki)   ; Seeker, Wanderer
       (method 'guno gen-gunodama) ; the language of the Forest Goblins

       ;;;; Responses in human speech:
       ;; Standard responses:
       (method 'default gen-default)
       (method 'hail gen-hail)
       (method 'name gen-name)
       (method 'job  gen-job)
       (method 'join gen-join)
       (method 'bye  gen-bye)

       ;; Having to do with the goblin language:
       (method 'gobl gen-goblin)
       (method 'lang gen-language)
       (method 'prac gen-practice)

       ;; Other responses:
       (method 'admi gen-primal)
       (method 'ambi gen-ambitious)
       (method 'band gen-band)
       (method 'capt gen-captain)
       (method 'deri gen-captain)
       (method 'cave gen-cave)
       (method 'fore gen-job)
       (method 'maid gen-maiden)
       (method 'prim gen-primal)
       (method 'rang gen-ranger)
       (method 'reas gen-reasons)
       (method 'sava gen-primal)

       (method 'cult gen-culture)
       (method 'shak gen-shakespeare)
       (method 'bard gen-shakespeare)  ;; synonyn
       (method 'haml gen-shakespeare)  ;; synonyn

       (method 'shro gen-shroom)
       (method 'thie gen-thie)
       (method 'wars gen-wars)
       (method 'wood gen-woodsman)
       (method 'clov gen-clov)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-gen tag)
  (bind 
   (kern-mk-char tag                 ; tag
                 "ジェン"            ; name
                 sp_human            ; species
                 oc_ranger           ; occ
                 s_old_ranger  ; sprite
                 faction-men         ; starting alignment
                 4 2 4           	 ; str/int/dex
                 pc-hp-off  ; hp bonus
                 pc-hp-gain ; hp per-level bonus
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 3  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'gen-conv           ; conv
                 sch_gen             ; sched
                 'townsman-ai        ; special ai
                 (mk-inventory (list (list 1 t_dagger) 
				     (list 1 t_playbook_hamlet)
				     ))  ; container
                 (list t_armor_leather)                ; readied
                 )
   (gen-mk #f #f)))
