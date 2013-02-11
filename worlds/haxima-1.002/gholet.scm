;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define gholet-lvl 4)
(define gholet-species sp_human)
(define gholet-occ nil)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; グラスドリンの地下の監獄
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (gholet-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ゴレットはかつては海賊で、今はグラスドリンの地下の監獄にいる。
;; 彼は慈悲深い死号の乗組員の生き残りの一人で、亡霊となったガーティ船長に復讐
;; のため追われている。
;;----------------------------------------------------------------------------

;; Basics...
(define (gholet-hail knpc kpc)
  (say knpc "よーお、旦那あ。"))

(define (gholet-default knpc kpc)
  (say knpc "そのとおりでさぁ。それが旦那のいい所！"))

(define (gholet-name knpc kpc)
  (say knpc "ゴレットでさぁ。でも気にしないでくだせえ、旦那。")
  (quest-data-update 'questentry-ghertie 'gholet-dungeon 1))

(define (gholet-join knpc kpc)
  (say knpc "そんでこっから出て贅沢できるって？バカバカしいや！"))

(define (gholet-job knpc kpc)
  (say knpc "おっと、俺ぁ料理人だ、いや、だった。"
       "何にせよ、ここで見ての通りの新しい天職を得たんでさぁ。"))

(define (gholet-bye knpc kpc)
  (say knpc "面白いお話で、旦那。"))

;; Tier 2 replies
(define (gholet-cook knpc kpc)
  (say knpc "有名な豪華客船の料理人だったわけよ！"
       "慈悲深い死号、聞いたことあるか？")
  (if (yes? kpc)
      (say knpc "おお、そりゃあいい。有名だって言ったろ！")
      (say knpc "おお、昔は本当に有名だった。"
           "今どうなってるかはわかんねえ。")))

(define (gholet-merc knpc kpc)
  (say knpc "おお、そうさぁ、お頭はすばらしい女だった。"
       "ガーティーってんだ。"))

(define (gholet-gher knpc kpc)
  (say knpc "いい女だった。あれよりいい頭はいねえ。"))

(define (gholet-voca knpc kpc)
  (say knpc "おう、これが今までで一番楽な仕事でさぁ。"))

(define (gholet-mean knpc kpc)
  (say knpc "ミーニーのジジイとは長げえこと会ってねえな。"
       "救貧院をやってると聞いたがなあ。"))

(define (gholet-jorn knpc kpc)
  (say knpc "おお、あいつは本当にやべえよ、旦那。"
       "寝た犬はそのままにしておきなよ。"))

(define (gholet-dog knpc kpc)
  (say knpc "犬は白き牡鹿荘で寝てると聞いたなあ。")
  (quest-data-update 'questentry-ghertie 'jorn-loc 1))

;; Quest-related
(define (gholet-ring knpc kpc)

  (if (not (in-inventory? knpc t_skull_ring_g))
      (say knpc "指輪？何の指輪？")
      (begin

        (define (take-picklocks)
          (if (< (num-in-inventory kpc t_picklock) 12)
		(begin
		(quest-data-update-with 'questentry-ghertie 'gholet-price 1 (quest-notify nil))
              (say knpc "うーむ、少し問題があるなあ、旦那。"
                   "鍵開け道具が足りねえよ。"
                   "でもこの指輪は取り置きにしておくよ。")
		   )
              (begin
                (say knpc "そうだ。あんたは持ってく、俺は出ていく、"
                     "うまくいった、うまくいった！新しい指輪を楽しんでくれ、旦那！")
                (kern-obj-remove-from-inventory kpc t_picklock 12)
                (kern-obj-add-to-inventory knpc t_picklock 12)
                (kern-obj-remove-from-inventory knpc t_skull_ring_g 1)
		(skullring-g-get nil kpc)
		)))

        (say knpc "おお、この古いブツか？痒くてしょうがねえんだ。"
             "コイツのせいにちげえねえ。"
             "コイツは外そう。もちろん指も一緒にだ。"
             "少しきたねえが、欲しいか？")
        (if (yes? kpc)
            (begin
              (say knpc "気にすんなよ。全然。"
                   "コイツは本当にすげえ代物だ！"
                   "でも、いいことをすれば、いいことになって返っている。"
                   "そうだろ、旦那？")
              (if (yes? kpc)
                  (begin
                    (say knpc "もちろんそうするよなぁ、旦那！"
                         "持ちつ持たれつってヤツよ！"
                         "鍵開け道具が1ダース。鍵開け道具が1ダースあればコイツはあんたのモンだ。"
                         "どうよ？")
                    (if (yes? kpc)
                        (take-picklocks)
                        (begin
			(quest-data-update-with 'questentry-ghertie 'gholet-price 1 (quest-notify nil))
                          (say knpc "それがこの指輪の値段だ。"
                               "払う気になったらまた来てくれ。")
                          (kern-conv-end))))
                  (begin
                    (say knpc "だったら帰んなよ。")
                    (kern-conv-end))))
            (say knpc "ごちゃごちゃいいやがって。"
                 "この指輪のためにここに来たのは知ってるんだ。")))))
      
(define gholet-conv
  (ifc basic-conv

       ;; basics
       (method 'default gholet-default)
       (method 'hail gholet-hail)
       (method 'bye  gholet-bye)
       (method 'job  gholet-job)
       (method 'name gholet-name)
       (method 'join gholet-join)
       
       ;; other responses
       (method 'cook gholet-cook)
       (method 'merc gholet-merc)
       (method 'gher gholet-gher)
       (method 'voca gholet-voca)
       (method 'ring gholet-ring)

       (method 'mean gholet-mean)
       (method 'jorn gholet-jorn)
       (method 'dog  gholet-dog)
       ))

(define (mk-gholet)
  (bind 
   (kern-char-force-drop
   (kern-mk-char 
    'ch_my           ; tag
    "ゴレット"             ; name
    gholet-species         ; species
    gholet-occ              ; occ
    s_brigand     ; sprite
    faction-men      ; starting alignment
    1 0 3            ; str/int/dex
    0 0              ; hp mod/mult
    0 0              ; mp mod/mult
    max-health; hp
    -1                   ; xp
    max-health ; mp
    0
    gholet-lvl
    #f               ; dead
    'gholet-conv         ; conv
    nil              ; sched
    nil              ; special ai
    ;;..........container (and contents)
    (mk-inventory
              (list
               (list 1 t_skull_ring_g)
               ))
    nil              ; readied
    )
   #t)
  (gholet-mk)))
