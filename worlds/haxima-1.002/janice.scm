;;----------------------------------------------------------------------------
;; ジャニス
;;
;; 最初はジェフリーズ司令官の補佐だが、審判の後に彼の後任に選出される。
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_jan
               (list 0  0  gjan-bed    "sleeping")
               (list 6  0  gc-hall     "working")
               (list 7  0  ghg-s6      "eating")
               (list 8  0  gc-hall     "working")
               (list 11 0  ghg-s3      "eating")
               (list 12 0  gc-hall     "working")
               (list 17 0  ghg-s3      "eating")
               (list 18 0  g-fountain  "idle")
               (list 20 0  gjan-bed    "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (jan-mk) (list 'townsman))

;;----------------------------------------------------------------------------
;; Conv
;;----------------------------------------------------------------------------

;; Basics...
(define (jan-hail knpc kpc)
  (say knpc "こんにちは、旅の方。")
  )

(define (jan-name knpc kpc)
  (if (player-stewardess-trial-done?)
      (say knpc "司令官のジャニスです。")
      (say knpc "ジャニスです。")
      ))

(define (jan-job knpc kpc)
  (if (player-stewardess-trial-done?)
      (say knpc "グラスドリンの軍を指揮しています。")
      (say knpc "ジェフリーズ司令官の補佐をしております。")
      ))

;; Special
(define (jan-comm knpc kpc)
  (if (player-stewardess-trial-done?)
      (say knpc "私はジェフリーズ前司令官の後任として選出されました。")
      (say knpc "ジェフリーズ司令官は有能な指導者です。")
      ))

(define (jan-repl knpc kpc)
  (if (player-stewardess-trial-done?)
      (say knpc "彼の長いグラスドリンでの経歴が、このような不名誉で終わったのは恥ずかしいことです。")
      (say knpc "どういう意味ですか？")
      ))

(define (jan-mili knpc kpc)
  (say knpc "グラスドリンの軍は、現在はクロポリスと国境の警備を行っています。"
       "現在は戦争状態ではありません。"))

(define (jan-bord knpc kpc)
  (say knpc "現在はトリグレイブや緑の塔との関係は良好ですが、警戒を怠ることはできません。")
  )

;; Townspeople...

(define jan-conv
  (ifc glasdrin-conv

       ;; basics
       (method 'hail jan-hail)
       (method 'job  jan-job)
       (method 'name jan-name)
       (method 'jani jan-name)

       (method 'comm jan-comm)
       (method 'jeff jan-comm)
       (method 'mili jan-mili)
       (method 'repl jan-repl)
       (method 'bord jan-bord)
       ))

(define (mk-janice)
  (bind 
   (kern-mk-char 'ch_janice       ; tag
                 "ジャニス"        ; name
                 sp_human            ; species
                 oc_warrior          ; occ
                 s_cloaked_female ; sprite
                 faction-glasdrin         ; starting alignment
                 2 1 1               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 5  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'jan-conv         ; conv
                 sch_jan           ; sched
                 'townsman-ai                 ; special ai
                 nil                 ; container
                 (list t_armor_chain
                       t_chain_coif
                       t_sword
                       ))         ; readied
   (jan-mk)))
