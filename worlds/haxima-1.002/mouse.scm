;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define mouse-start-lvl 8)

;;----------------------------------------------------------------------------
;; Schedule
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (mouse-mk) (list #t))
(define (mouse-first-meeting? mouse) (car mouse))
(define (mouse-set-first-meeting! mouse val) (set-car! mouse val))
(define (mouse-talked)
	(quest-data-update-with 'questentry-thiefrune 'talked 1 (quest-notify (grant-party-xp-fn 10)))
	)


(define (mouse-meet-first-time knpc kpc)

  (define (mouse-disappear)
    (say knpc "おっと兄弟よ、もう会いたくなかったな！")
    (kern-obj-add-effect knpc ef_invisibility nil)
    (kern-conv-end kpc)
    )

  (define (mouse-query)
    (say knpc "やあ。赤い女のパシリかい？")
    (if (yes? kpc)
        (mouse-disappear)
        (begin
        	(say knpc "ヒェー！びっくりしたよ。")
        	(mouse-talked)
        )
    ))

  (define (mouse-gratitude)
    (say knpc "アロペクスよ感謝します！赤い女は死んだ！"
         "あんた、よくやってくれたな。")
         (mouse-talked)
         )

  (define (kathryn-speech)
    (say ch_kathryn "バカな人ね！泥棒の所まで案内してくれるなんて！")
    (kern-obj-set-conv ch_kathryn nil)
    (kern-being-set-base-faction ch_kathryn faction-monster))

  (define (thud-speech)
    (say ch_thud "泥棒が　いた！殺す！殺す！殺す！")
    (kern-obj-set-conv ch_thud nil)
    (kern-being-set-base-faction ch_thud faction-monster))

  (define (open-gate)
    (open-moongate (mk-loc (loc-place (kern-obj-get-location knpc)) 7 2)))
  
  (define (warp-in-kathryn kgate)
    (warp-in ch_kathryn 
             (kern-obj-get-location kgate)
             south
             faction-monster))

  (define (warp-in-thud kgate)
    (warp-in ch_thud 
             (kern-obj-get-location kgate)
             west
             faction-monster))

  (mouse-set-first-meeting! (kobj-gob-data knpc) #f)
  (if (defined? 'ch_kathryn)
      (if (is-alive? ch_kathryn)
          (if (is-player-party-member? ch_kathryn)

              ;; kathryn is alive in the party (if thud is defined then he must
              ;; be in the party, too; see kathryn.scm)
              (begin
                (kern-char-leave-player ch_kathryn)
                (kathryn-speech)
                (if (defined? 'ch_thud)
                    (begin
                      (if (is-alive? ch_thud)
                          (thud-speech))
                      (kern-char-leave-player ch_thud)))
                (mouse-disappear))

              ;; kathryn is alive but not in the party so gate her in, and
              ;; thud, too, if he's alive
              (let ((kgate (open-gate))
                    (use-thud? (and (defined? 'ch_thud)
                                    (is-alive? ch_thud))))
                (kern-sleep 1000)
                (warp-in-kathryn kgate)
                (if use-thud?
                    (warp-in-thud kgate))
                (kathryn-speech)
                (if use-thud?
                    (thud-speech))
                (kern-sleep 1000)
                (close-moongate kgate)
                (mouse-disappear)))

          ;; kathryn is dead
          (if (is-player-party-member? ch_kathryn)

              ;; but in the party so remove her and thud, too, if he's defined
              (begin
                (kern-char-leave-player ch_kathryn)
                (if (defined? 'ch_thud)
                    (if (is-alive? ch_thud)
                        (begin
                          (thud-speech)
                          (kern-char-leave-player ch_thud)
                          (mouse-disappear))
                        (begin
                          (kern-char-leave-player ch_thud)
                          (mouse-gratitude)))
                    (mouse-gratitude)))

              ;; kathryn is dead but not in the party (since she is not in the
              ;; party, thud cannot be either)
              (mouse-query)))

      ;; kathryn is undefined (so she could never have been in the party, and
      ;; thus neither could thud)
      (mouse-query)))

;;----------------------------------------------------------------------------
;; Conv
;;----------------------------------------------------------------------------
(define (mouse-hail knpc kpc)
  (let ((mouse (kobj-gob-data knpc)))
    (if (mouse-first-meeting? mouse)
        (mouse-meet-first-time knpc kpc)
        (begin
        	(say knpc "あ、こんにちは。へへっ。")
   	        (mouse-talked)
	    )
        )))

(define (mouse-default knpc kpc)
  (say knpc "さあどうかな。"))

(define (mouse-name knpc kpc)
  (say knpc "ネズミです。"))

(define (mouse-join knpc kpc)
  (say knpc "悪いなあ。共同作業には向いてないんだ。へへ。"))

(define (mouse-job knpc kpc)
  (say knpc "えー、物を…集めること。"))


(define (mouse-coll knpc kpc)
  (say knpc "泥棒と呼ぶ人もいる。"))

(define (mouse-thie knpc kpc)
  (say knpc "最近まではいい仕事だったねえ。"
       "何か欲しい物があれば、それを手に入れるためにあっしに金を払った。"
       "で、この変な赤い女に雇われたんだ。"))

(define (mouse-lady knpc kpc)
  (say knpc "その赤い女はあっしをある物を手に入れるために雇った。その後、金と交換するために会った。"
       "ここまではよくあることだ。わかるだろ？"
       "でも、この女は金を払うかわりに、あっしを殺そうとしたんだ！"))

(define (mouse-kill knpc kpc)
  (say knpc "赤い女とゴツい手下は容赦なかった！"
       "こいつらを倒したことだけは感謝するよ。だが、こいつらが単独でやったのではない気がする。"
       "このくだらない石版とおさらばしない限りずっと狙われそうだ！"))

(define (mouse-rune knpc kpc)
  (if (not (in-inventory? knpc t_rune_k))
      (say knpc "それはもうあんたの問題だ、親友よ！")
      (begin

        (define (give-rune gold)
          (let* ((pgold (kern-player-get-gold)))
            (if (> pgold gold)
                (kern-obj-add-gold kpc (- 0 gold))
                (let ((price (min pgold gold)))
                  (say knpc "おっと、金が足りないな！"
                       "払える分だけ受け取っておこう。")
                  (kern-obj-add-gold kpc (- 0 price)))))
          (kern-obj-remove-from-inventory knpc t_rune_k 1)
          (kern-obj-add-to-inventory kpc t_rune_k 1)
          (quest-data-update-with 'questentry-thiefrune 'recovered 1 (quest-notify (grant-party-xp-fn 50)))
          )
        
        (say knpc "赤い女のために手に入れたこの石版は、最初に聞いたときからずっとやっかいごとに過ぎなかった。"
             "これが何なのかもわからない！"
             "お買い得価格であんたに売ってやろう。どう？金貨500枚だ。")
        (if (kern-conv-get-yes-no? kpc)
            (give-rune 500)
            (begin
              (say knpc "うーん、赤い女から助けてもらった借りがあるからな。250枚はどうだ？")
              (if (kern-conv-get-yes-no? kpc)
                  (give-rune 250)
                  (begin
                    (say knpc "商売上手だなあ、親友よ。100枚？")
                    (if (kern-conv-get-yes-no? kpc)
                        (give-rune 100)
                        (begin
                          (say knpc "50？")
                          (if (kern-conv-get-yes-no? kpc)
                              (give-rune 50)
                              (begin
                                (say knpc "わかった。持ってけ。これでいいな？")
                                (if (kern-conv-get-yes-no? kpc)
                                    (give-rune 0)
                                    (begin
                                      (say knpc "たのむよ！"
                                           "金を出すから持って行ってくれ！"
                                           "ずーっと遠くへ！")
                                      (give-rune (- 0 100))))))
                          )))))))))
      
(define (mouse-bye knpc kpc)
  (say knpc "悪気はないが、もう二度と会いたくないね。"))

(define (mouse-alopex knpc kpc)
  (say knpc "アロペクス？ああ、古い泥棒の神だ。"
       "そう聞いた。"))

(define mouse-conv
  (ifc nil
       (method 'default mouse-default)
       (method 'hail mouse-hail)
       (method 'bye mouse-bye)
       (method 'job mouse-job)
       (method 'name mouse-name)
       (method 'join mouse-join)

       (method 'coll mouse-coll)
       (method 'kill mouse-kill)
       (method 'lady mouse-lady)
       (method 'rune mouse-rune)
       (method 'thie mouse-thie)
       (method 'alop mouse-alopex)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-mouse)
  (bind 
   (kern-char-force-drop
    (kern-char-arm-self
     (kern-mk-char 
      'ch_mouse ;;..tag
      "ネズミ" ;;....name
      sp_human ;;.....species
      nil ;;..........occupation
      s_brigand ;;.....sprite
      faction-men ;;..faction
      0 ;;............custom strength modifier
      0 ;;............custom intelligence modifier
      6 ;;............custom dexterity modifier
      2 ;;............custom base hp modifier
      2 ;;............custom hp multiplier (per-level)
      1 ;;............custom base mp modifier
      1 ;;............custom mp multiplier (per-level)
      max-health ;;..current hit points
      -1 ;;...........current experience points
      max-health ;;..current magic points
      0
      mouse-start-lvl  ;;..current level
      #f ;;...........dead?
      'mouse-conv ;;...conversation (optional)
      nil ;;..........schedule (optional)
      nil ;;..........custom ai (optional)
      
      ;;..........container (and contents)
      (mk-inventory
       (list
        (list 1 t_rune_k)
        (list 1 t_armor_leather)
        (list 1 t_leather_helm)
        (list 1 t_sword)
        (list 1 t_bow)
        (list 50 t_arrow)))
      
      nil ;;..........readied arms (in addition to the container contents)
      nil ;;..........hooks in effect
      ))
    #t)
   (mouse-mk)))
