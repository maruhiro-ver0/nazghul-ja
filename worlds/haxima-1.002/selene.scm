;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define selene-lvl 5)
(define selene-species sp_human)
(define selene-occ nil)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; 古アブサロット
;;----------------------------------------------------------------------------
(define selene-bed oa-bed3)
(define selene-mealplace oa-tbl2)
(define selene-workplace oa-baths)
(define selene-leisureplace oa-temple)
(kern-mk-sched 'sch_selene
               (list 0  0 selene-bed          "sleeping")
               (list 7  0 selene-mealplace    "eating")
               (list 8  0 selene-workplace    "working")
               (list 12 0 selene-mealplace    "eating")
               (list 13 0 selene-workplace    "working")
               (list 18 0 selene-mealplace    "eating")
               (list 19 0 selene-leisureplace "idle")
               (list 22 0 selene-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (selene-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; セレネは呪われた者の教えに従う女性である。
;; 彼女は不安定で、不道徳で、堕落している。
;;----------------------------------------------------------------------------

;; Basics...
(define (selene-hail knpc kpc)
  (say knpc "［この若い女性はあなたをいたずらっぽい目で見ている。］"))

(define (selene-default knpc kpc)
  (say knpc "［彼女は不快な音を立てて笑った。］"))

(define (selene-name knpc kpc)
  (say knpc "セレネ。"))

(define (selene-join knpc kpc)
  (say knpc "［彼女は頭を振り、はっきりと断った。］"))

(define (selene-job knpc kpc)
  (say knpc "［彼女は肩をすくめた。］物で遊んでいるの。"))

(define (selene-bye knpc kpc)
  (say knpc "［彼女はあなたが去った後、大声で言った。］また会いましょう、英雄さん！"))

(define (selene-play knpc kpc)
  (say knpc "物…人…。"))

(define (selene-peop knpc kpc)
  (say knpc "人をしたいようにするのが好きなの。"))

(define (selene-want knpc kpc)
  (say knpc "したいこと何でも。他はどうでもいいの。ただ人をしたいようにするのが好き。"
       "もし人がそうしなかったら…［彼女は肩をすくめ、クスクスと笑った。］"))

(define (selene-accu knpc kpc)
  (say knpc "そんなに悪くないの、英雄さん。どちらかと言うと楽しいの。"))

(define (selene-fun knpc kpc)
  (say knpc "呪われた者になりたい？もちろんいいよ！私は犠牲の間が好き。"))

(define (selene-sacr knpc kpc)
  (say knpc "自分で探しなさい、バカ！"))

(define (selene-denn knpc kpc)
  (say knpc "彼をしたいようにするのは簡単なの。彼は私を怖がってる。"
       "そして私を欲しがっている。"))

(define (selene-sila knpc kpc)
  (say knpc "［彼女は突然おびえたように見えた。そして凶暴になった。］"
       "何で私を困らせるの？あっち行って！")
  (kern-conv-end))

(define selene-conv
  (ifc basic-conv

       ;; basics
       (method 'default selene-default)
       (method 'hail selene-hail)
       (method 'bye  selene-bye)
       (method 'job  selene-job)
       (method 'name selene-name)
       (method 'join selene-join)

       (method 'play selene-play)
       (method 'peop selene-peop)
       (method 'men  selene-peop)
       (method 'want selene-want)
       (method 'accu selene-accu)
       (method 'fun  selene-fun)
       (method 'sacr selene-sacr)
       (method 'denn selene-denn)
       (method 'sila selene-sila)
       ))

(define (mk-selene)
  (bind 
   (kern-mk-char 
    'ch_selene           ; tag
    "セレネ"             ; name
    selene-species         ; species
    selene-occ              ; occ
    s_townswoman     ; sprite
    faction-men      ; starting alignment
    0 2 1            ; str/int/dex
    0 0              ; hp mod/mult
    0 0              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    selene-lvl
    #f               ; dead
    'selene-conv         ; conv
    sch_selene           ; sched
    'townsman-ai              ; special ai
    nil              ; container
    (list t_dagger)              ; readied
    )
   (selene-mk)))
