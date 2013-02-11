;;----------------------------------------------------------------------------
;; Schedule
;;
;; グレゴールの小屋
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_ilya
               (list 0  0  gh-ilyas-bed   "sleeping")
               (list 6  0  gh-stable      "working")
               (list 7  0  gh-kitchen     "working")
               (list 12 0  gh-table-1     "eating")
               (list 13 0  gh-pasture     "working")
               (list 15 0  gh-all         "idle")
               (list 17 0  gh-table-1     "eating")
               (list 18 0  gh-living-room "idle")
               (list 20 0  gh-ilyas-bed   "sleeping"))

;;----------------------------------------------------------------------------
;; Gob
;;
;; イリアに関する冒険は、彼女の家族を殺したトロルから逃げたとき、家に置き忘れ
;; た馬のぬいぐるみを探すことである。冒険のフラグは彼女のgobに格納される。
;;----------------------------------------------------------------------------
(define (ilya-mk gave-quest? finished-quest?) 
  (list gave-quest? finished-quest?))
(define (ilya-gave-quest? ilya) (car ilya))
(define (ilya-quest-done? ilya) (cadr ilya))
(define (ilya-give-quest ilya) (set-car! ilya #t))
(define (ilya-finish-quest ilya) (set-car! (cdr ilya) #t))

;;----------------------------------------------------------------------------
;; パスカ
;;
;; Puska -- ilya's stuffed horse toy -- is a quest item. Nothing special about
;; it really but it is unique and needs its own object type. The object itself
;; is declared in the p_abandoned_cellar constructor. But the type declaration
;; needs to be in a file that is reloaded, so here is as good a place as any.
;;----------------------------------------------------------------------------
(define puska-ifc
  (ifc '()
       (method 'get (lambda (kobj getter)
                      (kern-log-msg "子供がなくしたものに違いない！")
                      (kobj-get kobj getter)))))

(mk-obj-type 't_puska "馬のぬいぐるみ" s_toy_horse layer-item puska-ifc)

;;----------------------------------------------------------------------------
;; Quest
;;
;; This is a single response in Ilya's conversation. I've called it our here
;; separately to make it obvious.
;;----------------------------------------------------------------------------
(define (ilya-quest knpc kpc)
  (let ((ilya (kobj-gob-data knpc)))
    (display ilya)(newline)
    (if (ilya-gave-quest? ilya)

        ;; yes - gave quest already
        (if (ilya-quest-done? ilya)
            (say knpc "パスカは今とっても幸せ！")
            (begin
              (say knpc "パスカは見つかった？")
              (if (kern-conv-get-yes-no? kpc)

                  ;; yes - puska found
                  (begin 
                    (say knpc "返してくれる？")
                    (if (kern-conv-get-yes-no? kpc)

                        ;; yes - ilya may have puska
                        (if (kern-obj-has? kpc t_puska)

                            ;; yes - player has puska
                            (begin
                              (kern-obj-remove-from-inventory kpc t_puska 1)
                              (say knpc "ここ、ここよ、パスカ。"
                                   "もう安心よ。［彼女は振り返った。］ありがとう！お礼ができればいいけれど。"
                                   "待って、これを持っていって。魔法使いが使うものだって、お母さんが言ってた。見つけたときはいつも取っていたの。")
                              (ilya-finish-quest ilya)
                              (kern-obj-add-to-inventory kpc nightshade 23)
                              )

                            ;; no - puska not in player inventory
                            (begin
                              (say knpc "［泣きながら］いないじゃない！")
                              (kern-conv-end)))

                        ;; no - ilya can't have puska
                        (begin
                          (say knpc "大人になったら魔法使いになる！"
                               "そしてあなたを消し炭にしてやるの！")
                          (kern-conv-end))))

                  ;; no - didn't find her yet
                  (begin
                    (say knpc "農場の場所はおぼえてる？")
                    (if (kern-conv-get-yes-no? kpc)
                        (say knpc "きっとそこにいるの！")
                        (say knpc "西へ行って山道を通り、北に丘に行けばあるの。"))))))

        ;; no - didn't give quest yet
        (begin
          (say knpc "パスカは私の馬のぬいぐるみなの。でもなくしてしまった！"
               "見つけたら教えてくれる？")
          (if (kern-conv-get-yes-no? kpc)
              (begin
                (say knpc "農場は西側への道の北の丘にあるわ。"
                     "トロルに気をつけて！")
                (ilya-give-quest ilya))
              (begin
                (say knpc "パスカを取ったりしたら、大人になったとき、あなたを見つけるわ。")
                (kern-conv-end)))))))

(define (ilya-join knpc kpc)
  (say knpc "私子供なのに。変なの！")
  )

;;----------------------------------------------------------------------------
;; 動物
;;
;; Ilya has an odd relationship with spiders. She'll teach the player a spell
;; to ward off spiders if he plays along. Spiders will dominate the woods
;; around the Abandoned Farm (Ilya's old home). In fact, I intend to have them
;; locked in a battle with the trolls the first time the player enters the
;; Abandoned Farm. I'm planning on having a "great mother" spider known around
;; these parts as Angril or Angriss, perhaps she was one of Ilya's pets as a
;; child - I'm not sure how I want to play that one out yet.
;;----------------------------------------------------------------------------
(define (ilya-animals knpc kpc)
  (say knpc "羊と、猫のチャームと、鶏を飼っているの。"
       "動物は好き？")
  (if (kern-conv-get-yes-no? kpc)

      ;; yes - the player likes animals
      (begin
        (say knpc "どの動物が好き？")
        (let ((fav (kern-conv-get-string kpc)))
          (if (or (string=? fav "spider") (string=? fav "クモ"))

              ;; yes - the player's favorite animal is spiders
              (begin
                (say knpc "私も！どうすれば襲われないか知っているの。"
                     "教えて欲しい？")
                (if (kern-conv-get-yes-no? kpc)

                    ;; yes - the player wants to learn the spider ward
                    (say knpc "簡単！蜘蛛の糸と大蒜を混ぜて、"
                         "アン・ゼン・ベット<An Xen Bet>と唱えるの。")

                    ;; no - the player does not want to learn the spider ward
                    (say knpc "そう。でも時々人を襲うこともあるのよ。")))
                    

              ;; no - the player's favorite animal is NOT spiders
              (say knpc "私はクモが好き！"))))

      ;; no - the player does not like animals
      (say knpc "怖くないよ！")))

(define (ilya-fire knpc kpc)
  (say knpc "火をおこすのは簡単なの。黒真珠と硫黄を混ぜて…"
       "硫黄…灰はどこ？"
       "そしてヴァス・フラム<Vas Flam>と言うの！"))

(define (ilya-died knpc kpc)
  (say knpc "トロルが農場を襲ったの！"
       "お母さんは私を地下室に隠した。"
       "そしてトロルが寝ている間に抜け出した。"
       "でも、パスカを忘れてしまった…。"))

;;----------------------------------------------------------------------------
;; Conv
;;----------------------------------------------------------------------------
(define ilya-conv
  (ifc basic-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default (lambda (knpc kpc) (say knpc "知らない。")))
       (method 'hail (lambda (knpc kpc) (say knpc "こんにちは。")))
       (method 'bye (lambda (knpc kpc) (say knpc "バイバイ。")))
       (method 'job (lambda (knpc kpc) (say knpc "おじいさんの手伝いをしているの。")))
       (method 'name (lambda (knpc kpc) (say knpc "イリア。")))
       (method 'age (lambda (knpc kpc) (say knpc "8歳。")))
       (method 'chor (lambda (knpc kpc) (say knpc "動物の世話をしたり、火をおこしたり、料理したりするの。")))
       (method 'anim ilya-animals)
       (method 'gran (lambda (knpc kpc) (say knpc "お父さんとお母さんが死んでしまったから、おじいさんと住んでいるの。")))
       (method 'died ilya-died)
       (method 'dead ilya-died)
       (method 'trol (lambda (knpc kpc) (say knpc "トロルは大嫌い！大人になったらみんな殺してしまいたい。")))
       (method 'hate (lambda (knpc kpc) (say knpc "いつか魔法使いになって、大嫌いなあいつらを殺してしまいたい！"
                                              "また同じことが起こっても怖がらないわ！")))
       (method 'afra (lambda (knpc kpc) (say knpc "地下室にいるとき怖かった。"
                                                "お父さんとお母さんがトロルに食べられたとき、叫び声が聞こえた…"
                                                "［涙ぐんで］もし見つかってたら、きっと同じように食べられていた…。")))
       (method 'momm (lambda (knpc kpc) (say knpc "お母さんはもういない。火のおこし方を教えてくれたことを思い出す。"
                                               "トロルが襲ってきたとき、一匹を燃やしていたわ！")))
       (method 'dadd (lambda (knpc kpc) (say knpc "お父さんはもういない。"
                                               "トロルと戦ったけど、どうすることもできなかった。")))
       (method 'pusk ilya-quest)
       (method 'home (lambda (knpc kpc) (say knpc "私達の農場の北と南には森があったの。")))
       (method 'spid (lambda (knpc kpc) (say knpc "このあたりの森にはクモがたくさんいるって、おじいさんが言ってた。")))
       (method 'wood (lambda (knpc kpc) (say knpc "森に入るなって、おじいさんが言ってた。")))
       
       (method 'fire ilya-fire)
       (method 'hi ilya-fire)
       (method 'vas ilya-fire)
       (method 'flam ilya-fire)
       (method 'greg (lambda (knpc kpc) (say knpc "私のおじいさんよ。")))
       (method 'join ilya-join)
       ))

