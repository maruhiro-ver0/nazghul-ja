;;----------------------------------------------------------------------------
;; �Ϸ�
;;----------------------------------------------------------------------------

(define (terrain-effect-burn obj)
  (kern-obj-apply-damage obj "burning" 10))

(define (terrain-effect-poison obj)
  (if (and (> (kern-dice-roll "1d20") 10)
           (kern-obj-is-being? obj)
           (kern-obj-add-effect obj ef_poison nil))
      (kern-log-msg "��̸����")))
	
;; swamp logic:
;; 1) swamp only effects you on your turn (ie the 'slow progress' doesnt mean you get whacked 3 times before your next turn)
;;			this is calculated by whether your character speed is enough to bring your ap positive in your next turn
;; 2) swamp is weaker in the worldmap, where you are assumed to have some lattitude to go around the noxious bits
;; 3) swamp gives 'noxious fumes' feedback if someone in your party gets poisoned, or you see an individual critter get poisoned
;;       you dont get feedback when a npc party moves over swamp
(define (terrain-effect-swamp obj)
  (if (and (kern-obj-is-being? obj)
			(if (kern-place-is-wilderness? (loc-place (kern-obj-get-location obj)))
				(> (kern-obj-get-ap (kern-char-get-party obj)) (- 0 (kern-char-get-speed obj)))
				(> (kern-obj-get-ap obj) (- 0 (kern-char-get-speed obj)))
				))
	(let* (
			(difficulty
				(cond ((< (kern-obj-get-movecost obj pclass-canfly) cant) 1)
					((kern-place-is-wilderness? (loc-place (kern-obj-get-location obj))) 4)
					(else 6)
				))
			(avoid (* 2 (occ-ability-dexdefend obj)))
			(avoidroll (- (kern-dice-roll (mkdice 1 (+ avoid difficulty))) avoid ))
			(strength (kern-char-get-strength obj))
			(resistroll (- (kern-dice-roll (mkdice 1 (+ strength 10))) strength ))
			)
		(if (> avoidroll 0)
			(if (> resistroll 0)
				(begin
					(kern-obj-add-effect obj ef_poison nil)
					(if (kern-place-is-wilderness? (loc-place (kern-obj-get-location obj)))
						(if (is-player-party-member? obj)
							(kern-log-msg "��̸����"))
						(msg-log-visible (kern-obj-get-location obj) "��̸����")
					)			
				)
			))
	)))
	
(define (terrain-effect-lava obj)
  (if (eqv? (kern-obj-get-movecost obj pclass-canfly) cant)
	(if (and (kern-obj-is-being? obj)
			(kern-place-is-wilderness? (loc-place (kern-obj-get-location obj))))
		(let* ((avoid (* 2 (occ-ability-dexdefend obj)))
				(avoidroll (- (kern-dice-roll (mkdice 1 (+ avoid 5))) avoid)))
			(if (> avoidroll 0)
				(generic-burn obj (mkdice avoidroll 4)))
		)
		(burn obj))))

(define (terrain-effect-torch obj)
	(generic-burn obj "1d4"))

;; opacity constants:
(define opq 12) ;; opaque
(define hvy 5)  ;; heavy
(define dns 3)  ;; dense
(define lgt 2)  ;; light (density)
(define trn 0)  ;; transparent

