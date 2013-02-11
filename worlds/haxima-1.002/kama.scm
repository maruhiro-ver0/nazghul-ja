;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define kama-lvl 4)
(define kama-species sp_forest_goblin)
(define kama-occ oc_wrogue)
(define kama-exit-x 6)
(define kama-exit-y 2)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; 緑の塔の地下の独房
;;----------------------------------------------------------------------------
(define kama-cell gtl-cell1)
(kern-mk-sched 'sch_kama
               (list 0  0 kama-cell        "sleeping")
               (list 7  0 kama-cell        "idle")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (kama-mk jail-door-tag) (list #f #f jail-door-tag))
(define (kama-gave-food? gob) (car gob))
(define (kama-gave-food! gob) (set-car! gob #t))
(define (kama-joined-once? gob) (cadr gob))
(define (kama-joined-once! gob) (set-car! (cdr gob) #t))
(define (kama-get-jail-door-tag gob) (caddr gob))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; カマは森ゴブリンの狩人の男性で、今は緑の塔の地下に収容されている。
;; ジェンの友人で、カマは会いに来る途中に不運にも拘束された。
;; ゴブリン語が少しわかれば、カマは仲間になる。
;;----------------------------------------------------------------------------

;; Basics...
(define (kama-default knpc kpc)
  (say knpc "［反応がない。］"))

(define (kama-hail knpc kpc)
  (meet "［あなたは落ち着いた様子のゴブリンと会った。恐れる様子はなく、考え込んでいるような目でこちらを見ている。］")
  (if (kama-gave-food? (gob knpc))
      (say knpc "ボナハ。")
      (say knpc "ヌキ？")
      ))

(define (kama-bye knpc kpc)
  (say knpc "［彼の表情は変わらなかった。］"))

;; No == Name
(define (kama-no knpc kpc)
  (if (kama-gave-food? (gob knpc))
      (say knpc "［彼は自分を指差した。］カマ。")
      (kama-default knpc kpc)))

;; Me == Job
(define (kama-me knpc kpc)
  (if (not (kama-gave-food? (gob knpc)))
      (kama-default knpc kpc)
      (begin
        (say knpc "ニント。［彼はあなたを指差した。］ズト？")
        (if (yes? kpc)
            (say knpc "［彼はうなずいた。］")
            (say knpc "［彼はあなたを疑うような目で笑った。］")))))

;; Jo == Join
(define (kama-jo knpc kpc)
  (define (exit-point)
    (mk-loc (kobj-place knpc)
            kama-exit-x
            kama-exit-y))
  (define (door-still-locked?)
    (let ((kdoor (eval (kama-get-jail-door-tag (gob knpc)))))
      (cond ((null? kdoor) (error "Kama's door tag is undefined!") #t)
            (else
             (let ((gob (kobj-gob kdoor)))
               (or (door-locked? gob)
                   (door-magic-locked? gob)))))))
  (define (rejoin)
    (say knpc "ハ！イキ！")
    (join-player knpc)
    (kern-conv-end)
    )
  (define (join-first-time)
    (say knpc "ハジョ！ボナ　カ　ルカ！")
    (say knpc "［床の上に森の辺りの地図のようなものを描き、そして森の南端が東の山脈と接する所に力を込めて何度もバツ印を描いた。］")
    (quest-data-update-with 'questentry-rune-f 'angriss 1 (quest-notify nil))
    (kama-joined-once! (gob knpc))
    (join-player knpc)
    ;; Improve the player's relations with forest goblins
    (kern-dtable-inc faction-player faction-forest-goblin)
    (kern-dtable-inc faction-player faction-forest-goblin)
    (kern-conv-end)
    )
  (if (is-player-party-member? knpc)
      (say knpc "［彼は困惑した様子だ。］ハ…。")
      (if (kama-joined-once? (gob knpc))
          (rejoin)
          (if (not (kama-gave-food? (gob knpc)))
              (kama-default knpc kpc)
              (if (door-still-locked?)
                  (say knpc "［彼は独房の扉を指差し、肩をすくめた。］")
                  (join-first-time)
                  )))))

(define (kama-food knpc kpc)
  (kern-log-msg "［彼に食料を与える？］")
  (define (no-food)
    (say knpc "［彼はうなり声をあげ顔を背けた。］")
    (kern-conv-end))
  (define (yes-food)
    (kama-gave-food! (gob knpc))
    (say knpc "［彼はそれをガツガツと食べた。］"
         "ハ　ヌキ！［彼はあなたを指差した。］ボナハ。"))
  (if (yes? kpc)
      (if (> (get-food-donation knpc kpc) 0)
          (yes-food)
          (no-food))
      (no-food)))
          
(define (kama-rune knpc kpc)
  (if (not (kama-gave-food? (gob knpc)))
      (kama-default knpc kpc)
      (if (any-in-inventory? kpc rune-types)
          (say knpc "［あなたが石版を見せると、彼は不安げにうなずいた。］ルカ。")
          (say knpc "［石版について説明しようとしたが、彼は困惑しているようだ。］"))))

;; Ruka == Rune
;; Having a goblin spout out *sextant coordinates* is just daft. Changing to something descriptive
;; Maybe for the repeat, give a pointed direction based on the parties location on the worldmap? "He points south" or whatever direction is appropriate
(define (kama-ruka knpc kpc)
  (if (kama-joined-once? (gob knpc))
  		(begin
	      (say knpc "イキ　ルカ。")
    	  (say knpc "［床の上に森の辺りの地図のようなものを描き、そして森の南端が東の山脈と接する所に力を込めて何度もバツ印を描いた。］")
    	  (quest-data-update-with 'questentry-rune-f 'angriss 1 (quest-notify nil))
      	)
      (begin
        (say knpc "［彼は独房の床のほこりに丸と、それにつながった線を描いた。それはクモのようだった。それから彼はあなたと自分を指差し、クモの絵を消した。］")
        (prompt-for-key)
        (say knpc "［どうやら彼はあなたに加わりクモと戦うことを提案しているようだ。］"))))

;; King Clovis (leader of the human forces in the war against the Goblins, one generation ago.
(define (kama-clov knpc kpc)
  (if (not (kama-gave-food? (gob knpc)))
      (kama-default knpc kpc)  
      (say knpc "［彼は最初はわからないようだった。だが、彼はうなずいて言った。］ルカ　カ　チョト。")))

(define (kama-leav knpc kpc)
  (if (is-player-party-member? knpc)
      (begin
        (say knpc "カマ　ツジョ？")
        (if (yes? kpc)
            (begin
              (if (kern-char-leave-player knpc)
                  (begin
                    (say knpc "カマ　イキ。")
                    (kern-conv-end))
                  (say knpc "カマ　ツ　イキ。")))
            (kern-log-msg "［彼は安心したようだ。］")))
      (kern-log-msg "［彼は混乱しているようだ。］")))

;; Shakespeare
(define (kama-zukakiguru knpc kpc)
  (begin
    (say knpc "ハ！ズカキグル！")
    (aside kpc 'ch_gen "そう、私たちの共通の関心ごとです。")
    (say knpc "［彼はあなたの困った顔つきを見て、ゆっくりと言い直した。］ズ・カ　キ・グ・ル、チョグハ　ズリュマ：ヌ　ハメリュト！")
    (aside kpc 'ch_gen "本当の作者を知ったときの驚きを想像してみてください！")
    ))

;; Hameluto == Good/yes/skillful, Destiny change individual (Prince Hamlet)
(define (kama-hameluto knpc kpc)
  (begin
  (say knpc "ハメリュト？ハ！［カマの言い方が変わった。そして真剣な顔つきで再びあなたの方を向いた。］")
  (aside kpc 'ch_gen "あなたに聞かせてくれるそうですよ！［ジェンは興味深そうに見ている。］")
  (prompt-for-key)
  (say knpc "ヌボダ？ツボダ？エーグリュ！")
  (aside kpc 'ch_gen "生きるべきか、死ぬべきか。それが問題だ！")

  (say knpc "ボグ　ハヒメ、ナツダ、カマナ、ルリュマダ？")
  (aside kpc 'ch_gen "どちらが気高いであろうか？非道な運命のつぶてと矢に耐えるか、")

  (say knpc "エー、ボメカ、イキカチョ、カツチョ！")
  (aside kpc 'ch_gen "剣を取り困難の海に立ち向かいこれを終えるか。")

  (say knpc "［彼はそのまま長い間語るつもりのようだ。朗読を最後まで聞くか？］")
  (if (yes? kpc)
      (say knpc "［その後、驚くほど長い間語り続けた。］")
      (say knpc "ボナ　イキ？ハ！［彼は止めたが、もっと語りたいようだった。］")
      )
  (aside kpc 'ch_gen "この劇の核心の部分は、元よりも明瞭になっていると思いませんか？")
  ))

(define kama-conv
  (ifc nil
       (method 'default kama-default)
       (method 'hail kama-hail)
       (method 'bye  kama-bye)
       (method 'leav kama-leav)

       (method 'no   kama-no)
       (method 'me   kama-me)
       (method 'jo   kama-jo)
       (method 'food kama-food)
       (method 'rune kama-rune)
       (method 'ruka kama-ruka)
       (method 'clov kama-clov)

       (method 'shak kama-zukakiguru) ;; synonym
       (method 'bard kama-zukakiguru) ;; synonym
       (method 'zuka kama-zukakiguru)

       (method 'haml kama-hameluto) ;; synonym
       (method 'hame kama-hameluto)
    ))

(define (mk-kama jail-door-tag)
  (bind 
    (kern-mk-char 
     'ch_kama           ; tag
     "カマ"             ; name
     kama-species         ; species
     kama-occ              ; occ
     s_fgob_civilian  ; sprite
     faction-men      ; starting alignment
     2 0 10            ; str/int/dex
     pc-hp-off  ; hp bonus
     pc-hp-gain ; hp per-level bonus
     0 ; mp off
     0 ; mp gain
     max-health ; hp
     -1                   ; xp
     max-health ; mp
     0
     kama-lvl
     #f               ; dead
     'kama-conv         ; conv
     sch_kama           ; sched
     nil              ; special ai
     nil              ; container
     nil              ; readied
     )
   (kama-mk jail-door-tag)))
