;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define jones-lvl 6)
(define jones-species sp_human)
(define jones-occ nil)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; クロポリスの砦
;;----------------------------------------------------------------------------
(define jones-bed ph-bed1)
(define jones-mealplace ph-tbl1)
(define jones-workplace ph-arms)
(define jones-leisureplace ph-hall)
(kern-mk-sched 'sch_jones
               (list 0  0 jones-bed          "sleeping")
               (list 7  0 jones-mealplace    "eating")
               (list 8  0 jones-workplace    "working")
               (list 12 0 jones-mealplace    "eating")
               (list 13 0 jones-workplace    "working")
               (list 18 0 jones-mealplace    "eating")
               (list 19 0 jones-leisureplace "idle")
               (list 22 0 jones-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (jones-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ジョーンジーはグラスドリン軍の補給部隊で働いている。
;; 彼はクロポリスの砦にいる。
;;----------------------------------------------------------------------------

;; Basics...
(define (jones-name knpc kpc)
  (say knpc "ジョーンジーだ。何でもどうぞ。"))

(define (jones-job knpc kpc)
  (say knpc "グラスドリン軍の補給部隊で働いている。何か買っていくか？")
  (if (yes? kpc)
      (jones-trade knpc kpc)
      (say knpc "なにかいるものがあったら来てくれ。")))

;; Trade...
(define jones-merch-msgs
  (list "午前9時から午後6時の間に補給基地に来てくれ。"
        "基本的な物はそろっている。"
        nil
        nil
        "それで十分か？もっとあった方がいいのでは？"
        "装備は十分にあった方がいいぞ。"
   ))

(define jones-catalog
  (list
   (list t_arrow        1 "下ではトロルが酒を飲むように矢を使うことになるぞ！")
   (list t_bolt         1 "ゲイザーが瞬きしている間に弾を使い果たしてしまうだろう！")
   (list t_oil          6 "そう、火炎ビンはたくさん持っておけ。下はもっとひどいぞ。")
   (list t_torch        6 "下で松明を切らせたくはないだろう！")
   (list t_heal_potion 23 "そう、少し高い。だが、ここでは回復の薬は手に入りにくく、そして絶対に必要だ。")
   (list t_mana_potion 23 "魔力の薬は多めに買ったほうがよい。仲間の魔術師はいつもより働かなければならないだろう。")
   (list t_food        10 "下の層で迷ったとき、食料がなくなったら最悪だ。")
   ))

(define (jones-trade knpc kpc) (conv-trade knpc kpc "buy" jones-merch-msgs jones-catalog))

;; Quest-related

(define jones-conv
  (ifc kurpolis-conv

       ;; basics
       (method 'job jones-job)
       (method 'name jones-name)
       
       ;; trade
       (method 'trad jones-trade)
       (method 'buy jones-trade)

       ))

(define (mk-jones)
  (bind 
   (kern-mk-char 
    'ch_jones        ; tag
    "ジョーンジー"      ; name
    jones-species         ; species
    jones-occ              ; occ
    s_townsman     ; sprite
    faction-men      ; starting alignment
    2 0 0            ; str/int/dex
    0 0              ; hp mod/mult
    0 0              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    jones-lvl
    #f               ; dead
    'jones-conv         ; conv
    sch_jones           ; sched
    'townsman-ai              ; special ai
    nil              ; container
    (list t_axe
    		t_armor_chain)              ; readied
    )
   (jones-mk)))
