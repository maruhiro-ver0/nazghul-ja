;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; クロポリスの入り口
;;----------------------------------------------------------------------------
(define doug-bed ke-bed1)
(define doug-mealplace ke-tbl1)
(define doug-workplace ke-hall)
(define doug-leisureplace ke-dine)
(kern-mk-sched 'sch_doug
               (list 0  0 doug-bed          "sleeping")
               (list 11 0 doug-mealplace    "eating")
               (list 12 0 doug-workplace    "working")
               (list 18 0 doug-mealplace    "eating")
               (list 19 0 doug-leisureplace "idle")
               (list 24 0 doug-workplace    "working")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (doug-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ダグラスはクロポリスの第一層駐屯地の指揮官で、ゴブリンの王国の階のクロポリ
;; スの入り口に陣を置いている。
;;----------------------------------------------------------------------------

;; Basics...
(define (doug-hail knpc kpc)
  (say knpc "［あなたは厳しい顔つきの聖騎士と会った。］地獄の入り口へようこそ、旅人よ。")
  (if (and (in-player-party? 'ch_mesmeme)
           (is-alive? ch_mesmeme))
      (begin
        (say knpc "［彼はメスメメを見た。］この迷宮で捕らえたのか？")
        (if (yes? kpc)
            (say knpc "それは第三層の聖騎士の砦の下にいる。"
                 "だが、収容所にそれがいるとは思えない。"
                 "そいつは早く殺したほうがよい。")
            (say knpc "こんなに飼いならされたものは見たことがない。裏切りに気をつけろ。")))))

(define (doug-default knpc kpc)
  (say knpc "それはわからん。"))

(define (doug-name knpc kpc)
  (say knpc "私はダグラス隊長、このクロポリス第一層駐屯地の指揮官だ。"))

(define (doug-join knpc kpc)
  (say knpc "そしてここを放棄しろと？そのような考えはない。私の部下にもそのようなことを尋ねるな。さもないと地上へと放り出すぞ。"))

(define (doug-job knpc kpc)
  (say knpc "この駐屯地で指揮している。"))

(define (doug-bye knpc kpc)
  (say knpc "深い所に行くときは気をつけろ。"))

;; Special
(define (doug-garr knpc kpc)
  (say knpc "グラスドリンはクロポリスの怪物を押さえるため、ここに駐屯地を置いている。この下には第二層駐屯地がある。"))

(define (doug-mons knpc kpc)
  (say knpc "この層にいるのは、ほとんどがゴブリンとトロルだ。深いところでは突然最悪の者が現れることがある。"))

(define (doug-gobl knpc kpc)
  (say knpc "洞窟ゴブリンがこの層を支配している。奴らは凶暴だが装備は粗末だ。"
       "洞穴の中には普通は危険ではない森ゴブリンもいる。"
       "森と洞窟のゴブリンは仲が悪く、それが我々の支配の助けになっている。"))

(define (doug-trol knpc kpc)
  (say knpc "ゴブリンの村の向こう側にいる汚い連中だ。"
       "彼らを何度一掃しても、すぐに元通りになる。"
       "まるで岩から生まれているかのようだ。"))

(define (doug-wors knpc kpc)
  (say knpc "私が会った中で最悪のもの？ゲイザーだ。奴は幾人かの奴隷を持っている。その中には聖騎士もいる。思い出したよ。［彼は震えながら背を向けた。］")
  (kern-conv-end)
  )

(define (doug-kurp knpc kpc)
  (say knpc "クロポリスは怪物どもの生まれる地だ。奴らを一掃することはできぬが、我々はその栓となることはできる。"))

(define (doug-seco knpc kpc)
  (say knpc "第二層駐屯地へは、東の交差点を南へ進み、はしごを下りれば行ける。"))

(define (doug-gaze knpc kpc)
  (say knpc "ゲイザーは悪夢から生まれたような怪物だ。成長した者は他の生き物を奴隷にし、自分の代わりに戦わせる能力がある。"))

(define doug-conv
  (ifc kurpolis-conv

       ;; basics
       (method 'default doug-default)
       (method 'hail doug-hail)
       (method 'bye doug-bye)
       (method 'job doug-job)
       (method 'name doug-name)
       (method 'join doug-join)

       (method 'garr doug-garr)
       (method 'mons doug-mons)
       (method 'gobl doug-gobl)
       (method 'trol doug-trol)
       (method 'wors doug-wors)
       (method 'kurp doug-kurp)
       (method 'hell doug-kurp)
       (method 'door doug-kurp)
       (method 'seco doug-seco)
       (method 'gaze doug-gaze)
       ))

(define (mk-douglas)
  (bind 
   (kern-mk-char 'ch_douglas        ; tag
                 "ダグラス"          ; name
                 sp_human            ; species
                 oc_warrior          ; occ
                 s_companion_paladin ; sprite
                 faction-men         ; starting alignment
                 2 2 1               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 4  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'doug-conv         ; conv
                 sch_doug           ; sched
                 'townsman-ai                 ; special ai
                 nil                 ; container
                 (list t_armor_chain
                       t_chain_coif
                       t_sword
                       ))         ; readied
   (doug-mk)))
