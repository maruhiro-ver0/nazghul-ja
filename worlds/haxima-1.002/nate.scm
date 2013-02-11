;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define nate-start-lvl 2)

;;----------------------------------------------------------------------------
;; Schedule
;;
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (nate-mk) (list #f #f))
(define (nate-caught? gob) (car gob))
(define (nate-caught! gob) (set-car! gob #t))
(define (nate-met? gob) (cadr gob))
(define (nate-met! gob) (set-car! (cdr gob) #t))

;;----------------------------------------------------------------------------
;; Conv
;;
;; ネイトは盗賊の頭である。
;;----------------------------------------------------------------------------
(define (nate-hail knpc kpc)
  (let ((nate (kobj-gob-data knpc)))
    (define (join)
      (say knpc "都合がいいときに秘密について聞いてくだせえ、旦那。"
           "それまで絶対に逃げたりしやせん。")
      (join-player knpc)
      (give kpc t_arrow 20)
      (nate-caught! nate)
      (quest-data-update-with 'questentry-bandits 'captured-nate 1 (quest-notify nil))
      )
    (nate-met! nate)
    (cond ((nate-caught? nate)
           (say knpc "何でも言ってくだせえ。")
           )
          (else
           (say knpc "冒険者よ、俺が殺される理由はない。"
                "盗みはやった、でも人殺しはしてねえ。"
                "降伏されてくれ。そうすればすげえ秘密を教えてやる。"
                "どうだ？")
           (cond ((yes? kpc) (join))
                 (else
                  (say knpc "旦那！俺を殺せば秘密は俺と一緒に消えちまうんだ。"
                       "頼む、俺はあんたの仲間になって、あんたのために戦って、あんたを古き力のもとに導きたいんだ！"
                       "抜け出したりしねえ。"
                       "その後で俺をブタ箱に送るなり、逃がすなり好きなようにしてくれ。"
                       "どうだ？")
                  (cond ((yes? kpc) (join))
                        (else
                         (say knpc "降伏した奴を殺すなんて血も涙もない奴だ！")
                         (kern-conv-end)
                         ))))))))

(define (nate-secr knpc kpc)
  (cond ((is-player-party-member? knpc)
         (cond ((equal? (get-place knpc) p_shard)
                (say knpc "ブルンデガードの隠された入り口を教えしますぜ！"))
               (else
                (say knpc "旦那！ここは安全ではありませんぜ！荒野へ出てそれから話しやしょう。")
                )))
        (else
         (say knpc "ここなら秘密は安全だ。")
         )))

(define (nate-brun knpc kpc)
  (if (is-player-party-member? knpc)
      (say knpc "旦那、森の道を北に進んだ山の所でブルンデガードを探しやしょう。"
           "そこで合言葉を教えますぜ。")
      (say knpc "その言葉を言うな！")))

(define (nate-pass knpc kpc)
  (if (is-player-party-member? knpc)
      (cond ((equal? (get-place knpc) p_brundegardt)
             (say knpc "そう、ここだ。よく見つけやしたね旦那。合言葉は…"
                  "［彼は歯をかみ締めた］"
                  "…ノア。［彼はため息をついた。］合言葉はノアだ。")
             (prompt-for-key)
             (say knpc "旦那、お願いがありやす。"
                  "ずっと長い間、ブルンデガードに入る方法を探し、やっとのことで秘密を見つけやした。"
                  "一緒に連れて行ってくだせえ。そして生き延びやしょう。何なりと申し付けてくだせえ。"
                  "お願げえしやす。")
             (cond ((yes? kpc)
                    (say knpc "ご恩は一生忘れやせん！でもここは長いこと隠されていやした。"
                         "中に何がいるか分かりやせん。"
                         "松明、食料、鍵開け道具をできるだけ持って行きやしょう。")
                    (prompt-for-key)
                    (say knpc "でも、一番大切なのは、呪文を調合するための秘薬でやす。"
                         "旦那に魔術師の能力があればよいのでやすが。"
                         "この言葉を覚えていてくだせえ。「それを終えれば、それが必ず必要になる。」"))
                   (else
                    (say knpc "考えなおしてくだせえ。でも、もし俺を連れて行かねえのなら、"
                         "警告を聞いてくだせえ。"
                         "旦那のようなちょっとした戦士でも、一人でブルンデガードに入ってはいけやせん。"
                         "盗みや強奪の能力がある者を連れていくべきでやす。")
                    )))
             (else
              (say knpc "でも旦那！ここはブルンデガードではありやせん！")
              ))
      (say knpc "合言葉？何の合言葉だ？")
      ))

(define nate-conv
  (ifc basic-conv
       (method 'name (lambda (knpc kpc) (say knpc "ネイトと呼ばれている。")))
       (method 'brun nate-brun)
       (method 'hail nate-hail)
       (method 'pass nate-pass)
       (method 'secr nate-secr)
       ))

(define nate-greetings
  (list
   "降伏する！"
   "殺さないでくれ！"
   "捕まえてくれ！"
   "たのむ、牢屋に連れて行ってくれ！"
   ))

(define (nate-ai knpc)
  (let ((nate (kobj-gob-data knpc)))
    (cond ((nate-met? nate) (std-ai knpc))
          ((any-player-party-member-visible? knpc)
           (taunt knpc nil nate-greetings)
           #t)
          (else
           (std-ai knpc)
           )
          )))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-nate)
  (bind 
   (kern-char-arm-self
    (kern-mk-char 
     'ch_nate ;;..........tag
     "ネイト" ;;.......name
     sp_human ;;.....species
     oc_wrogue ;;.. .occupation
     s_companion_bard ;;..sprite
     faction-outlaw ;;..faction
     +1 ;;...........custom strength modifier
     0 ;;...........custom intelligence modifier
     +6 ;;...........custom dexterity modifier
     pc-hp-off ;;............custom base hp modifier
     pc-hp-gain ;;............custom hp multiplier (per-level)
     0 ;;............custom base mp modifier
     0 ;;............custom mp multiplier (per-level)
     max-health ;;..current hit points
     -1  ;;...........current experience points
     max-health ;;..current magic points
     0
     nate-start-lvl  ;;..current level
     #f ;;...........dead?
     'nate-conv ;;...conversation (optional)
     nil ;;sch_nate ;;.....schedule (optional)
     'nate-ai ;;..........custom ai (optional)

     ;;..............container (and contents)
     (mk-inventory
      (list
       (list 20 t_arrow)
       (list 1   t_bow)
       (list 1   t_dagger)
       (list 1   t_sword)
       (list 1   t_leather_helm)
       (list 1   t_armor_leather)
       (list 5   t_heal_potion)
       ))

     nil ;;.........readied arms (in addition to the container contents)
     nil ;;..........hooks in effect
     ))
   (nate-mk)))
