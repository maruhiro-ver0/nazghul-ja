;;----------------------------------------------------------------------------
;; Schedule
;; 
;; 緑の塔
;;----------------------------------------------------------------------------
(define (mk-zone x y w h) (list 'p_green_tower x y w h))
(kern-mk-sched 'sch_deric
               (list 0  0 (mk-zone 17  4  1   1)  "sleeping")
               (list 6  0 (mk-zone 30 30  5   5)  "working")
               (list 12  0 (mk-zone 52 54  1   1)  "eating")
               (list 13  0 (mk-zone 30 30  5   5)  "working")
               (list 18  0 (mk-zone 52 54  1   1)  "eating")
               (list 19  0 (mk-zone 30 30  5   5)  "working")
               (list 21  0 (mk-zone 13  2  4   4)  "idle")
               (list 22  0 (mk-zone 17  4  1   1)  "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (deric-mk tell-secret?) (list tell-secret? (mk-quest)))
(define (deric-tell-secret? deric) (car deric))
(define (deric-set-tell-secret! deric) (set-car! deric #t))
(define (deric-bandit-quest deric) (cadr deric))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; デリックは緑の塔の警備隊長である。
;;----------------------------------------------------------------------------

(define (deric-name knpc kpc)
  (say knpc "私はデリック隊長、警備隊の司令官である。何なりと申すがよい。"))

(define (deric-job knpc kpc)
  (say knpc "警備隊を指揮することである。そして私にはより大きな目的がある。"
       "私は自分の能力で指揮官の地位に上り詰めた。だが、君が昇進するためには、"
       "誰かが死ぬのを待たなければならないだろう！"))

(define (deric-health knpc kpc)
  (say knpc "私は健康そのものである！"))

(define (deric-rangers knpc kpc)
  (say knpc "そう！警備隊はこの広大な森の平和を守る責務を負っている。"
       "法を守らせ、ゴブリンどもを監視するなどだ。"
       "森を管理し、通路を維持するのも我々の仕事だ。"
       "自分自身のことを言えば、我々は私の統率のもとすばらしい仕事をしている。"
       "もちろん私は部下の働きに感謝している。［咳ばらい］"))

(define (deric-two knpc kpc)
  (say knpc "上の階のほとんどは防御設備だ。"
       "下の階は会議室、兵舎、厨房などだ。"
       "今は刑務所になっている。"
       "下の階には幽霊がいると考えている者もいるようだ。"))

(define (deric-haunted knpc kpc)
  (say knpc "下の階には幽霊がいると言う者がいる。私も奇妙な物音を聞いたことがある。"
       "壁の奥深くから、祈るような、悲鳴のような声がした。"
       "だが幽霊など見たことがない。"
       "もちろん私はそんなものは恐れない！"))

(define (deric-gen knpc kpc)
  (say knpc "名高き勝者、少し正気でないがな。"
       "彼のゴブリン戦争での活躍は警備隊の間では伝説となっている。そして古強者の最後の生き残りの一人でもある。"
       "今でも体の調子はよさそうだが、"
       "彼は土着の者になってしまった。どういう意味かわかるだろうか。"))

(define (deric-native knpc kpc)
  (say knpc "そう、彼は森の民、つまり森ゴブリンの習慣を受け入れている。"
       "しかし彼が我々に反逆心を持っていると疑っているのではない。"
       "もしできるなら、私は彼を改心させ、昇格させたいとすら思っている。"
       "ああ、だがそれは不可能だろう。"
       ))

(define (deric-shroom knpc kpc)
  (say knpc "気難しい婆さんだ。魔女の能力が少しあるが、何の問題もない。"
       "この町の北東で薬屋をしている。"))

(define (deric-abe knpc kpc)
  (say knpc "若い変わった男だ。変わり者というより、奇妙な…、別の言い方をすると…うまく言えんな。"
       "とにかく、そいつは町の南西の遺跡を調べている。"
       "王立図書館かどこかで働いているのだろう。"))


(define (deric-tower knpc kpc)
  (say knpc "そう、この町の中央にある、緑の塔と呼ばれる塔だ。"
       "ここが私の指揮所であり、警備隊の本部である。"
       "すばらしい建物だ！"
       "これが古い塔の遺跡の上に建てられたものだと知っているか？")
  (if (kern-conv-get-yes-no? kpc)
      (say knpc "面白いと思わんか？私には詳しくはわからないが。"
           "もっと知りたいなら、エイブか、もしかするとシュルームと話すとよいかもしれん。")
      (say knpc "そうか！今の塔は、かつてあった巨大な尖塔の一部にすぎない！"
           "エイブという若者のことを信じるなら、沈んでしまったそうだ。"
           "今では二つの階しか残っていない。")))

(define (deric-ambition knpc kpc)
  (say knpc "その通り。私には野心があり、それを認めることを恐れない！"
       "人は野心を持つ者を不安に思うが、やましい点などなにもない。"
       "無論私は今の地位にたどり着くために不正なことは何もしていない。"
       "私はこの偉大な組織の信条を固く信じている。君には野心があるか？")
  (if (kern-conv-get-yes-no? kpc)
      (begin
        (say knpc "ああ、君の事はよい。私はいつの日か王になりたい。"
             "私にはその機会があると思うか？")
        (if (kern-conv-get-yes-no? kpc)
            (begin
              (say knpc "わかっている！君のことを信用しているわけではないが、"
                   "鋭い洞察力を持つ者のようだ。"
                   "君にある秘密を教えよう。")
              (deric-set-tell-secret! (kobj-gob-data knpc)))
            (say knpc "［笑い］すまないが意見が合わないようだな！"
                 "選ばれし者はよく思われないものだ。")))
      (say knpc "［ため息］多くの者どもは無価値に人生を浪費している。"
           "私は彼らの内の一人でないことを喜んでいる！")))

(define (deric-secret knpc kpc)
  (if (deric-tell-secret? (kobj-gob-data knpc))
      (say knpc "塔の地下には隠された通路がある。"
           "このはしごを降りて、南東の準備室に入れ。"
           "東の壁に秘密の扉がある！"
           "何のためかはわからないがな。")
      (say knpc "君の様なよそ者に話すことは何もない！")))

(define (deric-afraid knpc kpc)
  (say knpc "もちろんだ！恐れは小物のホブゴブリンだ。"
       "いや、ホブゴブリンが小物の恐れか？"
       "ちくしょうめ、ばかげた言い回しが思い出せない。"))

(define (deric-prison knpc kpc)
  (say knpc "そうだ。とても強固な。現在、囚人は一人しかいない。"
       "このあたりをうろついていた森ゴブリンだ。"
       "凶暴な獣と言うほかにない。"
       "私はそいつを恐れたりはしない。［咳ばらい］"))

(define (deric-gobl knpc kpc)
  (say knpc "卑劣なやつらだ！まあ、少し前にやつを町の中で捕まえて、刑務所に放り込んでやったがな。"))

(define (deric-brute knpc kpc)
  (say knpc "とても疑わしい者だ。何も品物を持っていなかったので、明らかに商売に来たのではない。"
       "そして共通語が全く話せなかった。"
       "いや、それどころか何も話そうとしなかった。ううむ、地下にいれば少しは話すようになりそうなものだが。"
       "何をたくらんでいるのか突き止めなければ。"))

(define (deric-default knpc kpc)
  (say knpc "別のことを聞いてくれ！"))

;; Scan the player party looking for mercs
                         

(define (deric-hail knpc kpc)

  (define (get-ranger-merc)
    (let ((mercs (filter (lambda (kchar)
                           (kbeing-is-npc-type? kchar 'ranger))
                         (kern-party-get-members (kern-get-player)))))
      (cond ((null? mercs) nil)
            (else
           (car mercs)))))

  (define (rm-ranger-merc)
    (let ((kmerc (get-ranger-merc)))
      (if (not (null? kmerc))
          (begin
            (prompt-for-key)
            (say knpc "私は巡回する警備隊員を再構成しなければならない。")
            (kern-char-leave-player kmerc)
            ))))

  (cond ((in-player-party? 'ch_nate)
         (say knpc "盗賊の頭を捕らえたようだな！"
              "地下の刑務所の看守に渡し、収容証明書を受け取ってくるのだ。")
         (rm-ranger-merc)
         (quest-data-update-with 'questentry-bandits 'captured-nate-and-talked-to-deric 1 (quest-notify nil))
         )        
        ((has? kpc t_prisoner_receipt 1)
         (say knpc "盗賊を檻の向こう側に追いやったことは、私の輝かしい記録になるであろう！"
              "君に報酬を渡そう。")
         (give-player-gold 100)
         (kern-char-add-experience kpc 64)
         (take kpc t_prisoner_receipt 1)
         (quest-done! (deric-bandit-quest (kobj-gob-data knpc)) #t)
         (rm-ranger-merc)
         (quest-data-update-with 'questentry-bandits 'done 1 (grant-party-xp-fn 30))
         (quest-data-complete 'questentry-bandits)
         )
        (else
         (say knpc "よく来たな！")
         )))

(define (deric-bye knpc kpc)
  (say knpc "また会おう。"))

(define (deric-thie knpc kpc)
  (say knpc "ふむ。捕まえた獣のようなゴブリンは泥棒だったに違いない。"
       "だが、奴は刑務所の中だ。森を通って北へ一人で向かう者がいたという報告はあったが、目的地はわからん。"
       "北にはボレしかないがな。")
       (quest-data-update 'questentry-thiefrune 'tower 1)
       (quest-data-update-with 'questentry-thiefrune 'bole 1 (quest-notify (grant-party-xp-fn 10)))
       )

(define (deric-accu knpc kpc)
  (say knpc "おい。断言するが、このあたりに呪われた者はいない。"))


(define (deric-band knpc kpc)
  (let ((quest (deric-bandit-quest (kobj-gob-data knpc))))
    (cond ((quest-done? quest) 
           (say knpc "私が盗賊の頭を捕らえたからには、これ以上の問題は起こらないであろう。"
                "もちろん君のおかげだ。"
                "だが、命じたのはこの私だ。"
                "［咳払い］"))
          ((quest-accepted? quest)
           (say knpc "この森のどこかに盗賊の隠れ家がある。"
                "探し続けることだ！そして頭を生け捕りにして連れてくるのだ。")
           )
          (else
           (say knpc "盗賊の問題を聞いたのだな。"
                "そう、やつらの隠れ家はこの森のどこかにある。"
                "ずっと以前なら私がやつらを一掃しに行くだろう。"
                "しかし、知ってのとおり、私の代わりはいない。")
           (prompt-for-key)
           (say knpc
                "答えてくれ。君は勇敢そうだ。"
                "もし盗賊の頭を捕らえ、ここに連れて来たなら、喜んで君に賞金を与えよう。"
                "どうだろうか？")
           (if (yes? kpc)
               (begin
                 (quest-accepted! quest #t)
                 (say knpc "すばらしい！君には助けが必要だろう。\n"
                      "［彼はあなたに羊皮紙の文書を渡した。］\n"
                      "この命令書は、警備隊の指揮権を君に一時的に譲渡するものだ。"
                      "警備隊の一人に仲間に加わるように言いたまえ。")
                 (give kpc t_ranger_orders 1)
                 (quest-data-update-with 'questentry-bandits 'talked-to-deric 1 (quest-notify nil))
                 )
               (say knpc "そのような態度では、栄光は決して得られないであろう！")))
          )))
                       

(define deric-conv
  (ifc green-tower-conv
       (method 'abe        deric-abe)
       (method 'afra       deric-afraid)
       (method 'ambi       deric-ambition)
       (method 'aspi       deric-ambition)
       (method 'band       deric-band)
       (method 'brut       deric-brute)
       (method 'bye        deric-bye)
       (method 'comm       deric-rangers)
       (method 'default    deric-default)
       (method 'die        deric-ambition)
       (method 'gen        deric-gen)
       (method 'hail       deric-hail)
       (method 'haun       deric-haunted)
       (method 'heal       deric-health)
       (method 'job        deric-job)
       (method 'name       deric-name)
       (method 'nati       deric-native)
       (method 'pris       deric-prison)
       (method 'prom       deric-ambition)
       (method 'rang       deric-rangers)
       (method 'secr       deric-secret)
       (method 'shro       deric-shroom)
       (method 'skul       deric-brute)
       (method 'stor       deric-two)
       (method 'thie       deric-thie)
       (method 'towe       deric-tower)
       (method 'two        deric-two)
       (method 'gobl       deric-gobl)
))                

(define (mk-deric tag)
  (bind 
   (kern-mk-char tag                 ; tag
                 "デリック"          ; name
                 sp_human            ; species
                 nil                 ; occ
                 s_ranger_captain   ; sprite
                 faction-men         ; starting alignment
                 1 3 2               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 4  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'deric-conv        ; conv
                 sch_deric          ; sched
                 'townsman-ai        ;; special ai
                 nil                 ; container
                 (list  t_sword_2
					         t_armor_leather_2
					         t_leather_helm_2
					         )                  ; readied
                 )
   (deric-mk #f)))
