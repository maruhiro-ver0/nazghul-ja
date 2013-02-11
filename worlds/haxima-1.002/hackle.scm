;;----------------------------------------------------------------------------
;; Schedule
;;
;; ボレ
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_hackle
               (list 0  0  bole-hackles-hut "idle")
               (list 2  0  bole-bed-hackle "sleeping")
               (list 10 0  bole-hackles-hut "idle")
               (list 20 0  bole-hackles-yard "idle")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (hackle-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;;
;; ハックルは魔女でボレに住んでいる。
;; 彼女の精神は運悪く出会ったゲイザーによって打ち砕かれた。
;; しかし、彼女にはまだ治療の能力がある。
;;----------------------------------------------------------------------------
(define (hackle-trade knpc kpc)
  (say knpc "彼女はそれか、それの友を治療することができる。"
       "彼女は生命力ごとに金の破片を要求する。それは同意するか？")
  (define (hackle-heal)
    (say knpc "彼女はどれを治療するか？")
    (let ((kchar (kern-ui-select-party-member)))
      (if (null? kchar)
          (say knpc "彼女はそれに別の何をするか？")
          (let* ((gold (kern-player-get-gold))
                 (pts (- (kern-char-get-max-hp kchar)
                         (kern-char-get-hp kchar))))
            (if (= 0 gold)
                (say knpc "金がなければ命もない！それがこの世の法！")
                (begin
                  (if (= 0 pts)
                      (say knpc "それはよくなった！彼女はそれにすることはもうない！")
                      (let ((n (min gold pts)))
                        (say knpc "彼女は治療した！")
                        (kern-obj-heal kchar n)
                        (kern-player-set-gold (- gold n))))
                  (say knpc "別のそれを治療するか？")
                  (if (kern-conv-get-yes-no? kpc)
                      (hackle-heal)
                      (say knpc "ならばそれは別のものを望む。")
                      )))))))
  (if (kern-conv-get-yes-no? kpc)
      (hackle-heal)
      (say knpc "それはそれの道を行け！")))
                   
              
        

;; basics...
(define (hackle-default knpc kpc)
  (say knpc "彼女はそれを手助けできない。"))

(define (hackle-hail knpc kpc)
  (if (in-player-party? 'ch_mesmeme)
      (begin
        (say knpc "［彼女はメスメメを見ると恐怖で縮こまった］あああ！それは彼女と戦った！")
        (aside kpc 'ch_mesmeme "恐れるな")
        )
      (say knpc "[あなたは髪の乱れた中年の女性と会った。] それは彼女と会った！"
           "何かを求めている！")
  ))

(define (hackle-name knpc kpc)
  (say knpc "彼女はハックル。"))

(define (hackle-job knpc kpc)
  (say knpc "彼女は狂っている！しかし彼女は治療できる！"))

(define (hackle-join knpc kpc)
  (say knpc "彼女は仲間にはなれない！彼女は彼女の羊を気にかけている！"))

(define (hackle-bye knpc kpc)
  (say knpc "彼女はさようならと言った。しかし、彼女はそれが戻ってくることを知っている！"))


;; other characters & town...
(define (hackle-may knpc kpc)
  (say knpc "それはきつい女、しかしハックルにはきついが親切である！"))

(define (hackle-kath knpc kpc)
  (say knpc "赤を着た女！女を着た悪魔！"))

(define (hackle-bill knpc kpc)
  (say knpc "軽率。そう、いつの日か木の神はそれを夕食にするだろう。"))

(define (hackle-thud knpc kpc)
  (say knpc "［彼女は笑い、驚き、叫んだ。］あれは玩具ではない！"
       "下僕として呼ばれた者、しかし悪魔である。"))

(define (hackle-melv knpc kpc)
  (say knpc "それは善い魂である。"))

(define (hackle-bole knpc kpc)
  (say knpc "ボレ(Bole)ではない！ホール(Hole)である！深遠への鍵穴！彼女は知っている！"))

;; misc...
(define (hackle-mesm knpc kpc)
  (say knpc "それはただの子供である。同族の者とは口がきけず、耳が聞こえない。"
       "しかし、飼い犬はいずれ主人を飼い犬にするだろう。")
  (aside kpc 'ch_mesmeme "飼い犬にあらず")
  )

(define (hackle-shee knpc kpc)
  (say knpc "羊の皮を被った狼！"
       "羊が鳴くとき、どのように狼が吠えるか！"))

(define (hackle-wood knpc kpc)
  (say knpc "彼女は古い樫の木でそれを見た。彼女は起こさなかった！"
       "それらは彼女らを好まない、それらは全てを好まない！"
       "ゴブリンはそれらを静めた。しかし彼女はその言葉を知らない。"))

(define (hackle-mad knpc kpc)
  (say knpc "ゲイザーが彼女を子供のとき捕らえた！彼女は逃げた。"
       "しかし、彼女の心は逃げ遅れた！"))

(define (hackle-gaze knpc kpc)
  (say knpc "もし会ったなら、それはいかなる場合でも殺さなければならない！"
       "それらはいかなる問いの答えも知っている。そしてその答えは拘束する！")
  (aside kpc 'ch_mesmeme "［不安そうに瞬いている。］")
)

;; thief quest...
(define (hackle-thie knpc kpc)
  (say knpc "それは真に強きならず者が強き魔術師から奪った！"))

(define (hackle-robs knpc kpc)
  (say knpc "それは奪い、その小さなネズミの穴に走り去った！"))

(define (hackle-hole knpc kpc)
  (say knpc "それは謎が好きだろうか？\n"
       "　'o'には穴(hole)がある！\n"
       "　そして穴には'o'がある！\n"
       "　そしてネズミ(mouse)には両方ある！\n"
       "　真夜中に\n"
       "　それは行くだろう！\n"
       "何を^c+m表す^c-かわかるか？")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "ならばそれを^c+m表し^c-謎を理解せよ！")
      (begin
        (say knpc "ウィス・クァス<Wis Quas>！赤い雌狐は巻物を持っている。しかし理性を持っていない。")))
  )

(define (hackle-reve knpc kpc)
  (say knpc "ビル坊はネズミがどこに消えたか知っている！"
       "それを^c+m表せ^c-！"))

(define (hackle-midd knpc kpc)
  (say knpc "そう！真夜中！"))

(define hackle-conv
  (ifc basic-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default hackle-default)
       (method 'hail hackle-hail)
       (method 'bye  hackle-bye)
       (method 'job  hackle-job)
       (method 'name hackle-name)
       (method 'join hackle-join)

       (method 'trad hackle-trade)
       (method 'buy hackle-trade)
       (method 'sell hackle-trade)
       (method 'heal hackle-trade)

       (method 'bill hackle-bill)
       (method 'kath hackle-kath)
       (method 'red  hackle-kath)
       (method 'bitc hackle-kath)
       (method 'may  hackle-may)
       (method 'melv hackle-melv)
       (method 'thud hackle-thud)
       
       (method 'bole hackle-bole)
       (method 'gaze hackle-gaze)
       (method 'god  hackle-wood)
       (method 'gods hackle-wood)
       (method 'hole hackle-hole)
       (method 'mad  hackle-mad)
       (method 'mesm hackle-mesm)
       (method 'migh hackle-robs)
       (method 'mous hackle-hole)
       (method 'reve hackle-reve)
       (method 'rob  hackle-robs)
       (method 'robs hackle-robs)
       (method 'wrog hackle-robs)
       (method 'wiza hackle-robs)
       (method 'shee hackle-shee)
       (method 'thie hackle-thie)
       (method 'wood hackle-wood)
       (method 'midd hackle-midd)
       (method 'nigh hackle-midd)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-hackle)
  (bind 
   (kern-mk-char 'ch_hackle          ; tag
                 "ハックル"          ; name
                 sp_human            ; species
                 nil                 ; occ
                 s_beggar             ; sprite
                 faction-men         ; starting alignment
                 0 0 1            ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 6  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'hackle-conv        ; conv
                 sch_hackle          ; sched
                 'townsman-ai                 ; special ai
                 nil                 ; container
                 nil                 ; readied
                 )
   (hackle-mk)))
