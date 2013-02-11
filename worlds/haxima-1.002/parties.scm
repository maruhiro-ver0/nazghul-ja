;;----------------------------------------------------------------------------
;; pgroup -- one type of npc within an npc party type
(define (pgroup-mk npct dice)
  (list 'pgroup npct dice))
(define (pgroup-npct pgrp) (cadr pgrp))
(define (pgroup-dice pgrp) (caddr pgrp))
(define (pgroup-size pgrp)
  (define (loop n sum)
    ;;(println "  pgroup-size loop n=" n "sum=" sum)
    (if (= n 0)
        sum
        (loop (- n 1)
              (+ sum (max 0 (kern-dice-roll (pgroup-dice pgrp))))
              )))
  (loop (min 3
             (max 1 
                  (length (filter is-alive? 
                                  (kern-party-get-members (kern-get-player))))))
        0)
  )
(define (pgroup-generate pgrp)
  ;;(println " pgroup-generate")
  (define (loop n)
    ;;(println "  n=" n)
    (if (<= n 0)
        nil
        (cons (mk-npc (pgroup-npct pgrp) (calc-level))
              (loop (- n 1)))))
  (loop (pgroup-size pgrp)))

;;----------------------------------------------------------------------------
;; ptype -- npc party type
(define (ptype-mk name sprite faction dc scarce . groups)
  (list 'ptype sprite faction groups name dc scarce nil))
(define (ptype-sprite ptype) (cadr ptype))
(define (ptype-faction ptype) (caddr ptype))
(define (ptype-groups ptype) (cadddr ptype))
(define (ptype-name ptype) (list-ref ptype 4))
(define (ptype-dc ptype) (list-ref ptype 5))
(define (ptype-scarcity ptype) (list-ref ptype 6))
(define (ptype-vehicle-type-tag ptype) (list-ref ptype 7))
(define (ptype-set-vehicle-type-tag! ptype vtag)
  (set-car! (list-tail ptype 7) vtag))
(define (ptype-generate ptype)
  ;;(println "ptype-generate")
  (let ((kparty (kern-mk-party)))
    (kern-being-set-name kparty (ptype-name ptype))
    (kern-obj-set-sprite kparty (ptype-sprite ptype))
    (kern-being-set-base-faction kparty (ptype-faction ptype))
    (map (lambda (pgroup)
           (map (lambda (kchar)
                  (kern-party-add-member kparty kchar))
                (pgroup-generate pgroup)))
         (ptype-groups ptype))
    (let ((vtag (ptype-vehicle-type-tag ptype)))
      ;;(println "vtag=" vtag)
      (if (not (null? vtag))
          (kern-party-set-vehicle kparty 
                                  (mk-vehicle (eval vtag)))))
    kparty
    ))

;;----------------------------------------------------------------------------
;; mk-npc-party
(define (mk-npc-party ptype-tag) 
  (ptype-generate (eval ptype-tag)))

;;----------------------------------------------------------------------------
;; NPC PARTY TYPES
(define forest-goblin-party-l1
  (ptype-mk "���֥����ɷ��" s_fgob_stalker faction-forest-goblin 1 2
            (pgroup-mk 'forest-goblin-stalker "1")
            ))            
(define forest-goblin-party-l2
  (ptype-mk "���֥����廡��" s_fgob_archer faction-forest-goblin 2 2
            (pgroup-mk 'forest-goblin-stalker "1")
            (pgroup-mk 'forest-goblin-hunter  "1")
            ))
            
(define forest-goblin-party-l3 
  (ptype-mk "���֥��μ�����" s_fgob_archer faction-forest-goblin 3 2
            (pgroup-mk 'forest-goblin-stalker "1d2")
            (pgroup-mk 'forest-goblin-hunter  "1d2")
            (pgroup-mk 'wolf "1d2")
            ))
(define forest-goblin-party-l4 
  (ptype-mk "���֥��ΰ�²"  s_fgob_civilian faction-forest-goblin 4 2
            (pgroup-mk 'forest-goblin-stalker "1d2")
            (pgroup-mk 'forest-goblin-hunter  "1d2")
            (pgroup-mk 'wolf "1d2")
            (pgroup-mk 'forest-goblin-shaman "1")
            ))
(define bandit-party-l1
  (ptype-mk "�ɤ��Ϥ��ν���" s_brigand faction-outlaw 1 4
            (pgroup-mk 'footpad "1d2")
            ))
(define bandit-party-l2
  (ptype-mk "��±��" s_brigand faction-outlaw 2 4
            (pgroup-mk 'bandit "1d2")
            ))
(define bandit-party-l3
  (ptype-mk "����ν���" s_brigand faction-outlaw 3 4
            (pgroup-mk 'highwayman "1d2")
            ))
(define bandit-party-l4
  (ptype-mk "����Ĥ��ν���" s_brigand faction-outlaw 4 4
            (pgroup-mk 'blackguard "1d2")
            ))
(define bandit-party-l5
  (ptype-mk "�����ʤ���Ĥ��ν���" s_brigand faction-outlaw 5 4
            (pgroup-mk 'blackguard "1d2")
            (pgroup-mk 'bomber "1d2")
            ))
(define pirate-party-l3
  (ptype-mk "��±��" s_brigand faction-outlaw 3 5
            (pgroup-mk 'highwayman "1d2")
            ))
(ptype-set-vehicle-type-tag! pirate-party-l3 't_ship)
(define pirate-party-l4
  (ptype-mk "��±��" s_brigand faction-outlaw 3 5
            (pgroup-mk 'blackguard "1d2")
            ))
(ptype-set-vehicle-type-tag! pirate-party-l4 't_ship)
(define troll-party-l3
  (ptype-mk "�ȥ��ν���" s_troll faction-troll 3 5
            (pgroup-mk 'troll "1")
            ))
(define troll-party-l4
  (ptype-mk "���֥�������򽾤����ȥ��ν���" s_troll faction-troll 4 5
            (pgroup-mk 'troll "1")
            (pgroup-mk 'forest-goblin-stalker "1d3-1")
            ))
(define green-slime-party-l2
  (ptype-mk "Ǵ�ݤβ�" s_slime faction-monster 2 3
            (pgroup-mk 'green-slime "1d3")
            ))
(define yellow-slime-party-l3
  (ptype-mk "������Ǵ�ݤγ�" s_yellow_slime faction-monster 3 3
            (pgroup-mk 'green-slime "1d3")
            (pgroup-mk 'yellow-slime "1")
            ))
(define fire-slime-party-l4
  (ptype-mk "���Ǵ�ݤγ�" s_red_slime faction-monster 4 3
            (pgroup-mk 'fire-slime "1d2")
            ))
(define hydra-party-l5
  (ptype-mk "�ҥɥ��Ǵ��" s_hydra faction-monster 5 3
            (pgroup-mk 'green-slime "1d3")
            (pgroup-mk 'yellow-slime "1d2")
            (pgroup-mk 'hydra "1")
            ))

(define dryad-party-l3
  (ptype-mk "�ڤ���" s_reaper faction-monster 3 5
            (pgroup-mk 'dryad "1")
            ))

(define dryad-party-l4
  (ptype-mk "�ڤ�����ϵ" s_reaper faction-monster 4 5
            (pgroup-mk 'dryad "1")
            (pgroup-mk 'wolf "1d3")
            ))

(define dryad-party-l5
  (ptype-mk "�ڤ����ȼ��ѻ�" s_reaper faction-monster 5 5
            (pgroup-mk 'dryad "1")
            (pgroup-mk 'forest-goblin-shaman "1d3")
            ))

(define wolf-party-l1 
  (ptype-mk "ϵ�η���" s_wolf faction-monster 2 5
            (pgroup-mk 'wolf "1")
            ))

(define wolf-party-l2 
  (ptype-mk "ϵ�η���" s_wolf faction-monster 2 5
            (pgroup-mk 'wolf "1d3")
            ))

(define skeleton-party-l2
  (ptype-mk "������ι��" s_skeleton faction-monster 2 5
            (pgroup-mk 'skeletal-warrior "1")
            ))

(define skeleton-party-l3
  (ptype-mk "������ι��" s_skeleton faction-monster 3 5
            (pgroup-mk 'skeletal-warrior "1")
            (pgroup-mk 'skeletal-spear-thrower "1")
            ))
(define skeleton-party-l4 
  (ptype-mk "������ι��" s_skeleton faction-monster 4 5
            (pgroup-mk 'skeletal-warrior "1d2")
            (pgroup-mk 'skeletal-spear-thrower "1d3")
            ))
(define skeleton-pirates-l4 
  (ptype-mk "ͩ����" s_skeleton faction-monster 4 5
            (pgroup-mk 'skeletal-warrior "1d2")
            (pgroup-mk 'skeletal-spear-thrower "1d3")
            ))
(ptype-set-vehicle-type-tag! skeleton-pirates-l4 't_ship)

(define lich-party-l5
  (ptype-mk "��å����Ի�Τ����" s_lich faction-monster 5 5
            (pgroup-mk 'lich "1")
            (pgroup-mk 'skeletal-warrior "1d2")
            (pgroup-mk 'skeletal-spear-thrower "1d3")
            ))

(define wisp-party-l5
  (ptype-mk "���ʤӤ����ν��ޤ�" s_wisp faction-none 5 5
            (pgroup-mk 'wisp "1d3")
            ))

(define ghast-party 
  (ptype-mk "ͩ��" s_ghost faction-monster 1 2
            (pgroup-mk 'ghast "1d3")
            ))

(define dragon-party-l6
  (ptype-mk "��Ω����ε" s_dragon_party faction-monster 6 1
            (pgroup-mk 'dragon "1")
            ))

(define dragon-party-l7
  (ptype-mk "ε��ƶ�����֥��" s_dragon_party faction-monster 7 1
            (pgroup-mk 'dragon "1")
            (pgroup-mk 'cave-goblin-berserker "1d2")
            (pgroup-mk 'cave-goblin-slinger "1d2")
            (pgroup-mk 'cave-goblin-priest "1")
            ))

(define dragon-party-l8
  (ptype-mk "ε�η���" s_dragon_party faction-monster 8 1
            (pgroup-mk 'dragon "1d3")
            ))

(define gint-party-l4
  (ptype-mk "��ͤ��廡��" s_gint_party faction-gint 4 5
            (pgroup-mk 'gint-warrior "1")
            ))

(define gint-party-l5
  (ptype-mk "��ͤμ�����" s_gint_party faction-gint 5 5
            (pgroup-mk 'gint-warrior "1")
            (pgroup-mk 'cave-goblin-slinger "1d2")
            (pgroup-mk 'wolf "1d2")
            ))

(define gint-party-l6
  (ptype-mk "��ͤ���Ʈ��" s_gint_party faction-gint 6 3
            (pgroup-mk 'gint-warrior "1d2")
            (pgroup-mk 'troll "1d2")
            (pgroup-mk 'cave-goblin-slinger "1d3")
            (pgroup-mk 'wolf "1d2")
            ))

(define kraken-party-l3
  (ptype-mk "���顼����η���" s_kraken faction-monster 3 5
            (pgroup-mk 'kraken "1d2")
            ))

(define sea-serpent-party-l3
  (ptype-mk "���إӤη���" s_sea_serpent faction-monster 3 5
            (pgroup-mk 'sea-serpent "1d2")
            ))

(define nixie-party-l2
  (ptype-mk "�˥������ν���" s_nixie_spear faction-monster 2 3
            (pgroup-mk 'nixie-swordsman "1d2")
            (pgroup-mk 'nixie-spearman "1d2-1")
            ))

(define nixie-party-l3
  (ptype-mk "���顼����򽾤����˥������ν���" s_kraken faction-monster 3 5
            (pgroup-mk 'nixie-swordsman "1d2")
            (pgroup-mk 'nixie-spearman "1d2")
            (pgroup-mk 'kraken "1")
            ))

(define nixie-party-l4
  (ptype-mk "���顼����򽾤����˥������ν���" s_kraken faction-monster 3 5
            (pgroup-mk 'nixie-swordsman "1d2")
            (pgroup-mk 'nixie-spearman "1d2")
            (pgroup-mk 'kraken "1")
            ))

(define nixie-party-l5
  (ptype-mk "���إӤ򽾤����˥������ν���" s_sea_serpent faction-monster 4 5
            (pgroup-mk 'nixie-swordsman "1d2")
            (pgroup-mk 'nixie-spearman "1d2")
            (pgroup-mk 'sea-serpent "1")
            ))

(define spider-party-l3
  (ptype-mk "����η���" s_spider faction-spider 3 5
            (pgroup-mk 'giant-spider "1d2")
            ))

(define spider-party-l4
  (ptype-mk "����η���" s_spider faction-spider 4 5
            (pgroup-mk 'giant-spider "1d2")
            (pgroup-mk 'queen-spider "1")
            ))
(define headless-party-l1
  (ptype-mk "��ʤ�" s_headless faction-monster 1 4
            (pgroup-mk 'headless "1")))
(define headless-party-l3
  (ptype-mk "��ʤ��ν���" s_headless faction-monster 3 4
            (pgroup-mk 'headless "1d2")))
(define headless-party-l5
  (ptype-mk "��ʤ��򽾤�������ѻ�" s_wizard faction-monster 5 4
            (pgroup-mk 'headless "1d2")
            (pgroup-mk 'warlock "1")
            ))

(define accursed-party-l4
  (ptype-mk "����줿Ƴ��" s_wizard faction-accursed 4 2
            (pgroup-mk 'accursed-master "1")
            (pgroup-mk 'accursed-apprentice "1d2-1")
            (pgroup-mk 'accursed-guardian "1d2")
            ))
(define accursed-party-l5
  (ptype-mk "����줿Ƴ��" s_wizard faction-accursed 5 2
            (pgroup-mk 'accursed-master "1")
            (pgroup-mk 'accursed-defender "1d2")
            ))
(define accursed-party-l6
  (ptype-mk "����줿���Ƴ��" s_wizard faction-accursed 6 2
            (pgroup-mk 'accursed-master "1")
            (pgroup-mk 'accursed-defender "1d2")
            (pgroup-mk 'accursed-templar "1d2")
            ))
(define militia-party-l4
  (ptype-mk "æ����" s_guard faction-outlaw  4 4
            (pgroup-mk 'halberdier "1d2")
            (pgroup-mk 'crossbowman "1d2-1")
            ))

(define snake-party-l1
  (ptype-mk "���ʤ�ؤη���" s_snake faction-monster 1 5
            (pgroup-mk 'snake "1d2")
            ))
(define bat-party-l1
  (ptype-mk "�������α�" s_bat faction-monster 1 1
            (pgroup-mk 'bat "1d2")
            ))

(define rat-party-l1
  (ptype-mk "�ͥ��ߤη���" s_rat faction-monster 5 5
            (pgroup-mk 'rat "1d2")
            ))

(define griffin-party-l3
  (ptype-mk "����ե���η���" s_griffin faction-monster 3 5
            (pgroup-mk 'griffin "1d2")
            ))

(define insect-party-l1
  (ptype-mk "����α�" s_insects faction-monster 1 5
            (pgroup-mk 'insect "1d3")
            ))