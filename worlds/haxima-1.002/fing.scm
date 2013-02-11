;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; オパーリン
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_fing
               (list 0  0  sea-witch-bay        "idle")
               (list 6  0  sea-witch-shore      "idle")
               (list 8  0  sea-witch-bay        "idle")
               (list 20 0  sea-witch-shore      "idle")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (fing-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; フィンはニキシーの男性で、一族の王子である。
;; 彼は、愛する人間の女性リアの近くにいるため、オパーリンに住んでいる。
;;----------------------------------------------------------------------------

;; Basics...
(define (fing-hail knpc kpc)
  (say knpc "［あなたはニキシーと会った。］こんにちは。陸の人。"))

(define (fing-default knpc kpc)
  (say knpc "もしかすると、別の陸の人なら知っているかもしれません。"))

(define (fing-name knpc kpc)
  (say knpc "私はフィンです。"))

(define (fing-join knpc kpc)
  (say knpc "この岸から離れることはできないのです。"))

(define (fing-job knpc kpc)
  (say knpc "私はこの谷…いえ、海の人の王子です。"))

(define (fing-bye knpc kpc)
  (say knpc "さようなら、陸の人。"))

;; Shores...
(define (fing-shor knpc kpc)
  (say knpc "私は愛する人の側にいるため、この岸を離れるわけにはいかないのです。"))

(define (fing-love knpc kpc)
  (say knpc "しかしながら、私の愛する人は陸を離れることができないのです。"
       "彼女は海の人の王女です。"
       "親切で誠実、そして自身の呪いにもかかわらず希望を捨てていないのです。"))

(define (fing-sea knpc kpc)
  (say knpc "海の下にはたくさんの王国、たくさんの遺跡、洞窟、"
       "沈んだ船、そしてすばらしい財宝があります。魔法使い、"
       "兵士と力強い生き物がいます！気分を害するかもしれませんが、"
       "それに比べると乾いた地はとても退屈でしょうね。"
       ))

(define (fing-curs knpc kpc)
  (say knpc "それは海の人の問題です。"))

;; Townspeople...
(define (fing-opar knpc kpc)
  (say knpc "あなた方のような陸の人にはよい所だと思います。"))

(define (fing-gher knpc kpc)
  (say knpc "私たちは彼女を下から賞賛していました！"
       "何と素早く、何と荒々しいか！"
       "嵐と見まがうような女性でした。"
       "彼女の手下は、どうやら悲惨な最期を遂げたようです。"))

(define (fing-crew knpc kpc)
  (say knpc "ガーティーの手下は東の島へと船を進めました。"
       "そして上陸し、二度と戻ってくることはありませんでした。"
       "彼女の船も失われました。"))

(define (fing-alch knpc kpc)
  (say knpc "私の愛しい人とよく話していますが、嫉妬はしていません。"
       "彼はあまりにも歳をとり太っていて、どんなほれ薬も彼女の疑いの目には効かないからです！"))

(define (fing-osca knpc kpc)
  (say knpc "彼のことは知りません。"))

(define (fing-henr knpc kpc)
  (say knpc "勇敢な陸の人だと聞きました。"))

(define (fing-bart knpc kpc)
  (say knpc "ゴブリンはあまり見たことがありません。彼らは海を恐れていると思います。"
       "彼はゴブリンの間では変わり者でしょう。"))


(define fing-conv
  (ifc nil

       ;; basics
       (method 'default fing-default)
       (method 'hail fing-hail)
       (method 'bye fing-bye)
       (method 'job fing-job)
       (method 'name fing-name)
       (method 'join fing-join)
       
       ;; Shores
       (method 'shor fing-shor)
       (method 'love fing-love)
       (method 'sea fing-sea)
       (method 'deep fing-sea)
       (method 'bay  fing-sea)
       (method 'curs fing-curs)

       ;; town & people
       (method 'opar fing-opar)
       (method 'alch fing-alch)
       (method 'gher fing-gher)
       (method 'crew fing-crew)
       (method 'osca fing-osca)
       (method 'henr fing-henr)
       (method 'bart fing-bart)
       (method 'lia  fing-love)

       ))

(define (mk-fing)
  (bind 
   (kern-mk-char 'ch_fing           ; tag
                 "フィン"           ; name
                 sp_nixie           ; species
                 oc_warrior         ; occ
                 s_nixie_civilian    ; sprite
                 faction-men         ; starting alignment
                 1 2 0               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 3  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'fing-conv         ; conv
                 sch_fing           ; sched
                 'townsman-ai                 ; special ai
                 (mk-inventory (list (list 10 t_spear)))                ; container
                 nil                 ; readied
                 )
   (fing-mk)))
