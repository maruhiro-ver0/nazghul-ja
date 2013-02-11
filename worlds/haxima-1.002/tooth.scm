;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define tooth-lvl 2)
(define tooth-species sp_rat)
(define tooth-occ oc_wrogue)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; 怪物の村クーン
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_tooth
               (list 0 0 campfire-4 "sleeping")
               (list 6 0 black-market-counter "working")
               (list 19 0 cantina-12 "idle")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (tooth-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; マエバは神経質なネズミ人間で、怪物の村クーンで闇市と質を営んでいる。
;; 何かの興奮剤の取りすぎ(または禁断症状)で苦しんでいるように見える。
;;----------------------------------------------------------------------------

;; Basics...
(define (tooth-hail knpc kpc)
  (kern-log-msg "あなたはずる賢そうな年老いた大きな前歯のネズミと会った。彼は神経質そうに震え、体を揺らしている。"
                "カフェインの取りすぎ？ブラックロータスが出た？あなたには何もわからない。")
  (say knpc "ちょっと。商売かい？商売はあるよ。どんな商売もあるよ！いい商売！悪い商売！"
       "言っとくれ、用意するよ、決めとくれ！何も聞いてない、何も言えない。")
  )

(define (tooth-default knpc kpc)
  (say knpc "知らない。それは知らない。情報？俺には関係ない。")
  )

(define (tooth-name knpc kpc)
  (say knpc "マエバ。有名だよ！評判いいよ。お客はみんな気に入ってる。"
       "みんなまた来る。お客のお友達は俺のこと話してる？冗談！"
       "商売はとってもいいよ。お客はみんな秘密にしてる。俺はすごい秘密！有名な秘密！")
  )

(define (tooth-join knpc kpc)
  (say knpc "できない。友よ。店しなきゃ。借金返さなきゃ。衛兵から逃げなきゃ。忙しすぎる！動かなきゃ！")
  )

(define (tooth-job knpc kpc)
  (say knpc "商売！商売！商売！商売！商売！商売！さあやろう。すぐやろう。"
       "ここでやろう。一緒にやろう。準備できた？さあいこう。")
  (tooth-trade knpc kpc)
  )

(define (tooth-bye knpc kpc)
  (say knpc "そんなに早く行くの？もう帰るの？もっとあるよ！たくさんあるよ！"
       "いいもの！でもここにはない！いいや！棚から飛んでいった！自己責任で…！"
       "［彼はあなたが去るまでこのようなことを言い続けた。］")
  )

(define tooth-merch-msgs
  (list nil ;; closed
        "これ見て、このすごいの見て！全部いい！珍しい、役立つ、他にない！" ;; buy
        "持ち物？受け取る。どこで見つけた？どうでもいい。" ;; sell
        "全部お買い得！どうやって儲けてる？わからない！自分で確かめて！" ;; trade
        "それだけ？まだあるよ！" ;; sold-something
        "待て！どこ行く？戻って、別の見て！俺の巻物コレクション見た？" ;; sold-nothing
        "もっとあったらまた来て！いつでも見るよ！" ;; bought-something
        "もっといいもの！魔法のもの、宝石、芸術品！" ;; bought-nothing
        "基本を忘れない！火炎ビン、宝石、鍵開け道具！" ;; traded-something
        "待て！どこ行く？戻って、別の見て！俺の巻物コレクション見た？" ;; traded-nothing
        ))

(define tooth-catalog
  (list
   (list t_picklock            5 "扉を開ける！ちょっと技がいる！")
   (list t_gem                20 "秘密の部屋と道を見つける！泥棒はコレが大好き！")
   (list t_grease             25 "狭いとこに入る？脂だ！")

   (list t_oil                 5 "粘菌と戦うのに一番！")
   (list t_slime_vial         30 "Kal Xen Noxを瓶詰めした！衛兵から逃げるのにいい！")
   (list t_arrow               3 "矢はいっぱいいるよ！")
   (list t_bolt                3 "弾は多すぎることはない！")
   (list t_smoke_bomb          4 "よく見える逃げ道を作る！")

   (list t_spiked_helm       300 "頭で戦え！")
   (list t_spiked_shield     300 "珍しい物！攻撃が大好きな人に！")

   (list t_dagger_4           (* 4 65) "とってもいい！小さい、隠せる、でも咬むと怖い！")
   (list t_sword_2            (* 2 85) "普通の剣よりいい！この切っ先を見て！")
   (list t_sword_4            (* 4 85) "一番いい！最強！本物の死の芸術家の武器！")
   (list t_morning_star_2     (* 2 105) "本当にカッコイイ武器！まとめて倒せ！")

   (list t_leather_helm_2     (* 2 100) "ちょっと余分に防御が要るならず者向け！")
   (list t_chain_coif_4       (* 4 100) "このきつい網目見て？この強い結びつき？どんな刃も和らげる！")
   (list t_iron_helm_4        (* 4 150) "とっても珍しい！頭を殴られても枕ぐらいにしか感じない！")

   (list t_armor_leather_2    (* 2 150) "巨人の武器庫の泥棒になりたい？トロルから宝石を盗みたい？これみたいな軽くていいやつか要る！")
   (list t_armor_leather_4    (* 4 150) "昔のならず者が持ってた！金貨のベッドで年取って死んだ！あんたもできる！")
   (list t_armor_chain_4      (* 4 330) "これは完璧！動きのジャマにならなくて強い！")
   (list t_armor_plate_4      (* 4 660) "巨人とトロルが殴っても効かないすごい鎧！ここ以外にない！")

   (list t_xen_corp_scroll    (* 7 base-scroll-cost) "暗殺者が好き！すぐ殺せる！")
   (list t_sanct_lor_scroll   (* 7 base-scroll-cost) "ならず者が好き！見えなくなって出入りする！")
   (list t_an_xen_ex_scroll   (* 6 base-scroll-cost) "倒せないヤツはこの呪文で仲間にしろ！")
   (list t_in_ex_por_scroll   (* 4 base-scroll-cost) "コイツがいっぱいあれば、魔法の扉も止められない！")
   (list t_wis_quas_scroll    (* 4 base-scroll-cost) "見えない扉(そして見えない敵)を見つけるのに完璧！")
   (list t_in_quas_xen_scroll (* 7 base-scroll-cost) "自分が二人欲しい？この巻物を読め！")
   (list t_an_tym_scroll      (* 8 base-scroll-cost) "本当にヤバイときはこの巻物を読んで時間を止めて逃げろ！")
   ))

(define (tooth-trade knpc kpc) (conv-trade knpc kpc "trade" tooth-merch-msgs tooth-catalog))
(define (tooth-buy   knpc kpc) (conv-trade knpc kpc "buy"   tooth-merch-msgs tooth-catalog))
(define (tooth-sell  knpc kpc) (conv-trade knpc kpc "sell"  tooth-merch-msgs tooth-catalog))

(define tooth-conv
  (ifc nil

       ;; basics
       (method 'default tooth-default)
       (method 'hail tooth-hail)
       (method 'bye  tooth-bye)
       (method 'job  tooth-job)
       (method 'name tooth-name)
       (method 'join tooth-join)

       (method 'trad tooth-trade)
       (method 'buy  tooth-buy)
       (method 'sell tooth-sell)
       (method 'deal tooth-trade)
       ))

(define (mk-tooth)
  (bind 
   (kern-mk-char 
    'ch_tooth           ; tag
    "マエバ"             ; name
    tooth-species         ; species
    tooth-occ              ; occ
    s_rat     ; sprite
    faction-men      ; starting alignment
    0 4 1            ; str/int/dex
    0  ; hp bonus
    0 ; hp per-level bonus
    0 ; mp off
    1 ; mp gain
    max-health ; hp
    -1                  ; xp
    max-health ; mp
    0
    tooth-lvl
    #f               ; dead
    'tooth-conv         ; conv
    sch_tooth           ; sched
    'townsman-ai              ; special ai
    nil
    nil              ; readied
    )
   (tooth-mk)))
