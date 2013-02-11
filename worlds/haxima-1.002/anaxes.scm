;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define anaxes-lvl 6)
(define anaxes-species sp_lich)
(define anaxes-occ oc_wizard)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ブルンデガードの洞窟の神殿
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (anaxes-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; アナクシズは遠い昔死んだ魔術師のリッチ/影で、かつてラクシマニに仕えていた
;; が、後に離反した。
;; アナクシズはブルンデガードの失われた領域、洞窟の神殿にいる。
;;----------------------------------------------------------------------------

;; Basics...
(define (anaxes-hail knpc kpc)
  (meet "［あなたは誇らしげな、遠い昔に死んだであろう魔術師の影と会った。］")
  (say knpc "おぬし、ラクシマニの使いか？")
  (if (yes? kpc)
      (say knpc "他の誰だと？［彼は残虐そうな笑いを浮かべた。］"
           "おぬしは私の封印を破った。"
           "しかし私を従わせることはできぬ！")
      (say knpc "偽るな。奴が私を反逆の罪で探していることは知っている！"))
  (aside kpc 'ch_nate 
         "［ささやき］旦那、ラクシマニは遠い昔に死んだはずですぜ！")
  )


(define (anaxes-default knpc kpc)
  (say knpc "［彼は黙ってあなたを見ている。］"))

(define (anaxes-name knpc kpc)
  (say knpc "私はアナクシズ、かつては十二人の内の一人であった。"))

(define (anaxes-luxi knpc kpc)
  (say knpc "ラクシマニは人ではない。仮面をした悪魔である！"
       "反乱の種をまき、芽が出ればそれを刈り取ってきた。"
       "そして今では神を退かせる方法を探っている。")
  (prompt-for-key)
  (say knpc "奴はこの神殿におのれの像を建てるよう命じた。"
       "出過ぎたことだ！今や奴の背信は明らかになった。")
  (prompt-for-key)
  (say knpc "私が生きている間は、このブルヌの神殿が汚されることはない！")
  (aside kpc 'ch_nate "ああ！最後の神の名！永遠に忘れられたかと思っていた！")
  (cond ((has? kpc t_lich_skull 1)
         (say knpc "待て！それは何だ？［彼はラクシマニの頭蓋骨を指差した。］どういうことだ？ラクシマニは死んだのか？")
         (yes? kpc)
         (say knpc "［彼はあなたを無視した。彼の目の光が消え始め、声はだんだんと弱くなった。］終わったのだ…")
         (prompt-for-key kpc)
         (say knpc "［彼は崩れ落ちた。］…イシン！…イシン")
         (aside kpc 'ch_nate "あいつの靴は俺の物だ。")
         (kern-conv-end)
         (kern-char-kill knpc))))

(define (anaxes-gods knpc kpc)
  (say knpc "神々は我々の不誠実さに怒りシャルドに復讐するだろう！"
       "ラクシマニと奴の追随者は、最後の戦いで焼き尽くされ血の海で溺れるであろう！"
       "戒めに誠実であれ！"))

(define (anaxes-brun knpc kpc)
  (say knpc "ここは戒めの神、ブルヌの神殿である。"
       "私はここにラクシマニの像を建てるという恥じるべき命令に反した。"
       "そしてブルヌの守を封印し攻撃に備えているのだ。")
  )

(define (anaxes-vigi knpc kpc)
  (say knpc "我々は戒めを忘れていたのだ！"
       "ラクシマニは皆を欺き続けた。そして我々は今その代償を払わねばならぬのだ。"))

(define (anaxes-fail knpc kpc)
  (say knpc "我々は神を裏切った。間違いなく神は我々を見捨てるだろう！"))

(define (anaxes-twel knpc kpc)
  (say knpc "私はラクシマニの十二人の助言者の一人だった。"
       "恥すべきことに、私は奴の帝国を築く手助けをしてしまったのだ。"
       "強き支配者がシャルドに秩序をもたらし、"
       "そして呪われた者の邪教を押さえ込むことができると考えていた。"
       "ああ！我らは裏切られたのだ！"))

(define (anaxes-accu knpc kpc)
  (say knpc "サンダリングの後、"
       "聖職者たちは堕落した。"
       "その者たちは神の代弁者であると主張し、その愚かな行為で神への信仰を汚した。")
  (prompt-for-key)
  (say knpc "ラクシマニの下で我々はその邪教徒たちと戦った。"
       "そして、偽りの司祭たちを火刑に処し、その寄生虫のような支持者を刃にかけた。"))

(define (anaxes-bye knpc kpc)
  (say knpc "汝は冒涜する者なり！私は抵抗する。"
       "たとえこの戦いで朽ちても、墓の向こうから打ち続けるであろう！")
  (aside kpc 'ch_nate "［つぶやき］既にそうしている！")
  (kern-being-set-base-faction knpc faction-monster)
  )

(define (anaxes-job knpc kpc)
  (say knpc "私はラクシマニの十二人の一人で、"
       "ここにある砦と監視塔での指揮を任されていた。"
       "しかしラクシマニはこの神殿の冒涜を命じた。"
       "ゆえに私は反逆したのである！")
  (aside kpc 'ch_nate 
         "［ささやき］このリッチは自分がラクシマニの時代に生きていると思っていますぜ。")
  )

(define (anaxes-fort knpc kpc)
  (say knpc "このブルヌの神殿と監視塔は、ブルヌの守と呼ばれている。"
       "この砦を攻め落とすことはできぬであろう。"))

(define (anaxes-towe knpc kpc)
  (say knpc "ブルヌの守の監視塔は、海、森、山、深淵、そして空を見張っている。"
       "記憶の前、サンダリングの前から、ここで下の危険と上の兆候を監視し続けているのだ。"))

(define (anaxes-sund knpc kpc)
  (say knpc "サンダリングとは世界が崩壊するほどの大変動のことである。"
       "無論おぬしは知らぬであろう！"
       "虚空を越えて来た悪魔でもない限りは…"))

(define anaxes-conv
  (ifc nil

       ;; basics
       (method 'accu anaxes-accu)
       (method 'assa anaxes-luxi)
       (method 'bye anaxes-bye)
       (method 'brun anaxes-brun)
       (method 'default anaxes-default)
       (method 'defe anaxes-fort)
       (method 'fail anaxes-fail)
       (method 'fait anaxes-vigi)
       (method 'fort anaxes-fort)
       (method 'god  anaxes-gods)
       (method 'gods anaxes-gods)
       (method 'hail anaxes-hail)
       (method 'job  anaxes-job)
       (method 'luxi anaxes-luxi)
       (method 'mast anaxes-luxi)
       (method 'name anaxes-name)
       (method 'rebe anaxes-luxi)
       (method 'shri anaxes-vigi)
       (method 'sund anaxes-sund)
       (method 'towe anaxes-towe)
       (method 'twel anaxes-twel)
       (method 'vigi anaxes-vigi)
       ))

(define (mk-anaxes)
  (let ((kchar
         (bind 
          (kern-char-force-drop
           (kern-mk-char 
            'ch_lux          ; tag
            "アナクシズ"     ; name
            anaxes-species   ; species
            anaxes-occ       ; occ
            s_lich           ; sprite
            faction-men      ; starting alignment
            0 0 0            ; str/int/dex
            0 0              ; hp mod/mult
            0 0              ; mp mod/mult
            max-health       ; hp
            -1               ; xp
            max-health       ; mp
            0
            anaxes-lvl       ; level
            #f               ; dead
            'anaxes-conv     ; conv
            nil              ; sched
            'lich-ai         ; special ai
            (mk-inventory
             ;; hack: as the kernel is currently written, he won't drop his
             ;; readied arms on death, and he won't ready arms from inventory
             ;; (its all messed up), but he will drop his inventory. So put
             ;; some decent arms in as loot.
             (list (list 1 t_armor_chain)
                   (list 1 t_chain_coif)
                   (list 1 t_morning_star)
                   (list 1 t_shield)
                   (list 3 mandrake)
                   (list 3 nightshade)
                   (list 8 sulphorous_ash)
                   (list 5 blood_moss)
                   (list 5 black_pearl)
                   (list 50 t_gold_coins)
                   (list 1 t_anaxes_letter)
                   (list 1 t_lichs_blood)
                   ))
            ;; readied
            (list
             t_armor_chain_4
             t_chain_coif_4
             t_morning_star_2
             t_shield_4
             )
            ) ; kern-mk-char
           #t) ; kern-char-force-drop
          (anaxes-mk)) ; bind
         ))
    (map (lambda (eff) (kern-obj-add-effect kchar eff nil))
         undead-effects)
    kchar))
