;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;;
;; トリグレイブ
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_chant
               (list 0  0  trigrave-east-west-road   "drunk")
               (list 2  0  trigrave-chants-bed       "sleeping")
               (list 12 0  trigrave-tavern-hall      "working")
               (list 23 0  trigrave-east-west-road   "drunk")               
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (chant-mk) (list 0))
(define (chant-get-gold knpc) (car (kobj-gob-data knpc)))
(define (chant-has-gold? knpc) (> (chant-get-gold knpc) 0))
(define (chant-set-gold! knpc amount) 
  (if (>= amount 0)
      (set-car! (kobj-gob-data knpc) 
                amount)))
(define (chant-dec-gold! knpc) (chant-set-gold! knpc 
                                                (- (chant-get-gold knpc)
                                                   1)))

;; ----------------------------------------------------------------------------
;; オンドリ
;;
;; オンドリは旅の吟遊詩人で多くの時間をトリグレイブで過ごしている。彼はおおらか
;; な自信家で、制止できない芸人でもある。彼には多くの地理の知識があり、うわさと
;; 醜聞を愛していて、様々な身分の友人(人前に現れない魔道師を含む)がいる。そして
;; もしかすると「誰かの」スパイかもしれないが、それはわからない。
;; ----------------------------------------------------------------------------
(define (chant-song knpc kpc)
  (if (isdrunk? knpc)
      (say knpc "さあみんなで！♪か〜も〜め〜の水兵さん！［ヒッヒッヒ］")
      (begin
        (say knpc "千の歌が僕の乾いた喉という檻の向こうで待っている！"
             "もしかすると少しの金貨で檻を壊せるかも？"
             "［彼は期待するようにあなたを見ている。彼にいくらかの金貨を与える？］")
        (if (kern-conv-get-yes-no? kpc)
            ;; yes - give chant some gold
            (let ((amount (kern-conv-get-amount)))
              (display "amount=")(display amount)(newline)
              (cond ((= 0 amount) 
                     (say knpc "見えない金貨には聞こえない歌を！"
                          "［彼はリュートを弾くまねをした。］"))
                    ((< amount 2)
                     (say knpc "ああ…わかりました。いきますよ。\n"
                          "\n"
                          "　♪ とってもケチな迷い人\n"
                          "　お金をいっぱい貯めときたい\n"
                          "　哀れなオンドリをあざ笑ったので\n"
                          "　ひどい音で耳をいっぱいにしてやる！\n"
                          "\n"
                          "［彼は荒々しく大声で歌い、おじぎをした。］"))
                    (else
                     (say knpc "僕の心は満たされた！"
                          "さあ、どこがいい？沼、森、"
                          "それとも忘れられた場所？")
                     (chant-set-gold! knpc amount))))
            ;; no -- don't give him some gold
            (say knpc "シラフの詩人は誰にも何もしないのさ！")))))

(define (chant-fen knpc kpc)
  (if (isdrunk? knpc)
      (say knpc "汚ねえところ！［ヒック］")
      (if (not (chant-has-gold? knpc))
          (chant-song knpc kpc)
          (begin
            (chant-dec-gold! knpc)
            (say knpc 
                 "湿地帯\n"
                 "\n"
                 "　♪ もしもあなたがお好きなら\n"
                 "　血を吸う虫が　臭い沼が\n"
                 "　憂鬱な空が　人ぐらいのカエルが\n"
                 "　悪魔の祭壇が　泥が詰まった靴が\n"
                 "　忘れられた警備隊が(よそ者を警戒している)\n"
                 "　道なき荒地が\n"
                 "　リッチが　幽霊が\n"
                 "　骸骨の戦士が…\n"
                 "　そうならば　友よ\n"
                 "　北の沼地へ行くがいい！\n"
                 "　そこはあなたの場所だ")))))

(define (chant-forest knpc kpc)
  (if (isdrunk? knpc)
      (say knpc "走れ〜、森を〜、走れ〜［ヒッヒッヒ］")
      (if (not (chant-has-gold? knpc))
          (chant-song knpc kpc)
          (begin
            (chant-dec-gold! knpc)
            (say knpc 
                 "東の森\n"
                 "\n"
                 "　♪ 森は素敵なところ　暗くて深くて\n"
                 "　いつでも飢えている！\n"
                 "　旅人をたくさん食べて\n"
                 "　そして王様も飲み込んだ\n"
                 "\n"
                 "　ゴブリンの住み家と盗賊の隠れ家\n"
                 "　そして巨大クモの巣\n"
                 "　森に行くときは忘れるな\n"
                 "　ノロマなバカを連れて行くのを！\n"
                 )))))

