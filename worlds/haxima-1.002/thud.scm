;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define thud-start-lvl  6)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ボレ
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_thud
               (list 0  0  bole-bedroom-thud "idle")
               (list 9  0  bole-dining-hall  "idle")
               (list 10 0  bole-courtyard   "idle")
               (list 12 0  bole-dining-hall   "idle")
               (list 23 0  bole-bedroom-thud "idle")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (thud-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ドンはキャスリンの用心棒で、今はこのあたりに泥棒がいると思い、ボレに留まっ
;; ている。多くの他の登場人物はドンは半分は人間でオーガの血が流れている、また
;; は魔術(召還された、または作られた)と考えている…。
;; 
;; ドンは仲間になる(そして裏切る)。
;; 彼はキャスリンの仲間で、彼女が仲間に加わると彼も加わる。
;;----------------------------------------------------------------------------
(define (thud-hail knpc kpc)
  (say knpc "［あなたの前にあるのは確かにオーガの一部だ。"
       "身長は3メートル程あり、威圧的だ。"
       "彼は目を細めてあなたをにらんだ。］"))

(define (thud-default knpc kpc)
  (say knpc "［彼の威圧的な目は動かなかった。］"))

(define (thud-name knpc kpc)
  (say knpc "ドンは　お前が　嫌い。"))

(define (thud-join knpc kpc)
  (if (is-player-party-member? ch_kathryn)
      (begin
        (say knpc "［キャスリンとあなたを見ると、彼は不満げに同意した。］")
        (kern-char-join-player knpc)
        (kern-conv-end))
      (say knpc "［彼はあざ笑った。］")))

(define (thud-job knpc kpc)
  (say knpc "ドンは　殺すのが　大好き。"))

(define (thud-kathryn knpc kpc)
  (say knpc "ドンは　殺さない。"))

(define (thud-thud knpc kpc)
  (say knpc "俺のことか？　俺　の　こ　と　か　？　ドンは　お前の　骨で　歯を　ほじるぞ！！"))

(define (thud-thief knpc kpc)
  (say knpc "［彼は怒り出した］泥棒は　ドンを　だました！ドンは　泥棒を　見つける！ドンは　泥棒を　殺す！"))

(define (thud-find knpc kpc)
  (say knpc "［彼は少し落ち着いた］赤い　淑女が　泥棒を　見つける。　泥棒は　隠れ　られない。"))

(define (thud-red-lady knpc kpc)
  (say knpc "［彼は恐ろしい目つきであなたを見た］赤い　淑女から　離れろ。"))

(define thud-conv
  (ifc nil
       (method 'default thud-default)
       (method 'hail thud-hail)
       (method 'bye 
               (lambda (knpc kpc) 
                 (say knpc "［彼はうんざりした目であなたが去るのを見ていた。］")))
       (method 'job  thud-job)
       (method 'name thud-name)
       (method 'join thud-join)

       (method 'find thud-find)
       (method 'kath thud-kathryn)
       (method 'kill thud-job)
       (method 'lady thud-red-lady)
       (method 'love thud-job)
       (method 'red  thud-red-lady)
       (method 'thie thud-thief)
       (method 'thud thud-thud)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-thud)
  (bind 
    (kern-char-arm-self
     (kern-mk-char 
      'ch_thud ;;.....tag
      "ドン" ;;.......name
      sp_troll ;;.....species
      oc_warrior ;;...occupation
      s_troll ;;......sprite
      faction-men ;;..faction
      4 ;;............custom strength modifier
      0 ;;............custom intelligence modifier
      2 ;;............custom dexterity modifier
      2 ;;............custom base hp modifier
      1 ;;............custom hp multiplier (per-level)
      0 ;;............custom base mp modifier
      0 ;;............custom mp multiplier (per-level)
      max-health;;..current hit points
      -1  ;;...........current experience points
      max-health ;;..current magic points
      0
      thud-start-lvl  ;;..current level
      #f ;;...........dead?
      'thud-conv ;;...conversation (optional)
      sch_thud ;;.....schedule (optional)
      'townsman-ai ;;..........custom ai (optional)
      nil ;;..........container (and contents)
      ;;.........readied arms (in addition to the container contents)
      (list
       t_2h_axe
       t_iron_helm
       t_armor_plate
       )
      nil ;;..........hooks in effect
      ))
   (thud-mk)))
