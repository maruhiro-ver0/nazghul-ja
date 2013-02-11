;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; ���ѡ����
;;----------------------------------------------------------------------------
(kern-mk-sched 'sch_bart
               (list 0  0  black-barts-bed      "sleeping")
               (list 11 0  black-barts-ship     "working")
               (list 18 0  bilge-water-hall     "idle")
               (list 23 0  black-barts-bed      "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (bart-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; �С��Ȥϰ��������Υ��֥���¤�����ͤǡ����ѡ����˽���Ǥ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (bart-hail knpc kpc)
  (say knpc "�Τ��ʤ��ϸ����ξ��ʤ����ʡ������������ν����Τ��르�֥��Ȳ�ä�����"
       "����"))

(define (bart-default knpc kpc)
  (say knpc "������"))

(define (bart-name knpc kpc)
  (say knpc "�С��ȡ�"))

(define (bart-join knpc kpc)
  (say knpc "����Ϥ��ʤ����̯�����ˤߤơ�Ƭ�򿶤ä�����"))

(define (bart-job knpc kpc)
  (say knpc "�С��Ȥ������롣�褤����"))

(define (bart-bye knpc kpc)
  (say knpc "���㡣"))

;; Trade...
(define (bart-trade knpc kpc)

  (define (buy-ship)
    (let* ((town (loc-place (kern-obj-get-location knpc)))
           (town-loc (kern-place-get-location town))
           (ship-loc (loc-offset town-loc east)))
      (if (ship-at? ship-loc)
          (say knpc "�ࡣ����졢���ʤ����ޤ���ư������")
          (begin
            (kern-obj-relocate (mk-ship) ship-loc nil)
            (take-player-gold oparine-ship-price)
            (say knpc "�������ˤ��롣")
            ))))

  (define (sell-ship)
    (let* ((town (loc-place (kern-obj-get-location knpc)))
           (town-loc (kern-place-get-location town))
           (ship-loc (loc-offset town-loc east))
           (kship (kern-place-get-vehicle ship-loc)))
      (if (null? kship)
          (say knpc "�С����������ʤ��������ߤ���ޤ��褤��")
          (begin
            (say knpc "���Υܥ�����롩�С��ȶ��" 
                 oparine-ship-tradein-price
                 "���Ϥ���������")
            (if (kern-conv-get-yes-no? kpc)
                (begin
                  (say knpc "�С��ȵ������������󤿱�������")
                  (kern-obj-remove kship)
                  (give-player-gold oparine-ship-tradein-price))
                (say knpc "�ࡣ���������ࡣ"))))))

  (if (not (string=? "working" (kern-obj-get-activity knpc)))
      (say knpc "��Ư���ʤ��������ࡪ")
      (begin
        (say knpc "�����㤦��")
        (if (yes? kpc)
            (begin
              (say knpc "�������" oparine-ship-price "�硣���ߤ�����")
              (if (kern-conv-get-yes-no? kpc)
                  (if (player-has-gold? oparine-ship-price)
                      (buy-ship)
                      (begin
                        (say knpc "���­��ʤ����С��Ȥ��ޤ���"
                             "��������̤��ä��Ǥ�������")
                        (kern-conv-end)))
                  (say knpc "�������ˤ���")))
            (begin
              (say knpc "������롩")
              (if (yes? kpc)
                  (sell-ship)
                  (begin
                    (say knpc "�ʤ�С��С��Ȳ����롩")
                    (kern-conv-end))))))))

;; Drink...
(define (bart-drink knpc kpc)
  (if (not (string=? "working" (kern-obj-get-activity knpc)))
      (say knpc "���ࡪ")
      (say knpc "��Ư��������ࡣ")))


;; Townspeople...
(define (bart-opar knpc kpc)
  (say knpc "���ν������롣"))

(define (bart-gher knpc kpc)
  (say knpc "�ġ�����������������϶���˴�̯�ʿ޷�������������"))

(define (bart-alch knpc kpc)
  (say knpc "�ҡ���塦�ȡ�ǳ����Į�����褿��"
       "��²���ܤ��Ƥ롣"))

(define (bart-seaw knpc kpc)
  (say knpc "���ν������롣"))

(define (bart-osca knpc kpc)
  (say knpc "�ġ��ȡ��С��Ȥ褤���Τ�ʤ���"))

(define (bart-henr knpc kpc)
  (say knpc "�С���ͧ�������褤���롪�С��Ȱ��๥����"))

(define bart-conv
  (ifc basic-conv

       ;; basics
       (method 'default bart-default)
       (method 'hail bart-hail)
       (method 'bye bart-bye)
       (method 'job bart-job)
       (method 'name bart-name)
       (method 'join bart-join)
       
       ;; drink
       (method 'drin bart-drink)

       ;; trade
       (method 'trad bart-trade)
       (method 'ship bart-trade)
       (method 'buy bart-trade)
       (method 'sell bart-trade)

       ;; town & people
       (method 'opar bart-opar)
       (method 'alch bart-alch)
       (method 'gher bart-gher)
       (method 'witc bart-seaw)
       (method 'lia bart-seaw)
       (method 'osca bart-osca)
       (method 'henr bart-henr)
       (method 'ja   bart-bye)

       ))

(define (mk-bart)
  (bind 
   (kern-mk-char 'ch_bart           ; tag
                 "�С���"           ; name
                 sp_forest_goblin    ; species
                 nil                 ; occ
                 s_fgob_civilian     ; sprite
                 faction-men         ; starting alignment
                 0 0 0               ; str/int/dex
                 0 0                 ; hp mod/mult
                 0 0                 ; mp mod/mult
                 max-health -1 max-health 0 1  ; hp/xp/mp/AP_per_turn/lvl
                 #f                  ; dead
                 'bart-conv         ; conv
                 sch_bart           ; sched
                 'townsman-ai                 ; special ai
                 (mk-inventory (list (list 1 t_axe)))                 ; container
                 nil                 ; readied
                 )
   (bart-mk)))