(define (chant-forgotten knpc kpc)
  (if (isdrunk? knpc)
      (say knpc "忘れた！［彼は泣きながら笑った。］")
      (if (not (chant-has-gold? knpc))
          (chant-song knpc kpc)
          (begin
            (chant-dec-gold! knpc)
            (say knpc 
                 "失われた殿堂 \n"
                 "\n "
                 "　♪ 深く深いところで\n"
                 "　古き者が目を覚ます\n"
                 "　この物語を知ってるか\n"
                 "　(物語は語られなかった。)\n"
                 "　飽きもせず僕は語る！\n"
                 "\n "
                 "［演奏を止めた。］調べに行かなければならなくなったら、"
                 "南の沿岸へ行けばいい。")
		 (if (null? (quest-data-getvalue 'questentry-rune-l 'know-hall))
			(quest-data-update-with 'questentry-rune-l 'approx-hall 1 (quest-notify nil))
		)
		 ))))

(define (chant-thie knpc kpc)
  (if (isdrunk? knpc)
      (say knpc 
           "　ヘイ、むずいなぞなぞ\n"
           "　君はまんなかにいる！\n"
           "　カルシファクスが月に向かって飛び跳ねる\n"
           "　それ見て死霊術師が笑う\n"
           "　そして泥棒は石版を盗んで走り出す！")
      (say knpc "まーちゃんは君に探させた？泥棒はこの町を避けていったはずだ。"
           "でも、旅人は見たかもしれない。グベンに聞いてみなよ。")))

(define (chant-man knpc kpc)
  (if (isdrunk? knpc)
      (begin
        (say knpc "なあ！秘密を守れるかぁ？")
        (if (yes? knpc)
            (begin
              (say knpc "にんげんは秘密の洞窟にいる。どこか知ってるかぁ？")
              (if (yes? kpc)
                  (say knpc "俺様もだぁ！［ヒッヒッヒ！］")
                  (say knpc "[" 
                       (loc-x the-mans-hideout-loc) "," 
                       (loc-y the-mans-hideout-loc) 
                       "]の山は本当の山じゃねえ！行ってびびらせてやれ！")))
            (say knpc "俺様もできねぇ！［彼は鼻を鳴らした。］")))
      (say knpc "にんげん？にんげんのことは知らないなあ。なぜ僕に聞くの？")))

