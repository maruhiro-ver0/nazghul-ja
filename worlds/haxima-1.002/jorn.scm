;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define jorn-lvl 5)
(define jorn-species sp_human)
(define jorn-occ oc_wrogue)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; 緑の塔
;;----------------------------------------------------------------------------
(define jorn-bed gt-jorn-bed)
(define jorn-mealplace gt-ws-tbl1)
(define jorn-workplace gt-jorn-hut)
(define jorn-leisureplace gt-ws-hall)
(kern-mk-sched 'sch_jorn
               (list 0  0 jorn-bed          "sleeping")
               (list 11 0 jorn-mealplace    "eating")
               (list 12 0 jorn-workplace    "working")
               (list 18 0 jorn-mealplace    "eating")
               (list 19 0 jorn-leisureplace "idle")
               (list 24 0 jorn-workplace    "working")               
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (jorn-mk) nil)

(define (jorn-on-death knpc)
	(kern-obj-put-at (kern-mk-obj t_skull_ring_j 1) (kern-obj-get-location knpc))
	)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ジョーンは元海賊の悪党で、今は緑の塔にいる。
;; 彼はかつて慈悲深い死号の乗組員で、亡霊となったガーティ船長に復讐のため追わ
;; れている。
;;----------------------------------------------------------------------------

;; Basics...
(define (jorn-hail knpc kpc)
  (say knpc "［あなたは乱暴そうな不機嫌な男と会った。］何だ？"))

(define (jorn-default knpc kpc)
  (say knpc "他を当たってくれ。"))

(define (jorn-name knpc kpc)
  (say knpc "俺はジョーンだ。聞いたことあるか？")
   (quest-data-update 'questentry-ghertie 'jorn-loc 1)
  (if (yes? kpc)
      (say knpc "そりゃいい。警告されただろう？")
      (say knpc "お気の毒に。怪我したくないだろう？")))

(define (jorn-join knpc kpc)
  (say knpc "［彼は冷ややかに笑った。］"))

(define (jorn-job knpc kpc)
  (say knpc "あんたには関係ないね。"))

(define (jorn-bye knpc kpc)
  (say knpc "［彼はあなたを無視した。］"))


;; Town & Townspeople

;; Quest-related
(define (jorn-pira knpc kpc)
  (say knpc "癪にさわる奴だな。"))

(define (jorn-ring knpc kpc)
      (quest-data-update 'questentry-ghertie 'jorn-loc 1)
        (say knpc "［彼は冷たい目であなたを見た。］なに？これが欲しいのか？")
        (if (no? kpc)
            (say knpc "なら黙ってろ。")
            (begin
              (say knpc "ならばこの指を切らねばならんな。"
                   "どうだ？切る準備はできたか？")
              (if (no? kpc)
                  (say knpc "［彼はあざ笑った。］そうは思わないね。")
                  (begin
                    (say knpc "［叫び声を上げると、彼は見えないほどの速さで剣を抜き、あなたと同じように切りつけてきた！］")
                    (kern-being-set-base-faction knpc faction-outlaw)
                    (kern-conv-end))))))

(define jorn-conv
  (ifc basic-conv

       ;; basics
       (method 'default jorn-default)
       (method 'hail jorn-hail)
       (method 'bye  jorn-bye)
       (method 'job  jorn-job)
       (method 'name jorn-name)
       (method 'join jorn-join)
       
       ;; other responses
       (method 'pira jorn-pira)
       (method 'gher jorn-pira)
       (method 'merc jorn-pira)
       (method 'ring jorn-ring)

       ))

(define (mk-jorn)
	(let ((knpc
		(kern-mk-char 
			'ch_jorn           ; tag
			"ジョーン"         ; name
			jorn-species     ; species
			jorn-occ         ; occ
			s_brigand        ; sprite
			faction-men      ; starting alignment
			2 0 1            ; str/int/dex
			0 0              ; hp mod/mult
			0 0              ; mp mod/mult
			max-health ; hp
			-1                ; xp
			max-health ; mp
			0
			jorn-lvl
			#f               ; dead
			'jorn-conv       ; conv
			sch_jorn           ; sched
			'spell-sword-ai  ; special ai

			;; container
			(mk-inventory (list
				(list 1 t_sword_2)
				(list 1 t_dagger_4)
				(list 1 t_armor_leather_2)
				(list 1 t_leather_helm_2)
				(list 67 t_gold_coins)
				(list 3 t_picklock)
				(list 3 t_heal_potion)
			))
			nil              ; readied
		)))
		(bind knpc  (jorn-mk))
		(kern-char-force-drop knpc #t)
		(kern-char-arm-self knpc)
		(kern-obj-add-effect knpc 
			ef_generic_death
			'jorn-on-death)
		knpc
	))
