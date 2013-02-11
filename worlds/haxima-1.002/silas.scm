;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define silas-lvl 8)
(define silas-species sp_human)
(define silas-occ oc_wizard)
(define shrine-path-x 97)
(define shrine-path-y 5)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; 古アブサロット
;;----------------------------------------------------------------------------
(define silas-bed oa-bed1)
(define silas-mealplace oa-tbl3)
(define silas-workplace oa-temple)
(define silas-leisureplace oa-baths)
(kern-mk-sched 'sch_silas
               (list 0  0 silas-bed          "sleeping")
               (list 7  0 silas-mealplace    "eating")
               (list 8  0 silas-workplace    "working")
               (list 12 0 silas-mealplace    "eating")
               (list 13 0 silas-workplace    "working")
               (list 18 0 silas-mealplace    "eating")
               (list 19 0 silas-leisureplace "idle")
               (list 22 0 silas-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (silas-mk) 
  (list #f (mk-quest) #f))
(define (silas-set-will-help! gob) (set-car! gob #t))
(define (silas-will-help? gob) (car gob))
(define (silas-quest gob) (cadr gob))
(define (silas-met? gob) (caddr gob))
(define (silas-set-met! gob) (set-car! (cddr gob) #t))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; サイラスは呪われた者の悪しき教えの指導者である。
;; 彼は注目すべき力を持った魔術師である。
;;----------------------------------------------------------------------------

;; Basics...
(define (silas-hail knpc kpc)
  (if (silas-met? (kobj-gob-data knpc))
      (say knpc "また会ったな。迷い人よ。")
      (begin
        (silas-set-met! (kobj-gob-data knpc))
        (say knpc "［あなたは魅惑的な老人と会った。］ようこそ、旅の方。"
             "私の考え違いでなければ、君は迷い人であろう。どうかね？")
        (if (yes? kpc)
            (say knpc "そうだと思った！君を待っていたよ。")
            (say knpc "［彼は明らかにあなたの言うことを信じていない。］"
                 "そうか。多くを語らないのだな。"
                 "ずっと君を待っていた。")))))

(define (silas-default knpc kpc)
  (say knpc "残念だがそれは手助けできぬ。"))

(define (silas-name knpc kpc)
  (say knpc "失礼。私はサイラスだ。"
       "君は、友よ、言わずともよい。"))

(define (silas-ask-help knpc kpc)
  (cond ((yes? kpc)
         (say knpc "その答えが聞けた喜びを言い表すことができない。"
              "君が私の側についたことで、シャルドに希望と安定の新しい時代をもたらすことができるだろう。"
              "準備はできているか。君がすべきことがある。")
         (silas-set-will-help! (kobj-gob-data knpc))
         (make-allies knpc kpc)
         )
        (else
         (say knpc "今のままでは成功は疑わしいが、"
              "君なしで最善を尽くさねばならない。"
              "残念だ。君は知っているだろう。"
              "過去に迷い人が現れるのは常に歴史が変わるときであった。"
              "迷い人の行い…あるいは行わないこと…が時としてその後の数百年の運命を決めたのだ。")
         )))

(define (silas-join knpc kpc)
  (say knpc "［彼は笑った。］実際、君を私の仲間に加えようと説得するつもりだった。"
       "私の目の前には極めて困難な仕事がある。だが、君の力と共にあれば成し遂げられるであろう。"
       "私の手助けをしてみぬか？")
  (silas-ask-help knpc kpc)
  )

(define (silas-job knpc kpc)
  (say knpc "私の目標はこのシャルドに新しい黄金時代をもたらすことだ。"
       "多くの障害が私の前には横たわっている。"
       "そしてこの目的のためには才能ある者が必要だ。"
       "迷い人よ。私の手助けをしてみぬか？君がいなければ成し遂げられない。")
  (silas-ask-help knpc kpc)
  )

(define (silas-help knpc kpc)
  (say knpc "私の手助けをしてみぬか？")
  (silas-ask-help knpc kpc)
  )

(define (silas-bye knpc kpc)
  (say knpc "さようなら、迷い人、そして幸運を！"))

;; Tier 2
(define (silas-expe knpc kpc)
  (say knpc "そうだ。君が来たことは聞いていた。"
       "遅かれ早かれ君が現れることはわかっていた。"
       "迷い人の歴史については幅広く調査している。"))
(define (silas-hist knpc kpc)
  (say knpc "地上の図書館は焼け落ち、大半の記録が失われてしまった。"
       "迷い人の記録はここにあるわずかな本に残っているだけかも知れぬ。"
       "［彼は頭を振った。］"))
(define (silas-wand knpc kpc)
  (say knpc "全ての迷い人は祭壇の門を通って来た。君のようにだ。だが、別の門があることを知っているかね？")
  (if (yes? kpc)
      (say knpc "よくわかっているな。もちろん悪魔の門のことだ。")
      (say knpc "それは確かに存在する。悪魔の門として知られているものだ。")))

(define (silas-demo knpc kpc)
  (say knpc "遠い昔、悪魔の門はシャルドと別の世界を結んでいた。"
       "それは知と進歩の黄金時代で、"
       "魔術師たちはこの世界と別の世界を自由に行き来し"
       "知識と物を共有していた。")
  (prompt-for-key)
  (say knpc "だが、最終的には問題が起こり始めた。"
       "ある別の世界の者が、門を使って自らの兵を動かし、他を征服し始めたのだ。"
       "シャルドに進攻されることを恐れた魔術師たちは、悪魔の門に八つの封印を施し"
       "八つに分けられた鍵を守ることにした。"))

(define (silas-key knpc kpc)
  (if (any-in-inventory? kpc rune-types)
      (say knpc "鍵は君が持っているような特別な石版だ。")
      (say knpc "鍵は特別な石版だ。残念だがそれらはこの時代に失われてしまった。")))

(define (silas-rune knpc kpc)
  (say knpc "私は目的のため全ての失われた石版を取り戻さなければならない。"
       "仮に悪魔の門を永遠に封印することを選択したとしても、"
       "石版の行方を知り、そして安全に管理しなければならない。同意するかね？")
  (if (yes? kpc)
      (say knpc "もちろんだ。これはまっとうな方針であろう。")
      (say knpc "しかし考えてみよ。もし石版が悪しき者の手に落ちたら、"
           "もしシャルドを去らねばならないときが来たら、"
           "もし別の世界の助けが必要になったとしたら？"
           "悪魔の門を決して開けるつもりがないとしても、選択肢があるのはよいことだろう。")))

;; Accursed, Wise
(define (silas-accu knpc kpc)
  (say knpc "［彼は笑った。］その通り。私は呪われた者だ。"
       "残念なことに、それは多くの者たちの悪魔的な空想からきた呼び名だ。"
       "あらゆる突飛な話には我々の活動が関わっているとされている。"
       "私はそれらは全て偽りだと断言する。"
       "しかし我々の真の行いを明かすことで自らの弁護をすることはできない。"
       "我々はみな秘密を誓っているからだ。"))

(define (silas-secr knpc kpc)
  (say knpc "呪われた者の教義は外部の者には秘密にされ守られている。"
       "そして愚かな者がまねようとすることを防いでいる！"
       "神聖で危険、そして無知な者には無用のものだ。"
       "だが断言しよう。それは何も知らない人々を巻き込むものではない！"))

(define (silas-wise knpc kpc)
  (say knpc "ああ、そうだ。いわゆる賢者。君は知っているであろう。"
       "彼らは尊敬すべき、そして価値のある伝統の一環だ。少なくとも過ぎし日の価値ある伝統であった。"
       "［ため息］今日の賢者はシャルドの力添えだけでなく、妨げにもなっている。"
       "アブサロットでの行いを考えてみたまえ。"))
 
(define (silas-absa knpc kpc)
  (say knpc "今なら君は間違いなく理解しているだろう。"
       "魔道師、我々の教えに間違った妬みを持つ者は呪われた者を滅ぼすことに心を奪われており、"
       "グラスドリンの統治者は力に飢え軍事帝国の夢を抱いている。"
       "彼女はシャルドの町を一つ一つ征服するか滅ぼすつもりだ。"
       "アブサロットは最も都合のよい最初の目標だったに過ぎない。"
       "彼女は簡単に証拠を作り上げ、他の町と魔道師を破壊するよう説き伏せた。"
       "後は知っての通りだ。"))

;; Philosophy
(define (silas-evil knpc kpc)
  (say knpc "悪とは本当は何なのか？念のために言うが、私は悪は存在しないと言っているのではない。"
       "ただ悪とは何かというこれまでの君の観念を問うているのだ。"
       "もし権威のある者が我々に何が悪であるかを言ったならば、我々はその言葉をそのまま受け入れるべきだろうか？"
       "我々とは違う権威のある者たちは、彼ら自身の目的があるのではないか？"
       "あらゆる行動は、それを認めようと認めまいと、各々の利己的な動機に基づいている。")
  (prompt-for-key)
  (say knpc "そして実際に、迷い人よ、そうあるべきなのだ！"
       "全ての者は自身の利益のために戦うべきだ。それが自然な振る舞いである。"
       "人は皆、抜け出すことができないゲームの駒なのだ。"
       "ゲームを拒否することは自らを拒否することであり、"
       "自分の利益より他者の利益を優先すべきという考えは、全て競争相手の流した嘘である。"))

(define (silas-good knpc kpc)
  (say knpc "善について尋ねているならば答えよう。君が一番欲しているものは何だ？"
       "物事は欲する者がいて初めて価値を持つ。"
       "だが逆に人は欲することは悪であるかのように、欲望を抑え辛抱するよう教えられている。"
       "それは全くの逆である！"
       "君に重大な秘密を教えよう。ある種の者たちの欲望は、他の者たちの欲望を押さえ込むことだ！"))

(define (silas-desi knpc kpc)
  (say knpc "そうだ。魂が肉体を動かすように、欲望が魂を動かす。"
       "欲望がなければ魂は無気力で空虚だ。"
       "呪われた者の第一歩は、己の欲望、つまり究極の善、全てを犠牲にし、全てを賭ける価値のあるものは何かを知ることだ。"))

(define (silas-sacr knpc kpc)
  (say knpc "呪われた者の教義では犠牲は欲望のはしごである。"
       "犠牲は選択の避けられない結果だ。全てを手にすることはできない！"
       "ある欲望の実現を目指すなら、他の可能性は失われる。"
       "木の枝がはさみによって切り落とされるように、人生の行き先の枝分かれも選択の度に切り落とされる。"
       "それが我々の犠牲、可能性の木の枝を刈ること、の意味だ。"))

;; People
(define (silas-ench knpc kpc)
  (say knpc "彼があのような呪われた者の敵であることは残念だ。"
       "だが、彼が古く、融通が利かず、そして一度悪と決めたものは心の中で決して変えない、ということを私は恐れている。"
       "不幸なことに彼の善と悪の観念は誤っており、かつ実現不可能だ。"))

(define (silas-deni knpc kpc)
  (say knpc "デニスは真面目だが、率直に言って想像力に欠ける若い男だ。"))

(define (silas-sele knpc kpc)
  (say knpc "セレネは才能のある若い女性だ。"
       "不幸なことに、彼女の力は飽くなき残虐さに常に抑圧されている。"))
 
;; Quest-related
(define (silas-ques knpc kpc)
  (let* ((gob (kobj-gob-data knpc))
        (quest (silas-quest gob)))

    (define (has-all-runes?)
      (all-in-inventory? kpc rune-types))

    (define (missing-only-s-rune?)
      (all-in-inventory? kpc
                         (filter (lambda (ktype)
                                   (not (eqv? ktype t_rune_s)))
                                 rune-types)))

    (define (give-last-rune)
      (say knpc "最後の一つを除く全ての石版を持っているようだな。"
           "少し君を騙していたことを許して欲しい。最後の一つは私がこの古アブサロットに隠したのだ。"
           "それを見つけるのが君の最後の試練だと考えてくれ。")
	(quest-data-update-with 'questentry-rune-s 'silasinfo 1 (quest-notify nil))
	(quest-data-assign-once 'questentry-rune-s)
	)

    (define (continue-quest) 
      (say knpc "最後の一つが見つからないようだな。迷い人よ、あきらめるな！"
           "賢者に尋ね、深淵を探り、遠く広く探すのだ。"))

    (define (end-quest)
      (quest-done! quest #t)
      (say knpc "よくやった、迷い人よ。失われた石版、伝説の栄光の時代は全てそろった。"
           "本当によくやった！")
      (prompt-for-key)
      (say knpc "今、全ての石版が戻った。安全に保管されなければならない。"
           "疑い深い意見ですまないが、私は賢者の石版の管理を信用できない。"
           "魔道師自身でさえそうだろう。")
      (prompt-for-key)
      (say knpc "君が何を考えているかはわかる、友よ、だがそうではない！"
           "ここで私が管理することなど到底できない。そして望んでもいない。"
           "そうではなく、もっと大胆な考えがあるのだ。")
      (prompt-for-key)
      (say knpc "迷い人よ。進むべき時が来た。"
           "このために君がシャルドに呼ばれたのだと私は思っている。"
           "鍵を手に取り、門を探し、その封印を解く。その向こうにあるものと対面する。"
           "勇気を示せ。そして新しい時代の先がけとなるのだ。やってくれるか？")
      (if (yes? kpc)
          (say knpc "ならば賢者にも隠された重大な秘密を教えよう：神はまだ生きている、その敵も同じ。"
               "君が何を見るかはわからない。だが、このことはわかっている：彼らの敵が門を封印した。")
          (say knpc "［彼は肩を落とした。］これは君が負うべきことではない、迷い人よ、君はこの世界のよそ者だ。"
               "少なくとも、鍵は安全に保管しておきなさい。君が考えを変えるつもりがないのであれば。")))
           
    (define (offer-quest)
      (say knpc "迷い人よ。君がすべき最も重要な仕事がある。"
           "悪魔の門を封印する八つの鍵の石版を探せ。やってくれるか？")
      (if (yes? kpc)
          (begin
            (quest-accepted! quest #t)
            (cond
            	((has-all-runes?)
            		(say knpc "すでに石版を持っているな？")
            		(prompt-for-key)
            		(end-quest)
            		)
            	((missing-only-s-rune?)
            		(give-last-rune))
            	(#t
            		(say knpc "頼りになりそうな者を知っている。最も賢い男、オパーリンの錬金術師だ。"
            		"もしかするとすでに彼を知っているかも知れないが。"
            		"彼を最初に尋ねるとよいだろう。"))
             ))
          (say knpc "それを見つけるのは我々の義務だ。失望した、友よ。"
               "だが、君には君の理由があることは疑わない。")))

    (if (silas-will-help? gob)
        (if (quest-done? quest)
            (say knpc "悪魔の門を探せ！")
            (if (quest-accepted? quest)
                (if (has-all-runes?)
                    (end-quest)
                    (if (missing-only-s-rune?)
                        (give-last-rune)
                        (continue-quest)))
                (offer-quest)))
        (say knpc "私の仲間になりなさい。そこには多くのすべきことと栄光がある。"
             "君はあらゆる時代で最も名高い迷い人…シャルドで最も偉大な英雄…になれるであろう。"))
    ))

(define (pissed-off-silas knpc kpc)
  (map (lambda (tag)
         (if (defined? tag)
             (let ((kchar (eval tag)))
               (if (is-alive? kchar)
                   (begin
                     (kern-being-set-base-faction kchar faction-accursed)
                     (kern-char-set-schedule kchar nil)
                     )))))
       (list 'ch_silas 'ch_dennis 'ch_selene))
  (make-enemies knpc kpc)
  )

(define (silas-noss knpc kpc)
  (say knpc "［彼の表情が凍りついた。］友よ、どのようにしてその名を知った？")
  (kern-conv-get-reply kpc)
  (say knpc "他の者たちにもそのように嗅ぎまわっているのか？")
  (if (yes? kpc)
      (say knpc "何ということだ。残念だが君と別れるときが来たようだ。")
      (say knpc "そうであろう。君の行いは無作法で、そして今は小さな嘘をついている。"
           "君はここでは歓迎されない。"
           "ただちに去りなさい。"))
  (pissed-off-silas knpc kpc)
  (kern-conv-end)
  )

(define silas-conv
  (ifc basic-conv

       ;; basics
       (method 'default silas-default)
       (method 'hail silas-hail)
       (method 'bye  silas-bye)
       (method 'job  silas-job)
       (method 'name silas-name)
       (method 'join silas-join)

       (method 'absa silas-absa)
       (method 'accu silas-accu)
       (method 'demo silas-demo)
       (method 'deni silas-deni)
       (method 'denn silas-deni)
       (method 'desi silas-desi)
       (method 'ench silas-ench)
       (method 'evil silas-evil)
       (method 'expe silas-expe)
       (method 'gate silas-demo)
       (method 'good silas-good)
       (method 'help silas-help)
       (method 'hist silas-hist)
       (method 'key  silas-key)
       (method 'keys silas-key)
       (method 'noss silas-noss)
       (method 'ques silas-ques)
       (method 'rune silas-rune)
       (method 'sacr silas-sacr)
       (method 'secr silas-secr)
       (method 'sele silas-sele)
       (method 'task silas-job)
       (method 'wand silas-wand)
       (method 'wise silas-wise)
       ))

(define (mk-silas)
  (bind 
   (kern-mk-char 
    'ch_silas           ; tag
    "サイラス"          ; name
    silas-species         ; species
    silas-occ              ; occ
    s_silas     ; sprite
    faction-men      ; starting alignment
    0 5 0            ; str/int/dex
    2 1              ; hp mod/mult
    2 1              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
	0
    silas-lvl
    #f               ; dead
    'silas-conv         ; conv
    sch_silas           ; sched
    'spell-sword-ai  ; special ai
    nil              ; container
    (list t_stun_wand) ; readied
    )
   (silas-mk)))
