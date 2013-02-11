;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define kalc-lvl 6)
(define kalc-species sp_human)
(define kalc-occ oc_wizard)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; カルシファクスは多くの場所を(月の門を使って)旅し、伝言などを運んでいる。
;;----------------------------------------------------------------------------
(define kalc-bed cheerful-bed-2)
(define kalc-mealplace )
(define kalc-workplace )
(define kalc-leisureplace )
(kern-mk-sched 'sch_kalc
               (list 0  0 kalc-bed          "sleeping")
               (list 7  0 bilge-water-seat-5 "eating")
               (list 8  0 enchtwr-hall       "idle")
               (list 11 0 g-fountain         "idle")
               (list 12 0 ghg-s6             "eating")
               (list 13 0 eng-workshop       "idle")
               (list 16 0 trigrave-tavern-hall "idle")
               (list 17 0 trigrave-tavern-table-3b "eating")
               (list 19 0 gt-ws-hall           "idle")
               (list 23 0 kalc-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (kalc-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; カルシファクスは女性の魔術師で、多くの月の門の知識がある。
;; 彼女は多くの場所を(月の門を使って)旅し、伝言などを運んでいる。
;; カルシファクスは仲間になる。
;;----------------------------------------------------------------------------

;; Basics...
(define (kalc-hail knpc kpc)
  (meet "［あなたはかわいらしい魔術師と会った。］")
  (say knpc "こんにちは、旅人さん。")
  )

(define (kalc-name knpc kpc)
  (say knpc "カルシファクスですわ。あなたは…？")
  (kern-conv-get-reply kpc)
  (say knpc "会えてうれしいですわ。")
  )

(define (kalc-join knpc kpc)
  (if (is-player-party-member? knpc)
      (say knpc "もう仲間ですわ！")
      (begin
        (say knpc "いいですわ。楽しそう！")
        (join-player knpc)
        (kern-conv-end)
        )
  ))

(define (kalc-job knpc kpc)
  (say knpc "門で旅をして、人々の間を走り回ることですわ。")
  )

(define (kalc-bye knpc kpc)
  (say knpc "また会える気がしますわ！")
  )

(define (kalc-gate knpc kpc)
  (say knpc "月の門ですわ。どうなっているかご存知かしら？")
  (if (yes? kpc)
      (say knpc "どうして皆様も同じようにしないのかしら。")
      (say knpc "ルミスの相が入り口を決めて、オードの相が出口の決めるのですのよ！")))

(define (kalc-lumi knpc kpc)
  (say knpc "ルミスは黄色くゆっくり動く方の月のことですわ。"))

(define (kalc-ord knpc kpc)
  (say knpc "オードは青く速く動く方の月ですわ。"))

(define (kalc-engi knpc kpc)
  (say knpc "私は技師を訪問した数少ない者の一人ですわ！"
       "月の門を使わなければ彼の場所には行けませんの。"
       "オードが満月に近いときに入ればよいのですわ。"))

(define (kalc-peop knpc kpc)
  (say knpc "魔道師や技師、町の役人の伝言を伝えていますの。"
       "安全で早く何かを運ぶ必要がある、代金を支払ってくれる方なら誰でもですわ！"))

(define (kalc-pay knpc kpc)
  (say knpc "なかなかの稼ぎになりますわ。"))

(define kalc-conv
  (ifc basic-conv

       ;; basics
       (method 'default (lambda (knpc kpc) (say knpc "どうかしら。")))
       (method 'hail kalc-hail)
       (method 'bye  kalc-bye)
       (method 'job  kalc-job)
       (method 'name kalc-name)
       (method 'join kalc-join)
       
       (method 'gate kalc-gate)
       (method 'lumi kalc-lumi)
       (method 'ord  kalc-ord)
       (method 'engi kalc-engi)
       (method 'peop kalc-peop)
       (method 'erra kalc-peop)
       (method 'pay  kalc-pay)
       ))

(define (mk-kalcifax)
  (bind 
   (kern-mk-char 
    'ch_kalc           ; tag
    "カルシファクス"       ; name
    kalc-species         ; species
    kalc-occ              ; occ
    s_blue_wizard
    faction-men      ; starting alignment
    0 7 0            ; str/int/dex
    (/ pc-hp-off 2)  ; hp bonus
    (/ pc-hp-gain 2) ; hp per-level bonus
    pc-mp-off        ; mp bonus
    pc-mp-gain       ; mp per-level bonus
    max-health ; hp
    -1  ; xp
    max-health ; mp
    0
    kalc-lvl
    #f               ; dead
    'kalc-conv         ; conv
    sch_kalc           ; sched
    'townsman-ai              ; special ai
    nil              ; container
    (list            ;; readied
     t_staff
     )
    )
   (kalc-mk)))
