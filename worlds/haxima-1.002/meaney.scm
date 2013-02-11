;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define meaney-lvl 6)
(define meaney-species sp_human)
(define meaney-occ nil)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; オパーリンの近くの救貧院
;;----------------------------------------------------------------------------
(define meaney-bed poorh-bed1)
(define meaney-mealplace poorh-sup1)
(define meaney-workplace poorh-hall)
(define meaney-leisureplace poorh-dining)
(kern-mk-sched 'sch_meaney
               (list 0  0 meaney-bed          "sleeping")
               (list 5  0 meaney-mealplace    "eating")
               (list 6  0 meaney-workplace    "working")
               (list 12 0 meaney-mealplace    "eating")
               (list 13 0 meaney-workplace    "working")
               (list 18 0 meaney-mealplace    "eating")
               (list 19 0 meaney-leisureplace "idle")
               (list 21 0 meaney-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (meaney-mk) (list 0 #t))
(define (meaney-get-donated meaney) (car meaney))
(define (meaney-donated? meaney) (> (meaney-get-donated meaney) 
                                    0))
(define (meaney-donate! meaney q) (set-car! meaney (+ (car meaney) q)))
(define (meaney-has-ring meaney) (cadr meaney))
(define (meaney-remove-ring meaney) (set-car! (cdr meaney) #f))

(define (meaney-on-death knpc)
	(if  (meaney-has-ring (kobj-gob-data knpc))
		(kern-obj-put-at (kern-mk-obj t_skull_ring_m 1) (kern-obj-get-location knpc))
	))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ミーニーは十字路教団の僧侶で、オパーリンの近くの救貧院に住んでいる。
;; 彼はかつて慈悲深い死号の乗組員の海賊だった。
;; そして亡霊となったガーティ船長に復讐のため追われている。
;;----------------------------------------------------------------------------

;; 基本
(define (meaney-hail knpc kpc)
  (say knpc "あなたを歓迎します。旅の方。"))

(define (meaney-default knpc kpc)
  (say knpc "それはお手伝いできません。"))

(define (meaney-name knpc kpc)
  (say knpc "修道僧のミーニーです。")
  (quest-data-update 'questentry-ghertie 'meaney-loc 1))

(define (meaney-join knpc kpc)
  (say knpc "私には貧しい者と怪我をした者への義務があります。"))

(define (meaney-job knpc kpc)
  (say knpc "この救貧院で"
       "病の者、貧しい者のために働いています。"))

(define (meaney-bye knpc kpc)
  (say knpc "さようなら。"))

;; Second-tier responses
(define (meaney-get-donation knpc kpc)
  (define (rejected)
    (cond ((> (kern-player-get-gold) 0)
           (say knpc "そうですが。ではまたのときに。［彼は悲しそうに背を向けた。］")
           (kern-conv-end))
          (else
           (say knpc "あなたも必要かもしれません。"))))
  (let ((meaney (kobj-gob-data knpc)))
    (if (not (meaney-donated? meaney))
        (begin
          (say knpc "貧しい者のため寄付をお願いできますか？")
          (if (kern-conv-get-yes-no? kpc)
              (let ((q (get-gold-donation knpc kpc)))
                (if (> q 0)
                    (begin
                      (say knpc "旅の方に祝福あれ！"
                           "あなたの行いは記憶されるでしょう。")
                      (meaney-donate! meaney q))
                    (rejected)))
              (rejected))))))

(define (meaney-poor knpc kpc)
  (say knpc "この救貧院では未亡人と孤児を支援しています。"
       "あなたは助けが必要ですか？")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "ならば喜んで食料を少し分け与えましょう。")
      (meaney-get-donation knpc kpc)))

(define (meaney-sick knpc kpc)
  (say knpc "ここに来た者は必要ならば誰でも治療します。治療が必要ですか？")
  (if (kern-conv-get-yes-no? kpc)
      (meaney-trade knpc kpc)
      (meaney-get-donation knpc kpc)))

(define (meaney-brot knpc kpc)
  (say knpc "私は十字路教団の僧侶です。"
       "この教団は迷い人のデービスにより、7世紀以上前に貧しい人々を救うために設立されました。"))

;; Trade...
(define (meaney-trade knpc kpc)
  (if (trade-services knpc kpc
                      (list
                       (svc-mk "体力回復" 0 heal-service)
                       (svc-mk "治癒" 0 cure-service)
                       ))
      (begin
        (say knpc "他に治療が必要な人はいますか？")
        (meaney-trade knpc kpc))
      (begin
        (say knpc "他に何か必要ですか？")
        (if (kern-conv-get-yes-no? kpc)
            (meaney-trade knpc kpc)
            (meaney-get-donation knpc kpc)))))

;; Town & Townspeople

;; Quest-related
(define (meaney-pira knpc kpc)
	(quest-data-update 'questentry-ghertie 'meaney-loc 1)
	(say knpc "そう。私はかつては海賊でした。ずっと昔のことです。"
		"おっかさんのガーティーと共に慈悲深い死号に乗っていました。"
		"今はその償いとして貧しい人たちに人生を捧げています。"))

(define (meaney-gher knpc kpc)
  (say knpc "ガーティーは私たち手下を家族のようにあつかってくれました。"
       "同時に容赦ない略奪者で、紛れもない悪党でもありました。"
       "彼女は死ぬべきだったでしょう。"
       "しかし、それは彼女の息子たちによってなされるべきではありませんでした。"))

(define (meaney-pena knpc kpc)
  (say knpc "私は数多くの罪を犯し、そしてたくさんの人の血を流しました。"
       "私は船長を裏切り、そして逆に裏切られました。"))

(define (meaney-betr knpc kpc)
  (say knpc "手下全員で共謀し船長を殺し、奪ったものを分けました。"
       "自分たちがそうしなければ、彼女は自分たち全員を殺すだろうと思い込んでいたのです。"
       "最初の友、料理人、そして私は酒を飲んで横になっている間に彼女を殺害しました。"
       "しかし船着場に戻ってみると、船は私たちを置いて行ってしまったのです。"))

(define (meaney-firs knpc kpc)
  (say knpc "最初の友はジョーンという名の悪党です。"
       "今でも東の広大な森のどこかで盗賊をやっていると聞きました。"
       "緑の塔で聞けばよいかもしれません。")
       (quest-data-update 'questentry-ghertie 'jorn-forest 1))

(define (meaney-cook knpc kpc)
  (say knpc "ゴレットは死んだか、どこかの牢獄に放り込まれているでしょう。"
       "最後に会ったのは真夜中にここを訪れたときでした。"
       "次の朝、目が覚めると募金箱の鍵が壊されていました。"
       "もちろん箱の中は空でした。")
       (quest-data-update 'questentry-ghertie 'gholet-prison 1)
       )

(define (meaney-ring knpc kpc)
  (if (not (meaney-has-ring (kobj-gob-data knpc)))
      (say knpc "もうその呪われた指輪は見たくないものです。")
      (begin
        (say knpc "はい。私はガーティーの息子、慈悲深い死号の指輪をつけています。"
             "そう、私は人殺しの海賊なのです。")
        (prompt-for-key)
        (say knpc "言い伝えによるとこの地に来た迷い人のルトは、その剣によって正義を施したそうです。"
              "私を断罪してくれますか？")
        (if (yes? kpc)
            (begin
              (say knpc "その剣で行ってください。覚悟はできています。［彼は頭を下げた。］")
              (kern-conv-end))
            (begin
              (say knpc "あなたは慈悲深い方だ。"
                    "しかし、今がこの指輪と別れるとき、そのためにはこの指と別れなければなりません。"
                    "私にはこの指を切り落とす勇気はありません。あなたがやってくれますか？")
              (if (yes? kpc)
                  (begin
                    (say knpc "［あなたは彼の手をつかみ、素早く指を切り落とした。］"
                          "あああっ！これで私は呪いから解き放たれました。"
                          "ありがとうございます、迷い人。"
                          "もし何か助けや治療が必要なら、私はあなたのために行います。")
			(skullring-m-get nil kpc)
			(meaney-remove-ring (kobj-gob-data knpc))
                    )
                  (say knpc "私はこの悪しきものから解放されたいのです！")))))))

(define meaney-conv
  (ifc basic-conv

       ;; basics
       (method 'default meaney-default)
       (method 'hail meaney-hail)
       (method 'bye  meaney-bye)
       (method 'job  meaney-job)
       (method 'name meaney-name)
       (method 'join meaney-join)
       
       ;; trade
       (method 'trad meaney-trade)
       (method 'buy  meaney-trade)
       (method 'sell meaney-trade)

       ;; town & people

       ;; other responses
       (method 'poor meaney-poor)
       (method 'dest meaney-poor)
       (method 'sick meaney-sick)
       (method 'heal meaney-sick)
       (method 'affl meaney-sick)
       (method 'brot meaney-brot)
       (method 'hous meaney-job)

       ;; pirate quest replies
       (method 'pira meaney-pira)
       (method 'gher meaney-gher)
       ;(method 'ma   meaney-gher)
       (method 'capt meaney-gher)
       (method 'pena meaney-pena)
       (method 'betr meaney-betr)
       (method 'firs meaney-firs)
       (method 'cook meaney-cook)
       (method 'ring meaney-ring)
       (method 'skul meaney-ring)
       (method 'ghol meaney-cook)
       (method 'jorn meaney-firs)
       ))

(define (mk-meaney)
	(let ((knpc
    (kern-mk-char 
     'ch_meaney           ; tag
     "ミーニー"           ; name
     meaney-species         ; species
     meaney-occ              ; occ
     s_companion_shepherd  ; sprite
     faction-men      ; starting alignment
     1 2 1            ; str/int/dex
     0 0              ; hp mod/mult
     0 0              ; mp mod/mult
     max-health ; hp
     -1                   ; xp
     max-health ; mp
     0
     meaney-lvl
     #f               ; dead
     'meaney-conv         ; conv
     sch_meaney           ; sched
     'townsman-ai              ; special ai

     ;;..........container (and contents)
     (mk-inventory
      (list
       (list 1 t_dagger)
       ))
     nil              ; readied
     )))
 (kern-char-force-drop knpc #t)
  (bind knpc (meaney-mk))
  (kern-obj-add-effect knpc 
           ef_generic_death
           'meaney-on-death)
	  knpc) )
  