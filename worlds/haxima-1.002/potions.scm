;; ----------------------------------------------------------------------------
;; potions.scm -- potion object types. Potions work on the drinker.
;; ----------------------------------------------------------------------------

(kern-mk-sprite-set 'ss_potions 32 32 2 5 0 0 "potions.png")

(kern-mk-sprite 's_healing_potion       ss_potions 1 0 #f 0)
(kern-mk-sprite 's_mana_potion          ss_potions 1 1 #f 0)
(kern-mk-sprite 's_immunity_potion      ss_potions 1 2 #f 0)
(kern-mk-sprite 's_cure_potion          ss_potions 1 3 #f 0)
(kern-mk-sprite 's_invisibility_potion  ss_potions 1 4 #f 0)
(kern-mk-sprite 's_red_bubbly_potion    ss_potions 1 5 #f 0)
(kern-mk-sprite 's_green_bubbly_potion  ss_potions 1 6 #f 0)
(kern-mk-sprite 's_yellow_bubbly_potion ss_potions 1 7 #f 0)
(kern-mk-sprite 's_round_bubbly_purple  ss_potions 1 10 #f 0)
(kern-mk-sprite 's_round_bubbly_lblue   ss_potions 1 11 #f 0)
(kern-mk-sprite 's_round_bubbly_yellow  ss_potions 1 12 #f 0)

;; mk-potion -- utility for making potion types. 'drink-proc' should return one
;; of the result-* codes.
(define (mk-potion tag name sprite drink-proc)
  (mk-usable-item tag name sprite norm drink-proc
                  (lambda (kpotion kuser) 
                    (drink-proc kpotion kuser))))

;; mk-clingy-potion -- utility for making potion types that automatically cause
;; npc's that want them to get them. 'drink-proc' should return one of the
;; result-* codes.
(define (mk-clingy-potion tag name sprite drink-proc wants-it?)
  (mk-usable-clingy-item tag name sprite norm drink-proc wants-it?))

;; healing (red) potion     
(mk-clingy-potion 't_heal_potion "体力回復の薬" s_healing_potion 
                  (lambda (kpotion kuser)
                    (kern-obj-heal kuser (kern-dice-roll "2d10"))
                    result-ok)
                  wants-healing?)

;; mana (blue) potion
(mk-clingy-potion 't_mana_potion "魔力の薬" s_mana_potion 
                  (lambda (kpotion kuser)
                    (kern-char-dec-mana kuser (- 0 (kern-dice-roll "1d8+2")))
                    result-ok)
                  wants-mana?)

;; cure (green) potion
(mk-potion 't_cure_potion "治癒の薬" s_cure_potion
           (lambda (kpotion kuser) 
             (kern-obj-remove-effect kuser ef_poison)
             result-ok))
			 
(mk-potion 't_xp_potion "レベル上昇の薬" s_cure_potion
           (lambda (kpotion kuser) 
             (kern-char-add-experience kuser 500)
             result-ok))

(define (potion-gain-stats kuser current-stat stat-name stat-setter)
  (println "cur:" current-stat)
  (cond ((< current-stat 20)
         (kern-log-msg (kern-obj-get-name kuser) "は" stat-name "を得た！")
         (stat-setter kuser (+ current-stat (kern-dice-roll "1d3+1")))
         result-ok)
        ((< current-stat 25)
         (kern-log-msg (kern-obj-get-name kuser) "は少しの" stat-name "を得た！")
         (stat-setter kuser (+ current-stat (kern-dice-roll "1d3")))
         result-ok)
        ((< current-stat 35)
         (let ((droll (kern-dice-roll "1d2-1")))
           (println "droll:" droll)
           (cond ((> droll 0)
                  (kern-log-msg (kern-obj-get-name kuser) "にはすでに多くの" stat-name "があるが、わずかに得られた。")
                  (stat-setter kuser (+ current-stat 1))
                  result-ok)
                 (else
                  (kern-log-msg (kern-obj-get-name kuser) "にはすでに多くの" stat-name "があり、今は少し気分が悪くなった。")
                  result-no-effect))))
        (else
         (kern-log-msg (kern-obj-get-name kuser) "にはあまりに多くの" stat-name "があり尊大で退屈な者なので薬は効果がなかった。")
         result-no-effect)))

(mk-potion 't_str_potion "腕力の薬" s_round_bubbly_yellow
		(lambda (kpotion kuser)
			(potion-gain-stats kuser (kern-char-get-base-strength kuser)
                                           "腕力" kern-char-set-strength)))
			 
(mk-potion 't_dex_potion "敏捷の薬" s_round_bubbly_purple
		(lambda (kpotion kuser)
			(potion-gain-stats kuser (kern-char-get-base-dexterity kuser)
                                           "敏捷性" kern-char-set-dexterity)))
			 
(mk-potion 't_int_potion "知能の薬" s_round_bubbly_lblue
		(lambda (kpotion kuser)
			(potion-gain-stats kuser (kern-char-get-base-intelligence kuser)
				"知能" kern-char-set-intelligence)))

(mk-potion 't_info_potion "啓蒙の薬" s_mana_potion
           (lambda (kpotion kuser) 
            (kern-log-msg (kern-obj-get-name kuser) "の能力")
			(kern-log-msg "盗賊の能力: " (number->string (occ-ability-thief kuser)))
			(kern-log-msg "黒魔法: " (number->string (occ-ability-blackmagic kuser)))
			(kern-log-msg "白魔法: " (number->string (occ-ability-whitemagic kuser)))
			(kern-log-msg "魔法に対する抵抗力: " (number->string (occ-ability-magicdef kuser)))
			(kern-log-msg "戦闘における腕力: " (number->string (occ-ability-strattack kuser)))
			(kern-log-msg "戦闘における敏捷性: " (number->string (occ-ability-dexattack kuser)))
			(kern-log-msg "回避: " (number->string (occ-ability-dexdefend kuser)))
			result-ok))


;; posion immunity (bubbly yellow) potion
(mk-potion 't_poison_immunity_potion "免疫の薬" s_immunity_potion
           (lambda (kpotion kuser) 
             (kern-obj-add-effect kuser ef_temporary_poison_immunity nil)
             result-ok))

;; invisibility (black) potion
(mk-potion 't_invisibility_potion "不可視の薬" s_invisibility_potion
           (lambda (kpotion kuser)
             (kern-obj-add-effect kuser ef_invisibility nil)
             result-ok))

;; FIXME: the following "blood" potions need to do stuff
(mk-potion 't_dragons_blood "竜の血"  s_red_bubbly_potion
           (lambda (kpotion kuser)
             (kern-obj-add-effect kuser ef_temporary_fire_immunity nil)
             result-ok))

;; hydra's blood -- turn arrows into poisoned arrows?
(mk-potion 't_hydras_blood "ヒドラの血" s_green_bubbly_potion
           (lambda (kpotion kuser)
             (kern-obj-add-effect kuser ef_temporary_grow_head nil)
             result-ok))

;; lich's blood -- turn arrows into diseased arrows?
(mk-potion 't_lichs_blood "リッチの血" s_yellow_bubbly_potion
           (lambda (kpotion kuser)
               (kern-obj-add-effect kuser ef_temporary_disease_immunity nil)
               (kern-obj-add-effect kuser ef_temporary_poison_immunity nil)
               result-ok))


