;; The Eye of Brune is a special mechanism that shows a map of the entire Shard
;; when handled successfully.

(define (eye-of-brune-handle keye khandler)
  (kern-obj-set-sprite keye s_eye_open)
  (kern-log-msg "*** �礭������ʹ������ ***")
  (kern-log-msg "��ϲ���٤��Ԥ���")
  (let ((answer (kern-conv-get-string khandler)))
    (cond ((string=? answer "����")
           (kern-log-msg "���뤬�褤��")
           (let ((kimage (kern-image-load "map.png")))
             (kern-map-set-image kimage)
             (kern-print "�褯�����饭���򲡤���\n")
             (ui-waitkey)
             (kern-map-set-image nil)
             (kern-image-free kimage)))
          (else
           (kern-log-msg "���ȷ�Ψ���������ԷɤʼԤ衪")
           (apply-lightning khandler)
           (kern-char-set-intelligence khandler
                                       (- (kern-char-get-base-intelligence khandler) 
                                          1))
           (kern-log-msg (kern-obj-get-name khandler) "����ǽ�򼺤ä���")
           )))
  (kern-obj-set-sprite keye s_eye_closed)
  )

(define eye-of-brune-ifc
  (ifc nil
       (method 'handle eye-of-brune-handle)
       ))

(mk-obj-type 't_eye_of_brune "�֥�̤���" s_eye_closed layer-mechanism eye-of-brune-ifc)
