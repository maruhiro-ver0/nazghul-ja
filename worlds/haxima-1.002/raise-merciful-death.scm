(define merciful-death-x 121)
(define merciful-death-y 87)

(define (raise-merciful-death)
  (let ((loc (mk-loc p_shard 
                     merciful-death-x 
                     merciful-death-y)))
  (kern-log-msg "�����褫���")
  (kern-log-msg "�Ļ��ῼ����椬��夷����")
  (shake-map 10)
  (kern-place-set-subplace p_merciful_death loc)
  (kern-map-set-dirty)
  ))
