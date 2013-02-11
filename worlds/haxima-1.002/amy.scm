;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define amy-lvl 1)
(define amy-species sp_human)
(define amy-occ oc_wright)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; 救貧院(迷い人の仲間になるまで)
;;----------------------------------------------------------------------------
(define amy-bed poorh-bed2)
(define amy-mealplace poorh-sup2)
(define amy-workplace poorh-pasture)
(define amy-leisureplace poorh-dining)
(kern-mk-sched 'sch_amy
               (list 0  0 amy-bed          "sleeping")
               (list 7  0 amy-mealplace    "eating")
               (list 8  0 amy-workplace    "working")
               (list 12 0 amy-mealplace    "eating")
               (list 13 0 amy-workplace    "working")
               (list 18 0 amy-mealplace    "eating")
               (list 19 0 amy-leisureplace "idle")
               (list 22 0 amy-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (amy-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; エイミーは職人の女性だが、職を失っている。
;; 彼女は救貧院にいる。
;; エイミーは仲間にすることができる。
;;----------------------------------------------------------------------------

;; Basics...
(define (amy-hail knpc kpc)
  (meet "あなたは経験豊かそうな職人の女性と会った。")
  (say knpc "こんにちは。")
  )

(define (amy-name knpc kpc)
  (say knpc "エイミーと呼んでください。")
  )

(define (amy-join knpc kpc)
  (if (is-player-party-member? knpc)
      (say knpc "もう仲間に加わっています！")
      (begin
        (say knpc "そう言ってくれるとは思ってなかったわ！")
        (join-player knpc)
        (kern-conv-end)
        )))

(define (amy-job knpc kpc)
  (say knpc "ええ…、修理屋を生業としているのだけれど、"
       "最近はあまり仕事がないのよ。")
  )

(define (amy-bye knpc kpc)
  (say knpc "さようなら。")
  )

(define (amy-mean knpc kpc)
  (say knpc "彼はすばらしい人です。"
       "この救貧院にいなければ、私はどうなっていたかわかりません。"
       "私の胸をジロジロ見ることもないですし。")
  )

(define (amy-tink knpc kpc)
  (say knpc "修理屋は渡り歩く職人です。"
       "町から町へと旅し、色々な人のものを修理します。")
  )

(define (amy-luck knpc kpc)
  (say knpc "人々は見知らぬ者に神経質になっています。"
       "みんな呪われた者のせいです。")
  )
  
(define (amy-accu knpc kpc)
  (say knpc "呪われた者というのは悪を崇拝する秘密の邪教の信者たちです。")
  )

;; Quest-related

(define amy-conv
  (ifc basic-conv

       ;; basics
       (method 'hail amy-hail)
       (method 'bye amy-bye)
       (method 'job amy-job)
       (method 'name amy-name)
       (method 'join amy-join)
       

       (method 'mean amy-mean)
       (method 'tink amy-tink)
       (method 'luck amy-luck)
       (method 'accu amy-accu)
       ))

(define (mk-amy)
  (bind 
   (kern-mk-char 
    'ch_amy           ; tag
    "エイミー"             ; name
    amy-species         ; species
    amy-occ              ; occ
    s_companion_tinker ; sprite
    faction-men      ; starting alignment
    2 4 4            ; str/int/dex
    pc-hp-off  ; hp bonus
    pc-hp-gain ; hp per-level bonus
    1 ; mp off
    1 ; mp gain
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    amy-lvl
    #f               ; dead
    'amy-conv         ; conv
    sch_amy           ; sched
    'townsman-ai              ; special ai
    nil              ; container
    (list
     t_armor_leather
     t_leather_helm
     t_sling
     t_sword
    ))
   (amy-mk)))
