;;----------------------------------------------------------------------------
;; Skill procedures
;;
;; Skill procedures should not do any requirements-checking because the kernel
;; checks all requirements before allowing them to be called. Skill procedures
;; should always return (ie, evaluate to) one of the standard result-* codes
;; (eg, result-ok, result-no-target, etc... see naz.scm).

(define (skill-jump kactor)
  (define (range)
    (let ((x (* (occ-ability-stracro kactor) (kern-obj-get-ap kactor))))
      (cond ((> x 1000) 4) ;; inconceivable!
            ((> x 500) 3)
            ((> x 150) 2)
            (else 0))))
  (if (has-effect? kactor ef_fatigue)
      result-not-now
      (cast-ui-ranged-loc powers-jump
                          kactor
                          (range)
                          0)))

(define (skill-sprint kactor)
  (if (has-effect? kactor ef_fatigue)
      result-not-now
      (let* ((origin (kern-obj-get-location kactor))
             (kplace (loc-place origin))
             (sprint-max-range (+ 2 (occ-ability-stracro kactor)))
             (sprint-max-cost (* sprint-max-range (kern-obj-get-ap kactor)))
             )
        (define (too-far? origin dest)
          (let ((path (line (loc-x origin) (loc-y origin) 
                            (loc-x dest) (loc-y dest))))
            (let ((cost (foldr (lambda (d xy)
                                 (+ d 
                                    (kern-place-get-movement-cost (mk-loc kplace
                                                                          (car xy) 
                                                                          (cdr xy)) 
                                                                  kactor)
                                    ))
                               0
                               path)))
              (> cost sprint-max-cost))))
        (define (checkloc x y)
          (let ((dest (mk-loc kplace x y)))
            (and (kern-place-is-passable dest kactor)
                 (not (occupied? dest))
                 (kern-in-los? origin dest)
                 (not (too-far? origin dest))
                 )))
        (cast-ui-template-loc powers-sprint
                              kactor
                              (kern-mk-templ origin sprint-max-range 'checkloc)
                              0))))

(define (skill-wriggle kactor)
  ;; fixme: use smart target that only suggests viable locations?
  (cast-ui-ranged-loc powers-wriggle kactor 1 0))

(define (check-wriggle kactor)
  (cond ((null? (kern-char-get-arms kactor)) #t)
        (else
         (kern-log-msg "装備を外さなければならない！")
         #f
         )))
      

(load "disarm-trap.scm")
  
(define (skill-stealth kactor)
  (kern-obj-add-effect kactor ef_stealth nil)
  result-ok)

(define (skill-butcher kactor)
  (cast-ui-ranged-any powers-butcher
                      kactor 1 (occ-ability-crafting kactor)
                      (mk-ifc-query 'butcher)))

(define (skill-pickpocket kactor)
  (cast-ui-basic-ranged-spell powers-pickpocket 
                              kactor 
                              1 
                              (occ-ability-thief kactor)
                              ))

;;----------------------------------------------------------------------------
;; Skill declarations
;;
;; (kern-mk-skill <tag>
;;                <name>
;;                <description>
;;                <ap-consumed>
;;                <mp-consumed>
;;                <can-use-in-wilderness?>
;;                <is-passive?>
;;                <yusage-proc>
;;                <yusage-special-check-proc>
;;                <list-of-required-tools>
;;                <list-of-required-consumables>)

(define (mk-skill name description ap-cost mp-cost use-in-wilderness
                  is-passive yusage-proc yusage-special-check-proc list-of-required-tools list-of-required-consumables)
  (kern-mk-skill name description ap-cost mp-cost use-in-wilderness
                 is-passive yusage-proc yusage-special-check-proc list-of-required-tools list-of-required-consumables))
					

(define sk_jump
  (mk-skill "跳ぶ" "通れない場所を飛び越える"
            0
            0 
            #f
            #f
           'skill-jump
            nil
            nil
            nil
            ))

(define sk_arm_trap
  (mk-skill "罠を仕掛ける" "トラバサミや鉄菱を仕掛ける"
            0
            0
            #f
            #t
            nil
            nil
            nil
            nil
            ))

(define sk_sprint
  (mk-skill "走る" "短い直線をすばやく移動する"
            0
            0
            #f
            #f
            'skill-sprint
            nil
            nil
            nil
            nil
            ))

(define sk_wriggle
  (mk-skill "忍び込む" "狭い場所を通り抜ける"
            base-move-ap   ;; ap
            0              ;; mp
            #f             ;; wilderness?
            #f             ;; passive?
            'skill-wriggle ;; yusage 
            'check-wriggle ;; yusage check
            nil            ;; tools
            (list (list t_grease 1)) ;; material
            ))

(define sk_disarm_trap
  ;; fixme: should some special tools be required?
  (mk-skill "罠を外す" "扉や箱の罠を外す"
            0              ;; ap
            0              ;; mp
            #f             ;; wilderness?
            #f             ;; passive?
            'skill-disarm-trap ;; yusage 
            nil            ;; yusage check
            nil            ;; tools
            nil            ;; material
            ))

(define sk_stealth
  (mk-skill "隠れる" "見つからないようにする"
            base-move-ap   ;; ap
            0              ;; mp
            #f             ;; wilderness?
            #f             ;; passive?
            'skill-stealth ;; yusage 
            nil            ;; yusage check
            nil            ;; tools
            nil            ;; material
            ))

(define sk_reach
  (mk-skill "伸ばす" "1つ向こうのものを操作する"
            base-move-ap   ;; ap
            0              ;; mp
            #f             ;; wilderness?
            #t             ;; passive?
            nil            ;; yusage 
            nil            ;; yusage check
            nil            ;; tools
            nil            ;; material
            ))

(define sk_butcher
  (mk-skill "加工する" "動物の死体を食料や道具にする"
            0              ;; ap
            0              ;; mp
            #f             ;; wilderness?
            #f             ;; passive?
            'skill-butcher ;; yusage 
            nil            ;; yusage check
            nil            ;; tools (fixme: add knife)
            nil            ;; material
            ))

(define sk_pickpocket
  (mk-skill "盗む" "他人の物を取る"
            base-move-ap   ;; ap
            0              ;; mp
            #f             ;; wilderness?
            #f             ;; passive?
            'skill-pickpocket ;; yusage 
            nil            ;; yusage check
            nil            ;; tools
            nil            ;; material
            ))

(define sk_unlock
  (mk-skill "こじ開ける" "鍵開け道具で扉を開ける"
            0
            0
            #f
            #t ;; passive
            'skill-unlock
            nil
            (list t_picklock)
            nil
            ))

;;----------------------------------------------------------------------------
;; Skill Set declarations
;;
;; The number preceeding the skill name is the minimum level needed to use the
;; skill.

(define sks_warrior
  (kern-mk-skill-set "戦士" (list
                                (list 1 sk_sprint)
                                (list 2 sk_jump)
                                )))

(define sks_ranger
  (kern-mk-skill-set "警備隊員" (list
                                (list 1 sk_sprint)
                                (list 2 sk_jump)
                                (list 3 sk_arm_trap)
                                (list 5 sk_stealth)
                                )))

(define sks_wrogue
  (kern-mk-skill-set "ならず者" (list 
                               (list 1 sk_sprint)
                               (list 1 sk_arm_trap)
                               (list 2 sk_unlock)
                               (list 2 sk_disarm_trap)
                               (list 3 sk_jump)
                               (list 3 sk_wriggle)
                               (list 4 sk_reach)
                               (list 4 sk_pickpocket)
                               (list 5 sk_stealth)
                               )))

(define sks_wright
  (kern-mk-skill-set "職人" (list 
                               (list 1 sk_arm_trap)
                               (list 2 sk_unlock)
                               (list 3 sk_disarm_trap)
                               )))

(define sks_wanderer 
  (kern-mk-skill-set "迷い人" (list 
                               (list 2 sk_sprint)
                               (list 3 sk_jump)
                               (list 3 sk_unlock)
                               (list 4 sk_arm_trap)
                               (list 4 sk_disarm_trap)
                               (list 5 sk_reach)
                               (list 5 sk_pickpocket)
                               (list 6 sk_stealth)
                               )))
