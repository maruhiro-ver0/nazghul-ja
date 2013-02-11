;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define dennis-lvl 3)
(define dennis-species sp_human)
(define dennis-occ oc_wright)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; 古アブサロット
;;----------------------------------------------------------------------------
(define dennis-bed oa-bed2)
(define dennis-mealplace oa-tbl1)
(define dennis-workplace oa-slaves)
(define dennis-leisureplace oa-dining-hall)
(kern-mk-sched 'sch_dennis
               (list 0  0 dennis-bed          "sleeping")
               (list 7  0 dennis-mealplace    "eating")
               (list 8  0 dennis-workplace    "working")
               (list 12 0 dennis-mealplace    "eating")
               (list 13 0 dennis-workplace    "working")
               (list 18 0 dennis-mealplace    "eating")
               (list 19 0 dennis-leisureplace "idle")
               (list 22 0 dennis-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (dennis-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; デニスは呪われた者の信奉者で、古アブサロットに住んでいる。
;; 彼は信じやすいが、まだ完全には染まっていない。
;;----------------------------------------------------------------------------

;; Basics...
(define (dennis-hail knpc kpc)
  (say knpc "こんにちは。"))

(define (dennis-default knpc kpc)
  (say knpc "そのあたりのことはわかりません。"))

(define (dennis-name knpc kpc)
  (say knpc "デニスです。"))

(define (dennis-join knpc kpc)
  (say knpc "［彼はあざ笑った。］そうは思いません。旅の人。"))

(define (dennis-job knpc kpc)
  (say knpc "サイラス師の生徒です。"))

(define (dennis-bye knpc kpc)
  (say knpc "さようなら。"))

;; Tier 2
(define (dennis-stud knpc kpc)
  (say knpc "サイラス師から、自分の意思に集中すること、そして私の前進の妨げになるものを犠牲にすることを教わっています。私は自分の欲望に到達できることでしょう。そうでなくても、少なくとも呪われた者の生き方を極めることができるでしょう。"))

(define (dennis-accu knpc kpc)
  (say knpc "呪われた者は誤解されています。己の欲望を追い求めるのは、悪ではなく善なのです！なぜ我々の敵はそれがわからないのでしょうか？"))

(define (dennis-enem knpc kpc)
  (say knpc "グラスドリンの虐殺者と愚かな年寄りの魔道師はさらなる血を求めているのです！"))

(define (dennis-ways knpc kpc)
  (say knpc "呪われた者の生き方は段階的に生徒に明かされていきます。それぞれの段階で信奉者は力を得ていきます。次の段階に達するためには、生徒はふさわしい犠牲をささげる儀式を行わなければなりません。"))

(define (dennis-sacr knpc kpc)
  (say knpc "犠牲の儀式は秘密にされています。あなたのような何も知らない人には話せません。"))

(define (dennis-powe knpc kpc)
  (say knpc "想像もできないような力が、それをつかみ取る意志のある者を待っています。"))

(define (dennis-sila knpc kpc)
  (say knpc "サイラス師は力のある魔術師、そして賢明な先生です。"))

(define (dennis-absa knpc kpc)
  (say knpc "あの愚か者たちは、我々がそこにいると考えてアブサロットを破壊しました！しかし彼らは町の真下にあるこの古いアブサロットのことを知りませんでした。"))

(define (dennis-old knpc kpc)
  (say knpc "この遺跡を歩いていると、畏敬の念に駆られます。少し不気味ですが。古代の人々は奇妙な信仰を持っていたのですね！"))

(define (dennis-sele knpc kpc)
  (say knpc "［彼は顔を赤くした。］悪いことは言いません。彼女には近づかないほうがいいですよ！")
  (kern-conv-end)
  )

(define dennis-conv
  (ifc basic-conv

       ;; basics
       (method 'default dennis-default)
       (method 'hail dennis-hail)
       (method 'bye dennis-bye)
       (method 'job dennis-job)
       (method 'name dennis-name)
       (method 'join dennis-join)
       
       (method 'sele dennis-sele)
       (method 'stud dennis-stud)
       (method 'teac dennis-stud)
       (method 'accu dennis-accu)
       (method 'enem dennis-enem)
       (method 'ways dennis-ways)
       (method 'sacr dennis-sacr)
       (method 'powe dennis-powe)
       (method 'sila dennis-sila)
       (method 'absa dennis-absa)
       (method 'old dennis-old)
       ))

(define (mk-dennis)
  (bind 
   (kern-mk-char 
    'ch_dennis           ; tag
    "デニス"             ; name
    dennis-species         ; species
    dennis-occ              ; occ
    s_townsman     ; sprite
    faction-men      ; starting alignment
    0 1 0            ; str/int/dex
    0 0              ; hp mod/mult
    0 0              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    dennis-lvl
    #f               ; dead
    'dennis-conv         ; conv
    sch_dennis           ; sched
    'spell-sword-ai              ; special ai
    nil              ; container
    (list t_staff)              ; readied
    )
   (dennis-mk)))
