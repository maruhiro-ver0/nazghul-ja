(define (gsstatue-unknown knpc kpc)
  (say knpc "［像は沈黙したままだ］"))

(define (gsstatue-hail knpc kpc)
  (say knpc "［像が話しかけてきた］")
  (gamestart-statue-clean knpc "statspeak")
  )
    
(define gsstatue-conv
  (ifc '()
       ;; fundamentals
       (method 'default gsstatue-unknown)
       (method 'hail gsstatue-hail)
       )
       )

(define (gsstatue-dostat knpc kpc iname iset iget dname dset dget initial)
	(define (gs-check-upper value)
		(if (> value 11)
			(begin
				(say knpc "これ以上、汝の" iname "を上げることはできぬ。")
				#t
				)
			#f))
	(define (gs-check-lower value)
		(if (< value 1)
			(begin
				(say knpc "これ以上、汝の" dname "を下げるべきではない。")
				#t
				)
			#f))
	(define (gs-initialcheck)
		(say knpc dname "を" iname "に換えるか？")
		(if (kern-conv-get-yes-no? kpc)
			#f #t)
		)
	(define (gs-repeatcheck)
		(say knpc "続けるか？")
		(if (kern-conv-get-yes-no? kpc)
			#f #t)
		)
	(let ((ival (iget kpc))
			(dval (dget kpc))
			)
		(cond ((gs-check-upper ival))
			((gs-check-lower dval))
			((and initial (gs-initialcheck)) (say knpc "汝の意のままに。"))
			((and (not initial) (gs-repeatcheck)) (say knpc "汝の意のままに。"))
			(#t
				(iset kpc (+ ival 1))
				(dset kpc (- dval 1))
				(say knpc "[あなたの" iname "が上がった]")
				(say knpc "[あなたの" dname
					(cond ((< dval 3) "が弱まった！]")
						((< dval 9) "が下がった]")
						(#t " wanes]")
					)
				)
				(gamestart-reset-lamps kpc)
				(gsstatue-dostat knpc kpc iname iset iget dname dset dget #f)
			)
		)	
	))
		       
;; Statue of intelligence

(define (gs-int-hail knpc kpc)
  (say knpc "ようこそ、探求者よ。求めるものには知能を与えよう。")
  (gamestart-statue-clean knpc "statspeak")
  )
  
(define (gs-int-job knpc kpc)
	(say knpc "I represent the force of reason, and can assist you in endeavors of magic or wit.")
	)
  
(define (gs-int-assi knpc kpc)
	(say knpc "I can raise your intellect, but it will cost you some of your strength or dexterity")
	)

(define (gs-int-rais knpc kpc)
	(say knpc "You will need to say which attribute you want to suffer the penalty")
	)
		
;; expand on this as other abilities become available
(define (gs-int-inte knpc kpc)
  (say knpc "賢き者は魔力を生み出し、悪意ある者の術を打ち消す。だが愚かな者は惑わされ、容易に欺かれる。"
       "探求者よ、気をつけるがよい！邪悪な知能ある者は汝の行く道で待ち構えている。"
       "その者たちを乗り越えるには知力が必要だ。汝はそれを欲するか？")
  (if (yes? kpc)
      (say knpc "知力を得るためには、腕力と敏捷さのいずれかを差し出さねばならない。")
      (say knpc "知力を遠ざける者は悪魔を歓喜させるだろう。")
      )
  )
	
(define (gs-int-stre knpc kpc)
  (say knpc "聞け、探求者よ！腕力では闇の最も強き力に立ち向かうことはできぬであろう。")
  (gsstatue-dostat knpc kpc "知能" kern-char-set-intelligence kern-char-get-base-intelligence 
                   "腕力" kern-char-set-strength kern-char-get-base-strength #t)
  )
      
	
(define (gs-int-dext knpc kpc)
  (say knpc "考えよ、探求者！最も速き矢の一撃も、邪悪な黒魔術師には当たらぬだろう。"
       "そして魔力で封印された扉はこじ開けることができない。")
  (gsstatue-dostat knpc kpc "知能" kern-char-set-intelligence kern-char-get-base-intelligence 
                   "敏捷さ" kern-char-set-dexterity kern-char-get-base-dexterity #t)
  )

(define (gs-int-bye knpc kpc)
  (say knpc "行け、探求者よ。汝の魔力が汝自身を守り、召還された者たちが汝を助け、不浄な者の上に炎と雷の豪雨を降らせんことを！")
  )

(define gs-int-conv
  (ifc '()
       ;; fundamentals
       (method 'default gsstatue-unknown)
       (method 'bye gs-int-bye)
       (method 'hail gs-int-hail)
       (method 'job gs-int-inte)
       (method 'inte gs-int-inte)
       (method 'int gs-int-inte)
       (method 'wis gs-int-inte)
       (method 'wisd gs-int-inte)
       (method 'stre gs-int-stre)
       (method 'str gs-int-stre)
       (method 'dext gs-int-dext)
       (method 'dex gs-int-dext)
       )
  )
       
;; Statue of might

(define (gs-str-hail knpc kpc)
  (say knpc "ようこそ、探求者よ。強さを求める者には腕力を与えよう。")
  (gamestart-statue-clean knpc "statspeak")
  )
  
;; expand on this as other abilities become available
(define (gs-str-stre knpc kpc)
	(say knpc "腕力を得れば、汝は敵の兜を割り、骨を砕き、盾を粉砕できるであろう。"
             "最も重い鎧をも着ることができ、敵の打撃は意味をなさぬであろう。"
             "腕力は最も重要なものではない。唯一必要なものである！"
             "汝は力を求めるか？")
        (if (yes? kpc)
            (say knpc "腕力のために捧げよ。知能か、それとも敏捷さか？")
            (say knpc "汝の行く手で汝自身を救うのは力のみである。")
            ))
	
(define (gs-str-inte knpc kpc)
  (say knpc "戦士には狡猾さも必要だ。しかし最も必要なのは腕力である！")
  (gsstatue-dostat knpc kpc "腕力" kern-char-set-strength kern-char-get-base-strength 
                   "知能" kern-char-set-intelligence kern-char-get-base-intelligence #t)
  )
	
(define (gs-str-dext knpc kpc)
  (say knpc "汝の友は敏捷さの妙技に注目するだろう。"
       "しかし、汝の敵は力でのみ説得できるであろう！")
  (gsstatue-dostat knpc kpc "腕力" kern-char-set-strength kern-char-get-base-strength 
                   "敏捷さ" kern-char-set-dexterity kern-char-get-base-dexterity #t)
  )

(define (gs-str-bye knpc kpc)
  (say knpc "行け、そして悪に一撃を与えるのだ。"))

(define gs-str-conv
  (ifc '()
       ;; fundamentals
       (method 'default gsstatue-unknown)
       (method 'bye gs-str-bye)
       (method 'hail gs-str-hail)
       (method 'job gs-str-stre)
       (method 'stre gs-str-stre)
       (method 'inte gs-str-inte)
       (method 'int gs-str-inte)
       (method 'dext gs-str-dext)
       (method 'dex gs-str-dext)
       )
  )
       
;; Statue of agility

(define (gs-dex-hail knpc kpc)
  (say knpc "よくぞ参った、探求者よ。ああ、我は隣の者たちのように、汝に獣の力も、上の空の学者の知力も与えることができぬ。"
       "だが敏捷さを授けることはできる。")
  (gamestart-statue-clean knpc "statspeak")
  )
  
(define (gs-dex-dext knpc kpc)
  (say knpc "敏捷さは有能な冒険者に必要である。どのように鍵の掛かった扉を打ち破る？\n\n"
       "隠れ身と器用さで宝を容易に見つけたとき、どのようにかび臭い魔術書の目を逃れる？\n\n"
       "敵が遠くから冷静に撃ってきたとき、どのように混乱の中でよい武器を選択する？\n\n"
       "真に、些細な判断の遅れは窮地を招き、素早い身のこなしと決断は勝利をもたらすであろう。"
       "汝もそう考えるか？")
  (if (yes? kpc)
      (say knpc "その通り。敏捷さは愚鈍な腕力や野卑な知能を犠牲にする価値がある。")
      (say knpc "ああ。うむ。友よ、財布に気をつけよ。盗人はのろまな犠牲者を好むものだ。")
      )
  )
	
(define (gs-dex-inte knpc kpc)
  (say knpc "知能は評価されすぎていると我は思う。"
       "亡骸から略奪できるときに、誰もその亡骸を蘇生させようなどとは思わない、ということだ。")
       (gsstatue-dostat knpc kpc "敏捷さ" kern-char-set-dexterity kern-char-get-base-dexterity 
                        "知能" kern-char-set-intelligence kern-char-get-base-intelligence #t)
       )
	
(define (gs-dex-stre knpc kpc)
  (say knpc "腕力は影響を受けやすい者には勇ましい影響を与えるだろう。"
       "だが、常に武器と鎧を持ち運ぶのは無意味な苦労のように思える。")
  (gsstatue-dostat knpc kpc "敏捷さ" kern-char-set-dexterity kern-char-get-base-dexterity 
                   "腕力" kern-char-set-strength kern-char-get-base-strength #t)
  )

(define (gs-dex-bye knpc kpc)
  (say knpc "さらば、常に機知とともにあれ。"
       "酒を飲む機会も、美しい乙女に接吻する機会も、逃してはならぬ。"
       "そしていかなるときも、探求者よ、よい死に方をすることを忘れてはならぬ！")
  )

(define gs-dex-conv
  (ifc '()
       ;; fundamentals
       (method 'default gsstatue-unknown)
       (method 'bye gs-dex-bye)
       (method 'hail gs-dex-hail)
       (method 'job gs-dex-dext)
       (method 'dex gs-dex-dext)
       (method 'dext gs-dex-dext)
       (method 'stre gs-dex-stre)
       (method 'str gs-dex-stre)
       (method 'inte gs-dex-inte)
       (method 'int gs-dex-inte)
       )
  )
