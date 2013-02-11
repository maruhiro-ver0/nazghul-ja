;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define engineer-start-lvl 8)

(define voidship-parts
  (list 
  	(list t_power_core 1)
	(list sulphorous_ash 20)
	(list t_gem 10)
  ))

(define voidship-loc (mk-loc 'p_shard 50 3))

;;----------------------------------------------------------------------------
;; Schedule
;;
;; 技師の小屋
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_engineer
               (list 0  0  eng-workshop   "working")
               (list 1  0  eng-bed        "sleeping")
               (list 10 0  eng-workshop   "working")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (engineer-mk)
  (list #f 
        (mk-quest)))
(define (eng-met? gob) (car gob))
(define (eng-quest gob) (cadr gob))
(define (eng-met! gob val) (set-car! gob val))

;; ----------------------------------------------------------------------------
;; Voidship plans
;; ----------------------------------------------------------------------------
(mk-reusable-item 
 't_voidship_plans "虚空船計画書" s_lexicon norm
 (lambda (klexicon kuser)
   (kern-ui-page-text
   "虚空船計画書"
   "部品一覧:"
   "　硫黄の灰 (20)"
   "　宝石 (10)"
   "　炉心 (1)"
   )))

;;----------------------------------------------------------------------------
;; Conv
;;
;; 技師は知識のある偉大な職人で、賢者の一人である。
;; 彼はシャルドの端のたどり着くのが困難な虚空の高原(虚空の島)ある作業場に住ん
;; でいる。
;;----------------------------------------------------------------------------
(define (eng-hail knpc kpc)
  (say knpc "［あなたはやせた、白くボサボサの髪の男と会った。"
       "彼は最初はあなたに気づいていないようだった。］おっと、こんにちは。"))

(define (eng-name knpc kpc)
  (say knpc "ルドルフだ。技師と言った方がわかりやすいだろう。"))

(define (eng-job knpc kpc)
  (say knpc "ああ、これとあれだ。ものを作るのが好きなんだよ。"))

(define (eng-default knpc kpc)
  (say knpc "わからないな。魔道師に聞いてくれ。"))

(define (eng-bye knpc kpc)
  (say knpc "［彼はすでにあなたのことを気にかけていないようだ。］"))

(define (eng-join knpc kpc)
  (say knpc "忙しすぎるな。闘士に頼んでみなさい。彼女は冒険が好きだから。"))

(define (eng-warr knpc kpc)
  (say knpc "彼女はこれまでで最も優れた戦士の一人だと考えている。"
       "だが、最も気高き者の一人だということも知っている。"
       "彼女が信じられないような勇気ある、そして愚かなことをしたのでなければ"
       "グラスドリンで会えるだろう。")
    (quest-wise-subinit 'questentry-warritrix)
  	(quest-data-update 'questentry-warritrix 'general-loc 1)
       )

(define (eng-make knpc kpc)
  (say knpc "私はどんな種類のものでも作る。最近は旅するものに興味があるな。"
       "例えば、門、虚空船などだ。"
       "構想で頭の中がいっぱいだよ。"))

(define (eng-wand knpc kpc)
  (say knpc "君は迷い人か？ずっと会いたいと思っていたんだ。"
       "門は自分で作ったのか？")
  (kern-conv-get-yes-no? kpc)
  (say knpc "ずっとそれがどうなっているのか考えている。"
       "いくつかの理論を考えた。そしてそれを試すために虚空船を設計したのだ。"
       "だがまだ結論は出ていない。"))

(define (eng-void knpc kpc)
  (let* ((eng (kobj-gob-data knpc))
         (quest (eng-quest eng)))

    (define (remove-stuff)
      (map (lambda (ktype) 
             (kern-obj-remove-from-inventory kpc (car ktype) (cadr ktype)))
           voidship-parts))

	;;FIXME: the grammer here needs work
	
    (define (really-has-parts?)
      (display "really-has-parts?")(newline)
      (let ((missing (filter 
				(lambda (ktype)
					(let ((nrem (- (cadr ktype) (num-in-inventory kpc (car ktype)))))
						(cond 
							((> nrem 1)
								(begin
									(say knpc "まだ" nrem "の" (kern-type-get-name (car ktype)) "が必要だ。")
									#t))
							((> nrem 0)
								(begin
									(say knpc "まだ" (kern-type-get-name (car ktype)) "が必要だ。")
									#t))
							(else #f))))
					voidship-parts)))
		
        (if (null? missing)
			#t
            #f)))

    (define (build-ship)
      (say knpc "よし。全てそろったようだな。"
           "では取り掛かるとしよう。")
      (remove-stuff)
      (kern-log-msg "［数多くの努力、苦労、試行、失敗の後…］")
      (prompt-for-key)
      (kern-log-msg "［再試行、再失敗、進んで戻って、髪が抜け落ちる…］")
      (prompt-for-key)
      (kern-log-msg "［さらに苦労、議論、やり直し、また失敗…］")
      (prompt-for-key)
      (kern-log-msg "［再試行、再失敗、涙、歯ぎしり…］")
      (prompt-for-key)
      (kern-log-msg "［等々、等々…］")
      (prompt-for-key)
      (kern-log-msg "［…ついに…］")
      (prompt-for-key)
      (kern-log-msg "［…おっと、ちくしょう、今度は何だ？…］")
      (prompt-for-key)
      (kern-log-msg "［…だが、まもなく…］")
      (prompt-for-key)
      (kern-obj-relocate (mk-voidship) (eval-loc voidship-loc) nil)
      (kern-log-msg "［二人とも疲れてボロボロだ。］")
      (say knpc
           "うむ…。悪くない出来だ。彼女は全て君のものだ。"
           "外の船着場で待っているぞ。幸運を祈る！")
      (kern-log-msg "［彼はいびきをかき始めた。］")
      (kern-obj-add-effect knpc ef_sleep nil)
      (quest-done! quest #t)
      (kern-conv-end))

    (define (missing-power-core?)
      (not (in-inventory? kpc t_power_core)))

    (define (has-plans)
      (say knpc "おお、それが私の虚空船の計画書だ！"
           "必要な部品は全てあるかね？")
      (if (kern-conv-get-yes-no? kpc)
          (if (really-has-parts?)
              (build-ship))
          (if (missing-power-core?)
              (say knpc "南の深い裂け目を渡った場所のどこかに引き上げられた虚空船がある。"
                   "裂け目を渡る方法を見つければ、そこから炉心を取り出すことができるだろう。")
              (say knpc "ううむ、何を待っているのかな？それらを持ってきなさい。")
              )))
      
    (define (no-plans)
      (say knpc "シャルドの周りには広大な虚空が広がっている。"
           "私は虚空を渡る船の設計をした。だがまだ完成していない。"
           "どこかに計画書がある。見つけてきたら教えてやろう。")
           (quest-data-update 'questentry-whereami 'shard 2)
           )

    (if (quest-done? quest)
        (say knpc "全て完成した。")
        (if (in-inventory? kpc t_voidship_plans)
            (has-plans)
            (no-plans)))))

(define (eng-gate knpc kpc)
  (say knpc "月の門と祭壇の門は謎に満ちている。"
       "私はその謎を解き明かしたい。"
       "悪魔の門は知っているかね？")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "それは本当にあるのか、そうではないのか。私は知りたいのだ。")
      (say knpc "こんな言い伝えがある。"
           "悪魔の門は、この世界から別の世界へとつながっている。"
           "そして妄想に捕らわれた者が、それを閉ざし、鍵をどこかへ投げ捨てた。"
           "もしそれが本当なら残念なことだ。")))
  
(define (eng-key knpc kpc)
  (say knpc "鍵はいくつかの石版で、それは失われたか、バラバラになったとされている。"
       "よくあるつまらないおとぎ話だ。だが、もしかするとそこに真実の核があるのかもしれない。"))

(define (eng-wise knpc kpc)
  (say knpc "自らを賢者と呼ぶ傲慢な者は、ほぼ間違いなく愚かな者だ。"
       "例を挙げればグラスドリンの統治者だ。"))

(define (eng-stew knpc kpc)
  (say knpc "彼女は長い間、賢者の一人として数えられていた。"
       "そして、そのことでどれだけの血が流されたのかわからない。"
       "アブサロットのことは聞いたな？")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "力の悪用の完璧な例だ。何と悲しいことか。")
      (say knpc "統治者は他の町と魔道師を騙し、アブサロットの町で大虐殺を行ったのだ。"
           "アブサロットは呪われた者の温床とされていた。"
           "もし呪われた者がいるわずかな証拠でもあれば、残りの町も同じように焼き払っただろう。")))

(define (eng-accu knpc kpc)
  (say knpc "彼らは悪と契約した者たちの集団とされている。"
       "余計なことばかり気にしている者たちは、彼らに浮き足立っている。"
       "私は全く気にしていない。"))

(define (eng-shri knpc kpc)
  (say knpc "もちろん祭壇の門の記録やその場所をよく調べてみた。"
       "だが、それがどうなっているのか、どうすれば制御できるのか、それを示すものは何もなかった。"
       "最後にそれが開いたのは百年以上前のことだと私は考えている。"))

(define (eng-rune knpc kpc)
  (say knpc "言い伝えでは悪魔の門はいくつかの石版で封印されたと言われている。"
       "別の話では石版は二度と門を開けられないようバラバラにされたとも、"
       "ただ単に運悪く失われたとも言われている。"
       "もちろんそれはただの言い伝えで、そのような石版や、門の存在すらわからないのだ！"))

(define (eng-wiza knpc kpc)
  (say knpc "魔術師は力に心を奪われがちだ。"))

(define (eng-wrog knpc kpc)
  (say knpc "ほとんどのならず者はただの病のようなものだ。彼らはあらゆる所にいる。"))

(define (eng-wrig knpc kpc)
  (say knpc "職人は私のような者たちだ。"
       "物を作ることを好み、物の仕組みを見つけ出す。"
       "そして自由に興味のある物事を追い求めようとする。"))

(define (eng-necr knpc kpc)
  (say knpc "悪い者ではない。一度か二度、彼と議論したことがある。")
  (quest-data-update 'questentry-necromancer 'nonevil 1)
  )

(define (eng-alch knpc kpc)
  (say knpc "油断できないロクデナシだ。だが、尊敬すべきところもある。"))

(define (eng-man knpc kpc)
  (say knpc "ならず者、だが助けになる者だ。何とかうまくやっているよ。"))

(define (eng-ench knpc kpc)
  (say knpc "私に言わせれば少し狂信的なところがある。人は皆そうだが。"))

(define eng-merch-msgs
  (list "今はダメだ。"
        "私が開発した物の一部を見せてやろう…"
        nil
        nil
        "いつも仲間の修理屋に感謝されているよ。"
        "いいさ。"
   ))

(define eng-catalog
  (list
   ;; Various tools and devices
   (list t_picklock       10 "突然いくつかの予備の鍵が必要になった。どんな錠にも合う便利なものだ。")  ;; high prices, not his specialty
   (list t_shovel        100 "このシャベルは手放したくないな。どれだけ役に立つか君にはわからないだろう。")  ;; high prices, not his specialty
   (list t_pick          100 "このつるはしは使ったものだ。一度だけ。これは手放してもいいだろう。")  ;; high prices, not his specialty
   (list t_sextant       200 "これは私の最高傑作の一つだ。この六分儀があれば、イン・ウィス<In Wis>の呪文なしで地上での位置がわかる。")
   (list t_chrono        200 "これは小さな、持ち運べる時計だ！面白いだろう？［彼は楽しさのあまり笑った。］")
   
   ;; A bit of oil and grease, for a grease-monkey:
   (list t_grease         20 "脂はたくさんある。色々なことに使っている。")
   (list t_oil            10 "この油の爆発力の使い道はいくらでもある。これは恐らく動力源にもなるだろう。")  ;; high prices, not his specialty

   ;; Crossbows and bolts, as he likes intricate devices
   (list t_lt_crossbow    50 "かわいらしい小さなクロスボウだろう？この小さなレバーと機械は本当によくできている。")
   (list t_crossbow      100 "私は撃つのは苦手だ。しかし、虚空に向かって自分で安全な撃ち方を教えることができたかと思うと、打ち方を学んでおけばよかったと思うよ。")
   (list t_hvy_crossbow  300 "標準的なクロスボウを改良せずにはいられなかった。取り付けてみればすぐに傑作だとわかるだろう。")
   (list t_trpl_crossbow 500 "もし一度に一発より多く撃てるクロスボウがあったら？私は挑戦してみた。そしてこれを作った。") ;; a mechanism of his devising
   (list t_bolt            2 "クロスボウを改良しているとき、多くの矢が必要だった。今でも何箱か残っている。")
   ))

(define (eng-trade knpc kpc) (conv-trade knpc kpc "buy" eng-merch-msgs eng-catalog))

(define engineer-conv
  (ifc nil
       (method 'default eng-default)
       (method 'hail eng-hail)
       (method 'name eng-name)
       (method 'bye eng-bye)
       (method 'job eng-job)
       (method 'engi eng-job)
       (method 'join eng-join)

       (method 'trad eng-trade)
       (method 'buy  eng-trade)
       (method 'inve eng-trade)

       (method 'make eng-make)
       (method 'thin eng-make)
       (method 'wand eng-wand)
       (method 'void eng-void)
       (method 'gate eng-gate)
       (method 'key eng-key)
       (method 'wise eng-wise)
       (method 'stew eng-stew)
       (method 'accu eng-accu)
       (method 'shri eng-shri)
       (method 'rune eng-rune)
       (method 'wiza eng-wiza)
       (method 'wrog eng-wrog)
       (method 'wrig eng-wrig)
       (method 'necr eng-necr)
       (method 'alch eng-alch)
       (method 'man eng-man)
       (method 'ench eng-ench)
       (method 'warr eng-warr)
       ))

(define (mk-engineer)
  (bind 
   (kern-char-arm-self
    (kern-mk-char 
     'ch_engineer ;;..........tag
     "技師" ;;.......name
     sp_human ;;.....species
     oc_wright ;;.. .occupation
     s_companion_tinker ;;..sprite
     faction-men ;;..faction
     2 ;;...........custom strength modifier
     10 ;;...........custom intelligence modifier
     2 ;;...........custom dexterity modifier
     10 ;;............custom base hp modifier
     2 ;;............custom hp multiplier (per-level)
     20 ;;............custom base mp modifier
     5 ;;............custom mp multiplier (per-level)
     max-health ;;..current hit points
     -1  ;;...........current experience points
     max-health ;;..current magic points
     0
     engineer-start-lvl  ;;..current level
     #f ;;...........dead?
     'engineer-conv ;;...conversation (optional)
     sch_engineer ;;.....schedule (optional)
     'townsman-ai ;;..........custom ai (optional)
     ;;..............container (and contents)
     (mk-inventory
      (list
       (list 1   t_dagger)
       (list 1   t_doom_staff)
       (list 1   t_trpl_crossbow)
       (list 100 t_bolt)
       (list 5   t_cure_potion)
       (list 5   t_heal_potion)
       ))
     nil ;;.........readied arms (in addition to the container contents)
     nil ;;..........hooks in effect
     ))
   (engineer-mk)))
