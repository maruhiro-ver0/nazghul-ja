;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; グラスドリン
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_stew
               (list 0  0  gv-bed       "sleeping")
               (list 7  0  ghg-s4       "eating")
               (list 8  0  gc-hall "idle")
               (list 12 0  ghg-s1       "eating")
               (list 13 0  gc-hall "idle")
               (list 18 0  ghg-s1       "eating")
               (list 19 0  gc-hall "idle")
               (list 20 0  gv-bed       "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (stew-mk) (list 'townsman #f))
(define (stew-met? stew) (cadr stew))
(define (stew-met! stew) (set-car! (cdr stew) #t))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ヴィクトリアはグラスドリンの一時的な指導者で、統治者の名を背負っている。
;;----------------------------------------------------------------------------

;; Basics...
(define (stew-hail knpc kpc)
  (if (not (stew-met? (kobj-gob-data knpc)))
      (begin
        (say knpc "［あなたは威厳の漂う女性と会った。］"
             "ようこそ、迷い人よ。あなたが来ることは聞いていました。")
        (stew-met! (kobj-gob-data knpc)))
      (say knpc "［あなたは威厳の漂う女性と会った。］"
           "また会いましたね、迷い人よ。")))

(define (stew-default knpc kpc)
  (say knpc "それは手助けできません。"))

(define (stew-name knpc kpc)
  (say knpc "私はヴィクトリア、グラスドリンの統治者です。"))

(define (stew-join knpc kpc)
  (say knpc "何と大胆な！"))

(define (stew-job knpc kpc)
  (say knpc "グラスドリンの統治者です。"))

(define (stew-bye knpc kpc)
  (say knpc "自らの道を進みなさい、迷い人よ。"))

;; Warritrix...
(define (stew-warr knpc kpc)
  (cond ((player-found-warritrix?)
      (if (ask? knpc kpc "彼女がこの世を去ったことは聞きました。私が何か関わったとは、もちろん考えていませんね？")
          (say knpc "当然です。うわさは無視しなさい。それは私の政敵が広めたものです。")
          (begin
            (say knpc "大胆にも私を訴えるのならば、中庭の石像を打ちなさい。"
                 "でも警告します。あなたは宿なしの風来坊、そして私はこの地で最も力のある町の支配者なのです。"
                 "それは私とあなたの言葉も同じ。そして偽りの告発人は厳しく罰せられるでしょう。")
            (aside kpc 'ch_ini "迷いなどない。裏切り者の魔女よ、我々はあなたを訴える。"
                   "あなた以上の言葉でもって。")
            )
          ))
      ((quest-data-assigned? 'questentry-wise)
		(say knpc "しばらく会っておりません。何かの任務の遂行中と思います。")
		(quest-data-update 'questentry-warritrix 'assignment 1)
		)
	(else
		(say knpc "我らの最も優れた戦士です。今は警備に出ていると思います。")
		 (quest-data-update 'questentry-warritrix 'general-loc 1)
		 )
      ))

(define (stew-erra knpc kpc)
  (say knpc "ジェフリーズ司令官に聞いてください。彼なら詳しいことを知っているはずです。"))

;; Steward...
(define (stew-stew knpc kpc)
  (say knpc "グラスドリンは選出された統治者によって治められています。"
       "その責務は町と領土を守ることにあります。"))

(define (stew-real knpc kpc)
  (say knpc "グラスドリンの領土は、西の湿地帯から南東の森までです。"
       "地上と地下の維持も行っています。"))

;; Rune...
(define (stew-rune knpc kpc)
	(if (quest-data-assigned? 'questentry-wise)
		(say knpc "闘士は石版を首に掛けていました…います。"
			"でも、何が書かれているのかは知りません。")
		(say knpc "闘士は石版を首に掛けています。"
			"でも、何が書かれているのかは知りません。")
		)
       (quest-data-assign-once 'questentry-rune-l)
       )

(define (stew-wore knpc kpc)
	(if (quest-data-assigned? 'questentry-wise)
		(say knpc "何が言いたいのです？少し言い間違えただけです。")
		(stew-default knpc kpc)
	))

;; Absalot...
(define (stew-absa knpc kpc)
  (say knpc "アブサロットはこの地の病で、"
       "悪が広がる前に完全に取り除かなければなりませんでした。"
       "この決断については理解していただけますね？")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "罪のない人まで命を落としたことは悲劇です。"
           "しかし、その犠牲なしに戦うことはできないのです。")
      (say knpc "あなたに何がわかるというのですか？"
           "あなたはただのならず者でしょう。")))

(define (stew-inno knpc kpc)
  (say knpc "アブサロットの全ての者が邪悪だったわけではありません。"
       "しかし邪悪さの中にあり、それに対し寛大でした。"))

(define (stew-wick knpc kpc)
  (say knpc "アブサロットの人々は人間の生贄や悪魔崇拝を行っていました。"
       "そして他の町…この町にも改宗者が現れ始めました。"))

(define (stew-conv knpc kpc)
  (say knpc "そのことを知ったとき、彼らを火刑にしました。"
       "私は賢者や他の町の指導者たちと会い、どうするのか決めました。")
  (prompt-for-key)
  (say knpc "賢者の中の何人かは躊躇しました。しかし、"
       "私たちは彼らの反対意見を却下し、連合軍を結成しました。"
       "そしてアブサロットに進軍し、二度と再建できぬよう破壊し通路を封鎖したのです。"))

(define (stew-wise knpc kpc)
  (say knpc "賢者は町の指導者を援助していますが、一人では小さな力しかありません。"
       "かつて私たちに反対した魔道師でさえ、グラスドリンの力には抵抗できませんでした。")
       (quest-wise-subinit 'questentry-enchanter)
       )

(define (stew-rogu knpc kpc)
  (say knpc "あなたはどこから来たのですか？我々の地での目的は？"
       "もしや異国の軍隊の斥侯では？")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "ううむ。もしあなたの言うことが本当なら、尋問者の中に投げ込み、"
           "拷問にかけ全てを吐き出させるでしょう。"
           "しかし、実際には誇大妄想を抱えた愚かな目立ちたがり屋でしょう。"
           "迷い人よ、無から出でたように無に消えなさい。")
      (say knpc "ええ。あなたは偶然ここに来たただの風来坊でしょう。"
           "いずれにせよ、迷い人よ、あなたには注意すべきです。"
           "この町に背くようなことがあれば、拷問者の手によって私の怒りを知ることでしょう。"))
  (kern-conv-end))

;; Townspeople...
(define (stew-glas knpc kpc)
  (say knpc "グラスドリンは暗闇の中にある導きの光です。"
       "聖騎士たちはこの領土の正義のために身をささげ、闇を押し戻しています。"
       "半島の人々はこの町の恩恵にあずかっています。"))

(define (stew-unde knpc kpc)
  (say knpc "地下世界は日のあたらない怪物の生まれる場所です。"
       "私には全てにとって脅威である悪しき者たちを一掃する義務があります。"))

(define stew-conv
  (ifc glasdrin-conv

       ;; basics
       (method 'default stew-default)
       (method 'hail stew-hail)
       (method 'bye  stew-bye)
       (method 'job  stew-job)
       (method 'name stew-name)
       (method 'join stew-join)

       (method 'city stew-glas)
       (method 'town stew-glas)
       (method 'glas stew-glas)
       (method 'warr stew-warr)
       (method 'erra stew-erra)
       (method 'stew stew-stew)
       (method 'real stew-real)
       (method 'absa stew-absa)
       (method 'wore stew-wore)
       (method 'rune stew-rune)
       (method 'inno stew-inno)
       (method 'wick stew-wick)
       (method 'conv stew-conv)
       (method 'wise stew-wise)
       (method 'rogu stew-rogu)
       (method 'wrog stew-rogu)
       (method 'unde stew-unde)
       ))

(define (mk-steward)
  (bind 
   (kern-char-force-drop
    (kern-mk-char 'ch_steward         ; tag
                  "ヴィクトリア"      ; name
                  sp_human            ; species
                  nil                 ; occ
                  s_lady              ; sprite
                  faction-glasdrin         ; starting alignment
                  1 3 0               ; str/int/dex
                  0 0                 ; hp mod/mult
                  0 0                 ; mp mod/mult
                  max-health -1 max-health 0 6  ; hp/xp/mp/AP_per_turn/lvl
                  #f                  ; dead
                  'stew-conv          ; conv
                  sch_stew            ; sched
                  'townsman-ai                 ; special ai
                  (mk-inventory (list (list 1 t_sword_4)
                                      (list 1 t_stewardess_chest_key)
                                      ))    ; container
                  nil                 ; readied
                  )
    #t)
   (stew-mk)))
