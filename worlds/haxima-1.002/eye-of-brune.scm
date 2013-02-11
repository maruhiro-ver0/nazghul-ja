;; The Eye of Brune is a special mechanism that shows a map of the entire Shard
;; when handled successfully.

(define (eye-of-brune-handle keye khandler)
  (kern-obj-set-sprite keye s_eye_open)
  (kern-log-msg "*** 大きな声が聞こえた ***")
  (kern-log-msg "汝は何を為す者か？")
  (let ((answer (kern-conv-get-string khandler)))
    (cond ((string=? answer "カンシ")
           (kern-log-msg "見るがよい！")
           (let ((kimage (kern-image-load "map.png")))
             (kern-map-set-image kimage)
             (kern-print "よく見たらキーを押せ…\n")
             (ui-waitkey)
             (kern-map-set-image nil)
             (kern-image-free kimage)))
          (else
           (kern-log-msg "何と軽率、怠慢、不敬な者よ！")
           (apply-lightning khandler)
           (kern-char-set-intelligence khandler
                                       (- (kern-char-get-base-intelligence khandler) 
                                          1))
           (kern-log-msg (kern-obj-get-name khandler) "は知能を失った！")
           )))
  (kern-obj-set-sprite keye s_eye_closed)
  )

(define eye-of-brune-ifc
  (ifc nil
       (method 'handle eye-of-brune-handle)
       ))

(mk-obj-type 't_eye_of_brune "ブルヌの目" s_eye_closed layer-mechanism eye-of-brune-ifc)
