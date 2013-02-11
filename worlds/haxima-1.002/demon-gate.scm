(kern-load "nossifer.scm")

;; constants
(define demon-gate-x 6)
(define demon-gate-y 9)

;; demon gate gob
(define (mk-demon-gate-gob) (list 8 #f #f))
(define (demon-gate-unlock gob) (set-car! gob (- (car gob) 1)))
(define (demon-gate-completely-unlocked? gob) (= (car gob) 0))
(define (demon-gate-opened? gob) (cadr gob))
(define (demon-gate-opened! gob) (set-car! (cdr gob) #t))
(define (end-game-played? gob) (caddr gob))
(define (end-game-played! gob) (set-car! (cddr gob) #t))


;; demon gate procs
(define (summon-nossifer kplace)
  (kern-log-msg "何者かが姿を現した。")
  (let ((knpc (mk-nossifer)))
    (kern-obj-put-at knpc
                     (mk-loc kplace
                             demon-gate-x
                             demon-gate-y))
    (kern-map-repaint)
    (kern-sleep 2000)
    (kern-conv-begin knpc)
  ))

(define (open-demon-gate kplace)
  (let* ((loc (mk-loc kplace
                      demon-gate-x
                      demon-gate-y))
         (gate (mk-moongate nil))
         (stages (list (list '()                       0)
                       (list s_blackgate_quarter        32)
                       (list s_blackgate_half           64)
                       (list s_blackgate_three_quarters 96)
                       (list s_blackgate_full           128))))
    (kern-map-flash 100)
    (kern-sleep 2000)
    (kern-log-msg "暗い門が開いた。")
    (kern-obj-put-at gate loc)
    (moongate-animate gate stages)
    (kern-sleep 2000)
    (summon-nossifer kplace)
    (kern-obj-remove gate)
    ))


(define (demon-gate-on kgate kchar)
  (let ((dgate (gob kgate)))
    (demon-gate-unlock dgate)))

(define (nossifer-vanquished?)
  (= 0 (num-hostiles (kern-get-player))))

(define (end-game)
  (kern-map-flash 1000)
  (kern-map-repaint)
  (kern-log-msg "**************************")
  (kern-sleep 2000)
  (kern-log-msg "ノシファーとその手先は打ち倒された。")
  (kern-sleep 2000)
  (kern-log-msg "悪魔の門は閉じた。")
  (kern-sleep 2000)
  (kern-log-msg "それは再び開かれるのだろうか？")
  (kern-sleep 2000)
  (kern-log-msg "迷い人はシャルドに永遠に捕らわれたままなのか？")
  (kern-sleep 2000)
  (kern-log-msg "彼は、もしかすると、もはや迷い人ではないのか？")
  (kern-sleep 2000)
  (kern-log-msg "彼が…")
  (kern-sleep 4000)
  (kern-log-msg "…征服者になる時が来たのだろうか？")
  (kern-sleep 2000)
  (kern-log-msg "その答えは　Haxima II: 征服者　にある。")
  (kern-log-msg "**************************")

  (kern-log-msg "*** おめでとう ***")
  (kern-log-msg "あなたはこのゲームを完了した！")
  (kern-log-msg "何かキーを押すと終了する。")
  (kern-ui-waitkey)

  (kern-end-game)
  )

(define (demon-gate-exec kgate)
	(let ((dgate (gob kgate)))
		(if (and (not (end-game-played? dgate))
				(demon-gate-opened? dgate)
				(nossifer-vanquished?))
			(begin
				(end-game)
				(end-game-played! dgate)
			))
		(println (demon-gate-completely-unlocked? dgate) " "
					(demon-gate-opened? dgate) " " (nossifer-vanquished?))
		(if (and (demon-gate-completely-unlocked? dgate)
				(not (demon-gate-opened? dgate)))
			(begin
				(open-demon-gate (get-place kgate))
				(demon-gate-opened! dgate)
			)
		)
	))
        

;; demon gate type ifc
(define demon-gate-ifc
  (ifc '()
       (method 'on demon-gate-on)
       (method 'exec demon-gate-exec)
       ))

;; demon gate type
(mk-obj-type 't_demon_gate nil nil layer-none demon-gate-ifc)

;; demon gate ctor
(define (mk-demon-gate)
  (kern-tag 'demon-gate
            (bind (kern-obj-set-ignore-time-stop (kern-mk-obj t_demon_gate 1)
                                                 #t)
                  (mk-demon-gate-gob))))
