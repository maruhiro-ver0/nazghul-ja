;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define kathryn-start-lvl  6)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; In Bole.
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_kathryn
               (list 0  0  bole-bed-kathryn "sleeping")
               (list 9  0  bole-table-1 "eating")
               (list 10 0  bole-courtyard   "idle")
               (list 12 0  bole-table-1 "eating")
               (list 13 0  bole-dining-hall "idle")
               (list 18 0  bole-table-1 "eating")
               (list 19 0  bole-dining-hall "idle")
               (list 23 0  bole-bed-kathryn "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (kathryn-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; キャスリンは強欲な女性の魔術師で、魔道師から力の石版を盗むことを契約した泥
;; 棒(ネズミ)からそれを取り戻すためボレにいる。…確実に魔道師は何も話していな
;; い。
;; 彼女は口がうまく、冷酷である。
;; 
;; キャスリンは仲間になる(そして最後には裏切る)。
;; 彼女には荒々しいドンがついていて、彼女が仲間になれば彼も仲間になる。
;;----------------------------------------------------------------------------
(define (kathryn-hail knpc kpc)
  (say knpc "［あなたを軽蔑の目で見るきれいな女性と会った。］はい？"))

(define (kathryn-default knpc kpc)
  (say knpc "［彼女はあなたをわざと無視した。］"))

(define (kathryn-name knpc kpc)
  (say knpc "よそ者には名前を言わないようにしているの。"
       "それより、知りたいことがあれば別の奴にききなさいよ。"
       "家畜がたくさんいる辺りの…。"))

(define (kathryn-join knpc kpc)
  (say knpc "［彼女はむせるほど笑った。］"))

(define (kathryn-job knpc kpc)
  (say knpc "［あざ笑いながら］修道女よ。金貨500枚でご奉仕しましょうか？"))


(define (kathryn-blowjob knpc kpc)
  (say knpc "嫌味よ。さっさと消えなさい。"))

(define (kathryn-clients knpc kpc)
  (say knpc "私の客は名前を明かさないものよ。"
       "ただ一つ知っておくべきなのは、彼らを怒らせてはならないということよ。"))

(define (kathryn-things knpc kpc)
  (say knpc "あなたのような人にはわからないモノよ。"))

(define (kathryn-thief knpc kpc)
  (say knpc "［彼女は狡猾な目であなたを見た。］なるほどね。もしかすると協力し合えるかもしれない。"
       "ここへは客の代わりに名前を明かさない売人からモノを仕入れるために来たの。"))

(define (kathryn-seller knpc kpc)
  (say knpc "モノが盗まれたとわかったときのショックを想像してみて！"
        "金と引き換えにモノを要求したら、すぐに目の前から消えたのよ！"))

(define (kathryn-vanish knpc kpc)
  (say knpc "パッと！いなくなった！透明の指輪を持っていたに違いない。"
       "ドンと一緒にそこらじゅうを探したわ。"))

(define (kathryn-search knpc kpc)
  (define (do-join)
    (say knpc "すばらしい！このあたりで泥棒について何か知っているか聞いてみましょう。")
    (if (in-inventory? knpc t_wis_quas_scroll)
        (begin
          (say knpc "ああ、この巻物はきっと役に立つわ。"
               "持っておいて。この魔法の奴はよくわからないけど。")
          (kern-obj-remove-from-inventory knpc t_wis_quas_scroll 1)
          (kern-obj-add-to-inventory kpc t_wis_quas_scroll 1)))
    (kern-char-join-player knpc)
    (if (and (defined? 'ch_thud)
             (is-alive? ch_thud))
        (begin
          (say knpc "親戚のドンも加わっていいかしら。"
               "こいつはガキみたいなもので、私がいないとどうしようもないから。")
          (kern-char-join-player ch_thud)))
    (kern-conv-end))
  (say knpc "私たちの目的は同じようね。手を組んで悪党を捕まえてモノを取り返しましょう。"
       "報酬は出すわ。"
       "もしモノを取り戻せれば、私とドンには十分な額になるの。"
       "どう？タフな方。仲間に加わらない？")
  (if (kern-conv-get-yes-no? kpc)
      (do-join)
      (begin
        (say knpc "［彼女は動揺した。］ああ、どうか助けて！"
             "私のボスは強くて乱暴なの！"
             "もし探しているモノが取り返せなければ、一生隠れて生きていかなければならない！"
             "どうか仲間に加わって？")
        (if (kern-conv-get-yes-no? kpc)
            (do-join)
            (begin
              (say knpc "［彼女は唇とまつげを近づけた。］"
                   "ええ、タフな方。あなたの勝ちよ。くだらないモノはどうでもいい。"
                   "あなた以外にはいないのよ。一緒に探しましょう。"
                   "どうかお願い。お願いします…。")
              (if (kern-conv-get-yes-no? kpc)
                  (do-join)
                  (say knpc "［彼女は怒りで顔を赤くし、金切り声を上げた。］バカ！"
                       "解決する方法がないくせに！"
                       "あなたが探しているのは、この地で最も暗き魔術師が睨んでいる物なのよ！"
                       "泥棒を捕まえて永遠の苦痛を与えてやるわ！"
                       "あなたは関わらないほうが身のためよ！")
                  (kern-conv-end)))))))

(define (kathryn-tavern knpc kpc)
  (say knpc "いい所よ。あなたがゴキブリならね。"))

(define (kathryn-companion knpc kpc)
  (say knpc "ドン？私の…親戚よ。"))

(define (kathryn-cousin knpc kpc)
  (say knpc "遠い親戚。"))

(define (kathryn-bill knpc kpc)
  (say knpc "あの村のバカ？きっと森で道具を使うために出て行ったのでしょう。"
       "一緒に行ってきたら？"))

(define (kathryn-hackle knpc kpc)
  (say knpc "あのイカレた雌狐？小川が交差する所にいる？"
       "あの醜さは治らないでしょうね。残念だけど。"))

(define (kathryn-may knpc kpc)
  (say knpc "宿屋の？詮索好きのババアよ。あなたは金を持ってなさそうだけど、"
       "もし持っていれば、寝るときは枕の下に隠しておくことね。"))

(define (kathryn-melvin knpc kpc)
  (say knpc "料理人の？汚い飲んだくれの年寄りよ。"))

(define (kathryn-sorceress knpc kpc)
  (say knpc "［彼女は驚いたふりをして手で口を覆った。］ああ！私の小さな汚れた秘密に気づいたわね！"
       "消えうせなさい。さもないと松明のように燃やすわよ。"))

(define (kathryn-scro knpc kpc)
  (if (is-player-party-member? knpc)
      (say knpc "持っているのはあなたにあげた一枚だけよ。"
           "どこで手に入るのかもわからないわ！")
      (say knpc "巻物？［彼女は笑った。］私のポケットに手を入れてみる？"
           "自分の心配をしなさいよ。")))


(define kathryn-conv
  (ifc nil
       (method 'default kathryn-default)
       (method 'hail kathryn-hail)
       (method 'bye  (lambda (knpc kpc) (say knpc "清々したわ。")))
       (method 'job  kathryn-job)
       (method 'name kathryn-name)
       (method 'join kathryn-join)

       (method 'blow kathryn-blowjob)
       (method 'bill kathryn-bill)
       (method 'clie kathryn-clients)
       (method 'comp kathryn-companion)
       (method 'cous kathryn-cousin)
       (method 'fait kathryn-seller)
       (method 'hack kathryn-hackle)
       (method 'item kathryn-seller)
       (method 'inn  kathryn-tavern)
       (method 'may  kathryn-may)
       (method 'meet kathryn-thief)
       (method 'melv kathryn-melvin)
       (method 'nun  kathryn-blowjob)
       (method 'ring kathryn-search)
       (method 'sear kathryn-search)
       (method 'sell kathryn-seller)
       (method 'sorc kathryn-sorceress)
       (method 'witc kathryn-sorceress)
       (method 'tave kathryn-tavern)
       (method 'thud kathryn-companion)
       (method 'thie kathryn-thief)
       (method 'vani kathryn-vanish)
       (method 'vill kathryn-search)
       (method 'scro kathryn-scro)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-kathryn)
  (bind 
   (kern-char-force-drop
    (kern-char-arm-self
     (kern-mk-char 
      'ch_kathryn ;;..tag
      "キャスリン" ;;....name
      sp_human ;;.....species
      oc_wizard ;;....occupation
      s_wizard ;;.....sprite
      faction-men ;;..faction
      0 ;;............custom strength modifier
      4 ;;............custom intelligence modifier
      0 ;;............custom dexterity modifier
      2 ;;............custom base hp modifier
      1 ;;............custom hp multiplier (per-level)
      4 ;;............custom base mp modifier
      2 ;;............custom mp multiplier (per-level)
      max-health ;; current hit points
      -1  ;;...........current experience points
      max-health ;; current magic points
      0
      kathryn-start-lvl  ;;..current level
      #f ;;...........dead?
      'kathryn-conv ;;conversation (optional)
      sch_kathryn ;;..schedule (optional)
      'spell-sword-ai ;;...custom ai (optional)
      ;;..............container (and contents)
      (mk-inventory
       (list
        (list 1 t_kathryns_letter)
        (list 100 t_gold_coins)
        (list 5 sulphorous_ash )
        (list 5 ginseng )
        (list 5 garlic )
        (list 3 spider_silk )
        (list 3 blood_moss )
        (list 2 black_pearl )
        (list 1 nightshade )
        (list 1 mandrake )
        (list 1 t_wis_quas_scroll)
        ))
      ;;..............readied arms (in addition to the container contents)
      (list
       t_staff
       )
      nil ;;..........hooks in effect
      ))
    #t)
   (kathryn-mk)))
