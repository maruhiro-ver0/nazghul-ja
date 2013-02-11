;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define jake-lvl 2)
(define jake-species sp_gint)
(define jake-occ nil)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; クーン
;;----------------------------------------------------------------------------
(define jake-bed )
(kern-mk-sched 'sch_jake
               (list 0  0 cantina-counter-zzz "sleeping")
               (list 9  0 cantina-counter "working")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (jake-mk) (list #t))
(define (jake-left? gob) (car gob))
(define (jake-left! gob val) (set-car! gob val))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ジェイクとパーシーは巨人(2つの頭のある巨人)で、怪物の村クーンに住んでいる。
;; ジェイクは野蛮な左の頭で、酒場の用心棒をしている。
;; パーシーは上品な右側の頭で、酒場の主人として経営をしている。
;;----------------------------------------------------------------------------

(define (left-head? knpc)
  (jake-left? (gob knpc)))
(define (left-head! knpc)
  (jake-left! (gob knpc) #t)
  (say knpc "ここだ！"))
(define (right-head! knpc)
  (jake-left! (gob knpc) #f)
  (say knpc "いかがなさりましたか？"))

;; Basics...
(define (jake-hail knpc kpc)
  (kern-log-msg "あなたは2つの頭のある巨人と会った。一方は荒々しく見え、もう一方は、何と言うか……、"
                "神経質と言っても言い過ぎではないだろう。")
  (if (left-head? knpc)
      (say knpc "よお！坊や！")
      (say knpc "ようこそ、小さいお方。")
      ))

(define (jake-default knpc kpc)
  (if (left-head? knpc)
      (say knpc "フン、知るかよ！パーシーに聞け！")
      (say knpc "難しいお話でございます。")
      ))

(define (jake-name knpc kpc)
  (if (left-head? knpc)
      (say knpc "ジェイクだ！そしてこっちがパーシーだ！［左の頭は右を向いた。］")
      (say knpc "パーシバルでございます。そしてこちらがわたくしの永遠の友、ジェイクでございます。［左の頭が右側にうなずいた。］")
      ))

(define (jake-join knpc kpc)
  (if (left-head? knpc)
      (say knpc "ハッ！ハッ！ハッ！")
      (say knpc "ああ、申し訳ありません。身に余るお誘いでございます。")
      ))

(define (jake-job knpc kpc)
  (if (left-head? knpc)
      (say knpc "もちろん用心棒だ！さあ、飲むか出て行くかだ！")
      (begin
        (say knpc "わたくしは店主兼バーテンダーでございます。何かお飲みになりますか？")
        (if (yes? kpc)
            (jake-trade knpc kpc)
            (say knpc "考え直してくださいませ。最高級のものをお出しいたします。")
            ))))

(define (jake-bye knpc kpc)
  (if (left-head? knpc)
      (say knpc "じゃあな！")
      (say knpc "さようなら。また会いましょう。")
      ))

(define (jake-jake knpc kpc)
  (if (left-head? knpc)
      (say knpc "あぁ？何の用だ？")
      (begin
        (say knpc "本当にジェイクと話したいのですか？")
        (if (yes? kpc)
            (left-head! knpc)))
      ))

(define (jake-perc knpc kpc)
  (if (left-head? knpc)
      (begin
        (say knpc "なに？パーシーと話したいのか？")
        (if (yes? kpc)
            (right-head! knpc)
            ))
      (say knpc "はい。それはわたくしです。何なりとお申し付けくださいませ。")
      ))

(define (jake-drin knpc kpc)
  (if (left-head? knpc)
      (say knpc "パーシーに言え！")
      (jake-trade knpc kpc)))


;; Trade...
(define jake-merch-msgs
  (list nil ;; closed
        "メニューでございます。" ;; buy
        nil ;; sell
        nil ;; trade
        "お手伝いできたことを喜ばしく思います。" ;; bought-something
        "［ため息］ああ、わたくしは落胆いたしました。" ;; bought-nothing
        nil
        nil
        nil
        nil
   ))

(define jake-catalog
  (list
   (list t_food 7 "すばらしい子羊ローストでございます！恐れながら、人間にはもったいないものにございます。")
   (list t_beer 4 "はるか遠くの有名なジャイアントスパーの醸造者から取り寄せたラガービールでございます。")
   (list t_wine 6 "ワイン専門の泥棒から提供された最高のワインでございます。ゴホン…見覚えのないボトルだとよいのですが。")
   ))

(define (jake-trade knpc kpc) (conv-trade knpc kpc "buy" jake-merch-msgs jake-catalog))

;; Town & Townspeople

;; Quest-related

(define jake-conv
  (ifc basic-conv

       ;; basics
       (method 'default jake-default)
       (method 'hail jake-hail)
       (method 'bye  jake-bye)
       (method 'job  jake-job)
       (method 'name jake-name)
       (method 'join jake-join)
       
       ;; trade
       (method 'drin jake-drin)
       (method 'trad jake-trade)
       (method 'buy  jake-trade)

       ;; town & people
       (method 'jake jake-jake)
       (method 'perc jake-perc)
       ))

(define (mk-jake)
  (bind 
   (kern-mk-char 
    'ch_jake           ; tag
    "ジェイクとパーシバル"             ; name
    jake-species         ; species
    jake-occ              ; occ
    s_gint     ; sprite
    faction-men      ; starting alignment
    0 0 0            ; str/int/dex
    0 0              ; hp mod/mult
    0 0              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    jake-lvl
    #f               ; dead
    'jake-conv         ; conv
    sch_jake           ; sched
    'townsman-ai              ; special ai
    nil              ; container
    nil              ; readied
    )
   (jake-mk)))
