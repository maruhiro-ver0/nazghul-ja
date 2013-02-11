;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define lux-lvl 7)
(define lux-species sp_ghast)
(define lux-occ oc_wizard)

;;----------------------------------------------------------------------------
;; Schedule
;;
;; 緑の塔の墓
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (lux-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ラクシマニはリッチ(後に彼の頭蓋骨から影が呼び出される)で、クロポリスの遺跡
;; にある宝物庫を支配している。彼はシャルドを征服、統一した偉大な王だった。そ
;; して最後には賢者として知られるようになる者たちによって倒された。
;;----------------------------------------------------------------------------

;; Basics...
(define (lux-hail knpc kpc)
  (say knpc "［あなたは殺意に燃える影と会った。］何が望みだ？"
       "死すべき者よ。"))

(define (lux-default knpc kpc)
  (say knpc "我の時間を無駄にするな。"))

(define (lux-name knpc kpc)
  (say knpc "我は偉大なラクシマニ、この中央域の王である。"))

(define (lux-rune knpc kpc)
  (say knpc "［彼は突然かき乱されたように見えた。］"
       "それは悪魔の門を封印するため、賢者によって作られた八つの鍵の一つだ。"))

(define (lux-gate knpc kpc)
  (say knpc "それぞれの鍵には守護者がおり、互いに会うことを禁止されていた。"
       "そしてその伝統は引き継がれてきた。汝は守護者か？")
  (if (yes? kpc)
      (begin
        (say knpc "ならばなぜ汝はこの石版のことを我に聞くのだ？汝の主は何も言わなかったのか？")
        (if (yes? kpc)
            (say knpc "［彼は悪意をこめて笑った。］汝は我を愚かだと思っているのか。"
                 "そう思っている者が愚かなのだ。この石版は汝の破滅の元、この時代の破滅の元である！")
            (say knpc "破滅は人がその誓いを忘れた時代から始まる。")))
      (begin
        (say knpc "盗人か？")
        (if (yes? kpc)
            (say knpc "この死すべき時代では盗人さえも自らが盗んだものの価値を知らない。")
            (say knpc "ならば汝は偶然石版を手にしたというのか。"
                 "汝らの時代の終わりは近いだろう。")))))

(define (lux-age knpc kpc)
  (say knpc "悪魔の門が封印されたとき、魔術師たちの時代は終わった。"
       "それが我、このシャルドを征服し統一した者、ラクシマニの時代の始まりだった。"
       "我の後の支配者は世代を越すごとに悪くなり、ついに我の帝国は廃墟となった。"
       "そして失われた時代、この今が始まった。"
       "大いなる秘密を知りたいか？")
  (if (yes? kpc)
      (say knpc "ならば伝えよう。最後の守護者よ。")
      (say knpc "\n［部屋に恐ろしい笑い声が響いた。］\n"
           "だが、汝は知るであろう。最後の守護者よ！"))
  (say knpc "悪魔の門が開かれたとき、失われた時代は終わるであろう。"))

(define (lux-keep knpc kpc)
  (say knpc "汝は最後の守護者だ。石版を手にし、その意味を知る。"
       "さあ全ての石版は汝が守護すべきものだ。全てその手の中にあるか？")
  (if (yes? kpc)
      (say knpc "そうなのだな。全て揃わなければ門は開かない。")
      (say knpc "探し出せ。一人の名誉ある者が恥辱から時代を救う。"
           "もちろん彼自身を、ではない。")))

(define (lux-wise knpc kpc)
  (say knpc "賢者？［彼は笑った。］\n"
       "時代の支配者に反逆する者たちよ！\n"
       "\n"
       "戦士のアーガス、\n"
       "　この者は我の軍を打ち負かし\n"
       "　そして自らの軍を率いた\n"
       "魔術師のカイレフ、\n"
       "　この者は反逆者を指揮し\n"
       "　そして我の妖術師たちに歯向かった\n"
       "ならず者のナートハックス、\n"
       "　この者の盗人はわが敵と通じ\n"
       "　そして秘密の通路を見つけ出した\n"
       "職人のウェイレンド、\n"
       "　この者はわが砦を捜索する者の\n"
       "　装備を整えた\n"
       "\n"
       "我の敗北にも関わらず、彼らは死すべき定めにあった！"
       "\n")
  (say knpc "\n［彼はあなたを期待の目で見た。］\n"
       "何？彼らの名を知らぬか？")
  (if (yes? kpc)
      (say knpc "ならば驚嘆せよ。わが伝説を！")
      (begin
	(say knpc
	     "\n［彼の冷たい目は怒りで輝いた。］\n"
	     "ああ、この時代の賢者と呼ばれる者たちを支持する方を取るのだな。\n"
	     "このようなつまらぬ者は知らぬ。\n"
	     "去れ、死すべきものよ！")
	(kern-conv-end)
	))
  )

(define (lux-accu knpc kpc)
  (say knpc "呪われた者？\n"
       "それぞれの時代には、そのような力を求める者、"
       "そのような警句や道徳よって惑わされない者がいる。\n"
       "\n"
       "ある者は滅ぼされ、"
       "またある者は真の力を得て他を奴隷にする。\n"
       "\n"
       "それはまさに寄生虫のようなものである。")
  )


(define lux-conv
  (ifc basic-conv

       ;; basics
       (method 'default lux-default)
       (method 'hail lux-hail)
       (method 'name lux-name)

       (method 'rune lux-rune)
       (method 'key  lux-rune) ;; A synonym

       (method 'demo lux-gate) ;; A synonym
       (method 'gate lux-gate)

       (method 'wise lux-wise)
       (method 'accu lux-accu)

       (method 'age  lux-age)
       (method 'keep lux-keep)

       ))

(define (mk-luximene)
  (bind 
   (kern-mk-char 
    'ch_lux           ; tag
    "ラクシマニ"          ; name
    lux-species         ; species
    lux-occ              ; occ
    s_ghost     ; sprite
    faction-men      ; starting alignment
    0 0 0            ; str/int/dex
    0 0              ; hp mod/mult
    0 0              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    lux-lvl
    #f               ; dead
    'lux-conv         ; conv
    nil           ; sched
    nil              ; special ai
    nil              ; container
    nil              ; readied
    )
   (lux-mk)))

(define (mk-lich-king)
  (let ((kchar 
         (bind 
          (kern-char-force-drop
           (kern-mk-char 
            'ch_lich_king           ; tag
            "リッチの王" ; name
            sp_lich         ; species
            oc_wizard              ; occ
            s_lich     ; sprite
            faction-monster      ; starting alignment
            10 10 10            ; str/int/dex
            10 1              ; hp mod/mult
            0  0              ; mp mod/mult
            max-health ; hp
            -1                   ; xp
            max-health ; mp
            0
            8
            #f               ; dead
            nil              ; conv
            nil             ; sched
            'lich-ai        ; special ai
            (mk-inventory
             (list (list 1 t_morning_star)
                   (list 1 t_armor_chain_4)
                   (list 1 t_chain_coif_4)
                   (list 100 t_gold_coins)
                   (list 3 t_mana_potion)
                   (list 3 t_heal_potion)
                   (list 1 t_lich_skull)
                   (list 1 t_lichs_blood)
                   ))
            nil              ; readied
            )
           #t)
          (lux-mk))))
    (map (lambda (eff) (kern-obj-add-effect kchar eff nil))
         undead-effects)
    kchar))