(define terrains
  (list
   ;;    tag                name            pclass           sprite               t light step-on
   ;;    =================  ==============  =============    ==============       = ===== =======
   (list 't_stars           "����"          pclass-space     s_stars             trn 0 'chasm-fall)
   (list 't_deep            "������"        pclass-deep      s_deep              trn 0 nil)
   (list 't_sunlit_deep     "������"        pclass-deep      s_deep              trn 64 nil)
   (list 't_shallow         "��"            pclass-deep      s_shallow           trn 0 nil)
   (list 't_blendable_shoals "������"       pclass-shoals    s_shoals            trn 0 nil)
   (list 't_shoals          "������"        pclass-shoals    s_shoals            trn 0 nil)
   (list 't_sludge          "�̤����"      pclass-sludge    s_sludge            trn 0 nil)
   (list 't_shallow_sludge  "�̤����"      pclass-shallows  s_shallow_sludge    trn 0 nil)
   (list 't_grass           "����"          pclass-grass     s_grass             trn 0 nil)
   (list 't_sunlit_grass    "����"          pclass-grass     s_grass             trn 64 nil)
   (list 't_dirt            "��"            pclass-grass     s_dirt              trn 0 nil)
   (list 't_gravel          "����"          pclass-grass     s_gravel            trn 0 nil)
   (list 't_trees_v         "�ڡ�"          pclass-trees     s_trees             trn 0 nil)
   (list 't_trees           "�ڡ�"          pclass-trees     s_trees             lgt 0 nil)
   (list 't_trees_d         "�ڡ�"          pclass-trees     s_trees             dns 0 nil)

   (list 't_forest_v        "��"            pclass-forest    s_forest            trn 0 nil)
   (list 't_forest          "��"            pclass-forest    s_forest            hvy 0 nil)
   (list 't_forest_d        "��"            pclass-forest    s_forest            7   0 nil)
   (list 't_forest_l        "��"            pclass-forest    s_forest            dns 0 nil)
   (list 't_forest_b        "��"            pclass-forest    s_forest            opq 0 nil)

   (list 't_hills           "��"            pclass-hills     s_hills             dns 0 nil)
   (list 't_mountains_v     "��̮"          pclass-vmountains s_mountains        trn 0 nil)
   (list 't_mountains_b     "��̮�Τդ��"  pclass-space     s_mountains         trn 0 nil)
   (list 't_mountains       "��̮"          pclass-mountains s_mountains         opq 0 nil)
   (list 't_fake_mountains  "��̮"          pclass-grass     s_mountains         opq 0 nil)
   (list 't_bog             "����"          pclass-hills     s_bog               trn 0 'terrain-effect-swamp)
   (list 't_lava            "�ϴ�"          pclass-hills     s_lava              trn  128 'terrain-effect-lava)
   (list 't_fake_lava       "�ϴ�"          pclass-grass     s_lava              trn  128 nil)
   (list 't_deep_lava       "�����ϴ�"      pclass-deep      s_deep_lava         trn   16 'great-burn)
   (list 't_fire_terrain    "��"            pclass-grass     s_field_fire        trn  512 'burn)
   (list 't_fireplace       "��ϧ"          pclass-grass     s_fireplace         trn 2048 'burn)

   (list 't_cobblestone     "�о�"          pclass-grass     s_cobblestone       trn 0 nil)
   (list 't_gold_cobble     "�о�"          pclass-grass     s_gold_cobble       trn 0 nil)
   (list 't_cyan_cobble     "�о�"          pclass-grass     s_cyan_cobble       trn 0 nil)
   (list 't_gray_cobble     "�о�"          pclass-grass     s_gray_cobble       trn 0 nil)
   (list 't_blue_cobble     "�о�"          pclass-grass     s_blue_cobble       trn 0 nil)
   (list 't_olive_cobble    "�о�"          pclass-grass     s_olive_cobble      trn 0 nil)
   (list 't_white_cobble    "�о�"          pclass-grass     s_white_cobble      trn 0 nil)
   (list 't_black_tile      "��������"      pclass-grass     s_black_tile        trn 0 nil)
   (list 't_gold_spiral_tile "��������"     pclass-grass     s_gold_spiral_tile  trn 0 nil)
   (list 't_blue_spiral_tile "��������"     pclass-grass     s_blue_spiral_tile  trn 0 nil)
   (list 't_tombstone       "����"          pclass-boulder   s_tombstone         trn 0 nil)
   (list 't_tombstone2      "����"          pclass-boulder   s_tombstone2        trn 0 nil)

   (list 't_impassable_cobblestone "�о�"   pclass-wall      s_cobblestone       trn 0 nil)
   (list 't_flagstones      "����"          pclass-grass     s_flagstone         trn 0 nil)
   (list 't_inv_wall        "����"          pclass-repel     s_flagstone         trn 0 'burn)
   (list 't_doorway         "������"        pclass-grass     s_stone_arch        trn 0 nil) ;;dont use this if poss
   (list 't_leftwing        "����"          pclass-wall      s_leftwing          trn 0 nil)
   (list 't_rightwing       "����"          pclass-wall      s_rightwing         trn 0 nil)
   (list 't_ship_hull       "��������"      pclass-wall      s_wall              trn 0 nil)
   (list 't_ship_hull2      "����"          pclass-wall      s_wall              opq 0 nil)
   (list 't_sh_hull_NE      "����"          pclass-wall      s_wall_b            trn 0 nil)
   (list 't_sh_hull_NW      "����"          pclass-wall      s_wall_a            trn 0 nil)
   (list 't_sh_hull_SE      "����"          pclass-wall      s_wall_c            trn 0 nil)
   (list 't_sh_hull_SW      "����"          pclass-wall      s_wall_d            trn 0 nil)
   (list 't_mast            "����"          pclass-wall      s_mast              trn 0 nil)
   (list 't_ships_wheel     "����"          pclass-wall      s_ships_wheel       trn 0 nil)
   (list 't_deck            "����"          pclass-grass     s_deck              trn 0 nil)
   (list 't_boulder         "��"            pclass-boulder   s_boulder           lgt 0 nil)
   (list 't_wall_rock_v     "����"          pclass-wall      s_wall_rock         trn 0 nil)
   (list 't_wall_rock       "����"          pclass-wall      s_wall_rock         opq 0 nil)
   (list 't_fake_wall_rock  "����"          pclass-forest    s_secret_rock       opq 0 nil)
   (list 't_wall_v          "��"            pclass-wall      s_wall_stone        trn 0 nil)
   (list 't_wall            "��"            pclass-wall      s_wall_stone        opq 0 nil)
   (list 't_fake_wall       "��"            pclass-forest    s_wall_stone        opq 0 nil)
   (list 't_wall_torch      "�ɤξ���"      pclass-wall      s_wall_torch        opq 1024 'terrain-effect-torch)
   (list 't_arrow_slit      "����"          pclass-bars      s_arrow_slit        trn 0 nil)
   (list 't_window_in_stone "��"            pclass-bars      s_window_in_stone   trn 0 nil)
   (list 't_window_in_rock  "��"            pclass-bars      s_window_in_rock    trn 0 nil)
   (list 't_secret_door     "������"        pclass-grass     s_secret_door       opq 0 nil)
   (list 't_sea_wall_v      "������"        pclass-wall      s_wall              trn 0 nil)
   (list 't_sea_wall        "������"        pclass-wall      s_wall              opq 0 nil)
   (list 't_sea_wall_NE     "������"        pclass-wall      s_wall_b            opq 0 nil)
   (list 't_sea_wall_NW     "������"        pclass-wall      s_wall_a            opq 0 nil)
   (list 't_sea_wall_SE     "������"        pclass-wall      s_wall_c            opq 0 nil)
   (list 't_sea_wall_SW     "������"        pclass-wall      s_wall_d            opq 0 nil)
   (list 't_ankh            "����"        pclass-wall      s_ankh              trn 0 nil)
   (list 't_statue          "��"            pclass-wall      s_statue            trn 0 nil)
   (list 't_altar           "����"          pclass-boulder   s_altar             trn 0 nil)
   (list 't_rune_altar      "���ǤΤ������" pclass-boulder s_altar            trn 64 nil)
   (list 't_active_altar    "��ư������ǤΤ������" pclass-boulder s_active_altar trn 512 nil)
   (list 't_pillar          "��"            pclass-wall      s_pillar            trn 0 nil)
   (list 't_false_pillar    "��"            pclass-grass     s_pillar            trn 0 nil)
   (list 't_counter_2x1_w   "��"            pclass-boulder   s_counter_2x1_w     trn 0 nil)
   (list 't_counter_2x1_c   "��"            pclass-boulder   s_counter_2x1_c     trn 0 nil)
   (list 't_counter_2x1_e   "��"            pclass-boulder   s_counter_2x1_e     trn 0 nil)
   (list 't_counter_1x1     "��"            pclass-boulder   s_counter_1x1       trn 0 nil)
   (list 't_bridge_WE       "��"            pclass-bridge    s_ew_bridge         trn 0 nil)
   (list 't_bridge_NS       "��"            pclass-bridge    s_ns_bridge         trn 0 nil)
   (list 't_lava_bridge_NS  "��"            pclass-bridge    s_ns_bridge         trn 0 nil)
   (list 't_chasm           "����"          pclass-space     s_null              trn 0 nil)
   (list 't_void            "����"          pclass-space     s_null              trn 0 nil)
   (list 't_trail_0         "ƻ"            pclass-grass     s_trail_0           trn 0 nil)
   (list 't_trail_1         "ƻ"            pclass-grass     s_trail_1           trn 0 nil)
   (list 't_trail_2         "ƻ"            pclass-grass     s_trail_2           trn 0 nil)
   (list 't_trail_3         "ƻ"            pclass-grass     s_trail_3           trn 0 nil)
   (list 't_trail_4         "ƻ"            pclass-grass     s_trail_4           trn 0 nil)
   (list 't_trail_5         "ƻ"            pclass-grass     s_trail_5           trn 0 nil)
   (list 't_trail_6         "ƻ"            pclass-grass     s_trail_6           trn 0 nil)
   (list 't_trail_7         "ƻ"            pclass-grass     s_trail_7           trn 0 nil)
   (list 't_trail_8         "ƻ"            pclass-grass     s_trail_8           trn 0 nil)
   (list 't_trail_9         "ƻ"            pclass-grass     s_trail_9           trn 0 nil)
   (list 't_trail_a         "ƻ"            pclass-grass     s_trail_a           trn 0 nil)
   (list 't_trail_b         "ƻ"            pclass-grass     s_trail_b           trn 0 nil)
   (list 't_trail_c         "ƻ"            pclass-grass     s_trail_c           trn 0 nil)
   (list 't_trail_d         "ƻ"            pclass-grass     s_trail_d           trn 0 nil)
   (list 't_trail_e         "ƻ"            pclass-grass     s_trail_e           trn 0 nil)
   (list 't_trail_f         "ƻ"            pclass-grass     s_trail_f           trn 0 nil)
   (list 't_A               "A��ʸ��"       pclass-wall      s_A                 trn 0 nil)
   (list 't_B               "B��ʸ��"       pclass-wall      s_B                 trn 0 nil)
   (list 't_fake_B          "B��ʸ��"       pclass-forest    s_B                 trn 0 nil)
   (list 't_C               "C��ʸ��"       pclass-wall      s_C                 trn 0 nil)
   (list 't_D               "D��ʸ��"       pclass-wall      s_D                 trn 0 nil)
   (list 't_E               "E��ʸ��"       pclass-wall      s_E                 trn 0 nil)
   (list 't_F               "F��ʸ��"       pclass-wall      s_F                 trn 0 nil)
   (list 't_G               "G��ʸ��"       pclass-wall      s_G                 trn 0 nil)
   (list 't_H               "H��ʸ��"       pclass-wall      s_H                 trn 0 nil)
   (list 't_I               "I��ʸ��"       pclass-wall      s_I                 trn 0 nil)
   (list 't_J               "J��ʸ��"       pclass-wall      s_J                 trn 0 nil)
   (list 't_K               "K��ʸ��"       pclass-wall      s_K                 trn 0 nil)
   (list 't_L               "L��ʸ��"       pclass-wall      s_L                 trn 0 nil)
   (list 't_M               "M��ʸ��"       pclass-wall      s_M                 trn 0 nil)
   (list 't_N               "N��ʸ��"       pclass-wall      s_N                 trn 0 nil)
   (list 't_O               "O��ʸ��"       pclass-wall      s_O                 trn 0 nil)
   (list 't_fake_O          "O��ʸ��"       pclass-forest    s_O                 trn 0 nil)
   (list 't_P               "P��ʸ��"       pclass-wall      s_P                 trn 0 nil)
   (list 't_Q               "Q��ʸ��"       pclass-wall      s_Q                 trn 0 nil)
   (list 't_R               "R��ʸ��"       pclass-wall      s_R                 trn 0 nil)
   (list 't_S               "S��ʸ��"       pclass-wall      s_S                 trn 0 nil)
   (list 't_T               "T��ʸ��"       pclass-wall      s_T                 trn 0 nil)
   (list 't_U               "U��ʸ��"       pclass-wall      s_U                 trn 0 nil)
   (list 't_V               "V��ʸ��"       pclass-wall      s_V                 trn 0 nil)
   (list 't_W               "W��ʸ��"       pclass-wall      s_W                 trn 0 nil)
   (list 't_X               "X��ʸ��"       pclass-wall      s_X                 trn 0 nil)
   (list 't_Y               "Y��ʸ��"       pclass-wall      s_Y                 trn 0 nil)
   (list 't_Z               "Z��ʸ��"       pclass-wall      s_Z                 trn 0 nil)
   (list 't_rune_A          "A�θ���ʸ��"   pclass-wall      s_rune_A            trn 0 nil)
   (list 't_rune_B          "B�θ���ʸ��"   pclass-wall      s_rune_B            trn 0 nil)
   (list 't_rune_C          "C�θ���ʸ��"   pclass-wall      s_rune_C            trn 0 nil)
   (list 't_rune_D          "D�θ���ʸ��"   pclass-wall      s_rune_D            trn 0 nil)
   (list 't_rune_E          "E�θ���ʸ��"   pclass-wall      s_rune_E            trn 0 nil)
   (list 't_rune_F          "F�θ���ʸ��"   pclass-wall      s_rune_F            trn 0 nil)
   (list 't_rune_G          "G�θ���ʸ��"   pclass-wall      s_rune_G            trn 0 nil)
   (list 't_rune_H          "H�θ���ʸ��"   pclass-wall      s_rune_H            trn 0 nil)
   (list 't_rune_I          "I�θ���ʸ��"   pclass-wall      s_rune_I            trn 0 nil)
   (list 't_rune_J          "J�θ���ʸ��"   pclass-wall      s_rune_J            trn 0 nil)
   (list 't_rune_K          "K�θ���ʸ��"   pclass-wall      s_rune_K            trn 0 nil)
   (list 't_rune_L          "L�θ���ʸ��"   pclass-wall      s_rune_L            trn 0 nil)
   (list 't_rune_M          "M�θ���ʸ��"   pclass-wall      s_rune_M            trn 0 nil)
   (list 't_rune_N          "N�θ���ʸ��"   pclass-wall      s_rune_N            trn 0 nil)
   (list 't_rune_O          "O�θ���ʸ��"   pclass-wall      s_rune_O            trn 0 nil)
   (list 't_rune_P          "P�θ���ʸ��"   pclass-wall      s_rune_P            trn 0 nil)
   (list 't_rune_Q          "Q�θ���ʸ��"   pclass-wall      s_rune_Q            trn 0 nil)
   (list 't_rune_R          "R�θ���ʸ��"   pclass-wall      s_rune_R            trn 0 nil)
   (list 't_rune_S          "S�θ���ʸ��"   pclass-wall      s_rune_S            trn 0 nil)
   (list 't_rune_T          "T�θ���ʸ��"   pclass-wall      s_rune_T            trn 0 nil)
   (list 't_rune_U          "U�θ���ʸ��"   pclass-wall      s_rune_U            trn 0 nil)
   (list 't_rune_V          "V�θ���ʸ��"   pclass-wall      s_rune_V            trn 0 nil)
   (list 't_rune_W          "W�θ���ʸ��"   pclass-wall      s_rune_W            trn 0 nil)
   (list 't_rune_X          "X�θ���ʸ��"   pclass-wall      s_rune_X            trn 0 nil)
   (list 't_rune_Y          "Y�θ���ʸ��"   pclass-wall      s_rune_Y            trn 0 nil)
   (list 't_rune_Z          "Z�θ���ʸ��"   pclass-wall      s_rune_Z            trn 0 nil)
   (list 't_rune_TH         "TH�θ���ʸ��"  pclass-wall      s_rune_TH           trn 0 nil)
   (list 't_rune_EE         "EE�θ���ʸ��"  pclass-wall      s_rune_EE           trn 0 nil)
   (list 't_rune_NG         "NG�θ���ʸ��"  pclass-wall      s_rune_NG           trn 0 nil)
   (list 't_rune_EA         "EA�θ���ʸ��"  pclass-wall      s_rune_EA           trn 0 nil)
   (list 't_rune_ST         "ST�θ���ʸ��"  pclass-wall      s_rune_ST           trn 0 nil)
   (list 't_rune_DOT        ".�θ���ʸ��"   pclass-wall      s_rune_DOTSEP       trn 0 nil)
   (list 't_equip_sign      "ƻ�񲰤δ���"  pclass-wall      s_torch_sign        opq 0 nil)
   (list 't_weapon_sign     "��ﲰ�δ���"  pclass-wall      s_shield_sign       opq 0 nil)
   (list 't_healer_sign     "�±���ɽ��"    pclass-wall      s_ankh_sign         opq 0 nil)
   (list 't_tavern_sign     "���δ���"    pclass-wall      s_beer_sign         opq 0 nil)
   (list 't_inn_sign        "�ɲ��δ���"    pclass-wall      s_bed_sign          opq 0 nil) 
   (list 't_alchemy_sign    "�ع���ɽ��"    pclass-wall      s_potion_sign       opq 0 nil) 
   (list 't_magic_sign      "�����δ���"    pclass-wall      s_mushroom_sign     opq 0 nil) 
   (list 't_str_sign        "���ϤΤ��뤷"  pclass-wall      s_axe_sign          trn 1024 nil) 
   (list 't_dex_sign        "�Ҿ��Τ��뤷"  pclass-wall      s_key_sign          trn 1024 nil) 
   (list 't_wis_sign        "��ǽ�Τ��뤷"  pclass-wall      s_book_sign         trn 1024 nil) 
   (list 't_nat_rock        "�����Ф���"    pclass-wall      s_nat_rock          opq 0 nil) 
   (list 't_fake_wall_nrock "�����Ф���"    pclass-forest    s_secret_nrock      opq 0 nil)
   ))

(map (lambda (terrain) (apply kern-mk-terrain terrain)) terrains)

;;----------------------------------------------------------------------------
;; Make some blended shore terrain types

(define (mk-shore-terrain tag . sprites)
  (kern-mk-terrain tag "������ί��" pclass-shoals
                   (mk-composite-sprite (cons s_shoals sprites))
                   trn 0 nil))

(mk-shore-terrain 't_shore_n  s_grass_n )
(mk-shore-terrain 't_shore_w  s_grass_w )
(mk-shore-terrain 't_shore_nw s_grass_nw)
(mk-shore-terrain 't_shore_e  s_grass_e )
(mk-shore-terrain 't_shore_ne s_grass_ne)
(mk-shore-terrain 't_shore_we s_grass_e s_grass_w)
(mk-shore-terrain 't_shore_nwe s_grass_ne s_grass_nw)
(mk-shore-terrain 't_shore_s  s_grass_s )
(mk-shore-terrain 't_shore_ns s_grass_s s_grass_n)
(mk-shore-terrain 't_shore_ws s_grass_sw)
(mk-shore-terrain 't_shore_nws s_grass_sw s_grass_nw)
(mk-shore-terrain 't_shore_es s_grass_se)
(mk-shore-terrain 't_shore_nes s_grass_se s_grass_ne)
(mk-shore-terrain 't_shore_wes s_grass_se s_grass_sw)
(mk-shore-terrain 't_shore_c s_grass_se s_grass_sw s_grass_ne s_grass_nw)

(define tset_shore
(list
   t_shoals    ;; 0: none
   t_shore_n   ;; 1: north
   t_shore_w   ;; 2: west
   t_shore_nw  ;; 3: north west
   t_shore_e   ;; 4: east
   t_shore_ne  ;; 5: east north
   t_shore_we  ;; 6: east west
   t_shore_nwe ;; 7: east west north
   t_shore_s   ;; 8: south
   t_shore_ns  ;; 9: south north
   t_shore_ws  ;; 10: south west
   t_shore_nws ;; 11: south west north
   t_shore_es  ;; 12: south east
   t_shore_nes ;; 13: south east north
   t_shore_wes ;; 14: south east west
   t_shore_c ;; 15: south east west north
   ))
   
(define tset_water
(append tset_shore
          (list t_shoals
                t_shallow
                t_deep
                t_sunlit_deep
                t_bridge_WE
                t_bridge_NS)))

;;----------------------------------------------------------------------------
;; bits of ship

;; regular terrains

(map
	(lambda (terrainentry)
		(apply
			(lambda (tag name pclass opacity sprite)
				(kern-mk-terrain tag name pclass sprite
					opacity 0 nil)
			)
			terrainentry
		)
	)
	(list
	
(list 't_bulwark_x_ns "����" pclass-wall opq s_bulwark_ns)
(list 't_bulwark_x_ew "����" pclass-wall opq s_bulwark_ew)
	
(list 't_bulwark_v_ne "����" pclass-boulder trn s_bulwark_sw)
(list 't_bulwark_v_nw "����" pclass-boulder trn s_bulwark_se)
(list 't_bulwark_v_se "����" pclass-boulder trn s_bulwark_nw)
(list 't_bulwark_v_sw "����" pclass-boulder trn s_bulwark_ne)
	
(list 't_bulwark_x_ne "����" pclass-wall opq s_bulwark_sw)
(list 't_bulwark_x_nw "����" pclass-wall opq s_bulwark_se)
(list 't_bulwark_x_se "����" pclass-wall opq s_bulwark_nw)
(list 't_bulwark_x_sw "����" pclass-wall opq s_bulwark_ne)

(list 't_stair_un "����" pclass-grass trn s_stair_n)
(list 't_stair_uw "����" pclass-grass trn s_stair_w)
(list 't_stair_ue "����" pclass-grass trn s_stair_e)
(list 't_stair_us "����" pclass-grass trn s_stair_s)

(list 't_tank_l "��°���ƴ�" pclass-mountains opq s_tank_l)
(list 't_tank_d "��°���ƴ�" pclass-mountains opq s_tank_d)
(list 't_tank_nw "��°���ƴ�" pclass-mountains opq s_tank_nw)
(list 't_tank_ne "��°���ƴ�" pclass-mountains opq s_tank_ne)
(list 't_tank_sw "��°���ƴ�" pclass-mountains opq s_tank_sw)
(list 't_tank_se "��°���ƴ�" pclass-mountains opq s_tank_se)

	)
)
	
		
;; composite terrains
(map
	(lambda (terrainentry)
		(apply
			(lambda (tag name pclass opacity sprites)
				(kern-mk-terrain tag name pclass (mk-composite-sprite sprites)
					opacity 0 nil)
				)
			terrainentry
		)
	)
	(list
	
(list 't_rail_ew "��" pclass-boulder trn (list s_deck s_bulwark_ew))
(list 't_rail_ns "��" pclass-boulder trn (list s_deck s_bulwark_ns))

(list 't_bulwark_n "����" pclass-boulder trn (list s_shallow s_deck_s s_bulwark_ew))
(list 't_bulwark_w "����" pclass-boulder trn (list s_shallow s_deck_e s_bulwark_ns))
(list 't_bulwark_e "����" pclass-boulder trn (list s_shallow s_deck_w s_bulwark_ns))
(list 't_bulwark_s "����" pclass-boulder trn (list s_shallow s_deck_n s_bulwark_ew))

(list 't_bulwark_v_n "����" pclass-boulder trn (list s_deck_s s_bulwark_ew))
(list 't_bulwark_v_w "����" pclass-boulder trn (list s_deck_e s_bulwark_ns))
(list 't_bulwark_v_e "����" pclass-boulder trn (list s_deck_w s_bulwark_ns))
(list 't_bulwark_v_s "����" pclass-boulder trn (list s_deck_n s_bulwark_ew))

(list 't_bulwark_w_ne "����" pclass-boulder trn (list s_shallow s_bulwark_sw))
(list 't_bulwark_w_nw "����" pclass-boulder trn (list s_shallow s_bulwark_se))
(list 't_bulwark_w_se "����" pclass-boulder trn (list s_shallow s_bulwark_nw))
(list 't_bulwark_w_sw "����" pclass-boulder trn (list s_shallow s_bulwark_ne))

(list 't_bulwark_d_ne "����" pclass-boulder trn (list s_deck s_bulwark_ne))
(list 't_bulwark_d_nw "����" pclass-boulder trn (list s_deck s_bulwark_nw))
(list 't_bulwark_d_se "����" pclass-boulder trn (list s_deck s_bulwark_se))
(list 't_bulwark_d_sw "����" pclass-boulder trn (list s_deck s_bulwark_sw))

(list 't_tank_d_nw "��°���ƴ�" pclass-mountains opq (list s_deck s_tank_nw))
(list 't_tank_d_ne "��°���ƴ�" pclass-mountains opq (list s_deck s_tank_ne))
(list 't_tank_d_sw "��°���ƴ�" pclass-mountains opq (list s_deck s_tank_sw))
(list 't_tank_d_se "��°���ƴ�" pclass-mountains opq (list s_deck s_tank_se))

	)
)
                                    
;;----------------------------------------------------------------------------

(define bad-terrain-list
  (list t_bog
        t_lava
        t_deep_lava
        t_fire_terrain
        t_fireplace
        t_inv_wall
        t_wall_torch
        ))

(define inflammable-terrain-list
  (list t_bog
        t_deep
        t_shallow
        t_shoals
        t_sunlit_deep
        t_stars
		t_void
		t_chasm
        ))
		
(load "blendterrains.scm")

(define (is-bad-terrain? kter)
  (in-list? kter bad-terrain-list))

(define (is-inflammable-terrain? kter)
  (in-list? kter inflammable-terrain-list))

(define (is-deck? kter)
	(in-list? kter 
		(list
			t_deck
			t_ship_hull
			t_ship_hull2
			t_mast
			t_ships_wheel
			
			t_bulwark_v_ne
			t_bulwark_v_nw
			t_bulwark_v_se
			t_bulwark_v_sw
			
			t_bulwark_n
			t_bulwark_w
			t_bulwark_e
			t_bulwark_s
			
			t_bulwark_w_ne
			t_bulwark_w_nw
			t_bulwark_w_se
			t_bulwark_w_sw
			
			t_bulwark_d_ne
			t_bulwark_d_nw
			t_bulwark_d_se
			t_bulwark_d_sw
			
			t_bulwark_v_n
			t_bulwark_v_w
			t_bulwark_v_e
			t_bulwark_v_s
	)))
