;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define joel-lvl 3)
(define joel-species sp_human)
(define joel-occ nil)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; アブサロットの門の前
;;----------------------------------------------------------------------------
(define joel-bed (list 'p_gate_to_absalot 8 9 1 1))
(define joel-mealplace joel-bed)
(define joel-workplace (list 'p_gate_to_absalot 7 10 5 5))
(define joel-leisureplace joel-workplace)
(kern-mk-sched 'sch_joel
               (list 0  0 joel-bed          "sleeping")
               (list 5  0 joel-mealplace    "eating")
               (list 6  0 joel-workplace    "working")
               (list 12 0 joel-mealplace    "eating")
               (list 13 0 joel-workplace    "working")
               (list 18 0 joel-mealplace    "eating")
               (list 19 0 joel-leisureplace "idle")
               (list 21 0 joel-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (joel-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ジョエルは素朴な牛飼いで、アブサロットの町の破壊された門の前で放牧をして暮
;; らしている。
;;----------------------------------------------------------------------------

;; Basics...
(define (joel-hail knpc kpc)
  (kern-log-msg "あなたは素朴な牛飼いと会った。")
  (say knpc "よお。")
  )

(define (joel-default knpc kpc)
  (say knpc "わからんなあ、相棒。"))

(define (joel-name knpc kpc)
  (say knpc "ジョエル。"))

(define (joel-join knpc kpc)
  (say knpc "いんや。"))

(define (joel-job knpc kpc)
  (say knpc "牛を飼っとる。平和でええこった。"))

(define (joel-peac knpc kpc)
  (say knpc "そうさあ。ここはアブサロットの昔の門だあ。"))

(define (joel-absa knpc kpc)
  (say knpc "中に入りたいのけ？")
  (if (yes? kpc)
      (say knpc "やめとけ。下は酷い奴がいっぱいおる。")
      (say knpc "それがええ。")))

(define (joel-nast knpc kpc)
  (say knpc "ゲイザー？不死の者？後はわかんねえ。"
       "聖騎士たちが膿を残して封印する前から、ここはひでえ所だった。"))

(define (joel-fest knpc kpc)
  (say knpc "グラスドリンから来た聖騎士たちがアブサロットを破壊した。"
	"人がいなくなったら怪物どもが入ってきたのさあ。"))
	
(define (joel-gaze knpc kpc)
  (say knpc "精神の奴隷主。いつでも他の奴を支配できるのさあ。"
       "気いつけないと、おめえも奴隷になるぞ。"))
	   
(define (joel-unde knpc kpc)
  (say knpc "幽霊、骸骨、後は知りたくねえ。"))

(define (joel-bye knpc kpc)
  (say knpc "じゃあなあ。"))

(define joel-conv
  (ifc basic-conv

       ;; basics
       (method 'default joel-default)
       (method 'hail joel-hail)
       (method 'bye joel-bye)
       (method 'job joel-job)
       (method 'name joel-name)
       (method 'join joel-join)

       (method 'peac joel-peac)
       (method 'nice joel-peac)
       (method 'absa joel-absa)
       (method 'nast joel-nast)
       (method 'stuf joel-nast)
       (method 'mons joel-nast)
       (method 'fest joel-fest)
       (method 'pala joel-fest)
       (method 'unde joel-unde)
       (method 'gaze joel-gaze)	   
       ))

(define (mk-joel)
  (bind 
   (kern-mk-char 
    'ch_joel           ; tag
    "ジョエル"         ; name
    joel-species         ; species
    joel-occ              ; occ
    s_companion_shepherd     ; sprite
    faction-men      ; starting alignment
    1 0 1            ; str/int/dex
    0 0              ; hp mod/mult
    0 0              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    joel-lvl
    #f               ; dead
    'joel-conv         ; conv
    sch_joel           ; sched
    'townsman-ai              ; special ai
    nil              ; container
    (list t_staff
					         )              ; readied
    )
   (joel-mk)))
