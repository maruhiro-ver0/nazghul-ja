;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; グラスドリン
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
;; イニは落胆した聖騎士で、グラスドリンに住んでいる。
;; 彼は闘士の考えに忠実で、彼女の暗殺を企てた腐敗に対して怒りを感じている。
;; イニは仲間になる。
;;----------------------------------------------------------------------------

;; Basics...
(define (ini-hail knpc kpc)
  (say knpc "［あなたは憂鬱そうな聖騎士と会った。］やあ。"))

(define (ini-default knpc kpc)
  (say knpc "わからぬ。"))

(define (ini-notyet knpc kpc)
  (say knpc "一般人にはそのことを話すべきでないと考えている。"))

(define (ini-name knpc kpc)
  (say knpc "アイナゴだ。だが皆はイニと呼んでいる。"))

(define (ini-join knpc kpc)
  (if (is-player-party-member? knpc)
      (say knpc "すでに仲間だ。さあ行こう！")
      (let ((ini (kobj-gob-data knpc)))
        (if (ini-will-join? ini)
            (begin
              (say knpc "ありがとう！のんびりしている時間はない。闘士を探し出そう！")
              (kern-conv-end)
              (join-player knpc))
            (say knpc "［ため息］聖騎士の任務があるのだ。")
            ))))
        
(define (ini-lost knpc kpc)
   (let ((ini (kobj-gob-data knpc)))
     (if (ini-will-join? ini)
			(begin
  			(say knpc "失われた殿堂の入り口は南西はるか遠くの洞窟だ。"
  				"船で["
           (loc-x lost-halls-loc) ","
           (loc-y lost-halls-loc) "]まで航行すれば見つかるだろう。")
			(quest-data-update-with 'questentry-rune-l 'know-hall 1 (quest-notify nil))
			(quest-data-update 'questentry-warritrix 'lost-hall-loc 1)
			)
  			(say knpc "失われた殿堂はとても危険な場所だ。近づかないほうがいい。"))))
     		
(define (ini-cave knpc kpc)
   (let ((ini (kobj-gob-data knpc)))
     (if (ini-will-join? ini)
     		(begin
     			(say knpc "失われた殿堂はそれ自体が深い洞窟の中にある。")
     			(say knpc (if (is-player-party-member? knpc) "" "") "洞窟の北にある大階段を見つけなければならないだろう。")
     			(say knpc "迷宮の住人には気をつけなければならない！")
     			)
     		(ini-notyet knpc kpc))))
     		
(define (ini-inha knpc kpc)
   (let ((ini (kobj-gob-data knpc)))
     (if (ini-will-join? ini)
     		(begin
     			(say knpc "新しい巨人やトロルの集団がそこに入るたびに、我々はそれらを一掃しようとしてきた。")
     			(say knpc (if (is-player-party-member? knpc) "" "") "長く苦しい戦いに備えるべきだろう。")
     			)
     		(ini-notyet knpc kpc))))

(define (ini-stair knpc kpc)
   (let ((ini (kobj-gob-data knpc)))
     (if (ini-will-join? ini)
     		(begin
     			(say knpc "北のどこかに階段があることを知っている。だが、遠くから見ただけなので、正確な位置はわからない。")
     			)
     		(ini-notyet knpc kpc))))
     			
(define (ini-job knpc kpc)
  (say knpc "聖騎士だ。しかしあまりこの仕事が好きではない。"))

(define (ini-bye knpc kpc)
  (say knpc "さらばだ。"))

(define (ini-warr knpc kpc)
  (cond ((player-stewardess-trial-done?)
                (say knpc "正義は果たされた。今やっと彼女の死を悲しむことができる。" ))
	((player-found-warritrix?)
                (if (ask? knpc kpc "統治者の力は絶大だ。しかし、正義を通す道がある。太古の道。危険な道だ。聞きたいか？")
                    (say knpc "グラスドリンの中央に石像がある。"
                         "その像を剣で打てばこの町で最も古い秩序を呼び出すことができる。そして裁きが始まるのだ。"
                         "しかし統治者に対抗できるだけの証拠なしに打ってはならない。証拠がなくては代わりに我々が裁かれるだろう！")
                    (say knpc "統治者をこのままにしてはおけない。誰かが罪を問わなければならない！")))
	((quest-data-assigned? 'questentry-wise)
		 (say knpc "［彼は少し背筋を伸ばした。］何かがおかしいのだ！"
		      "闘士はずっと前に何も言わずに行ってしまった。"
		      "司令官は今すぐ捜索隊を送るべきだ。だが彼は何もせず、別の問題に気を取られている。"
		      "悪い予感がする。あなたは彼女を探しているのか？")
		 (if (kern-conv-get-yes-no? kpc)
		     (begin
		       (say knpc "ぜひ仲間に加えて欲しい！"
		            "深淵のことはよく知っている。私はその任務に就いているのだ。"
		            "彼女が死してその責を果たさぬ限り、彼女以外の命令に従うつもりはない。")
		       (ini-will-join! (kobj-gob-data knpc)))
		     (say knpc "誰かがそれを行うべきだ！ここにいる者は皆彼女に大きな借りがある。")))
	(else
		(say knpc "闘士に会いたいのか？")
		(if (kern-conv-get-yes-no? kpc)
			(begin
				(say knpc "彼女に会うのは困難だ。今は警備に出ているのだと思う。")
				(say knpc "もしあなたがまたここに来るのであれば、彼女が戻っていたら知らせよう。")
			)
		))
	))

;; Paladin...
(define (ini-pala knpc kpc)
  (say knpc "私はこの仕事に命をかけてきた。だが私は良き聖騎士ではない。"
       "戦いの度に気分が悪くなるのだ。聖騎士として留まるように言われるが、"
       "ただ盾となる役立たずが欲しいからであろう。"
       "いずれ辞めるであろうが、他に何ができるだろうか？"))

(define (ini-quit knpc kpc)
  (say knpc "できるだけ金を貯めるようにしている。退役したら、トリグレイブの近くの農地を買い、ここを離れようと思っている。"
       "このようなことばかり考えている。長い行進もなく、石ころだらけの真っ暗な深淵で眠ることもなく、"
       "部隊の仲間が怪物に食われて目が覚めることもない。"))

;; Townspeople...
(define (ini-glas knpc kpc)
  (say knpc "憂鬱な所だ。そう思わぬか？")
  (kern-conv-get-yes-no? kpc)
  (say knpc "緑の塔へ行き森を見ていたいといつも考えている。"))

(define (ini-ange knpc kpc)
  (say knpc "あまり語らない女性だ。洞窟ゴブリンを短剣で突き刺すのを一度だけ見たことがある。"))

(define (ini-spit knpc kpc)
  (say knpc "丘での通常警備で彼女と同じ部隊だった。"
       "洞窟ゴブリンとの戦いで楽勝と思っていたとき、現れた巨人から共に辛うじて生き延びた。"
       "あのときは危なかった。"))

(define (ini-patc knpc kpc)
  (say knpc "私の命の恩人だ。"))

(define (ini-life knpc kpc)
  (say knpc "私は一度殺されたようなものだ。深淵を警備していたときのことだ。"
       "我々の医師を殺した死の騎士の部隊から敗走し、つかれきっていた。"
       "そのとき睡眠中のトロルの集団の中に迷い込んでしまったのだ。")
  (prompt-for-key)
  (say knpc "彼らはすぐに目覚めた。"
       "私は命がけで戦ったが、気がつくと病院で眼帯先生を見上げていた。"
       "部隊で他に生き残った者はいない。"))

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
                 "イニ"            ; name
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
