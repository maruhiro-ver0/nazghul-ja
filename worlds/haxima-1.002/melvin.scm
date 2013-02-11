;;----------------------------------------------------------------------------
;; Schedule
;;
;; ボレ
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_melvin
               (list 0  0  bole-bed-melvin      "sleeping")
               (list 7  0  bole-kitchen "working")
               (list 21 0  bole-bedroom-may      "idle")
               (list 22 0  bole-bed-melvin "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (melvin-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;;
;; メルヴィンはボレの宿の料理人である。
;; 彼はメイの(7番目の)夫である。
;;----------------------------------------------------------------------------
(define melv-merch-msgs
  (list "酒場が開いてるときに来てくれ。午前7時から深夜までやってる。"
        "今日のご馳走だ。" ;; buy
        nil ;; sell
        nil ;; trade
        "悪くないだろ？" ;; sold-something
        "まあ食ってみなよ。" ;; sold-nothing
        nil ;; bought-something
        nil ;; bought-nothing
        nil ;; traded-something
        nil ;; traded-nothing
   ))

(define melv-catalog
  (list
   (list t_beer  4 "ビール、これは朝飯だ！")
   (list t_food  3 "このあたりじゃシャルドいちのパラペーニョ・キッシュと評判だ！")
   ))

(define (melvin-buy knpc kpc) (conv-trade knpc kpc "buy" melv-merch-msgs melv-catalog))

;; basics...
(define (melvin-default knpc kpc)
  (say knpc "メイに聞いてくれ。俺にはわからん。"))

(define (melvin-hail knpc kpc)
  (say knpc "［あなたは二日酔いの料理人と会った。］いらっしゃい。"))

(define (melvin-name knpc kpc)
  (say knpc "料理人のメルヴィンだ。"))

(define (melvin-job knpc kpc)
  (say knpc "ボレの酒場と宿を妻のメイとやっている。"
       "俺が料理して、メイが出す。"))

(define (melvin-join knpc kpc)
  (say knpc "きっとうまくやれねえな。"
       "少なくともここにいた方がいい料理ができる。"))

(define (melvin-bye knpc kpc)
  (say knpc "ありがとう。腹が減ったらいつでも戻ってこいよ。"))

;; other characters & town...
(define (melvin-may knpc kpc)
  (say knpc "妻のメイは平凡な女だ。だが針のように鋭い。"))

(define (melvin-kath knpc kpc)
  (say knpc "あの赤いきれいな女！"
       "だが、俺も魔法使いの厄介ごとに首を突っ込むほど飲みすぎてもいないし、バカでもない。"
       "悪いことは言わん。あの女とその連れには近づくな！"))

(define (melvin-bill knpc kpc)
  (say knpc "あいつはネジが1本か2本外れてる。でもいい奴だ。"))

(define (melvin-thud knpc kpc)
  (say knpc "赤い女と一緒に来たのは人間じゃない。"
       "でも、あんなにうまくしゃべれるトロルは見たことがない。"
       "よくわからんが、何かの魔法かもしれん。"))

(define (melvin-bole knpc kpc)
  (say knpc "全くいい所だ。"))

(define (melvin-hack knpc kpc)
  (say knpc "ハックルはこの町の北西の橋を渡った所にいる。"
       "おかしな魔女だが、危険ではない。"))


;; thief quest...
(define (melvin-thie knpc kpc)
  (say knpc "最近怪しい奴がこのあたりにいたな。地獄の猟犬みたいに嗅ぎまわっていたが、"
       "あの赤い女が来てすぐにいなくなった。いなくなる前にハックルと話していたと思う。"
       "一番奇妙なことだ。"))

;; misc...
(define (melvin-wiza knpc kpc)
  (say knpc "おかしなことになっているんだよ！"
       "赤い魔法使いと変な奴の間で何かが起こっている。俺にはわかるんだ。"))

(define (melvin-inn knpc kpc)
  (say knpc "部屋がいるか、冷たい飲み物が欲しければメイに言ってくれ。"
       "だが、腹が減ったら俺にそう言ってくれ。"
       "すぐに出すぞ！"))

(define (melvin-hung knpc kpc)
  (say knpc "腹は減っているか？")
  (if (kern-conv-get-yes-no? kpc)
      (melvin-buy knpc kpc)
      (say knpc "そう。腹が減ったらそう言ってくれ！")))

(define melvin-conv
  (ifc basic-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default melvin-default)
       (method 'hail melvin-hail)
       (method 'bye  melvin-bye)
       (method 'job  melvin-job)       
       (method 'name melvin-name)
       (method 'join melvin-join)

       (method 'buy  melvin-buy)
       (method 'food melvin-buy)
       (method 'drin melvin-buy)
       (method 'supp melvin-buy)
       (method 'trad melvin-buy)

       (method 'food melvin-buy)
       (method 'trad melvin-buy)
       (method 'buy  melvin-buy)

       (method 'bill melvin-bill)
       (method 'cook melvin-inn)
       (method 'inn  melvin-inn)
       (method 'kath melvin-kath)
       (method 'red  melvin-kath)
       (method 'lady melvin-kath)
       (method 'sorc melvin-kath)
       (method 'may  melvin-may)
       (method 'hack melvin-hack)
       (method 'hung melvin-hung)
       (method 'tave melvin-inn)
       (method 'thud melvin-thud)
       (method 'thin melvin-thud)
       (method 'pet  melvin-thud)

       (method 'thie melvin-thie)
       (method 'rogu melvin-thie)
       (method 'char melvin-thie)

       (method 'bole melvin-bole)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-melvin)
  (bind 
   (kern-mk-char 'ch_melvin          ; tag
                 "メルヴィン"        ; name
                 sp_human            ; species
                 nil                 ; occ
                 s_townsman          ; sprite
                 faction-men         ; starting alignment
                 2 0 1             ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 3  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'melvin-conv        ; conv
                 sch_melvin          ; sched
                 'townsman-ai         ; special ai
                 nil     				; container
                 (list t_dagger)   ; readied
                 )
   (melvin-mk)))
