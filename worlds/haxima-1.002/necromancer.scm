;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define necr-lvl 8)
(define necr-species sp_human)
(define necr-occ oc_wizard)

;;----------------------------------------------------------------------------
;; Schedule
;;----------------------------------------------------------------------------
(define necr-bed nl-bed)
(define necr-mealplace nl-tbl)
(define necr-workplace nl-lab)
(define necr-leisureplace nl-lib)
(kern-mk-sched 'sch_necr
               (list 0  0 necr-bed          "sleeping")
               (list 7  0 necr-mealplace    "eating")
               (list 8  0 necr-workplace    "working")
               (list 12 0 necr-mealplace    "eating")
               (list 13 0 necr-workplace    "working")
               (list 18 0 necr-mealplace    "eating")
               (list 19 0 necr-leisureplace "idle")
               (list 22 0 necr-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (necr-mk) 
  (mk-quest))
(define (necr-quest gob) gob)

;;----------------------------------------------------------------------------
;; Conv
;;----------------------------------------------------------------------------

;; Basics...
(define (necr-hail knpc kpc)
  (let ((quest (necr-quest (kobj-gob-data knpc))))
    (if (and (quest-offered? quest)
             (not (quest-done? quest))
             (in-inventory? kpc t_lich_skull)
             )
        (necr-meet-lich knpc kpc)
        (say knpc "［あなたは色が白く痩せた、全身黒ずくめの魔術師と会った。］"
             "(ゴホン)ようこそ、迷い人よ。"))))

(define (necr-default knpc kpc)
  (say knpc "［彼は咳でむせている。］"))

(define (necr-heal knpc kpc)
  (begin
    (say knpc "\n［彼は咳き込んでいる。］\n"
         "大丈夫だ。［ゴホン］［ゼーゼー］")
    (prompt-for-key)

    (say knpc "よいか。\n")
    (prompt-for-key)

    (say knpc "\nワシは大丈…［ゴホン］")
    (prompt-for-key)

    (say knpc "\n［ゼーゼー］…")
    (prompt-for-key)

    (say knpc "［ウグッ］")
    (kern-sleep 100)
    (say knpc "［倒れた。］")
    (kern-sleep 100)
    (say knpc "［ハーハー］")
    (kern-sleep 3000)
    (say knpc "…………")
    (prompt-for-key)

    (say knpc "\n［沈黙した。］")
    (prompt-for-key)

    (if (in-player-party? 'ch_mesmeme)
	(begin	
	  (say knpc "\n［沈黙が続いた…］")
	  (kern-sleep 3000)
	  (aside kpc 'ch_mesmeme "［倒れた姿を見た。］\n食事？")
	  (aside kpc 'ch_amy "うぇーっ！悪いゲイザーめ！")
	  (prompt-for-key)
	  )
	)

    (if (in-player-party? 'ch_nate)
	(begin
	  (say knpc "\n［死にそうな音を立てている。］")
	  (kern-sleep 3000)
	  (aside kpc 'ch_nate "えー…")
	  (kern-sleep 100)
	  (aside kpc 'ch_nate "まずいかな…")
	  (kern-sleep 1000)
	  (aside kpc 'ch_nate "…コイツの物を盗っていったら？")
	  (kern-sleep 500)
	  (aside kpc 'ch_roland "馬鹿者！不名誉なことを！")
	  (prompt-for-key)
	  )
	)
    
    (if (in-player-party? 'ch_amy)
	(begin
	  (aside kpc 'ch_amy "どこかに…墓穴を掘ったほうがいいかしら？")
	  (prompt-for-key)
	  )
	)

    (kern-sleep 3000)
    (say knpc
	 "\n［彼はまだ痙攣している。］\n"
	 "［彼は胸のあたりを手探りした。］\n"
	 "　^c+bイン・ヴァス・マニ・コープ・ゼン<IN VAS MANI CORP XEN>^c-\n"
	 "")
    ;; (vas-mani knpc)  ;; SAM: Alas, this invoked UI, and emitted extra messages
    (say knpc
	 "\n［彼は起き上がり、深く息を吸った。］\n"
	 "大丈夫と言っているだろう。すまんな。")
    ))

(define (necr-name knpc kpc)
  (say knpc "ワシが死霊術師だ。"))

(define (necr-join knpc kpc)
  (say knpc "ワシは冒険者ではない。"))

(define (necr-job knpc kpc)
  (say knpc "死の秘密を解き明かすことだ。"))

(define (necr-bye knpc kpc)
  (say knpc "［彼は咳をしながらあなたを追い払った。］"))

;; L2
(define (necr-dead knpc kpc)
  (say knpc "死？まだ死んでおらぬ。おまえはどうだ？")
  (if (yes? knpc)
      (say knpc "強き霊を持っておらぬように見える。")
      (say knpc "そうは思わぬ。"
           "だが、多くの霊と話してきたが、おまえの霊とはこれ以上話せないようだ。")))

(define (necr-coug knpc kpc)
  (say knpc "ずっと前タバコをやっていた。今でもたまに吸う。"))

(define (necr-spir knpc kpc)
  (say knpc "いくつかのとても古い霊は歴史より前のことを知っている。(ゴホン)"
       "もし何か知りたいことがあれば、それを知る霊がどこかにいるはずだ。"))

;; Quest-related
(define (necr-meet-lich knpc kpc)
  (if (quest-done? (necr-quest (kobj-gob-data knpc)))
      (begin
        (say knpc "ラクシマニ王の霊に尋ねよ！彼が見えるか？")
        (if (no? kpc)
            (begin
              (say knpc "おお、失礼。これでよいだろう。\n"
		   "［彼は魔法の言葉を唱えた。］"
		   "　^c+bウィス・クァス<WIS QUAS>^c-！")
              (wis-quas knpc))
            (say knpc "うむ…")))
      (begin
        (say knpc "おお！ラクシマニ王の頭蓋骨を持ってきたな！"
             "これでよい話が聞けるに違いない。"
             "だが少し待て。今ここに…")
        (kern-obj-remove-from-inventory kpc t_lich_skull 1)
        (say knpc "\n［彼は魔法の言葉を唱えた。］\n"
             "　^c+bカル・アン・ゼン・コープ<KAL AN XEN CORP>^c-！"
             "ラクシマニよ、現れよ！")
        (kern-obj-put-at (mk-luximene)
                         (loc-offset (kern-obj-get-location knpc)
                                     south))
        (quest-done! (necr-quest (kobj-gob-data knpc)) #t)
        (say knpc "ここだ！彼が見えるか？")
        (if (no? kpc)
            (begin
              (say knpc "無論、彼の霊は力のない者には見ることができぬ。\n"
                   "これでよいだろう。\n"
                   "［彼は魔法の言葉を唱えた。］"
                   "　^c+bウィス・クァス<WIS QUAS>^c-！")
              (wis-quas knpc))
            (say knpc "石版のことを聞きなさい。")))))

(define (necr-rune knpc kpc)
  (let ((quest (necr-quest (kobj-gob-data knpc))))
    (if (quest-offered? quest)
        (if (in-inventory? kpc t_lich_skull)
            (necr-meet-lich knpc kpc)
            (if (quest-done? quest)
                (begin
                  (say knpc "ラクシマニ王の霊に尋ねよ！彼が見えるか？")
                  (if (no? kpc)
                      (begin
                        (say knpc "可視の呪文を試してみよう…\n"
			     "［彼は魔法の言葉を唱えた。］\n"
			     "　^c+bウィス・クァス<WIS QUAS>^c-\n"
			     "彼の影に話しかけ、石版のことを尋ねなさい。")
			(wis-quas knpc)
			(kern-conv-end)
			)
                      (begin
			(say knpc "よろしい。彼の影に尋ねなさい。")
			(kern-conv-end)
		      )
		  ))
                (say knpc "リッチとなったラクシマニ王の頭蓋骨を持ってくるのだ。"
                     "それで多くのことがわかる。")))
        (if (not (any-in-inventory? kpc rune-types))
            (say knpc "多くの石版を見てきた。(ゴホン)"
                 "何か一つ持ってくれば語れるかも知れぬ。")
            (begin
              (say knpc "ふむ。そうだ。"
                   "この石版に書かれた文字は、かつてラクシマニ王の墓で見たものと同じだ。(ゴホン)"
                   "彼の霊に尋ねれば何か答えてくれるかもしれぬ。"
                   "迷い人よ、おまえは勇敢かね？")
              (if (no? kpc)
                  (say knpc "私もだ。残念ながら。"
                         "この石版は興味をそそるのだが。(ゴホン)")
                  (begin
                    (say knpc "そうだと思った。"
                         "ラクシマニ王は今ではリッチとなっている。"
                         "最も凶暴な！"
                         "彼の墓は緑の塔の地下にある遺体安置所の中にある。"
                         "もし彼の頭蓋骨を持ってくれば、彼の霊をなだめ、話せるだろう。(ゴホン)"
                         "もちろんまず彼を、その手下と共に倒さねばならん。"
                         "不死の者を近づけさせない方法を知ってるかね？")
                    (quest-offered! quest #t)
                    (if (yes? kpc)
                        (say knpc "怒れる不死の者を扱うには最もよい呪文だ。")
                        (say knpc "覚えておけ。アン・ゼン・コープ<An Xen Corp>だ。"
                             "最も有効な呪文である。\n"
                             "^c+g大蒜^c-と^c+g硫黄の灰^c-を調合せよ。\n"
                             "(ゴホン)\n"
                             "いくらかこのあたりにあるはずだ。"
                             "持って行ってよいぞ。"))
		    )))))))

(define (necr-absa knpc kpc)
  (say knpc "ああ、アブサロット、古き知性の都、今は失われた。"
       "行ったことはあるかね？")
  (if (yes? kpc)
      (say knpc "今となっては恥辱の遺跡でしかない。")
      (begin
        (say knpc "グラスドリンの言い分を支持するかね？")
        (if (yes? kpc)
            (say knpc "［彼は咳払いをしてつぶやいた。］"
                 "ううむ…今ではそこには見るべきものは何もない。")
            (say knpc "秘密の道がある。錬金術師に尋ねなさい。彼が知っている。")))))

;; the wise
(define (necr-ench knpc kpc)
  (say knpc "あの愚かな年寄りはワシを呪われた者の一味と考えておる！"
       "奴は自分の道が唯一の道ではないことがわからないようだ。")
       )

(define (necr-man knpc kpc)
  (say knpc "彼女は情報が必要なとき会いに来ることがある…"
       "そしてワシの物を取っていくことがある…。")
  (quest-data-update 'questentry-the-man 'common 1)
  )

(define (necr-alch knpc kpc)
  (say knpc "賢い男だ。深く、よき自らの道を進んでいる。")
  (quest-data-update 'questentry-alchemist 'common 1)
  )

(define (necr-engi knpc kpc)
  (say knpc "賢明、そして好奇心を忘れないでいる。"
       "しかし、いつも何かを作っている。"
       "作り終えたと思えば、すぐに別のものを作り始める！(ゴホン)"
       "何か価値あるものと向き合うことは決してないであろう。")
       (quest-data-update 'questentry-engineer 'common 1)
       )

(define (necr-warr knpc kpc)
	(if (quest-data-assigned? 'questentry-wise)
		(begin
		  (say knpc "ああ、彼女は朽ちてしまった。"
		       "彼女の霊と虚空の中で会った。"
		       "グラスドリンの指導者に殺されたのだ。"
		       "神は我らを見捨てたのか。ヴァレ、復讐の王よ、まだこのシャルドにいるか！")
		       (quest-data-update 'questentry-warritrix 'slain 1)
		 )
		 (say knpc "遠い過去から、あれほど気高き騎士はいないであろう。")
       ))

(define (necr-vale knpc kpc)
  (say knpc "古き神、今はただ死んだことだけが知られている。"))

(define (necr-wise knpc kpc)
  (say knpc "それは遠い過去からのしきたりで、戦士、魔術師、ならず者の道を究めた者が、"
       "このシャルドを導くのだ。"
       "それは長いしきたりの鎖で、虚空の中の最も古い霊にまでさかのぼることができる。"))

(define (necr-accu knpc kpc)
  (say knpc "憎むべき者だ！(ゴホン)彼らの信仰は約500年前、もしかするとそれ以上前に始まっていると古い霊が話してくれた。"
       "だが、彼らの秘密は知らぬ。"
       "なぜなら彼らの霊は虚空には帰らないからだ！")
  (prompt-for-key)
  (say knpc "［彼は困惑しているようだ。］"
       "これまでの人生で呪われた者の死者を見たことがない。"
       "それが最もわからぬのだ。"))

(define (necr-gate knpc kpc)
  (say knpc "おお、あの悪魔の門の言い伝えか。"
       "ワシは単なる伝説だと考えている。"
       "魔道師に聞いてみなさい。彼はワシよりよく知っている。"
       "ワシも死人と会ったら聞いてみよう。"))

(define (necr-necr knpc kpc)
  (say knpc "［ゴホン］ワシは死と結びついた魔法を極めておる。"))

(define necr-conv
  (ifc basic-conv

       ;; basics
       (method 'default necr-default)
       (method 'hail necr-hail)
       (method 'bye necr-bye)
       (method 'job necr-job)
       (method 'name necr-name)
       (method 'join necr-join)
       (method 'heal necr-heal)
       
       (method 'dead necr-dead)
       (method 'coug necr-coug)
       (method 'spir necr-spir)
       (method 'rune necr-rune)
       (method 'absa necr-absa)
       (method 'ench necr-ench)
       (method 'man necr-man)
       (method 'alch necr-alch)
       (method 'engi necr-engi)
       (method 'warr necr-warr)
       (method 'vale necr-vale)
       (method 'wise necr-wise)
       (method 'accu necr-accu)
       (method 'gate necr-gate)
       (method 'demo necr-gate)
       (method 'necr necr-necr)
       ))

(define (mk-necromancer)
  (bind 
   (kern-mk-char 
    'ch_necr           ; tag
    "死霊術師"       ; name
    necr-species         ; species
    necr-occ              ; occ
    s_necromancer     ; sprite
    faction-men      ; starting alignment
    1 6 0            ; str/int/dex
    0 0              ; hp mod/mult
    0 0              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    necr-lvl
    #f               ; dead
    'necr-conv         ; conv
    sch_necr         ; sched
    'townsman-ai              ; special ai
    nil              ; container
    (list t_staff)              ; readied
    )
   (necr-mk)))
