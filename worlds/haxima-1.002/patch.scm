;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; グラスドリン
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_patch
               (list 0  0  gdp-bed "sleeping")
               (list 7  0  ghg-s1  "eating")
               (list 8  0  gh-ward "working")
               (list 11 0  ghg-s1  "eating")
               (list 12 0  gh-ward "working")
               (list 17 0  ghg-s1  "eating")
               (list 18 0  gc-hall "idle")
               (list 21 0  gdp-hut "idle")
               (list 22 0  gdp-bed "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (patch-mk) (list 'townsman))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; グラスドリンに住む老人の魔術師で、医師として働いている。
;; 彼は眼帯をしていて、「眼帯の先生」として知られている。
;;----------------------------------------------------------------------------

;; Basics...
(define (patch-hail knpc kpc)
  (say knpc "［あなたは眼帯をした元気な魔術師の老人と会った。］"
       "こんにちは、旅の方。"))

(define (patch-default knpc kpc)
  (say knpc "それは手助けできないな。"))

(define (patch-name knpc kpc)
  (say knpc "人々は私を眼帯の先生と呼んでいる。"))

(define (patch-join knpc kpc)
  (say knpc "いいや。ここにいるのが私の務めだ、迷い人よ。"))

(define (patch-job knpc kpc)
  (say knpc "この病院で働いている。治療が必要かね？")
  (if (kern-conv-get-yes-no? kpc)
      (patch-trade knpc kpc)
      (say knpc "必要なときに治療しよう。")))

(define (patch-bye knpc kpc)
  (say knpc "おだいじに！"))

;; Trade...
(define (patch-trade knpc kpc)
  (if (trade-services knpc kpc
                      (list
                       (svc-mk "回復" 30 heal-service)
                       (svc-mk "治癒" 30 cure-service)
                       (svc-mk "蘇生" 100 resurrect-service)))
      (begin
        (say knpc "他に何かすることがあるかね？")
        (patch-trade knpc kpc))
      (begin
        (say knpc "他に何かあるかね？")
        (if (kern-conv-get-yes-no? kpc)
            (patch-trade knpc kpc)
            (say knpc "よろしい。")))))
  
;; Patch...
(define (patch-patc knpc kpc)
  (say knpc "クロポリスで片目を失った。そこはとても暗いので本当は必要なかったのだ。"
       "［彼は見えるほうの目をウィンクした。］"))

(define (patch-kurp knpc kpc)
  (say knpc "聖騎士は迷宮の前線を守っている。"
       "そして、若いころ兵役に就いていたときは、そこにいたのだ。"))

(define (patch-tour knpc kpc)
  (say knpc "全てのグラスドリンの市民は兵役の義務がある。"
       "私は医師だった。"))

(define (patch-medi knpc kpc)
  (say knpc "医師は治療の技術に長けた魔術師だ。"
       "全ての聖騎士の部隊には戦いを支援するため医師が加わっている。"
       "戦闘の基礎訓練も受ける。しかし私は短剣を一度使っただけだ。"))

(define (patch-dagg knpc kpc)
  (say knpc "そうだ。短剣を六ヶ月持ち歩き、ついにそれを使った…。"
       "炊事の番でイモの皮を剥いたのだ。"))

(define (patch-dung knpc kpc)
  (say knpc "怪物たちは深淵で生まれる。奴らが地上に来る前に止めなければならない。"
       "そう思うだろう？")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "その通り！だから聖騎士はそこに部隊を置き、中間を警備しているのだ。"
           "迷宮で助けが必要なら彼らを探しなさい。部隊には医師がいる。")
      (say knpc "ゴホン！彼らが怒り田舎に帰ってしまうぞ！")))

(define (patch-doc knpc kpc)
  (say knpc "私は医師だ。治療が必要かね？")
  (if (kern-conv-get-yes-no? kpc)
      (patch-trade knpc kpc)
      (say knpc "よろしい。助けが必要になったらこの病院に来なさい。"
           "君のような冒険者は戦いでどれだけボロボロになるか、私は知っている！")))

(define (patch-hosp knpc kpc)
  (say knpc "そうだ。グラスドリンの聖騎士は常に戦っている。"
       "突然来る冒険者や村の病気の者も診る。"))

;; Townspeople...

(define patch-conv
  (ifc glasdrin-conv

       ;; basics
       (method 'default patch-default)
       (method 'hail patch-hail)
       (method 'bye  patch-bye)
       (method 'job  patch-job)
       (method 'name patch-name)
       (method 'join patch-join)
       
       ;; trade
       (method 'trad patch-trade)
       (method 'heal patch-trade)
       (method 'cure patch-trade)
       (method 'resu patch-trade)
       (method 'help patch-trade)

       ;; patch
       (method 'patc patch-patc)
       (method 'kurp patch-kurp)
       (method 'tour patch-tour)
       (method 'medi patch-medi)
       (method 'dagg patch-dagg)
       (method 'dung patch-dung)
       (method 'doc  patch-doc)
       (method 'hosp patch-hosp)
       (method 'outp patch-dung)

       ;; town & people

       ))

(define (mk-patch)
  (bind 
   (kern-mk-char 'ch_patch           ; tag
                 "眼帯"              ; name
                 sp_human            ; species
                 oc_wizard           ; occ
                 s_companion_wizard  ; sprite
                 faction-glasdrin         ; starting alignment
                 1 3 0               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 6            ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'patch-conv         ; conv
                 sch_patch           ; sched
                 'townsman-ai                 ; special ai
                 (mk-inventory (list (list 1 t_staff)))                 ; container
                 (list t_dagger)                 ; readied
                 )
   (patch-mk)))
