;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define zane-start-lvl 8)

;;----------------------------------------------------------------------------
;; Schedule
;;
;; 魔道師の塔の1階
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_zane
               (list 0  0  enchtwr-zane-bed        "sleeping")
               (list 6  0  enchtwr-campsite        "idle")
               (list 8  0  enchtwr-dining-room-1   "eating")
               (list 9  0  enchtwr-campsite        "idle")
               (list 12 0  enchtwr-dining-room-1   "eating")
               (list 13 0  enchtwr-hall            "idle")
               (list 19 0  enchtwr-dining-room-1   "eating")
               (list 20 0  enchtwr-dining-room     "idle")
               (list 21 0  enchtwr-campsite        "idle")
               (list 22 0  enchtwr-zane-bed        "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (zane-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;;
;; ゼインは湿地帯の警備隊員である。彼は魔道師の塔でキャンプし、このあたりの
;; 毒の沼での野外活動で必要な物を売っている。
;;----------------------------------------------------------------------------
(define zane-merch-msgs
  (list nil ;; closed
        "町の物は信用できない。自分で作ってる。見せてやろう。" ;; buy
        nil ;; sell
        nil ;; trade
        "このあたりでは足元に気をつけろ。" ;; bought-something
        "好きにしな。" ;; bought-nothing
        nil
        nil
        nil
        nil
        ))

(define zane-catalog
  (list
   ;; reagents
   (list ginseng        (* 5 reagent-price-mult) "これは回復に効く。")
   (list garlic         (* 4 reagent-price-mult) "病気になったときいるはずだ。")
   (list blood_moss     (* 6 reagent-price-mult) "これはなかなか見つからない。")
   (list nightshade     (* 8 reagent-price-mult) "これは本当にジメジメした所でしか育たない。")
   (list mandrake       (* 10 reagent-price-mult) "強い呪文にはコイツがいる。")
   
   ;; potions
   (list t_heal_potion            21 "これはヤバイとき本当に役に立つ。")
   (list t_cure_potion            21 "毒にはこれが一番いい。余分に持っておけ。")
   (list t_poison_immunity_potion 21 "毒のある場所を通るときは、まずこれを飲んでおけ。")
   
   ;; bows, arrows and bolts 
   ;; (as an accomplished Ranger, he is also a bowyer and fletcher)
   (list t_self_bow    30 "この小さいヤツは軽くて素早く撃てる。")
   (list t_bow         90 "この弓はどんなときも使える。安くて軽い。射程もいい。")
   (list t_long_bow   300 "開けた場所の狩には完璧だ。")
   (list t_great_bow  700 "聖騎士の悪夢だ。コイツは遠くからでも鎧をぶち抜けるだろう。")
   
   (list t_arrow        2 "これは特別製だ。だが売ってやろう。")
   (list t_bolt         2 "町の民兵のためにクロスボウの矢を作ってる。")
   ))

(define (zane-trade knpc kpc) (conv-trade knpc kpc "buy" zane-merch-msgs zane-catalog))

(define (zane-ench knpc kpc)
  (say knpc "ああ、この中に閉じこもっている。見てみろ。"
       "誰にもじゃまされたくないようだ。"
       "本当に会いたければ、入る方法を見つけなければならんな。"))

(define (zane-fens knpc kpc)
  (say knpc "ここがそのど真ん中だ。とても危険だ。"
       "気をつけろ。"))
  
(define zane-conv
  (ifc ranger-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default (lambda (knpc kpc) (say knpc "他のヤツに聞きな。")))
       (method 'hail (lambda (knpc kpc) (say knpc "［彼はうなずいた。］")))
       (method 'bye (lambda (knpc kpc) (say knpc "じゃあな。")))
       (method 'job (lambda (knpc kpc) 
                      (say knpc "警備隊員だ。湿地帯を警備してる。")))
       (method 'name (lambda (knpc kpc) (say knpc "ゼイン。")))
       (method 'join (lambda (knpc kpc) 
                       (say knpc "悪いな。もう仕事がある。")))
       (method 'ench zane-ench)
       (method 'fens zane-fens)
       (method 'dang
               (lambda (knpc kpc)
                 (say knpc "毒と怪物でいっぱいだ。"
                      "しばらくここにいるつもりか？")
                 (if (kern-conv-get-yes-no? kpc)
                     (begin
                       (say knpc "毒に対する呪文がいるはずだ。"
                            "知ってるか？")
                       (if (kern-conv-get-yes-no? kpc)
                           (say knpc "ならいい。材料は売ってやるぞ。")
                           (say knpc "ナイトシェイドと大蒜を調合し、Sanct Noxと唱えろ。"
                                "秘薬はたくさん持っているので売ってやってもいいぞ。")
                           ))
                     (say knpc "それがいい。")
                     )))
       (method 'pois
               (lambda (knpc kpc)
                 (say knpc "緑の薬かAn Noxの呪文で治る。")))
       (method 'poti
               (lambda (knpc kpc)
                 (say knpc "たくさん持っているので売ってやるぞ。")))
       (method 'mons
               (lambda (knpc kpc)
                 (say knpc "粘菌、盗賊、不死の者ども。")))
       (method 'reag
               (lambda (knpc kpc)
                 (say knpc "自分はどこでも見つけられる。"
                      "あまった分は売ってやるぞ。")))
       (method 'buy zane-trade)
       (method 'sell zane-trade)
       (method 'trad zane-trade)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-zane-first-time tag)
  (bind 
   (kern-char-arm-self
    (kern-mk-char 
     tag ;;..........tag
     "ゼイン" ;;.......name
     sp_human ;;.....species
     oc_ranger ;;.. .occupation
     s_companion_ranger ;;..sprite
     faction-men ;;..faction
     +1 ;;...........custom strength modifier
     0 ;;...........custom intelligence modifier
     +1 ;;...........custom dexterity modifier
     +1 ;;............custom base hp modifier
     +1 ;;............custom hp multiplier (per-level)
     0 ;;............custom base mp modifier
     0 ;;............custom mp multiplier (per-level)
     max-health ;;..current hit points
     -1  ;;...........current experience points
     max-health ;;..current magic points
     0 ;; AP_per_turn
     zane-start-lvl  ;;..current level
     #f ;;...........dead?
     'zane-conv ;;...conversation (optional)
     sch_zane ;;.....schedule (optional)
     'townsman-ai ;;..........custom ai (optional)

     ;;..............container (and contents)
     (mk-inventory
      (list
       (list 10  t_food)
       (list 100 t_arrow)
       (list 1   t_great_bow)
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
   (zane-mk)))
