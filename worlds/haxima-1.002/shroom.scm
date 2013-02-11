;; shroom.scm - 緑の塔の北東に住む歴史を知る老婆

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; 緑の塔
;;----------------------------------------------------------------------------
(define (mk-zone x y w h) (list 'p_green_tower x y w h))
(kern-mk-sched 'sch_shroom
               (list 0  0  (mk-zone 51 9  1  1)  "sleeping")
               (list 5  0  (mk-zone 40 11 3  3)  "idle")
               (list 6  0  (mk-zone 49 6  7  1)  "working")
               (list 12 0  (mk-zone 50 9  1  1)  "eating")
               (list 13 0  (mk-zone 49 6  7  1)  "working")
               (list 18 0  (mk-zone 56 54 1  1)  "eating")
               (list 19 0  (mk-zone 53 50 4  7)  "idle")
               (list 21 0  (mk-zone 51 9  1  1)  "sleeping"))

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (shroom-mk gave-quest? finished-quest?) (list gave-quest? 
                                                      finished-quest?))
(define (shroom-gave-quest? shroom) (car shroom))
(define (shroom-quest-done? shroom) (cadr shroom))
(define (shroom-give-quest shroom) (set-car! shroom #t))
(define (shroom-set-quest-done! shroom) (set-car! (cdr shroom) #t))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; シュルームは半魔女であり、緑の塔で秘薬や薬を売っている。
;; 彼女はゴブリン戦争ではクロービス王の軍で戦い、戦場の乙女と呼ばれていた。
;;----------------------------------------------------------------------------

(define shroom-merch-msgs
  (list "そうさ。キノコなんかを売っている。店が開いているとき北西の角に来なさい。"
        "森のどこで取るのが一番いいかあたしは知っているのさ。"
        "何かいいものはあるかね。"
        "キノコやほかの秘薬がある。何か買うかね？"
        "気をつけて使ってくれよ。"
        "自分で取りに行こうとするな。邪悪なものに殺されるよ！"
        "売るものがあったらまた来な。"
        "好きにすればいいさ。"
        "どうも。"
        "ただ婆さんと話したかっただけかい？"
   ))

(define shroom-catalog
  (list
   (list sulphorous_ash (*  2 reagent-price-mult) "この臭い塊を見つけるには丘のずっと向こうへ行かねばならん。")
   (list garlic         (*  3 reagent-price-mult) "あたしの畑で取ったものだ。ボレの料理人もこいつを気に入ってる。")
   (list ginseng        (*  3 reagent-price-mult) "森人が人参がどこにあるか教えてくれた。")
   (list blood_moss     (*  4 reagent-price-mult) "この珍しい血の苔は、森の奥の死んだ木に生えてたものだ。")
   (list spider_silk    (*  5 reagent-price-mult) "蜘蛛の糸は珍しくはない。だが取るのは大変だ。")
   (list nightshade     (* 10 reagent-price-mult) "ナイトシェイドは南の川の近くで探さねばならん。")
   (list mandrake       (*  8 reagent-price-mult) "マンドレイクはこの森に生えている。だがどこにあるのか知っている奴は少ない！")
   
   (list t_heal_potion  20 "森は危ない。何かあったときのため持っていくとよいだろう。")
   (list t_mana_potion  20 "一日中秘薬を探した帰り、光の呪文を唱えた後にこいつを使っている。")
   (list t_cure_potion  20 "無用心に毒を食らってしまったらこいつを使えばいい。")
   (list t_poison_immunity_potion 20 "毒の沼で秘薬を探すときはいつもこいつを飲んでいる。")
   (list t_slime_vial   20 "ぐうたらな奴はこれを好む。あたしも持ち歩いてる。ネバネバがいくらあっても足りないくらいだ。")
   ))

;; Shroom's merchant procedure
(define (shroom-trade knpc kpc) (conv-trade knpc kpc "trade" shroom-merch-msgs shroom-catalog))

;; Shroom's mushroom quest
(define (shroom-wards knpc kpc)
  (let ((shroom (kobj-gob-data knpc)))
    (if (shroom-gave-quest? shroom)
        ;; gave quest
        (if (shroom-quest-done? shroom)
            ;; quest already done
            (say knpc "他はみんな忘れちまった。")
            ;; quest NOT yet done
            (begin
              (say knpc "キノコを持ってくれば火の呪文を教えよう。"
                   "覚えているか？")
              (if (kern-conv-get-yes-no? kpc)
                  (say knpc "うむ…")
                  (say knpc "［ため息］書き留めておいたほうがよかろう。"
                       "町を離れ、南へ行くと海の近くに山脈がある。"
                       "そこに洞窟の入り口があるだろう。"))))
        (begin
          (say knpc "あのころ、あたしは戦いの呪文をたくさん知ってた。"
               "知りたいか？")
          (if (kern-conv-get-yes-no? kpc)
              (begin
                (say knpc "あたしが知ってた呪文は、火から身を守るものだ。"
                     "だが、まずは頼みを聞いてからだ。よいな？")
                (if (kern-conv-get-yes-no? kpc)
                    (begin
                      (say knpc "南の洞窟には紫色のキノコが生えている。"
                           "それを持ってくるのだ。わかったな？")
                      (if (kern-conv-get-yes-no? kpc)
                          (begin
                            (say knpc "よろしい。洞窟の中はネバネバの巣だ。"
                                 "火炎ビンをたくさん持っていけ！")
                            (shroom-give-quest shroom))
                          (say knpc "そうだな。怖いんだろう。")))
                    (say knpc "タダでは何も買えんぞ、若いの！")))
              (say knpc "無論そうだろうな。あんたのような優秀な戦士は、あたしのような年寄りの魔女から教わることは何もないのだろうね。"))))))
                               
(define (shroom-hail knpc kpc)
  (let ((shroom (kobj-gob-data knpc)))
    (display "shroom: ")
    (display shroom)(newline)
    (if (shroom-gave-quest? shroom)
        ;; gave quest
        (if (shroom-quest-done? shroom)
            ;; quest done
            (say knpc "また会ったな、若い迷い人よ。")
            ;; quest not done yet
            (if (in-inventory? kpc t_royal_cape)
                (begin
                  ;; player has shrooms
                  (say knpc "おお、これじゃ！このキノコだ。")
                  (kern-obj-remove-from-inventory kpc t_royal_cape 1)
                  (shroom-set-quest-done! shroom)
                  (say knpc "あたしが教える番だ。"
                       "その呪文は第一陣のイン・フラム・サンクト<In Flam Sanct>だ。"
                       "ロイヤルケープ茸、硫黄の灰、大蒜を調合しろ。"
                       "それを唱え自分や仲間にかけると、火が何ともなくなるのじゃ！"))
                ;; player does NOT have shrooms yet
                (say knpc "まだ紫色のキノコは見つからぬようだな。"
                      "あせることはない。"
                      "だが、死ぬ前には欲しいもんだね。")))
        ;; has NOT given quest yet
        (say knpc "なんか用かね。"))))

(define (shroom-thie knpc kpc)
  (say knpc "怪しい奴は見なかったがね。"))

(define (shroom-roya knpc kpc)
  (say knpc "ロイヤルケープ茸の使い方を知ってるか？")
  (if (yes? kpc)
      (say knpc "めったに手に入らない。だが、黄色い粘菌のある場所で見つかることがある。")
      (say knpc "こいつには吸収する力がある！")))

(define (shroom-band knpc kpc)
  (say knpc "盗賊？そう、年寄りは森では気をつけねば。"))

(define shroom-conv
  (ifc basic-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default (lambda (knpc kpc) (say knpc "昔聞いたような気がするな。")))
       (method 'hail shroom-hail)
       (method 'bye (lambda (knpc kpc) (say knpc "さらばじゃ。")))
       (method 'job (lambda (knpc kpc) (say knpc "薬や秘薬などを売っている。")))
       (method 'name (lambda (knpc kpc) (say knpc "シュルームと呼ばれている。"
                                                "用は何かね。")))
       (method 'cape shroom-roya)
       (method 'roya shroom-roya)
       (method 'shro (lambda (knpc kpc) (say knpc "キノコのことをよく知っている。"
                                                "だからあたしをシュルームと呼ぶんだろうね。")))
       (method 'maid (lambda (knpc) (say knpc "［彼女は何本も抜けてしまった歯を見せた。］"
                                           "あたしがかつて美しき戦場の乙女と呼ばれたなんて信じられるかい？"
                                           "［彼女はケラケラと笑った。］")))
       (method 'mush shroom-trade)
       (method 'buy (lambda (knpc kpc) (conv-trade knpc kpc "buy" shroom-merch-msgs shroom-catalog)))
       (method 'trad shroom-trade)
       (method 'sell (lambda (knpc kpc) (conv-trade knpc kpc "sell" shroom-merch-msgs shroom-catalog)))
       (method 'reag shroom-trade)
       (method 'poti shroom-trade)
       (method 'join (lambda (knpc) (say knpc "あたしには若すぎるよ、坊や！")))
       (method 'gen (lambda (knpc) (say knpc "ああ、若いときはハンサムだった。"
                                        "一緒にベッドで夜を明かしたものさ！"
                                        "だが少しおかしくなっちまった。"
                                        "ゴブリンと仲良くするなんてさ。")))
       (method 'stra (lambda (knpc) (say knpc "ジェンは森でゴブリン達と会い、"
                                            "一緒に狩りをするようになった。"
                                            "半分ゴブリンみたいなものだ。"
                                            "奴らのやり方をまねてさ。でも、"
                                            "もうあのバカにやめさせることはできんよ。")))
       (method 'gobl (lambda (knpc) (say knpc "奴らとは今も昔も商売をしている。"
                                            "奴らの呪術師はこの森の植物をよく知ってる。"
                                            "あたしは奴らの言葉は少しは分かるし、魔法も少し分かる。"
                                            "だが、奴らは絶対に信用できん。")))
       (method 'thie shroom-thie)
       (method 'trus (lambda (knpc) (say knpc "ゴブリンは機会があれば仕返しするに違いない。"
                                          "あたしが奴らならそうする！")))
       (method 'wars (lambda (knpc) (say knpc "ああ！そう、あたしはゴブリンどもと戦った。"
                                         "ずっと昔のことだ。人は忘れちまったがね。")))
       (method 'ward shroom-wards)
       (method 'spel shroom-wards)
       (method 'band shroom-band)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-shroom tag)
  (bind 
   (kern-mk-char tag                 ; tag
                 "シュルーム"        ; name
                 sp_human            ; species
                 nil                 ; occ
                 s_companion_druid   ; sprite
                 faction-men         ; starting alignment
                 1 6 1               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 3  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'shroom-conv        ; conv
                 sch_shroom          ; sched
                 'townsman-ai                 ; special ai
                 (mk-inventory (list (list 1 t_sword)))                 ; container
                 (list t_armor_leather)                 ; readied
                 )
   (shroom-mk #f #f)))
