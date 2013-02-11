;; Reagent-seller
;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; In Oparine.
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_lia
               (list 0  0  sea-witch-bed        "sleeping")
               (list 6  0  sea-witch-beach      "idle")
               (list 8  0  sea-witch-counter    "working")
               (list 20 0  sea-witch-beach      "idle")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (lia-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; リアはオパーリンに住む女性の魔術師で、秘薬を売っている。
;; そして彼女が愛するニキシーの王子のフィンの近くにいる。
;; 
;; 彼女はよくわからない呪いをかけられていると言われている。
;; 彼女はニキシーか他の海の民で、人間の姿に変身しているだけかもしれない。
;;----------------------------------------------------------------------------

;; Basics...
(define (lia-hail knpc kpc)
  (say knpc "［あなたは忘れられないような美人と会った。］いらっしゃいませ。"))

(define (lia-default knpc kpc)
  (say knpc "それはお手伝いできません。"))

(define (lia-name knpc kpc)
  (say knpc "私はリアです。"))

(define (lia-join knpc kpc)
  (say knpc "この岸を離れることはできません。"))

(define (lia-job knpc kpc)
  (say knpc "秘薬を売っています。珍しい黒真珠もありますよ。"))

(define (lia-bye knpc kpc)
  (say knpc "さようなら、迷い人さん。"))

;; Trade...
(define lia-merch-msgs
  (list "私の店は午前8時から午後8時まで開いています。"
        "これだけの品があります。"
        "よい物があれば買い取ります。"
        "買いますか？それとも売りたい物がありますか？"
        "あなたの魔法に加護がありますように。"
        "わかりました。"
        "何か他に必要な物はありますか？"
        "適正な価格を提示しただけです。"
        "深き神があなたを助けるでしょう。"
        "そう望むなら。"
   ))

(define lia-catalog
  (list
   (list sulphorous_ash         (*  2 reagent-price-mult) "この灰は火の海にある竜の寝床から取ってきたものです。")
   (list garlic                 (*  4 reagent-price-mult) "大蒜はよくある、でも呪文で使いやすい薬草です。")
   (list ginseng                (*  4 reagent-price-mult) "この人参はマンドレイクと一緒に自分で育てたものです。")
   (list black_pearl            (*  4 reagent-price-mult) "私の特別な場所で取ったものです。他では見つからないでしょう。")
   (list blood_moss             (*  6 reagent-price-mult) "このあたりでは血の苔はなかなか見つかりません。")
   (list nightshade             (* 11 reagent-price-mult) "ナイトシェイドはこのあたりでは珍しいものです。")
   (list mandrake               (* 11 reagent-price-mult) "マンドレイクは人参と一緒に育てています。")
   
   (list t_in_an_scroll         (*  3 base-scroll-cost) "魔力で勝る者と直面しても、これがあれば同格になります。")
   (list t_in_mani_corp_scroll  (*  8 base-scroll-cost) "仲間が倒れてもこれがあれば悲しむことはありません。")
   (list t_vas_rel_por_scroll   (*  3 base-scroll-cost) "この門の巻物があれば、遠くへ旅することも、悲惨な状態から逃げることもできます。")
   (list t_vas_mani_scroll      (*  2 base-scroll-cost) "ひどい傷を負ってもこれで回復することができます。")
   (list t_wis_quas_scroll      (*  2 base-scroll-cost) "この巻物で見えない世界への目が開くでしょう。")
   ))

(define (lia-trade knpc kpc)  (conv-trade knpc kpc "trade" lia-merch-msgs lia-catalog))
(define (lia-buy knpc kpc)  (conv-trade knpc kpc "buy" lia-merch-msgs lia-catalog))
(define (lia-sell knpc kpc)  (conv-trade knpc kpc "sell" lia-merch-msgs lia-catalog))

(define (lia-pear knpc kpc)
  (say knpc "I have my own source for the rare black pearl. "
       "Would you like to purchase some?")
  (if (kern-conv-get-yes-no? kpc)
      (lia-buy knpc kpc)
      (say knpc "You won't get this quality anywhere else!")))

;; Shores...
(define (lia-shor knpc kpc)
  (say knpc "愛する人の近くにいるため、私はここにいなければなりません。"))

(define (lia-love knpc kpc)
  (say knpc "私の愛する人は海を離れることができません。"
       "彼は海の人の王子なのです。"
       "勇敢で誠実、そして私の呪いにもかかわらず私を見捨てないでいます。"
       ))

;; Sea
(define (lia-sea knpc kpc)
  (say knpc "長い間、故郷に戻っていません！"
       "深き場所の中庭が、"
       "天をかける船が、"
       "そして遠くざわめく人々の会話が恋しい。"))

(define (lia-curs knpc kpc)
  (say knpc "それは話したくありません。"))

;; Townspeople...
(define (lia-opar knpc kpc)
  (say knpc "この町の人々は私には乾きすぎています。"))

(define (lia-gher knpc kpc)
  (say knpc "海の死肉漁りが彼女の船をよく追っていました。"
       "彼らは彼女の犠牲者でよく肥えていました。"))

(define (lia-alch knpc kpc)
  (say knpc "彼は時々来て、私と魔法の話をします。"
       "私の人間の友達の一人です。"))

(define (lia-osca knpc kpc)
  (say knpc "彼のことは、海に行ったことがないこと以外はよく知りません。"))

(define (lia-henr knpc kpc)
  (say knpc "彼はかつてすばらしい船乗りでした。"
       "深き場所の偉大な者が時々その勇敢さを語っていました。"))

(define (lia-bart knpc kpc)
  (say knpc "彼の船は高く評価されています。"
       "でも、私にとって船は不格好で重々しいものです。"))

(define lia-conv
  (ifc basic-conv

       ;; basics
       (method 'default lia-default)
       (method 'hail lia-hail)
       (method 'bye  lia-bye)
       (method 'job  lia-job)
       (method 'name lia-name)
       (method 'join lia-join)
       
       ;; Shores
       (method 'shor lia-shor)
       (method 'love lia-love)
       (method 'sea  lia-sea)
       (method 'deep lia-sea)
       (method 'curs lia-curs)

       ;; trade
       (method 'trad lia-trade)
       (method 'reag lia-buy)
       (method 'buy  lia-buy)
       (method 'sell lia-sell)
       (method 'blac lia-buy)
       (method 'pear lia-buy)

       ;; town & people
       (method 'opar lia-opar)
       (method 'alch lia-alch)
       (method 'gher lia-gher)
       (method 'osca lia-osca)
       (method 'henr lia-henr)
       (method 'bart lia-bart)
       (method 'fing lia-love)

       ))

(define (mk-lia)
  (bind 
   (kern-mk-char 'ch_lia           ; tag
                 "リア"            ; name
                 sp_human            ; species
                 oc_wizard           ; occ
                 s_townswoman        ; sprite
                 faction-men         ; starting alignment
                 0 2 1               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 3  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'lia-conv         ; conv
                 sch_lia           ; sched
                 'townsman-ai                 ; special ai
                 (mk-inventory (list (list 1 t_dagger)))    ; container
                 nil                 ; readied
                 )
   (lia-mk)))
