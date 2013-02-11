;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define edward-start-lvl 4)

;;----------------------------------------------------------------------------
;; Schedule
;;
;; 緑の塔の地下
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_edward
               (list 0  0  gtl-jailor-bed "sleeping")
               (list 7  0  gtl-jail       "working" )
               (list 21 0  gtl-jailor-bed "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (edward-mk) (list #f #f))
(define (edward-met? gob) (car gob))
(define (edward-meet! gob) (set-car! gob #t))
(define (edward-has-nate? gob) (cadr gob))
(define (edward-has-nate! gob) (set-car! (cdr gob) #t))

;;----------------------------------------------------------------------------
;; Conv
;;
;; エドワードは盲目の老人で、緑の塔の地下で看守の仕事をしている。
;;----------------------------------------------------------------------------
(define (edward-hail knpc kpc)
  (meet "あなたは色白で目の濁った老人と会った。")
  (let ((edward (kobj-gob-data knpc)))
    (cond ((not (edward-met? edward))
           (say knpc "誰かいるのか？名乗れ！")
           (reply? kpc)
           (edward-meet! edward)
           (say knpc "知らないやつだ。脱獄したのか？")
           (if (yes? kpc)
               (say knpc "さっさと行け！あんたを止めるには年を取りすぎている。")
               (say knpc "安心した。誰も話す相手がいないのでね。")
               )
           )
          (else
           (say knpc "また来たね。足音でわかったよ。")
           ))))

(define (edward-give-nate knpc kpc)
  (say knpc "囚人を連れてきたのか？")
  (cond ((yes? kpc)
         (cond ((is-only-living-party-member? ch_nate)
                (say knpc "もしそうしたいなら、自首しなさい。"
                     "だが、その死体を何とかしてからだ！"
                     "ここは死体置き場ではない。")
                )
               (else
                (say knpc "おお、そうか。仲間が増えたわい。［彼はネイトを引き取り、独房に入れ鍵をかけた。］")
                (kern-char-leave-player ch_nate)
                (kern-obj-relocate ch_nate (mk-loc p_green_tower_lower 9 10) nil)
                (prompt-for-key)
                (say knpc "これが証明書だ。隊長に渡しなさい。")
                (give (kern-get-player) t_prisoner_receipt 1)
                (edward-has-nate! (kobj-gob-data knpc))
                (quest-data-update-with 'questentry-bandits 'nate-given-to-jailor 1 (quest-notify nil))                
                )))
        (else
         (say knpc "そうかい。［彼はネイトの方を向き、肩をすくめた。］")
         )))

(define (edward-pris knpc kpc)
  (cond ((in-player-party? 'ch_nate) (edward-give-nate knpc kpc))
        (else
         (let ((edward (kobj-gob-data knpc)))
           (if (edward-has-nate? edward)
               (say knpc "今は森ゴブリンと、あんたが連れてきた奴がいる。")
               (say knpc "最近森ゴブリンが入った。"
                    "やつとは互いに理解しあえないが、だからといって話をしないわけではない。"))))
        ))

(define (edward-gobl knpc kpc)
  (say knpc "恐ろしいことはない。やつらは危害を加えない。"))

(define (edward-stor knpc kpc)
  (say knpc "木霊について聞いたことがあるか？")
  (cond ((no? kpc)
         (say knpc "木霊はかつてこの森に現れた。"
              "門が開き、神々が崇められていた昔のことだ。")
         (prompt-for-key kpc)
         (say knpc "ある日美しい乙女がこの森に一人で迷い込んだとき、"
              "木霊は顔立ちのよい森人として姿を現した。"
              "娘は森の奥へと誘い込まれ、ついに木になってしまった。")
         (prompt-for-key kpc)
         (say knpc "それがこの広大な彼の森の始まりだ。"
              "そして今でも多くの幽霊のような木々がある理由だ。")
         )
        (else
         (say knpc "木霊とは何なのか、誰も知らない。"
              "他の神々と同じような伝説だろう。")
         )))

(define (edward-gate knpc kpc)
  (say knpc "門のことはわからない。かつてそれはあった、知っているのはそれだけだ。"))

(define (edward-gods knpc kpc)
  (say knpc "古き神々の話をするのはよくない。"
       "それを聞かれると呪われると言われている。"))

(define (edward-accu knpc kpc)
  (say knpc "古き神々の呪われた力……"
       "この牢獄にもそれはある。"))

(define (edward-talk knpc kpc)
  (say knpc "ここでは囚人しか話す相手がいない。"))

(define (edward-blin knpc kpc)
  (say knpc "暗闇は何でもない。さらに言えば光も何でもない。"
       "どちらも同じことだ。"))

(define (edward-guar knpc kpc)
  (say knpc "正直に言うと、捕まえられるとは思えない。"))

(define (edward-jail knpc kpc)
  (cond ((in-player-party? 'ch_nate) (edward-give-nate knpc kpc))
        (else
         (say knpc "囚人に食事を与え、話しをする。"
              "やつらが逃げるのを防ぐ役目もある。")
         )))

(define edward-conv
  (ifc ranger-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default 
               (lambda (knpc kpc) 
                 (say knpc "［彼は肩をすくめた。］")))
       (method 'hail edward-hail)
       (method 'bye 
               (lambda (knpc kpc) 
                 (say knpc "暗いから気をつけて！")))
       (method 'job 
               (lambda (knpc kpc) 
                 (say knpc "看守だ。")))
       (method 'name 
               (lambda (knpc kpc) 
                 (say knpc "エドワードだ。あんたの名前は聞いている。")))
       (method 'join 
               (lambda (knpc kpc) 
                 (say knpc "そうしたいね。［だができない。］")))
       (method 'accu edward-accu)
       (method 'blin edward-blin)
       (method 'esca edward-guar)
       (method 'gate edward-gate)
       (method 'gobl edward-gobl)
       (method 'god  edward-gods)
       (method 'gods edward-gods)
       (method 'guar edward-guar)
       (method 'jail edward-jail)
       (method 'old  edward-gods)
       (method 'pris edward-pris)
       (method 'stor edward-stor)
       (method 'talk edward-talk)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-edward)
  (bind 
   (kern-char-arm-self
    (kern-mk-char 
     'ch_edward ;;..........tag
     "エドワード" ;;.......name
     sp_human ;;.....species
     oc_ranger ;;.. .occupation
     s_old_townsman ;;..sprite
     faction-men ;;..faction
     0 ;;...........custom strength modifier
     0 ;;...........custom intelligence modifier
     0 ;;...........custom dexterity modifier
     0 ;;............custom base hp modifier
     0 ;;............custom hp multiplier (per-level)
     0 ;;............custom base mp modifier
     0 ;;............custom mp multiplier (per-level)
     max-health ;;..current hit points
     -1  ;;...........current experience points
     max-health ;;..current magic points
     0
     edward-start-lvl  ;;..current level
     #f ;;...........dead?
     'edward-conv ;;...conversation (optional)
     sch_edward ;;.....schedule (optional)
     'townsman-ai ;;..........custom ai (optional)

     ;;..............container (and contents)
     (mk-inventory
      (list
       (list 1 t_torch)
       (list 1 t_dagger)
       ))
     (list t_armor_leather)                ; readied ;;.........readied arms (in addition to the container contents)
     nil ;;..........hooks in effect
     ))
   (edward-mk)))
