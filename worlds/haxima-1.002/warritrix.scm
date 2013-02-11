;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define warr-lvl 8)
(define warr-species sp_ghast)
(define warr-occ oc_warrior)

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (warr-mk) (list 3))
(define (warr-must-go? gob) (= 0 (car gob)))
(define (warr-end-conv gob) (set-car! gob (- (car gob) 1)))

;;----------------------------------------------------------------------------
;; Conv
;; 
;; クラリッサ(闘士として知られている)は、生きているときには比類なき強さと技の
;; 女戦士であった。殺された今、亡骸の側(失われた殿堂の破壊された祭壇)で統制の
;; 石版の力によって影になっている。
;;----------------------------------------------------------------------------

;; Basics...
(define (warr-hail knpc kpc)
  (meet "静かな威厳のある女性の亡霊があなたの目の前にいる。")
  (say knpc "よく来たな。迷い人よ。")
  (quest-data-update 'questentry-warritrix 'found 1)
  (quest-data-icon! 'questentry-warritrix 's_ghost)
  (quest-data-complete 'questentry-warritrix)
  )

(define (warr-name knpc kpc)
  (say knpc "私はクラリッサ。多くの者には闘士として知られていた。")
  )

(define (warr-join knpc kpc)
  (say knpc "生きているときに会っていれば！")
  )

(define (warr-job knpc kpc)
  (say knpc "正義に仕えることだ。おまえも同じか？")
  (if (yes? kpc)
      (begin
        (say knpc "正義に仕えるためには正義を知らねばならぬ。"
             "私はこの洞窟を完全に探索することを命じられた。"
             "部隊が怪物たちとの戦いで弱り果てたとき、"
             "呪われた者の暗殺者の待ち伏せに会った。そしてみな殺された。"
             "答えてくれ。裏切り者への復讐を果たしてくれるか？")
        (yes? kpc)
        (say knpc "正義は罰ではなく報いによってもたらされる。"
             "私を殺した者にはこの廃墟がふさわしく、"
             "謀略を考えた者は自らの失脚を招くだろう。"
             "力を求める者は自らの助けを求めるときには力を失うものだ。"
             "復讐するな。それよりも真実を求めるべきだ。")
        )
      (say knpc "不正は何もしないことによってなされるのだ。"))
  )

(define (warr-trut knpc kpc)
  (say knpc "真実を求めよ。そのためには証拠が必要だ。"))

(define (warr-warr knpc kpc)
  (say knpc "他の者が褒め称えるその名にはうんざりしていた。"
       "本当のことを言えば、私は大勢の聖騎士の中の一人に過ぎなかったのだ。"))

(define (warr-evid knpc kpc)
  (say knpc "ならず者は他が隠そうとしたものを探すことに長けている。"
       "そしてその全てのならず者の頂点がにんげんだ。")
       (quest-wise-subinit 'questentry-the-man)
       (quest-data-update 'questentry-the-man 'common 1)
       )

(define (warr-wise knpc kpc)
  (say knpc "賢者は惑わされ分断された。"
       "呪われた者はよくやったものだ。"))

(define (warr-bye knpc kpc)
  (if (warr-must-go? (gob knpc))
      (begin
        (say knpc "もう会うことはないだろう。迷い人よ。")
        (kern-log-msg "霊は消え去った。")
        (kern-obj-remove knpc))
      (begin
        (say knpc "聞きたいことは全て聞いたか？")
        (if (yes? kpc)
            (say knpc "もうすぐ行かねばならぬ。虚空へと呼ばれているのだ。")
            (say knpc "ならばもう少しここに留まっていよう。")
            )
        (warr-end-conv (gob knpc)))))

;; Quest-related
(define (warr-rune knpc kpc)
  (say knpc "おまえは石版を集めているのだな。その目的はわからぬが。"
       "ここ何年かの間は名高きクロービス王、私の名づけの親から授かった石版を持ち歩いていた。"))

(define (warr-clov knpc kpc)
  (say knpc "クロービス王は石版を持ち歩いていた。"
       "彼はゴブリン戦争での戦いで命を落とした。その石版を探しているか？")
  (if (yes? kpc)
  		(begin
      (say knpc "もしどこにあるか知っている者がいるとすれば、それはゴブリンだ。"
           "緑の塔へ行きジェンを探し、彼に^c+mクロービス^c-のことを尋ねなさい。")
       	(quest-data-update 'questentry-rune-f 'gen 1)
        (quest-data-assign-once 'questentry-rune-f)
           )
      (say knpc "もし探すつもりなら、今私に尋ねなさい。"
           "全ての死んだ者と同じように虚空へと引き寄せられている。長い間ここにはいられない。"
           ))
  )

(define (warr-just knpc kpc)
  (say knpc "正義は単なる目標に過ぎず、それを支える理論も、思想も、信仰も必要としない。"
       "それは否定できない目標だ。"))

(define (warr-absa knpc kpc)
  (say knpc "統治者はそこが呪われた者の習慣を広めていることを口実に"
       "私にアブサロットを破壊するよう命じた。"
       "だが、力への執着は正に呪われた者の証ではないのか？")
  (yes? kpc)
  (say knpc "そうなのであろうな。")
  )

(define (warr-void knpc kpc)
  (say knpc "全ての霊は虚空の迷い人である。"))

(define (warr-assa knpc kpc)
  (say knpc "彼らは私たちを待ち伏せていた。"
       "ここに来ることを知っているのは、グラスドリンの統治者と司令官のジェフリーズ以外はいないにも関わらずだ。"))

(define (warr-jeff knpc kpc)
  (say knpc "銀のような若い頃の高貴な行いは、歳をとってからの過ちで輝きを失った。"
       "英雄が勝利によって腐敗するならば、奮闘し死ぬほうがまだよい。"))

(define (warr-powe knpc kpc)
  (say knpc 
       "あらゆるものを敵とみなす者たちは決して十分な力を得ることはできない。"
       "だが、恐れを知らぬ者は軽蔑の中でそれを掴み取るのだ。"))

(define warr-conv
  (ifc basic-conv

       ;; basics
       (method 'hail warr-hail)
       (method 'bye  warr-bye)
       (method 'job  warr-job)
       (method 'name warr-name)
       (method 'join warr-join)
       
       (method 'rune warr-rune)
       (method 'clov warr-clov)
       (method 'just warr-just)
       (method 'absa warr-absa)
       (method 'stew warr-absa)
       (method 'warr warr-warr)
       (method 'evid warr-evid)
       (method 'wise warr-wise)
       (method 'void warr-void)
       (method 'trut warr-trut)
       (method 'assa warr-assa)
       (method 'jeff warr-jeff)
       (method 'powe warr-powe)
       ))

(define (mk-warritrix)
  (bind 
   (kern-mk-char 
    'ch_warr           ; tag
    "闘士"             ; name
    warr-species         ; species
    warr-occ              ; occ
    s_ghost     ; sprite
    faction-men      ; starting alignment
    10 0 10            ; str/int/dex
    5 2              ; hp mod/mult
    5 2              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0  ;; AP_per_turn
    warr-lvl
    #f               ; dead
    'warr-conv         ; conv
    nil              ; schedule
    nil              ; special ai
    nil              ; container
    nil              ; readied
    )
   (warr-mk)))
