;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define tim-start-lvl 4)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; In the Tower of Brundegart (p_brundegardt_tower_4), locked outside.
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (tim-mk) (list #f #f))
(define (tim-caught? gob) (car gob))
(define (tim-caught! gob) (set-car! gob #t))
(define (tim-met? gob) (cadr gob))
(define (tim-met! gob) (set-car! (cdr gob) #t))

;;----------------------------------------------------------------------------
;; Conv
;;
;; ティムは片腕のない、よだれをたらしたおかしな男で、ブルンデガードの塔の外に
;; 捕らわれている。
;; 
;; かつては知(と力)の探求者であった。彼の肉体はグリフィン(とその腹を空かせた
;; 雛)に奪われ、彼の精神はブルヌの目との接触で破壊された。
;;----------------------------------------------------------------------------
(define (tim-hail knpc kpc)
  (meet "あなたはよだれをたらした片腕のおかしな男と会った。")
  (say knpc "目を見ていたのだ！"))

(define (tim-eye knpc kpc)
  (say knpc "目を見ることで私は知力を得たのだ。あなたは知力を求める者か？")
  (cond ((yes? knpc)
         (say knpc "ああ、友よ。鍵をなくしてしまったのだ！"))
        (else
         (say knpc "愚かな！")
         (kern-conv-end))))

(define (tim-key knpc kpc)
  (say knpc "私の鍵だ！そこの死んだ者が持っていた。"
       "獅子のような鳥に、最初は腕を奪われ、次に鍵を奪われたのだ！"))

(define (tim-arm knpc kpc)
  (say knpc "丘を歩いているとき、私が選ばれた。"
       "そして雛に与えるためここに運ばれたのだ。"))

(define (tim-name knpc kpc)
  (say knpc "知らないふりをするな！"
       "この全能の者を知らぬ者などいない！これは必然だ！"))

(define (tim-job knpc kpc)
  (say knpc "この世界に知の光をもたらす者だ！"))

(define (tim-enli knpc kpc)
  (say knpc "その通りである！目だ！目…［彼は胎児のようにうずくまり、泣きながらつぶやいた。］")
  (kern-conv-end))

(define (tim-lion knpc kpc)
  (say knpc "［彼は悲鳴をあげ縮こまった。］見たのか？！"
       "もう片方の腕を取りに来たのか？雛はそんなに腹を空かせているのか！恐ろしい！"))

(define tim-conv
  (ifc nil
       (method 'hail tim-hail)
       (method 'eye  tim-eye)
       (method 'me  tim-eye)
       (method 'key  tim-key)
       (method 'arm  tim-arm)
       (method 'name tim-name)
       (method 'job  tim-job)
       (method 'enli tim-enli)
       (method 'lion tim-lion)
       ))


;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-tim)
  (bind 
   (kern-char-arm-self
    (kern-mk-char 
     'ch_tim ;;..........tag
     "ティム" ;;.......name
     sp_human ;;.....species
     oc_wizard ;;.. .occupation
     s_wizard ;;..sprite
     faction-men ;;..faction
     +1 ;;...........custom strength modifier
     0 ;;...........custom intelligence modifier
     +1 ;;...........custom dexterity modifier
     +1 ;;............custom base hp modifier
     +1 ;;............custom hp multiplier (per-level)
     0 ;;............custom base mp modifier
     0 ;;............custom mp multiplier (per-level)
     max-health ;;..current hit points
     -1  ;;...........current experience points
     max-health ;;..current magic points
     0
     tim-start-lvl  ;;..current level
     #f ;;...........dead?
     'tim-conv ;;...conversation (optional)
     nil ;;sch_tim ;;.....schedule (optional)
     nil ;;..........custom ai (optional)
     nil ;;..............container (and contents)
     nil ;;.........readied arms (in addition to the container contents)
     nil ;;..........hooks in effect
     ))
   (tim-mk)))
