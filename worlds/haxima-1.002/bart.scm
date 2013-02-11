;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; オパーリン
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_bart
               (list 0  0  black-barts-bed      "sleeping")
               (list 11 0  black-barts-ship     "working")
               (list 18 0  bilge-water-hall     "idle")
               (list 23 0  black-barts-bed      "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (bart-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; バートは飲んだくれのゴブリンの造船職人で、オパーリンに住んでいる。
;;----------------------------------------------------------------------------

;; Basics...
(define (bart-hail knpc kpc)
  (say knpc "［あなたは口数の少なそうな、ウィスキーの臭いのするゴブリンと会った。］"
       "ウン。"))

(define (bart-default knpc kpc)
  (say knpc "エー？"))

(define (bart-name knpc kpc)
  (say knpc "バート。"))

(define (bart-join knpc kpc)
  (say knpc "［彼はあなたを奇妙そうにみて、頭を振った。］"))

(define (bart-job knpc kpc)
  (say knpc "バートは船を作る。よい船。"))

(define (bart-bye knpc kpc)
  (say knpc "ジャ。"))

;; Trade...
(define (bart-trade knpc kpc)

  (define (buy-ship)
    (let* ((town (loc-place (kern-obj-get-location knpc)))
           (town-loc (kern-place-get-location town))
           (ship-loc (loc-offset town-loc east)))
      (if (ship-at? ship-loc)
          (say knpc "ム。船着場、場所ない。まず船動かせ。")
          (begin
            (kern-obj-relocate (mk-ship) ship-loc nil)
            (take-player-gold oparine-ship-price)
            (say knpc "船、外にある。")
            ))))

  (define (sell-ship)
    (let* ((town (loc-place (kern-obj-get-location knpc)))
           (town-loc (kern-place-get-location town))
           (ship-loc (loc-offset town-loc east))
           (kship (kern-place-get-vehicle ship-loc)))
      (if (null? kship)
          (say knpc "バート船見えない。船着場止めろ。また来い。")
          (begin
            (say knpc "このボロ船売る？バート金貨" 
                 oparine-ship-tradein-price
                 "枚渡す。いい？")
            (if (kern-conv-get-yes-no? kpc)
                (begin
                  (say knpc "バート気前いい。あんた運いい。")
                  (kern-obj-remove kship)
                  (give-player-gold oparine-ship-tradein-price))
                (say knpc "ム。船すぐ沈む。"))))))

  (if (not (string=? "working" (kern-obj-get-activity knpc)))
      (say knpc "今働かない。今飲む！")
      (begin
        (say knpc "船、買う？")
        (if (yes? kpc)
            (begin
              (say knpc "船、金貨" oparine-ship-price "枚。船欲しい？")
              (if (kern-conv-get-yes-no? kpc)
                  (if (player-has-gold? oparine-ship-price)
                      (buy-ship)
                      (begin
                        (say knpc "金貨足りない。バートだます？"
                             "［彼は地面に唾を吐いた。］")
                        (kern-conv-end)))
                  (say knpc "いい。泳げ。")))
            (begin
              (say knpc "船、売る？")
              (if (yes? kpc)
                  (sell-ship)
                  (begin
                    (say knpc "ならば、バート何する？")
                    (kern-conv-end))))))))

;; Drink...
(define (bart-drink knpc kpc)
  (if (not (string=? "working" (kern-obj-get-activity knpc)))
      (say knpc "飲む！")
      (say knpc "今働く。後飲む。")))


;; Townspeople...
(define (bart-opar knpc kpc)
  (say knpc "魚の臭いする。"))

(define (bart-gher knpc kpc)
  (say knpc "ツ・グ。悪い魂。［彼は空中に奇妙な図形を描いた。］"))

(define (bart-alch knpc kpc)
  (say knpc "ヒ・リュ・ト。燃える町から来た。"
       "一族おぼえてる。"))

(define (bart-seaw knpc kpc)
  (say knpc "魚の臭いする。"))

(define (bart-osca knpc kpc)
  (say knpc "ツ・ト。バートよい話知らない。"))

(define (bart-henr knpc kpc)
  (say knpc "バート友だち。よい酒作る！バート飲む好き。"))

(define bart-conv
  (ifc basic-conv

       ;; basics
       (method 'default bart-default)
       (method 'hail bart-hail)
       (method 'bye bart-bye)
       (method 'job bart-job)
       (method 'name bart-name)
       (method 'join bart-join)
       
       ;; drink
       (method 'drin bart-drink)

       ;; trade
       (method 'trad bart-trade)
       (method 'ship bart-trade)
       (method 'buy bart-trade)
       (method 'sell bart-trade)

       ;; town & people
       (method 'opar bart-opar)
       (method 'alch bart-alch)
       (method 'gher bart-gher)
       (method 'witc bart-seaw)
       (method 'lia bart-seaw)
       (method 'osca bart-osca)
       (method 'henr bart-henr)
       (method 'ja   bart-bye)

       ))

(define (mk-bart)
  (bind 
   (kern-mk-char 'ch_bart           ; tag
                 "バート"           ; name
                 sp_forest_goblin    ; species
                 nil                 ; occ
                 s_fgob_civilian     ; sprite
                 faction-men         ; starting alignment
                 0 0 0               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 1  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'bart-conv         ; conv
                 sch_bart           ; sched
                 'townsman-ai                 ; special ai
                 (mk-inventory (list (list 1 t_axe)))                 ; container
                 nil                 ; readied
                 )
   (bart-mk)))
