;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; オパーリン
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_ghertie
               (list 0  0  cheerful-room-3      "idle")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (ghertie-mk) 
  (list (mk-quest)))

(define (ghertie-quest gob) (car gob))



;;----------------------------------------------------------------------------
;; Conv
;; 
;; ガーティーは女性の海賊の船長で、殺され復讐心に燃える亡霊となっている。
;; 彼女はオパーリンの宿に出る。
;;----------------------------------------------------------------------------

;; Quest...
(define (ghertie-give-instr knpc kpc)
  (say knpc "あたいの手下はドクロの印のついた呪われた指輪を身につけている。"
       "それを外すことはできない。"
       "ジョーン、ゴレット、そしてミーニーはまだ生きている。"
       "その指輪を持って来い。それが取り引きの条件だ。"
       "その後こちらも取り引きに応じる。")
	(quest-data-update-with 'questentry-ghertie 'questinfo 1 (quest-notify nil))
)

(define (ghertie-update-quest knpc kpc)
  (let ((nrem (- 3 (num-in-inventory kpc t_skull_ring))))
    (if (= nrem 0)
        (begin
          (say knpc "復讐は遂げられた！これで休める……"
               "慈悲深い死号は[" merciful-death-x "," merciful-death-y "]に眠っている。"
               "だが彼女は海の底にいる。どうやって宝を取るのかはお前の問題だ！"
               "［彼女は冷酷な笑いと共に消え去った。］")
			(quest-data-update-with 'questentry-rune-c 'shiploc 1 (quest-notify nil))
			(quest-data-assign-once 'questentry-ghertie)
			(quest-data-update-with 'questentry-ghertie 'done 1 (grant-party-xp-fn 20))
			 (kern-conv-end)
          (kern-obj-remove knpc)
          (kern-map-set-dirty))
        (begin
          (say knpc "まだ指輪は" nrem "つ足りない。"
               "あたいの指示を忘れたのか？")
           (if (kern-conv-get-yes-no? kpc)
               (begin
                 (say knpc "おまえが手下だったら殴り殺していただろうな！")
                 (ghertie-give-instr knpc kpc))
               (say knpc "ならなぜ手ぶらで戻ってくる？"
                    "もし誓いを果たせなければ、お前の魂をあたいの手で殴り殺してやるからな！"))))))

;; Basics...
(define (ghertie-hail knpc kpc)
  (let ((quest (ghertie-quest (kobj-gob-data knpc))))
		(quest-data-update 'questentry-ghertie 'ghertieloc 1)
		(quest-data-assign-once 'questentry-ghertie)
    (display "quest:")(display quest)(newline)
    (if (quest-accepted? quest)
        (ghertie-update-quest knpc kpc)        
        (say knpc "［あなたは荒々しい姿の女性の幽霊と会った。］"
             "あたいを邪魔するとはいい度胸だ。今は機嫌が悪いんだ。"))))

(define (ghertie-default knpc kpc)
  (say knpc "そんなことを話してるんじゃねえ。"))

(define (ghertie-name knpc kpc)
	(quest-data-update 'questentry-ghertie 'ghertieid 1)
  (say knpc "ガートルードだ。"))

(define (ghertie-join knpc kpc)
  (say knpc "あたいはここを永遠に離れない。"))

(define (ghertie-job knpc kpc)
  (say knpc "生きてるときは海賊だった。今はこの部屋の幽霊だ。"))

(define (ghertie-bye knpc kpc)
  (if (quest-accepted? (ghertie-quest (kobj-gob-data knpc)))
      (say knpc "早く恨みを晴らしてくれ！")
      (say knpc "自分の手下を信じるな！")))

;; Pirate...
(define (ghertie-pira knpc kpc)
  (say knpc "この海岸で何年も海賊をやって、お宝を蓄えたさ。"
       "だが海賊を辞める前夜、手下に裏切られた。"
       "みんなあたいの息子みたいに思ってたのにさ。恥知らずめ！"))

(define (ghertie-betr knpc kpc)
  (say knpc "腰抜けがあたいを寝ている間に殺し、船を奪っていったのさ。"))

(define (ghertie-ship knpc kpc)
  (say knpc "「慈悲深い死」号は速く小回りのきく船だった。"
       "あれよりいい船はないね。宝は全てなくなり、もう何もかも終わりだ。"
       "だが、あたいの船を奪った手下は絶対に許さねえ！"))

(define (ghertie-haun knpc kpc)
  (say knpc "ここを離れられないのさ。"
       "裏切った手下はあたいが静かに死んでいたくないと考えていた。"
       "だから奴は呪いでここに蘇らせた。それで奴を追うことができないのさ。"
       "フン！奴はあたいの船の呪いを知らないのさ！"))

(define (ghertie-curs knpc kpc)
  (say knpc "あたいは自分の船に呪いをかけた。"
       "もし盗まれたら自分で動き、ある場所で沈むようにだ！"
       "その海の墓はあたいだけが知っている…。"))

(define (ghertie-grav knpc kpc)
  (say knpc "なぜ言わなきゃならん？"))

(define (ghertie-reve knpc kpc)
  (let ((quest (ghertie-quest (kobj-gob-data knpc))))
    (if (quest-accepted? quest)
        (say knpc "そう、おまえは代わりに復讐すると誓った。"
             "何をゴチャゴチャ言っている？")
        (begin
          (say knpc "［彼女は冷たい目であなたを見た。］"
               "おまえはあたいの死んだ心が一番欲しい言葉を言った。"
               "恨みを晴らすために手を貸してくれるのか？")
	(quest-data-update 'questentry-ghertie 'revenge 1)
          (if (kern-conv-get-yes-no? kpc)
              (begin
                (say knpc "手下は全員船と一緒に沈んだわけじゃねえ。"
                     "死んだ奴の中を探したが、何人かいない奴がいた。"
                     "生き残った奴を見つけ出し殺せ。"
                     "そうすればあたいの船がどこにあるか教えてやろう。"
                     "契約はこうだ。いいな？")
                (if (kern-conv-get-yes-no? kpc)
                    (begin
                      (say knpc "契約成立だ。死すべき者よ。")
                      (quest-accepted! quest #t)
                      (ghertie-give-instr knpc kpc))
                    (say knpc "簡単に契約しないのはいいことだ。"
                         "契約を破った奴をここで待ち続けることになるからな。")))
              (begin
                (say knpc "なら軽々しく言うな、バカ野郎！")
                (kern-conv-end)))))))

(define (ghertie-fort knpc kpc)
  (say knpc "金、宝石、魔法の物、武器に鎧、それに石版だ。")
	(quest-data-assign-once 'questentry-rune-c)
	)

(define ghertie-conv
  (ifc basic-conv

       ;; basics
       (method 'default ghertie-default)
       (method 'hail ghertie-hail)
       (method 'bye ghertie-bye)
       (method 'job ghertie-job)
       (method 'name ghertie-name)
       (method 'join ghertie-join)
       
       ;; special
       (method 'pira ghertie-pira)
       (method 'betr ghertie-betr)
       (method 'crew ghertie-betr)
       (method 'ship ghertie-ship)
       (method 'haun ghertie-haun)
       (method 'curs ghertie-curs)
       (method 'grav ghertie-grav)
       (method 'fort ghertie-fort)
       (method 'reve ghertie-reve)

       ))

(define (mk-ghertie)
  (bind 
   (kern-mk-char 'ch_ghertie           ; tag
                 "ガーティー"            ; name
                 sp_ghast            ; species
                 oc_warrior                 ; occ
                 s_ghost               ; sprite
                 faction-men         ; starting alignment
                 0 0 0               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 6  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'ghertie-conv         ; conv
                 sch_ghertie           ; sched
                 nil                 ; special ai
                 nil                 ; container
                 nil                 ; readied
                 )
   (ghertie-mk)))
