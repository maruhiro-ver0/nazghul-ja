;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; グラスドリン
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_ches
               (list 0  0  gc-bed       "sleeping")
               (list 7  0  ghg-s3       "eating")
               (list 8  0  gas-counter "working")
               (list 11 0  ghg-s3       "eating")
               (list 12 0  gas-counter "working")
               (list 18 0  ghg-s3       "eating")
               (list 19 0  ghg-hall     "idle")
               (list 21 0  gc-bed       "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (ches-mk) (list 'townsman))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; チェスターは武器屋の大男で、グラスドリンに住んでいる。
;;----------------------------------------------------------------------------

;; Basics...
(define (ches-hail knpc kpc)
  (say knpc "［あなたは木の幹のような腕の大男と会った。］"
       "よお、戦士さん！"))

(define (ches-default knpc kpc)
  (say knpc "それは俺の知識を超えている。"))

(define (ches-name knpc kpc)
  (say knpc "「斧と盾」のチェスターだ。"
       "厳粛な人物と見られるためには、厳粛な武器が必要だ。"
       "何か興味のある物はあるか？")
  (if (kern-conv-get-yes-no? kpc)
      (ches-trade knpc kpc)))

(define (ches-join knpc kpc)
  (say knpc "否、友よ。冒険者には装備を供給する誰かが必要だ！"))

(define (ches-job knpc kpc)
  (say knpc "この地で最も良い武器と鎧を売っている。"
       "見ていくか？")
       (if (kern-conv-get-yes-no? kpc)
           (ches-trade knpc kpc)
           (say knpc "まあいいだろう。ここよりいい物はない。"
                "断言する。")))

(define (ches-bye knpc kpc)
  (say knpc "さらば。友に俺の店のことを話してくれ！"))

(define ches-catalog
  (list
   (list t_staff            20 "仲間の魔術師に杖を持たせれば、その便利さがわかるはずだ。")
   (list t_dagger           65 "靴の中に一つか二つの短剣を常に忍ばせておけ。")
   (list t_mace             80 "槌矛は頭蓋骨を砕き骨を壊すにはいい武器だ。")
   (list t_axe              85 "この斧はまさに盾を割るためのものだ。")
   (list t_sword            85 "剣は戦士の主力の武器だ。")
   (list t_2H_axe           90 "この両手斧があれば草を刈り取るように敵をなぎ倒せる。")
   (list t_2H_sword        100 "そうだ。個人的にはこの強力な両手剣が好みだ。")
   (list t_morning_star    105 "この刺付き鉄球を取り出せば、それだけで敵は退くだろう。")
   (list t_halberd         150 "斧槍を持つ者が後ろにいれば、前面は強化されるだろう。")
   
   (list t_sling            50 "もし子供がいるなら、投石紐は最初の武器としてはいいだろう。")
   (list t_spear            15 "投槍はゴブリンや蛮族がよく使っている武器だ。")

   (list t_self_bow        120 "この小さな弓は小さな動物を狩るにはもってこいだ。")
   (list t_bow             200 "警備隊のように森の中を這い回る者にはこの弓がいい。")
   (list t_arrow             1 "もし敵と直面したくなければ、矢を大量に持っておくべきだ。")
   
   (list t_crossbow        380 "もし敵が刃から逃げ出したなら、このクロスボウで倒せ！")
   (list t_hvy_crossbow    600 "敵に囲まれたら、勇ましい戦士もこの美女だけが頼りだ。")
   (list t_bolt              1 "グラスドリンの軍は最高の武器を求めている。そして唯一俺がクロスボウの矢を供給している。")
   
   (list t_leather_helm     50 "軽い兜は鉛筆のような首のならず者にはぴったりだ。")
   (list t_chain_coif      100 "鎖頭巾は視界を遮らずに首を守れる。")
   (list t_iron_helm       150 "この鉄兜はおまえの頭を最も固いダイヤに変えるだろう。")
   (list t_armor_leather   150 "皮の鎧は動きのじゃまにならないが、最低限の防御力しかない。")
   (list t_armor_chain     330 "鎖かたびらは聖騎士に最適の鎧だ。そして彼らはそのことをよくわかっている。")
   (list t_armor_plate    1000 "甲冑を着れば不死身の戦士になれる。")
   
   (list t_shield           30 "丈夫な盾があれば遠くから撃ってくる臆病者の敵から身を守れる。")
   
   (list t_spiked_helm     250 "攻撃は最大の防御だ！この刺付き兜が証明してくれるだろう。冗談ではなく。")
   (list t_spiked_shield   250 "この刺付き盾があれば武器はほとんどいらないだろう。")
   ))

(define ches-merch-msgs
  (list "俺が店にいるときに「斧と盾」に来てくれ。最高の武器と防具をお見せしよう。午前9時から午後6時までやってる。"
        "さあ俺の武器・鎧を見てくれ！" ;; buy
        "使った武器・鎧も下取りするぞ。" ;; sell
        "この地で最高の戦士たちに装備を供給している。なにが欲しい？" ;; trade
        "さあ敵の頭蓋骨を砕け！もっといいのが欲しくなったらまた来てくれ。" ;; sold-something
        "おまえの装備は少し古びているな。考えなおしたほうがいい。" ;; sold-nothing
        "このオンボロの代わりを何か買っていきな。" ;; bought-something
        "そのガラクタが欲しい奴が他にいるとは思えない。" ;; bought-nothing
        "巨人を蹴散らす準備ができたな！" ;; traded-something
        "好きなだけ見ていきなよ。" ;; traded-nothing
        ))

;; Trade...
(define (ches-trade knpc kpc) (conv-trade knpc kpc "trade" ches-merch-msgs ches-catalog))
(define (ches-buy knpc kpc) (conv-trade knpc kpc "buy" ches-merch-msgs ches-catalog))
(define (ches-sell knpc kpc) (conv-trade knpc kpc "sell" ches-merch-msgs ches-catalog))

;; Paladins...
(define (ches-pala knpc kpc)
  (say knpc "兵役では何度か聖騎士と同行した。でも稼ぐ方法がなかった。"
       "だから退役後はこの店を開いたんだ。"))

;; Townspeople...
(define (ches-glas knpc kpc)
  (say knpc "悪くない町だ。聖騎士なんかを相手にした商売にはもってこいだ。"))

(define (ches-ange knpc kpc)
  (say knpc "美人だ。けど俺はもっと荒々しいのが好みだな。"))

(define (ches-patc knpc kpc)
  (say knpc "俺は病気になったことがない。だがいい腕だと聞いた。"))

(define (ches-jess knpc kpc)
  (say knpc "今は若い女のいるいい場所だ！"
       "傷が残念だが、真っ暗なら同じだろう？"))

(define ches-conv
  (ifc glasdrin-conv

       ;; basics
       (method 'default ches-default)
       (method 'hail ches-hail)
       (method 'bye ches-bye)
       (method 'job ches-job)
       (method 'name ches-name)
       (method 'join ches-join)
       
       ;; trade
       (method 'trad ches-trade)
       (method 'buy ches-buy)
       (method 'sell ches-sell)

       ;; paladin
       (method 'pala ches-pala)

       ;; town & people
       (method 'glas ches-glas)
       (method 'ange ches-ange)
       (method 'patc ches-patc)
       (method 'jess ches-jess)

       ))

(define (mk-chester)
  (bind 
   (kern-mk-char 'ch_chester         ; tag
                 "チェスター"        ; name
                 sp_human            ; species
                 oc_warrior          ; occ
                 s_townsman          ; sprite
                 faction-glasdrin         ; starting alignment
                 5 0 2               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 3  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'ches-conv          ; conv
                 sch_ches            ; sched
                 'townsman-ai                 ; special ai
                 (mk-inventory (list (list 1 t_mace)
                                     (list 1 t_armor_chain))) ; container
                 nil ;;  readied
                 )
   (ches-mk)))
