;;----------------------------------------------------------------------------
;; Schedule
;; 
;; �Ф���
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_doris
               (list 0  0  doris-bed "sleeping")
               (list 8  0  white-stag-counter "working"))

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (doris-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; �ɥꥹ���Ф���ˤ����򤭲�����ν���ͤǤ��롣
;;----------------------------------------------------------------------------
(define (doris-name kdoris kplayer)
  (say kdoris "��ϥɥꥹ�������򤭲�����μ�ͤ衣"))

(define (doris-default)
  (say kdoris "����ä��ԤäơĤ������ɤ����뤳�Ȥ�Ǥ��ʤ��"))

(define (doris-join kdoris kplayer)
  (say kdoris "�ξФ��Ϥ��Ǥ�衪�ɤΤ��Ȥ������դ��"))

(define (doris-doris knpc kpc)
  (say knpc "��������Τ��Ȥ衣"))

(define (doris-trade knpc kpc)
  (let ((door (eval 'white-stag-door))
        (price 15))
    ;; is the room still open?
    (if (not (door-locked? (kobj-gob door)))
        ;; yes - remind player
        (say knpc "�Х��ͤ��������Ϥ⤦�����Ƥ���"
             "Į����ޤǽ�����Ǥ���Τ衣")
        ;; no - ask if player needs a room
        (begin
          (say knpc "�����϶��" price "�硢����Į��Ф�ޤǲ��٤Ǥ������Ǥ��ޤ���"
               "������Ǥ�����")
          (if (kern-conv-get-yes-no? kpc)
              ;; yes - player agrees to the price
              (let ((gold (kern-player-get-gold)))
                ;; does player have enough gold?
                (if (>= gold price)
                    ;; yes - player has enough gold
                    (begin
                      (kern-player-set-gold (- gold price))
                      (say knpc "���Τ��ޤ�������¦��ϭ����ʤ�Ǥ���������"
                           "���֤�ü�κǽ�������衣")
                      (send-signal knpc door 'unlock)
                      (kern-conv-end)
                      )
                    ;; no - player does not have enouvh gold)
                    (say knpc "���⤬­��ʤ��褦�͡�"
                         "­���ޤǤ��Τ�������⤭��äơ�ï���򻦤��ƻ��Τ򤢤��äƤ��Ƥϡ�"
                         "ͦ���������Ԥϳ��������Ƥ��ޤ��衣"
                         "�������̥��Ū�����Ф������")))
              ;; no - player does not want the room
              (say knpc "�ǤϤޤ��ε���ˡ�"))))))

(define (doris-lodge knpc kpc)
  (say knpc "������������Ƥ衣���ĤƤ���Τ�Τ��ä����ɡ�ŷ�˾�����Ƥ��ޤ��ޤ�����"
       "���ҤΤۤȤ�ɤϤ��Τ�����ο��ͤ�ι�ͤ衣"))

(define (doris-daddy knpc kpc)
  (say knpc "��ϼ��������������٤Ǥ��νɤ�Ω�Ƥޤ������㤬���Ǥ���ϻ䤬�����Ѥ����ΤǤ���"))

(define (doris-local knpc kpc)
  (say knpc "���Τ�����ˤϡ��Ѥ��Ԥ�����̩�Τ��ꤽ���ʿͤޤǿ�������"
       "�������ѤǤ���ͭǽ�����򤤿ͤǤ⤢�뤱��ɡ�"
       "���ʤ��ϡ������ο�ã����ɤ�ͧ�⡢����Ũ�⸫�Ĥ��뤳�ȤϤǤ��ʤ��Ǥ��礦�͡�"))

(define (doris-woodsman knpc kpc)
  (say knpc "��͡��ڤ��ꡢ������μ褹���ã�ϡ����Τ��������Ƥ����̤������̤�᤮�ƹԤ��ޤ���"
       "Į�Τ�������ϼ���ͷ�Ӥ����Ф�������ޤ�ޤ���"
       "�Ǥ⡢���ο���Ư���Ԥ����̤Ͽ�����ǥ����פ��ޤ���"
       "���������ΤϾ������ࡢ���񡢤����Ȥ��������Τ���Ǥ���"))

(define (doris-travelers knpc kpc)
  (say knpc "���������ʤ��Τ褦�ʿͤ衣"))

(define (doris-gen knpc kpc)
  (say knpc "�ΤΥ��֥���������Ρ����Τ�����Ǥ�����ߤ����ʿͤ衣"
       "�ڡ��δ֤Ǥ������Ƥ���Τ����Ĥ��뤫�⤷��ޤ���͡���Ϥ褯���ߤ���Ƥ��ޤ��衣"))

(define (doris-deric knpc kpc)
  (say knpc "�������ǥ�å��ġġ��񤨤Фɤ�ʿͤ��狼��"
       "���Ω�ɤ����ɡ������ն����ϰ̤˿�������䤹�Ĥ��Ϥʤ��褦�͡�"))

(define (doris-shroom knpc kpc)
  (say knpc "���������ǡ����֥�����Ѥ��ΤäƤ���ȸ����Ԥ⤤�ޤ���"
       "�����ï�����µ��ˤʤä��Ȥ������������ˤʤ�Τ衣"
       "�����ˤ�褯���٤���ޤ��衣"))

(define (doris-abe knpc kpc)
  (say knpc "���饹�ɥ��γؼԤΤ褦�͡����פ�Ĵ���ˤۤȤ�ɤλ��֤���䤷�Ƥ���"
       "�ܤ���ߤ����ʿͤ衣"))

(define (doris-abigail knpc kpc)
  (say knpc "����ϸɻ��ʤΡ�����ǻ䤬�ܻҤˤ����Τ衣���äȼ�ʬ�λҶ����ߤ����ä����ɡ�"
       "�Ǥ��ʤ��ä������λҤξ��褬�԰¡ġ�"
       "��ˤϤ��λҤ����ä���Τ�����ϤǤ��ʤ��"))

(define (doris-goblins knpc kpc)
  (say knpc "����Į�οͤȸ�פ򤷤Ƥ���"
       "��������餫���㤤�ޤ���"
       "�Ǥ⡢���Ϥ��Ĥⷲ��Ƥ��뤫�顢������Į�����뤳�Ȥ�ˡ�Ƕػߤ���Ƥ���Ρ�"
       "���ΤۤȤ�ɤϾ���򤹤����ڤ�夲�ơ����ؤ���äƹԤ��"))

(define (doris-orphaned knpc kpc)
  (say knpc "����롼�ब��ΤȤ���ˤ��λҤ�Ϣ��Ƥ����Ȥ����ޤ��֤������ä���"
       "������Ǹ��Ĥ����Ȥ���¦�ˤ���ξ�Ƥϻ��Ǥ����ȸ��äƤ���"
       "�ʤ����Ǥ����Τ�������Ȥ⻦���줿�Τ�������롼��ϲ������ʤ��ä���"
       "�⤷��������䤬�Τꤿ���ʤ��Τ��⤷��ʤ���"))

(define (doris-hail knpc kpc)
  (say knpc "�򤭲�����ؤ褦������"))

(define (doris-bye knpc kpc)
  (say knpc "�ޤ��ɤ�����"))

(define (doris-default knpc kpc)
  (say knpc "�ɤ����뤳�Ȥ�Ǥ��ʤ��"))

(define (doris-thie knpc kpc)
  (say knpc "�Ƕ�ϲ������ͤϸ��Ƥ���ޤ��󡣥ǥ�å���Ĺ���������������ʹ���Ƥ��뤫���Τ�ޤ���"
       "������⳰�ǲ������Ƥ��뤫�⤷��ޤ���͡�"))

(define (doris-band knpc kpc)
  (say knpc "ι�ͤϤߤ�ʺ��äƤ��롪"
       "�ǥ�å��ˤɤ��ˤ������ߤ��������ΤޤޤǤϾ���ˤʤ�ޤ���"))

(define doris-conv
  (ifc green-tower-conv
       (method 'band      doris-band)
       (method 'hail      doris-hail)
       (method 'bye       doris-bye)
       (method 'default   doris-default)
       (method 'name      doris-name)
       (method 'room      doris-trade)
       (method 'defa      doris-default)
       (method 'job       doris-trade)
       (method 'join      doris-join)
       (method 'dori      doris-doris)
       (method 'buy       doris-trade)
       (method 'innk      doris-trade)
       (method 'whit      doris-lodge)
       (method 'stag      doris-lodge)
       (method 'lodg      doris-lodge)
       (method 'dadd      doris-daddy)
       (method 'loca      doris-local)
       (method 'wood      doris-woodsman)
       (method 'trav      doris-travelers)
       (method 'gen       doris-gen)
       (method 'deri      doris-deric)
       (method 'shro      doris-shroom)
       (method 'abe       doris-abe)
       (method 'abig      doris-abigail)
       (method 'orph      doris-orphaned)
       (method 'gobl      doris-goblins)
       (method 'thie      doris-thie)
       ))

;;----------------------------------------------------------------------------
;; First-time constructor
;;----------------------------------------------------------------------------
(define (mk-doris tag)
  (bind 
   (kern-mk-char tag                 ; tag
                 "�ɥꥹ"            ; name
                 sp_human            ; species
                 nil                 ; occ
                 s_townswoman   ; sprite
                 faction-men         ; starting alignment
                 0 1 0               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 2  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'doris-conv         ; conv
                 sch_doris           ; sched
                 'townsman-ai        ; special ai
                 nil                 ; container
                 (list t_dagger)     ; readied
                 )
   (doris-mk)))
