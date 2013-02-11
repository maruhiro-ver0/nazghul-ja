;;----------------------------------------------------------------------------
;; Schedule
;;
;; トリグレイブ
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_jim
               (list 0  0  trigrave-jims-bed        "sleeping")
               (list 6  0  trigrave-tavern-table-1a  "eating")
               (list 7  0  trigrave-forge            "working")
               (list 12 0  trigrave-tavern-table-1a  "eating")
               (list 13 0  trigrave-forge            "working")
               (list 18 0  trigrave-tavern-hall      "idle")
               (list 22 0  trigrave-jims-bed         "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;
;; Quest flags, etc, go here.
;;----------------------------------------------------------------------------
(define (jim-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;;
;; ジムは店主で、仕事をしている時間ならば取り引きできる。彼は背が高く、鍛冶屋
;; をしていて、無愛想である。もし町にリーダーがいるとすれば、それは彼である。
;; なぜなら住民は彼を尊敬し、危機のとき頼れると考えているからである。しかし、
;; 彼は名声には興味がなく、野心のために行動することはない。彼は冒険者には興味
;; がなく、(個人的には)冒険者は愚かだと考えている。しかし、彼らと取り引きする
;; と喜ぶ。彼は大酒のみで、おそらく若いころは荒くれ者だった。
;;----------------------------------------------------------------------------
(define jim-merch-msgs
  (list "店が開いてるときに来てくれ。北東の金物屋だ。午前7時から午後6時までやっている。"
        "欲しい物があれば言ってくれ。"
        "いらなくなった物があれば買い戻すぞ。"
        "欲しい物があれば言ってくれ。"
        "まずは強く打て、よきもののために、友よ。"
        "またの機会に。"
        "溶かすか、部品にして使うよ。"
        "どうも。"
        "まずは強く打て、よきもののために、友よ。"
        "どうも。"
   ))

(define jim-catalog
  (list
   (list t_dagger          40 "戦士でない者にはいい武器だ。")
   (list t_sword           80 "地味だが完璧な均衡の剣だ。")
   (list t_axe             70 "斧は野外の活動で必要だ。戦いでも使える。")
   (list t_mace            75 "鎚矛は単純だが軽装の鎧を着た敵には効果のある武器だ。")
   
   (list t_2H_axe         240 "鎧や盾を切り裂くために作られた戦斧だ。")
   (list t_2H_sword       350 "持てるだけの力があれば、両手剣はとても強力な武器だ。")
   
   (list t_chain_coif     110 "鎖頭巾は頭部への攻撃から首を守るだろう。")
   (list t_iron_helm      160 "鉄兜があれば頭への鎚矛の直撃も防げるだろう。")
   (list t_armor_chain    300 "鎖かたびらがあれば大抵の刃や矢を跳ね返せる。")
   (list t_armor_plate    600 "重いが、甲冑は極めて強力な攻撃や鎧を貫通する攻撃を除けば全てから守るだろう。")
   
   (list t_shield          45 "盾は接近戦では必要だ。")
   
   (list t_spiked_helm    150 "刺付き兜はもっと攻撃力が欲しい者に好まれる。")
   (list t_spiked_shield  150 "刺付き盾は素早い戦士の基本的な押して突く動作を更なる攻撃にできる。")
   ))

(define (jim-trade knpc kpc) (conv-trade knpc kpc "trade" jim-merch-msgs jim-catalog))

(define jim-conv
  (ifc basic-conv
       ;; default if the only "keyword" which may (indeed must!) be longer than
       ;; 4 characters. The 4-char limit arises from the kernel's practice of
       ;; truncating all player queries to the first four characters. Default,
       ;; on the other hand, is a feature of the ifc mechanism (see ifc.scm).
       (method 'default (lambda (knpc kpc) (say knpc "わからんな。")))
       (method 'hail (lambda (knpc kpc) (say knpc "いらっしゃい。")))
       (method 'bye (lambda (knpc kpc) (say knpc "どうも。")))
       (method 'job 
               (lambda (knpc kpc) 
                 (say knpc "トリグレイブの鍛冶屋だ。何かいるか？")
                            (if (kern-conv-get-yes-no? kpc)
                                (jim-trade knpc kpc)
                                (say knpc "まあ見ていきな。"))))
       (method 'name (lambda (knpc kpc) (say knpc "皆ジムと呼んでいる。")))
       (method 'buy (lambda (knpc kpc) (conv-trade knpc kpc "buy" jim-merch-msgs jim-catalog)))
       (method 'sell (lambda (knpc kpc) (conv-trade knpc kpc "sell" jim-merch-msgs jim-catalog)))
       (method 'trad jim-trade)
       (method 'join (lambda (knpc kpc) 
                       (say knpc "何が起ころうとも、ここが俺の場所だ。")))


       (method 'chan (lambda (knpc kpc)
                       (say knpc "オンドリはトリグレイブの酒場に出入りしている吟遊詩人だ。"
                            "このあたりじゃ有名だ。")))
       (method 'char 
               (lambda (knpc kpc)
                 (say knpc "森の炭焼き人のおかげで俺の鍛冶場を熱くできる。")))
       (method 'earl
               (lambda (knpc kpc)
                 (say knpc "イアルは小間物屋の店主だ。"
                      "昔は魔術師だったと言い張っている。")))
       (method 'gwen
               (lambda (knpc kpc)
                 (say knpc "グベンは宿屋をやっている。"
                      "美人だが謎の多い女だ。")))
       (method 'iron (lambda (knpc kpc)
                       (say knpc "丘には原石が豊富にある。谷では多くの戦いがあるが、くず鉄を探しにそこに行く必要はない。")))
       (method 'shie
               (lambda (knpc kpc)
                 (say knpc "［彼は冷たい目であなたを見た。］"
                      "グラスドリンの紋章の盾はもう捨てた。"
                      "これ以上話したくないのだが。")))
       (method 'thie
               (lambda (knpc kpc)
                 (say knpc "おかしな奴は見なかったな。グベンに聞いてみればいい。宿屋で大勢の旅人と話しているだろうからな。")))
       (method 'trig 
               (lambda (knpc kpc) 
                 (say knpc "トリグレイブには話になるものはあまりない。")))
       (method 'wood 
               (lambda (knpc kpc)
                 (say knpc "森は獣と盗賊のねぐらだ。"
                      "短い武器と軽い鎧が必要だ。藪の中では長い武器と重い鎧は邪魔になるだけだ。")))
       
       ))
