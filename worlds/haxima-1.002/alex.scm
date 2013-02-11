;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define alex-lvl 8)
(define alex-species sp_human)
(define alex-occ oc_wizard)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; クロポリスの聖騎士の砦
;;----------------------------------------------------------------------------
(define alex-bed ph-bed3)
(define alex-mealplace ph-tbl3)
(define alex-workplace ph-hall)
(define alex-leisureplace ph-dine)
(kern-mk-sched 'sch_alex
               (list 0  0 alex-bed          "sleeping")
               (list 7  0 alex-mealplace    "eating")
               (list 8  0 alex-workplace    "working")
               (list 12 0 alex-mealplace    "eating")
               (list 13 0 alex-workplace    "working")
               (list 18 0 alex-mealplace    "eating")
               (list 19 0 alex-leisureplace "idle")
               (list 22 0 alex-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (alex-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; アレックスはグラスドリン軍の隊長で、クロポリスの不死の者の階を守る第二層駐
;; 屯地で任務についている。
;;----------------------------------------------------------------------------

;; Basics...
(define (alex-hail knpc kpc)
  (say knpc "ようこそ、冒険者よ。我々の壁の後ろ側は少しは安全だ。"))

(define (alex-name knpc kpc)
  (say knpc "グラスドリン軍のアレックス隊長だ。"))

(define (alex-job knpc kpc)
  (say knpc "戦闘魔術師、そしてこの駐屯地の指揮官だ。我々の門を通りたいのかね？")
  (if (yes? kpc)
      (alex-pass knpc kpc)
      (say knpc "気が変わったら合言葉について尋ねてくれ。")))

(define (alex-bye knpc kpc)
  (say knpc "壁の外では背後に気をつけろ。"))

(define (alex-warm knpc kpc)
  (say knpc "戦闘魔術師は、戦闘魔法の専門家だ。私の最大のなやみがわかるかね？")
  (yes? kpc)
  (say knpc "秘薬をどう見つけるかだ。奥に行く前に備えるのを忘れるな！"))

(define (alex-garr knpc kpc)
  (say knpc "ここはクロポリスにおける軍の三つの駐屯地の一つだ。"
       "第一層駐屯地は怪物が地上へ出ないようにクロポリスの入り口を守っている。")
  (prompt-for-key)
  (say knpc "この第二層駐屯地は下の収容所を管理し、不死の者を食い止める。")
  (prompt-for-key)
  (say knpc "第三層駐屯地は…どこへ続くかわからない道を守っている。")
  )

(define (alex-unde knpc kpc)
  (say knpc "クロポリスのこの層には、不死の者が支配する古い砦がある。私の考えを知りたいか？")
  (if (yes? kpc)
      (say knpc "不死の者どもはリッチに仕えているのだと考えている。")
      (say knpc "ならば君を混乱させないため何も言わないでおこう！")))

(define (alex-lich knpc kpc)
  (say knpc "リッチとは何か？それは不死の魔術師である。リッチは呪文と同じように死者を操ることができる。最も恐ろしい敵だ。"))

(define (alex-pass knpc kpc)
  (say knpc "合言葉は「深淵」だ。"))

(define (alex-thir knpc kpc)
  (say knpc "第三層駐屯地とは連絡が取れなくなっている。"
       "連隊の戦士の一人が下の収容所にいる。"
       "私は彼が本当におかしくなってしまったのではないかと恐れている。深い場所は人をそのようにしてしまう。"))

(define (alex-pris knpc kpc)
  (say knpc "収容所へ行きたければ、はしごを下りなさい。"))

(define (alex-firs knpc kpc)
  (say knpc "第一層駐屯地へ行きたければ、はしごを上り、北へ行き、その後西へ行きなさい。"))

(define alex-conv
  (ifc kurpolis-conv

       ;; basics
       (method 'hail alex-hail)
       (method 'bye alex-bye)
       (method 'job alex-job)
       (method 'name alex-name)

       (method 'warm alex-warm)
       (method 'garr alex-garr)
       (method 'comm alex-garr)
       (method 'lich alex-lich)
       (method 'pass alex-pass)

       (method 'thir alex-thir)
       (method 'pris alex-pris)
       (method 'firs alex-firs)
       ))

(define (mk-alex)
  (bind 
   (kern-mk-char 
    'ch_alex           ; tag
    "アレックス"       ; name
    alex-species         ; species
    alex-occ              ; occ
    s_companion_wizard     ; sprite
    faction-men      ; starting alignment
    2 5 1            ; str/int/dex
    0 0              ; hp mod/mult
    0 0              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    alex-lvl
    #f               ; dead
    'alex-conv         ; conv
    sch_alex           ; sched
    'townsman-ai              ; special ai
    nil              ; container
    (list t_sword
    		t_shield
    		t_leather_helm
					         t_armor_leather_2
					         )               ; readied
    )
   (alex-mk)))