(define chant-conv
  (ifc basic-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default 
               (lambda (knpc kpc) 
                 (if (isdrunk? knpc)
                     (say knpc "酔っているんだぁ…［ヒック］")
                     (say knpc "困ったなあ。"))))
       (method 'hail 
               (lambda (knpc kpc)
                 (if (isdrunk? knpc)
                     (say knpc "［酔っぱらいながら］笑って、チ〜ズ！")
                     (say knpc "ようこそ、わが友よ！"))))
       (method 'bye 
               (lambda (knpc kpc) 
                 (if (isdrunk? knpc)
                 (say knpc "ババババイバイ［笑いながら］")
                 (say knpc "道が君の足にキスしますように！"))))
       (method 'job 
               (lambda (knpc kpc) 
                 (if (isdrunk? knpc)
                     (say knpc "［おおげさな身振りで、彼は自分の目を指差し、"
                          "耳を指差し、そして口を塞ぐ動作をして、"
                          "すまし顔でうなずき、ウィンクした。］")
                     (say knpc "知恵と歌の運び手さ！"))))
       (method 'name 
               (lambda (knpc kpc)
                 (if (isdrunk? knpc)
                     (say knpc "オンドリ！［おじぎをしようとして倒れた。］")
                     (say knpc "吟遊詩人のオンドリ、なんでもどうぞ。"
                          "［おじぎをしたあと舞った。］"))))
       (method 'join 
               (lambda (knpc kpc) 
                 (if (isdrunk? knpc)
                     (say knpc "飲み仲間かぁ？"
                          "待ってましたぁ！")
                     (say knpc "旅をする詩人がいれば、博学な者もいる。"
                          "僕は後の方なのさ。"))))

       (method 'chan
               (lambda (knpc kpc)
                 (if (isdrunk? knpc)
                     (say knpc "［ヒック！］♪泣きじょうごの、飲んだくれの、バカ野郎はだあれだぁ\n"
                          "誰が獣の子を褒めるものか…")
                     (say knpc "\n"
                          "\n"
                          "　♪ かしこい、すてきな詩人はだあれ？\n"
                          "　歌うよにリュートを弾くのはだあれ？\n"
                          "　彼女の運命のお話を話すだろうか、\n"
                          "　死すべき運命が上手な嘘なら？"))))
       (method 'earl
               (lambda (knpc kpc)
                 (if (isdrunk? knpc)
                     (say knpc "あんなボケた奴は見たことねぇ！")
                     (say knpc 
                          "僕らのすばらしい店主…\n"
                          "\n"
                          "　♪ 昔は炎の主だった \n"
                          "　戦で名を上げた \n"
                          "　でも、見ての通り \n"
                          "　悪い魔法に手を出して \n"
                          "　今じゃ名前も思い出せない！"
                          ))))

       (method 'ench
               (lambda (knpc kpc)
                 (if (isdrunk? knpc)
                     (say knpc "まーちゃん！塔の中で座って、"
                          "魔法陣を描きながら命令していたなぁ！")
                     (say knpc 
                          "魔道師の塔に旅することもありますよ。"))))
       (method 'gwen
               (lambda (knpc kpc)
                 (if (isdrunk? knpc)
                     (say knpc "［彼はあなたにもたれかかり、大声で言った。］"
                          "何で魔女は剣を持ってるんだろうねぇ？")
                     (say knpc
                          "ああ、謎多き宿屋の女主人…\n"
                          "\n"
                          "　♪ 灰色の鳩が涙を流すとき\n"
                          "　世界がみな眠る\n"
                          "　海から霧のように亡霊が現れるとき\n"
                          "　フクロウは月明かりの中\n"
                          "　静かな夜に尋ねよ\n"
                          "　答えは彼女が知っている！"))))
       (method 'fen chant-fen)
       (method 'fore chant-forest)
       (method 'wood chant-forest)
       (method 'forg chant-forgotten)
       (method 'jim
               (lambda (knpc kpc)
                 (if (isdrunk? knpc)
                     (say knpc "騎士の裏返しさぁ！［ゲップ！］")
                     (say knpc
                          "おっと！こんなうわさもありますよ！\n"
                          "\n"
                          "　♪ 残虐と獰猛\n"
                          "　それがすばらしきジム\n"
                          "　鎧は血で濡れている\n"
                          "　己が主を打ち倒し\n"
                          "　盾の紋章をかき消す\n"
                          "　そして呪われた店に消えうせる\n"
                          ))))
       (method 'roun
               (lambda (knpc kpc)
                 (if (isdrunk? knpc)
                     (say knpc "そう！俺様は見張っていた。"
                          "あいつらに気をつけろ…")
                     (say knpc "何でそんなことを聞くの！？"))))
       (method 'song chant-song)
       (method 'them
               (lambda (knpc kpc)
                 (if (isdrunk? knpc)
                     (say knpc "［ささやき］あいつら！賢者の敵さぁ！シーッ！")
                     (say knpc "［疑うようにあなたを見た。］"
                          "だいじょうぶかい？"))))
       (method 'thie chant-thie)
       
       (method 'towe
               (lambda (knpc kpc)
                 (if (isdrunk? knpc)
                     (say knpc "憂うつなところさぁ！")
                     (say knpc
                          "北の湿地帯で見られますよ。"
                          "でもそこへ行きたいのなら、"
                          "魔道師は来客を好まないことを覚えておいてください！"))))

       (method 'wit
               (lambda (knpc kpc)
                 (say knpc "うーん、本当はただのうわさ話さ。"
                      "名前を言えば、その人のうわさを聞かせますよ。")))
       (method 'lost
               (lambda (knpc kpc)
                 (say knpc "ええ、この伝説的な失われた殿堂の歌を知らなければ、僕は吟遊詩人にはならなかったでしょうね！")))
       (method 'man chant-man)
       (method 'wrog chant-man)
       ))
