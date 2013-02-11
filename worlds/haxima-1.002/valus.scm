;;----------------------------------------------------------------------------
;; ヴァルス
;;
;; 最初はグラスドリンの囚人だが、後に新しい統治者となる。
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; 最初はグラスドリンの地下の独房にいる。
;; 統治者となった後は、ヴァルスはジェフリーズのスケジュールに従う。
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (valus-mk) (list 'townsman))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ヴァルスは投獄された貴族で、後にグラスドリンの統治者になるが、今は地下の監
;; 獄で落胆している。
;;----------------------------------------------------------------------------

;; Basics...
(define (valus-hail knpc kpc)
  (say knpc "ようこそ、見知らぬ者よ。")
  )

(define (valus-name knpc kpc)
  (if (player-stewardess-trial-done?)
      (say knpc "私はヴァルス、グラスドリンの統治者だ。")
      (say knpc "私はヴァルス、見渡す限りのこの世界の王だ。［彼は身振りで独房を示した。］")
  ))

(define (valus-job knpc kpc)
  (cond ((player-stewardess-trial-done?)
         (say knpc "グラスドリンの人々が私を牢から解放してくれた。証拠となったあの日記を見つけてくれたことに感謝する。"
              "君は私の恩人だ。")
         (prompt-for-key)
         (say knpc "その後、私は新しい統治者に選ばれた。")
         )
        (else
         (say knpc "退役後の人生を楽しんでいる。")
         )))

(define (valus-join knpc kpc)
  (if (player-stewardess-trial-done?)
         (say knpc "ここを守るのが私の義務だ。")
         (say knpc "逆に尋ねるが、なぜ扉を開け仲間に加えぬのだ？")
         ))

;; Special
(define (valus-comm knpc kpc)
  (if (player-stewardess-trial-done?)
         (say knpc "ジャニスはよい司令官になるだろう。彼女が単なる分隊長だったころからそう信じている。")
         (say knpc "ジェフリーズが新しい司令官だ。彼は統治者のよき犬である。わたしはそうなれなかった。")
         ))

(define (valus-pet knpc kpc)
  (say knpc "アブサロットの後、彼女は私に市民の死の責任を負わせた。"
       "そして、大酒とトロルとの不適切な行為について私を非難した。")
  (aside kpc 'ch_ini "トロルの部分は本当だったと思うが。")
  )

(define (valus-trol knpc kpc)
  (say knpc "何といえばよかったのだろうか？あのトロルたちはお楽しみを知っていたのだ。［彼は冷ややかに笑った。］")
  (prompt-for-key)
  (say knpc "しかし、冗談はさておき、彼女は私を投獄し数多くの尋問を行った。"
       "前任の統治者は奇妙な状況の中でおかしくなった。"
       "理由はわからないが、彼女は私がその問題に干渉することを嫌っていた。")
  )

(define (valus-absa knpc kpc)
  (say knpc "友よ、戦争は地獄だ。呪われた者に関するたわごとはともかく、"
       "アブサロットの魔術師たちはあまりにも強力になっていた。"
       "司令官は皆イシンの言い伝えを知っている。")
  )

(define (valus-isin knpc kpc)
  (say knpc "言い伝えでは、そのイシンの女魔術師はほぼ一人で二つの軍を打ち負かしたそうだ。"
       "トゥーレマンの軍は完全に征服され、彼らの町は忘れられた。")
  (prompt-for-key)
  (say knpc "グラスドリンの軍は最後には彼女に勝利した。だが、損失の重大さのため、その目的を破棄せざるをえなかった。"
       "我々は教訓を忘れてはならない。")
  )

(define (valus-less knpc kpc)
  (say knpc "イシンとの戦いから得た教訓は、魔術師たちに力を与えすぎてはならないということだ。"
       "そして、もしそうなっても正面から戦いを挑んではならない。"
       "なぜあの場所で戦わなければならなかったのか、私は常に疑問に思っている。")
  )

;; new....
(define (valus-stew knpc kpc)
  (if (player-stewardess-trial-done?)
      (say knpc "私が統治者となった今、この周辺も変わるだろう。")
      (say knpc "あの狂った女の統治でグラスドリンは崩壊するだろう。")
      ))

(define (valus-poli knpc kpc)
  (say knpc "統治者の目的は他の全てを犠牲にしてでも自身の権力を増すことだ。")
  )

(define (valus-chan knpc kpc)
  (say knpc "私の一番の関心事は安全、安定、そしてグラスドリンによる支配だ。")
  )

(define (valus-domi knpc kpc)
  (if (ask? knpc kpc "町や国が自らの安全を保障する唯一の道は、他を支配することである。君は同意するか？")
      (say knpc "そうだ。優れた指導者なら誰でも知っている。そして自らの国を最も強力なものにするため戦うのだ。")
      (say knpc "もし他の町が我々より強力になれば我々は支配されるだろう。"
           "統治者として、私にはそれを阻止するため行動する責任があるのだ。")
      ))

(define valus-conv
  (ifc glasdrin-conv

       ;; basics
       (method 'hail valus-hail)
       (method 'job  valus-job)
       (method 'name valus-name)
       (method 'valu valus-name)
       (method 'join valus-join)

       (method 'absa valus-absa)
       (method 'chan valus-chan)
       (method 'civi valus-absa)
       (method 'comm valus-comm)
       (method 'dog  valus-pet)
       (method 'domi valus-domi)
       (method 'drun valus-trol)
       (method 'isin valus-isin)
       (method 'jeff valus-comm)
       (method 'less valus-less)
       (method 'pet  valus-pet)
       (method 'poli valus-poli)
       (method 'reti (lambda (knpc kpc) (say knpc "かつて私はグラスドリンの司令官だった。")))
       (method 'ruin valus-poli)
       (method 'secu valus-domi)
       (method 'stab valus-domi)
       (method 'stew valus-stew)
       (method 'trol valus-trol)
       (method 'unna valus-trol)
       ))

(define (mk-valus)
  (bind 
   (kern-mk-char 'ch_valus       ; tag
                 "ヴァルス"          ; name
                 sp_human            ; species
                 oc_warrior          ; occ
                 s_fallen_paladin ; sprite
                 faction-glasdrin         ; starting alignment
                 2 1 1               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 5  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'valus-conv         ; conv
                 nil           ; sched
                 'townsman-ai                 ; special ai
                 nil                 ; container
                 (list t_armor_chain
                       t_chain_coif
                       t_sword
                       ))         ; readied
   (valus-mk)))
