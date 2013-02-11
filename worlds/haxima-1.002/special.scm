;;----------------------------------------------------------------------------
;; Special -- one-off stuff that needs to be kern-loaded and doesn't really fit
;; anywhere else.
;;----------------------------------------------------------------------------

(kern-mk-sprite-set 'ss_special 32 32 3 3 0 0 "special.png")

(kern-mk-sprite 's_gold_skull ss_special 1 0 #f 0)
(kern-mk-sprite 's_power_core ss_special 1 1 #f 0)

;;----------------------------------------------------------------------------
;; Bandit-Hideout generator -- 
;; procedure invoked by a step trigger to place the bandit hideout on the world map.
;; Should return true iff it triggers to remove the step generator that invokes it.
;;----------------------------------------------------------------------------
(define bandit-hideout-loc (list 'p_shard 72 63))
(define (mk-bandit-hideout kbeing)
  (if (eqv? kbeing 
            (kern-get-player))
      (begin
        (kern-log-msg "木々で隠された空き地を見つけた。抜き身の刃を持った怪しい人影がうろついている！")
        (kern-place-set-subplace p_bandit_hideout_l1
                                 (eval-loc bandit-hideout-loc))
        (kern-map-set-dirty)
        #t)
      #f))


;;----------------------------------------------------------------------------
;; Angriss Lair generator -- procedure invoked by a step trigger to create
;; Angriss's Lair. Should return true iff it triggers to remove the step
;; generator that invokes it.
;;----------------------------------------------------------------------------
(define angriss-lair-loc (list 'p_shard 88 69))
(define (mk-angriss-lair kbeing)
  (if (eqv? kbeing 
            (kern-get-player))
      (begin
        (kern-log-msg "木々が乱雑に生えている…\n木には網がかけられており、恐ろしい「残骸」が包まれぶら下がっている。\nここがアングリスの住み家の入り口かもしれない！")
        (kern-place-set-subplace p_angriss_lair 
                                 (eval-loc angriss-lair-loc))
        (kern-map-set-dirty)
        #t)
      #f))


;;----------------------------------------------------------------------------
;; Mans-Hideout generator -- 
;; procedure invoked by a step trigger to place the MAN's hideout on the world map.
;; Should return true iff it triggers to remove the step generator that invokes it.
;;----------------------------------------------------------------------------
(define the-mans-hideout-loc (list 'p_shard 92 10))
(define (mk-mans-hideout kbeing)
  (if (eqv? kbeing 
            (kern-get-player))
      (begin
        (kern-log-msg "安全な場所に隠された入り口を見つけた！")
        (kern-place-set-subplace p_mans_hideout
                                 (eval-loc the-mans-hideout-loc))
        (kern-map-set-dirty)
        #t)
      #f))


;;----------------------------------------------------------------------------
;; Brundegardt generator -- 
;; procedure invoked by a step trigger to place Brundegardt on the world map.
;; Should return true iff it triggers to remove the step generator that invokes it.
;;----------------------------------------------------------------------------
(define brundegardt-loc (list 'p_shard 76 40))
(define (mk-brundegardt kbeing)
  (if (eqv? kbeing 
            (kern-get-player))
      (begin
        (kern-log-msg "隠された小道をたどると、山の中腹の木々で覆われた奇妙な場所にたどり着いた！")
        (kern-place-set-subplace p_brundegardt
                                 (eval-loc brundegardt-loc))
        (kern-map-set-dirty)
        #t)
      #f))


;; ----------------------------------------------------------------------------
;; The Warritrix's note
;; ----------------------------------------------------------------------------
(mk-reusable-item 
 't_warritrix_orders "作戦命令書" s_lexicon norm
 (lambda (klexicon kuser)
   (kern-ui-page-text
   "闘士への命令書"
   "グラスドリンで最も忠実な奉仕者、"
   "失われた殿堂の奥深くで呪われた者が集まっている"
   "疑いがある。"
   "すぐに調査を開始せよ。洞窟を全て探索するまでは"
   "離れてはならない。"
   "−司令官ジェフリーズ"
   "追記　この命令書はただちに破棄すること。")))


;; Kraken lakes kraken trigger
(define (spawn-kraken-lakes-sea-serpent kbeing)
  (kern-log-msg "水の中に何かがいる…")
  (kern-obj-put-at (spawn-npc 'kraken 8) (mk-loc p_deepness 31 34))
  (kern-obj-put-at (spawn-npc 'kraken 8) (mk-loc p_deepness 32 35))
  (kern-obj-put-at (spawn-npc 'kraken 8) (mk-loc p_deepness 30 29))
  #t)

;; Locations referred to more than once
(define lost-halls-loc (list 'p_shard 39 75))

;; Power core for voidship
(mk-quest-obj-type 't_power_core "古代の炉心" s_power_core layer-item obj-ifc)

;; Luximene begins the game as a Lich King, when defeated he drops his skull,
;; which can be used with the Necromancer to summon his shade.
(mk-quest-obj-type 't_lich_skull "ラクシマニ王の頭蓋骨" s_gold_skull layer-item obj-ifc)

;; grow -- trigger hook fx to create items (eg, growing reagents, hence the name)
(define (grow-trig ktrig ktype-tag dice)
  (println "grow-trig")
  (println "  ktrig=" ktrig)
  (println "  ktype-tag=" ktype-tag)
  (println "  dice=" dice)
  (kern-obj-put-at (kern-mk-obj (eval ktype-tag) (kern-dice-roll 
                                       dice))
                   (kern-obj-get-location ktrig)))
