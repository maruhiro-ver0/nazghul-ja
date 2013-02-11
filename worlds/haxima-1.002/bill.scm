;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define bill-start-lvl 3)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ボレ
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_bill
               (list 0  0  bole-bed-bill "sleeping")
               (list 6  0  bole-table-1  "idle")
               (list 7  0  bole-n-woods  "working")
               (list 12 0  bole-table-2  "eating")
               (list 13 0  bole-n-woods  "working")
               (list 18 0  bole-table-2  "eating")
               (list 19 0  bole-dining-hall "idle")
               (list 21 0  bole-bills-hut "idle")
               (list 22 0  bole-bed-bill "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (bill-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;;
;; ビルは木こりで、ボレに住んでいる。
;; あまり賢くない者である。
;;----------------------------------------------------------------------------
(define bill-catalog
  (list
   (list t_staff 10 "杖を作れるくらいまっすぐな枝はなかなか見つからない。") ;; rather cheap
   (list t_torch  3 "夜出歩くのが好きだ。だから松明を作ってる。") ;; rather cheap
   (list t_arrow  3 "緑の塔の警備隊もたまに俺の矢を買ってる。")
   (list t_bolt   4 "このあたりでクロスボウを使ってるヤツは少ない。")
   ))

(define bill-merch-msgs
  (list nil ;; closed
        "全部俺が作ったんだ。" ;; buy
        nil ;; sell
        nil ;; trade
        "気に入ってくれりゃいいけど。" ;; sold-something
        "気が変わったらまた来なよ。" ;; sold-nothing
        nil ;; bought-something
        nil ;; bought-nothing
        nil ;; traded-something
        nil ;; traded-nothing
        ))


(define (bill-buy knpc kpc) (conv-trade knpc kpc "buy" bill-merch-msgs bill-catalog))

(define (bill-goods knpc kpc)
  (say knpc "何か買う？")
  (if (kern-conv-get-yes-no? kpc)
      (bill-buy knpc kpc)
      (say knpc "欲しくなったら言ってくれ。")))

(define (bill-may knpc kpc)
  (say knpc "町の酒場をやってる。いい女だ。"))

(define (bill-lady knpc kpc)
  (say knpc "今、町に女がいるんだよ。本当にきれいな。"
       "でも、でかい、きたねえ男が付いてるんだ。"))

(define (bill-bole knpc kpc)
  (say knpc "ああ、俺はボレが好きだ。"
       "酒場があって、そこで飯食って、クソほど酔っ払う。"
       "酒場は俺の家だ。"))

(define (bill-wolves knpc kpc)
  (say knpc "いつも注意してる。"
       "町のずっと南にはたくさんいるな。"))

(define (bill-scared knpc kpc)
  (say knpc "町の西にいたときよ。"
       "狼がいてなかなか行けない場所だ。"
       "そこに大きな、古い、死んだカシの木があったんだ。"
       "こいつはいいと思ったよ。"
       "で、こいつを切ろうとしたら、何と動き出したんだよ！"))

(define (bill-thie knpc kpc)
  (say knpc "少し前にカリカリしたヤツが酒場にいたな。"
       "きれいな女と話してた。何かについてケンカしてたと思う。そいつが町の北東の丘、どこかわかるか？、へ行くのを見た。"
       "それから戻ってこなかった。どこへ行ったかはわからねえ！その丘は行き止まりだ！"
       "本当に変な話さ。"))

(define (bill-mous knpc kpc)
  (say knpc "ネズミはどこにでもいる。ネズミみてえに走り回ってるヤツも見たよ！"))

(define (bill-tree knpc kpc)
  (say knpc "森には色んな木がある。"
       "でもよ、この前幽霊木を見たんだよ！"))

(define bill-conv
  (ifc nil
       (method 'default (lambda (knpc kpc) (say knpc "［彼は肩をすくめた。］")))
       (method 'hail (lambda (knpc kpc) (say knpc "よーお。")))
       (method 'bye (lambda (knpc kpc) (say knpc "じゃまた。")))
       (method 'job (lambda (knpc kpc) 
                      (say knpc "おりゃあ木こりだ。")))
       (method 'name (lambda (knpc kpc) (say knpc "ビルと呼ばれてる。")))
       (method 'join (lambda (knpc kpc) 
                       (say knpc "いんや！あんたは飛び回ってる、俺は木こり。"
                            "合わねえよ。悪く思わんでくれ。")))

       (method 'arro bill-goods)
       (method 'axe
               (lambda (knpc kpc)
                 (say knpc "木ぃ切るときゃ短刀よかいい。")))
       (method 'buy bill-buy)
       (method 'bole bill-bole)
       (method 'chop
               (lambda (knpc kpc)
                 (say knpc "斧使って。")))
       (method 'fore
               (lambda (knpc kpc)
                 (say knpc "そうさあ、森にはほんとにたくさん木がある。"
                      "そして狼もな。")))
       (method 'haun
               (lambda (knpc kpc)
                 (say knpc "［彼はあなたに寄りかかり、小声で言った。］"
                      "この町の西でも出るんだよ。"
                      "びびって逃げちまったよ。ハハ！")))
       (method 'jink bill-scared)
       (method 'ladi bill-lady)
       (method 'lady bill-lady)
       
       (method 'may bill-may)

       (method 'wood
               (lambda (knpc kpc)
                 (say knpc "木ぃ切って、割って、薪を作る。"
                      "ああ、あと松明や矢も。")))
       (method 'shit
               (lambda (knpc kpc)
                 (say knpc "おお！失礼。そんなこと言うつもりはなかったんだ。"
                      "メイはいつも俺にクソだの畜生だの言うなと言ってる。"
                      "女はそういうのは嫌いだからな。")))
       (method 'scar bill-scared)
       (method 'thie bill-thie)
       (method 'mous bill-mous)
       (method 'man  bill-thie)
       (method 'scur bill-thie)
       (method 'torc bill-goods)
       (method 'town bill-bole)
       (method 'trad bill-buy)
       (method 'tree bill-tree)
       (method 'ki bill-tree) ; 「木」と「キ(ゴブリン語)」の音が同じであるため
       (method 'wake
               (lambda (knpc kpc)
                 (say knpc "そう！死んだ古い樫の木が生き返った！"
                      "牛みてえな角と二つのでっけえ目があって、俺を睨んでた！"
                      "ズボンから飛び出して、"
                      "斧も置いて死ぬほど走って逃げたよ！")))
       (method 'wolv bill-wolves)
       (method 'wulv bill-wolves)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-bill)
  (bind 
   (kern-char-arm-self
    (kern-mk-char 
     'ch_bill ;;......tag
     "ビル" ;;.......name
     sp_human ;;.....species
     nil ;;..........occupation
     s_townsman ;;...sprite
     faction-men ;;..faction
     2 ;;............custom strength modifier
     0 ;;............custom intelligence modifier
     0 ;;............custom dexterity modifier
     0 ;;............custom base hp modifier
     0 ;;............custom hp multiplier (per-level)
     0 ;;............custom base mp modifier
     0 ;;............custom mp multiplier (per-level)
     max-health ;;..current hit points
     -1  ;;...........current experience points
     max-health ;;..current magic points
     0
     bill-start-lvl  ;;..current level
     #f ;;...........dead?
     'bill-conv ;;...conversation (optional)
     sch_bill ;;.....schedule (optional)
     'townsman-ai ;;..........custom ai (optional)

     ;;..............container (and contents)
     (mk-inventory
      (list
       (list 10  t_torch)
       (list 100 t_arrow)
       (list 1   t_2h_axe)
       ))
     nil ;;.........readied arms (in addition to the container contents)
     nil ;;..........hooks in effect
     ))
   (bill-mk)))
