;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define enchanter-start-lvl 8)

;;----------------------------------------------------------------------------
;; Schedule
;;
;; 魔道師の塔の1階
;; 
;; (彼は自分の塔の2階を訪れることはないが、それは私たちに複数の場所のスケジュ
;; ールをいずれは作らなければならないと思わせる動機付けになっている :-)
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_enchanter
               (list 0  0  enchtwr-ench-bed        "sleeping")
               (list 8  0  enchtwr-dining-room-2   "eating")
               (list 9  0  enchtwr-hall            "idle")
               (list 12 0  enchtwr-dining-room-2   "eating")
               (list 13 0  enchtwr-hall            "idle")
               (list 19 0  enchtwr-dining-room-2   "eating")
               (list 20 0  enchtwr-bedroom-1       "idle")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (enchanter-mk)
  (list #f 
        (mk-quest) ;; get stolen rune
        (mk-quest) ;; learn the purpose of the runes
        (mk-quest) ;; get all runes
        (mk-quest) ;; open demon gate
        ))
(define (ench-met? gob) (car gob))
(define (ench-first-quest gob) (cadr gob))
(define (ench-second-quest gob) (caddr gob))
(define (ench-quest gob n) (list-ref gob n))
(define (ench-met! gob val) (set-car! gob val))

;;----------------------------------------------------------------------------
;; Conv
;;
;; 魔道師は力のある魔術師で、賢者の一人である。
;; 彼は魔道師の塔に住んでいる。
;; 彼は主要な冒険の多くで重要な役割を演じる。
;;----------------------------------------------------------------------------
(define (ench-hail knpc kpc)
  (let ((ench (gob knpc)))

    ;; Fourth Quest -- open the demon gate
    (define (check-fourth-quest)
      (say knpc "悪魔の門の場所はわかったか？")
      (if (yes? kpc)
          (begin
            (say knpc "ならば石版の鍵で開ける錠は見つかったか？")
            (if (yes? kpc)
                (say knpc "なのにこのあたりをうろついて時間を無駄にしているのか。")
                (say knpc "それは恐らく寺院の祭壇のようなものであろう。"
                     "寺院は隠され、もしかすると暗号で姿を現すかもしれない。"
                     "呪われた者を探し調べよ。彼らは手がかりを知っているに違いない。")))
          (say knpc "アブサロットの図書館をよく探すのだ。")))

    ;; Third Quest -- find all the Runes
    (define (finish-third-quest)
      (say knpc "石版を全て見つけたのだな！"
           "うむ、この上なく困難だったであろう。")
      (prompt-for-key)
      (say knpc "最後の任務だ。"
           "悪魔の門を探し出し、それを再び開かねばならない。"
           "場所はわかっているか？")
      (if (yes? kpc)
          (say knpc "汝が何と直面するかはわからぬ。"
               "自身でよく備えよ。"
               "そして汝の仲間になるほどの愚か者を連れてゆけ。")
          (say knpc "呪われた者が何か知っていたに違いない。"
               "アブサロットの図書館にはまだ手がかりが残っているかも知れぬ。"
               "よく調べるのだ。")
          )
      (quest-done! (ench-quest ench 3) #t)
      (kern-char-add-experience kpc 100)
      (quest-accepted! (ench-quest ench 4) #t)      
      )

    (define (check-third-quest)
	(define (missing-only-s-rune?)
		(all-in-inventory? kpc
                         (filter (lambda (ktype)
                                   (not (eqv? ktype t_rune_s)))
                                 rune-types)))
	(cond			 
		((has-all-runes? kpc)
		(finish-third-quest)
		)
		
		((missing-only-s-rune? kpc)
		(say knpc "ほとんどの石版を見つけたようだな。")
		(prompt-for-key)
		(say knpc "うむ…。")
		(prompt-for-key)
		(say knpc "このことを言うのは躊躇していた。だが、汝の能力ならできるであろう。")
		(prompt-for-key)
		(say knpc "呪われた者たちもまた石版を探している。彼らの手の中にはたった一つしかないことを幸運に思わねばなるまい。")
		(prompt-for-key)
		(say knpc "我らの敵の中心地、アブサロットの廃墟を調べねばならぬであろう。")
		(quest-data-assign-once 'questentry-rune-s)
		)
		
		(else
		(say knpc "全ての石版を見つけたら戻って来たまえ。"
		     "他の賢者に助言を求めよ。彼らは石版の場所の手がかりを持っているかも知れぬ。")
		)
	)
    )

    ;; Second Quest -- find out what the Runes are for
    (define (second-quest-spurned)
      (say knpc "これは悪と立ち向かう善なる者の義務である。"
           "怠惰と冷笑に費やす時間はない。私の石版を渡しなさい。"
           "報酬を受け取ったら出て行きたまえ！")
      (kern-obj-remove-from-inventory kpc t_rune_k 1)
      (kern-obj-add-to-inventory knpc t_rune_k 1)
      (quest-accepted! (ench-second-quest ench) #f)
      (kern-conv-end))

    (define (start-second-quest)
      (quest-accepted! (ench-second-quest ench) #t)
      (say knpc "よろしい！第一に私の石版を持ち、そして守るのだ。")
      (quest-data-update 'questentry-rune-k 'entrusted-with-rune 1)
      (prompt-for-key)
      (say knpc "第二に、他の賢者たちと会い、石版について尋ねるのだ。"
           "オパーリンにいる錬金術師から始めるのがよいだろう。"
           "真に貪欲な者だが、"
           "謎を解き明かすことに人生を費やしている。")
      (quest-data-assign-once 'questentry-runeinfo)
      (quest-wise-subinit 'questentry-alchemist)
      (quest-wise-init)
      (kern-conv-end)
      )

    (define (offer-second-quest-again)
      (say knpc "戻ってきたな。良心の呵責を感じたのかもしれぬな。"
           "それは我々にとって最も悪いことだ。"
           "さて、呪われた者から私を助ける準備はできたか？")
      (if (kern-conv-get-yes-no? kpc)
          (begin
            (kern-obj-remove-from-inventory knpc t_rune_k 1)
            (kern-obj-add-to-inventory kpc t_rune_k 1)
            (start-second-quest))
          (begin
            (say knpc "まるで餌に向かう豚のようだ。"
                 "愚者は自らの愚かさに帰る。"
                 "自らの欲を満たしに帰るがよい！")
            (kern-conv-end)))
      )
    
    (define (finish-second-quest)
      (say knpc "［彼は重々しい様子だ。］"
           "つまり私の石版は悪魔の門を封印する八つの鍵の一つなのだな。"
           "よろしい。汝は残りを探さねばならぬ。"
           "呪われた者は我々の先を行っている。"
           "いくつかの石版を手に入れているのは疑いの余地もない。"
           "全ての石版を見つけたら、私の元に戻ってきて欲しい。")
      (quest-done! (ench-second-quest ench) #t)
      (quest-data-update 'questentry-runeinfo 'abe 1)
      (quest-data-update 'questentry-runeinfo 'keys 1)
      (quest-data-update 'questentry-runeinfo 'gate 1)
      (quest-data-update 'questentry-rune-k 'entrusted-with-rune 1)
      (quest-data-update-with 'questentry-runeinfo 'done 1 (grant-party-xp-fn 30))
      (quest-data-complete 'questentry-runeinfo)
      ;; temporary setup- will require information gathering first when done
      (prompt-for-key)
      (quest-data-assign-once 'questentry-allrunes)
      (quest-data-convert-subquest 'questentry-rune-k 'questentry-allrunes)
      (quest-data-assign-once 'questentry-rune-k)
      (quest-data-convert-subquest 'questentry-rune-c 'questentry-allrunes)
      (quest-data-convert-subquest 'questentry-rune-d 'questentry-allrunes)
      (quest-data-convert-subquest 'questentry-rune-l 'questentry-allrunes)
      (quest-data-convert-subquest 'questentry-rune-p 'questentry-allrunes)
      (quest-data-convert-subquest 'questentry-rune-s 'questentry-allrunes)
      (quest-data-convert-subquest 'questentry-rune-w 'questentry-allrunes)
      (quest-data-convert-subquest 'questentry-rune-f 'questentry-allrunes)
      (quest-accepted! (ench-quest ench 3) #t)
      )

    (define (check-second-quest)
      (say knpc "石版のことはわかったかね？")
      (if (yes? kpc)
          (begin
            (say knpc "うむ、それは何か？")
            (let ((reply (kern-conv-get-string kpc)))
              (if (or (string=? reply "demon") (string=? reply "gate") (string=? reply "key") (string=? reply "アクマ") (string=? reply "モン") (string=? reply "カギ"))
                  (finish-second-quest)
                  (begin
                    (say knpc "私はそうは思わぬ。全ての賢者に^c+m石版^c-について尋ねたか？")
                    (if (yes? kpc)
                        (say knpc "ならばそのうちの一人が手がかりを与えたはずだ！")
                        (say knpc "彼ら全てを探すのだ。"))))))
          (say knpc "全ての賢者に^c+m石版^c-のことを尋ねるのだ。")))

    ;; First Quest -- find the stolen Rune
    (define (finish-first-quest)
      (say knpc "おお、ついに私の石版を見つけたようだな！")
      (kern-obj-add-gold kpc 200)
		(quest-data-update-with 'questentry-thiefrune 'done 1 (grant-party-xp-fn 20))
		(quest-data-complete 'questentry-thiefrune)
      (say knpc "少しは役に立つようだな。"
           "何かの……抵抗に会ったかな？")
      (kern-conv-get-yes-no? kpc)
      (say knpc "泥棒の後ろには呪われた者がいる。"
           "この石版が何なのか調べねばならぬ。"
           "手を貸してくれるか？")
      (quest-offered! (ench-second-quest ench) #t)
      (if (kern-conv-get-yes-no? kpc)
          (start-second-quest)
          (second-quest-spurned)))

    (define (check-first-quest)
      (if (in-inventory? kpc t_rune_k)
          (finish-first-quest)
          (say knpc "むむ。まだものを見つけておらぬようだな！"
               "［彼は迷い人と仲間を見て不満げにつぶやいた。］")
            ))
    
    ;; Main
    (if (ench-met? ench)
        (if (quest-done? (ench-quest ench 4))
            (say knpc "ようこそ。賢者の友よ。")
            (if (quest-accepted? (ench-quest ench 4))
                (check-fourth-quest)
                (if (quest-accepted? (ench-quest ench 3))
                    (check-third-quest)
                    (if (quest-offered? (ench-second-quest ench))
                        (if (quest-accepted? (ench-second-quest ench))
                            (check-second-quest)
                            (offer-second-quest-again))
                        (if (quest-accepted? (ench-first-quest ench))
                            (check-first-quest)
                            (say knpc "うむ。今度は何か？"))))))
        (begin
          (quest-data-update-with 'questentry-calltoarms 'talked 1 (quest-notify (grant-xp-fn 10)))
          (kern-log-msg "この年老いることがないかのような魔術師は、あなたを見ても驚かなかった。")
          (say knpc "よくぞ参られた。"
               "待っておったぞ！")
          (ench-met! ench #t)))))

(define (ench-name knpc kpc)
  (say knpc "魔道師として知られている。"))

(define (ench-job knpc kpc)
  (say knpc "可能な限り悪と戦うことを手助けすることである。"))

(define (ench-default knpc kpc)
  (say knpc "それは助けられぬ。"))

(define (ench-bye knpc kpc)
  (say knpc "呪われた者に気をつけよ！"))

(define (ench-join knpc kpc)
  (say knpc "否。ここが私のいるべき場所である。"
       "強き仲間を求めるなら、闘士を探すのがよいだろう。"))


(define (ench-warr knpc kpc)
  (say knpc "闘士は荒々しい賢者である。"
       "そして汝のように放浪している。"
       "実際のところ、今どこに彼女がいるのかは知らぬ。"
       "グラスドリンへ聞けばよかろう。")
       (quest-wise-subinit 'questentry-warritrix)
       (quest-data-update 'questentry-warritrix 'general-loc 1)
       )

(define (ench-wand knpc kpc)
  (say knpc "然り。かつて会ったことがある。予期せぬことであった。"
       "汝が善となるか悪となるかは、汝しだいである。"))

(define (ench-offer-first-quest knpc kpc)
  (say knpc "善とは、悪とは何か。その定義をごまかしたりはしない。"
       "それは出会えば容易に区別できる。"
       "汝はこの地で善き行いをなすつもりか？")
  (if (kern-conv-get-yes-no? kpc)
      ;; yes - player intends to do good
      (begin
        (say knpc "ならば汝の力となろう。"
             "だが気をつけよ！多くの善を主張する者は、実際にはそうでない。"
             "そして試練で脱落する。汝には試練を受ける覚悟があるか？")
        (if (kern-conv-get-yes-no? kpc)
            ;; yes - player is ready to be tested
            (begin
              (say knpc "よろしい。最近あるものを盗まれた。"
                   "泥棒を見つけ出し、それを取り戻す者を見つけねばならなかったのだ。"
                   "引き受けるか？")
              (if (kern-conv-get-yes-no? kpc)
                  ;; yes -- player is willing
                  (begin
                    (say knpc "よろしい！警備隊は泥棒を追ってトリグレイブへと向かった。"
                         "そこへ行き^c+m泥棒^c-について尋ねるとよいだろう。")
							(quest-data-assign-once 'questentry-thiefrune)
              		(quest-data-complete 'questentry-calltoarms)
                  	;; if you dont read the letter, you might not get the quest till now!
              		(quest-data-assign-once 'questentry-calltoarms)
                  	(quest-data-update-with 'questentry-calltoarms 'done 1 (grant-xp-fn 10))
                    (quest-accepted! (ench-first-quest (gob knpc)) #t)
                    )
                  ;; no -- player is not willing
                  (say knpc "汝を見誤ったかもしれぬ。")))
            ;; no -- player is not ready
            (say knpc "善をなすことについて話すだけでは不十分である。"
                 "善をなすことなしに、善になることはできぬ。")))
      ;; no -- player does not intend to do good
      (say knpc "わかった。悪しき者は善をその意味をわからずなすことができる。"
           "そして冷淡な者はその良心を無視できぬことに気づくだろう。")))

(define (ench-good knpc kpc)
  (if (quest-accepted? (ench-first-quest (gob knpc)))
      (say knpc "悪は追う者がいなければ逃げるものである。"
           "だが、善は竜のごとく強い。")
      (ench-offer-first-quest knpc kpc)))

(define (ench-gate knpc kpc)
  (say knpc "この地には月と共に現れる他方とつながった多数の門がある。"
       "だが、祭壇の門は一つしかなく、私が知っている確実なことは、別の世界とつながっているということだけだ。"))

(define (ench-wise knpc kpc)
  (say knpc "賢者はこの地で最も力のある戦士、魔術師、職人、そしてならず者である。"
       "その役目はシャルドを守ることであるにもかかわらず、全てが善き者であるわけではない。"))

(define (ench-accu knpc kpc)
  (say knpc "呪われた者は悪の集団で、数多くの犯罪と残虐行為に関わっている。"
       "アブサロットの崩壊で彼らは終焉したはずだった。"
       "だが違った。"
       "私は彼らの力がより強大になっていることを恐れている。"))

(define (ench-moon knpc kpc)
  (say knpc "月の門のことはカルシファクスに尋ねよ。"
       "彼女はよく知っている。"))

(define (ench-shri knpc kpc)
  (say knpc "祭壇の門はいつ開くのか、それは予測できない。そして開くのは少しの間だけだ。"
       "そこに入ったものは決して戻ってこない。"
       "そして汝のような迷い人が姿を現すことがある。"))

(define (ench-rune knpc kpc)
  (say knpc "この石版は遠い昔師匠から受け取った物だ。"
       "師匠はこれが何のためにあるか知らなかった。私も調べたがその目的は全くわからなかった。"
       "これは重要ではない遺物と思っていた。"
       "なぜ本や歴史にはこれに関する記述が全くないのだろうか？"))

(define (ench-wiza knpc kpc)
  (say knpc "戦士、職人、ならず者の力はみな身体世界の知識から来るものである。"
       "だが、魔術師の力は魔術世界から来るものである。"))

(define (ench-know knpc kpc)
  (say knpc "目の見えぬ者は色を理解することはできないように、"
       "内なる目のなき者は魔術の力を理解することはできぬ。"
       "だが、その目を開いた者は、目に見えぬ原因と結果を理解することができよう。"))

(define (ench-wrog knpc kpc)
  (say knpc "最も賢きならず者はにんげんで、風に吹かれて行き帰りしている。"
       "にんげんに帰るべき場所があるとすれば、それは巧妙に隠されているだろう。"
       "周りの者に尋ねよ。欲する者とは既に会っているかも知れぬ。")
       (quest-wise-subinit 'questentry-the-man)
       (quest-data-update 'questentry-the-man 'common 1)
       )

(define (ench-wrig knpc kpc)
  (say knpc "最も賢き職人は孤独を好む。"
       "いずれ彼を見つけることができようが、それは町の中ではないだろう。"
       "魔術師のカルシファクスを探せ。彼女は技師のことをよく知っている。")
       (quest-wise-subinit 'questentry-engineer)
       (quest-data-update 'questentry-engineer 'kalcifax 1)
       )

(define (ench-necr knpc kpc)
  (say knpc "全ての賢者の中で最も堕落した邪悪な者だ。"
       "わが宿敵、死霊術師は地下の世界に潜んでいる。"
       "彼は強大で、偽りと腐敗を受け入れた者だ。")
       (quest-wise-subinit 'questentry-necromancer)
       (quest-data-update 'questentry-necromancer 'general-loc 1)
      )

(define (ench-alch knpc kpc)
  (say knpc "錬金術師はオパーリンにいる。"
       "彼は欲深く、とても狡猾だ。彼には気をつけねばならぬ。")
       (quest-wise-subinit 'questentry-alchemist)
       (quest-data-update 'questentry-alchemist 'oparine 1)
       )

(define (ench-thie knpc kpc)
	;;in case quest generated once in progress
	(quest-data-assign-once 'questentry-thiefrune)
  (if (quest-done? (ench-first-quest (gob knpc)))
      (say knpc "迷惑なものだが、彼は単なる仲介者であろう。"
           "彼をあまりに厳しく扱わないことを望む。")
      (say knpc "ものを盗んだその泥棒は非常に巧みであろう。"
           "警備隊員はトリグレイブで見失った。"
           "会った者に^c+m泥棒^c-について尋ねよ。")))

(define (ench-kalc knpc kpc)
  (say knpc "カルシファクス？残念だが彼女の居場所はわからない。"))

(define (ench-demo knpc kpc)
  (say knpc "悪魔の門は古き魔術師が別の世界へと渡るために使ったとされる伝説上の門だ。"
       "その後は様々な言い伝えがある。それは失われた、封印された、忘れられた、破壊されたなどだ。"
       "私はずっと作り話だと考えていた。"))

(define (ench-ench knpc kpc)
  (say knpc "何か？"))

(define enchanter-conv
  (ifc basic-conv
       (method 'default ench-default)
       (method 'hail ench-hail)
       (method 'name ench-name)
       (method 'bye ench-bye)
       (method 'job ench-job)
       (method 'join ench-join)
       
       (method 'ench ench-ench)
       (method 'accu ench-accu)
       (method 'alch ench-alch)
       (method 'evil ench-good)
       (method 'gate ench-gate)
       (method 'good ench-good)
       (method 'know ench-know)
       (method 'moon ench-moon)
       (method 'necr ench-necr)
       (method 'rune ench-rune)
       (method 'shri ench-shri)
       (method 'thie ench-thie)
       (method 'wand ench-wand)
       (method 'warr ench-warr)
       (method 'wise ench-wise)
       (method 'wiza ench-wiza)
       (method 'wrog ench-wrog)
       (method 'wrig ench-wrig)
       (method 'emgi ench-wrig)
       (method 'kalc ench-kalc)
       (method 'demo ench-demo)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-enchanter-first-time tag)
  (bind 
   (kern-char-arm-self
    (kern-mk-char 
     tag ;;..........tag
     "魔道師" ;;.......name
     sp_human ;;.....species
     oc_wizard ;;.. .occupation
     s_old_mage ;;..sprite
     ;;(mk-composite-sprite (list s_hum_body s_hum_belt s_hum_beard))
     faction-men ;;..faction
     0 ;;...........custom strength modifier
     7 ;;...........custom intelligence modifier
     0 ;;...........custom dexterity modifier
     10 ;;............custom base hp modifier
     2 ;;............custom hp multiplier (per-level)
     20 ;;............custom base mp modifier
     5 ;;............custom mp multiplier (per-level)
     max-health ;;..current hit points
     -1  ;;...........current experience points
     max-health ;;..current magic points
     0
     enchanter-start-lvl  ;;..current level
     #f ;;...........dead?
     'enchanter-conv ;;...conversation (optional)
     sch_enchanter ;;.....schedule (optional)
     'townsman-ai ;;..........custom ai (optional)
     ;;..............container (and contents)
     (mk-inventory
      (list
       (list 10  t_food)
       (list 100 t_arrow)
       (list 1   t_bow)
       (list 1   t_dagger)
       (list 1   t_sword)
       (list 1   t_leather_helm)
       (list 1   t_armor_leather)
       (list 5   t_torch)
       (list 5   t_cure_potion)
       (list 5   t_heal_potion)
       ))
     nil ;;.........readied arms (in addition to the container contents)
     nil ;;..........hooks in effect
     ))
   (enchanter-mk)))
