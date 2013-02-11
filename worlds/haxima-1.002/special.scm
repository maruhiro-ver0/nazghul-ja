;;----------------------------------------------------------------------------
;; Special -- one-off stuff that needs to be kern-loaded and doesn't really fit
;; anywhere else.
;;----------------------------------------------------------------------------

(kern-mk-sprite-set 'ss_special 32 32 3 3 0 0 "special.png")

(kern-mk-sprite 's_gold_skull ss_special 1 0 #f 0)
(kern-mk-sprite 's_power_core ss_special 1 1 #f 0)

;;----------------------------------------------------------------------------
;; Bandit-Hideout generator -- 
;; procedure invoked by a step trigger to place the bandit hideout on the world map.
;; Should return true iff it triggers to remove the step generator that invokes it.
;;----------------------------------------------------------------------------
(define bandit-hideout-loc (list 'p_shard 72 63))
(define (mk-bandit-hideout kbeing)
  (if (eqv? kbeing 
            (kern-get-player))
      (begin
        (kern-log-msg "�ڡ��Ǳ����줿�����Ϥ򸫤Ĥ�����ȴ���ȤοϤ���ä��������ͱƤ�����Ĥ��Ƥ��롪")
        (kern-place-set-subplace p_bandit_hideout_l1
                                 (eval-loc bandit-hideout-loc))
        (kern-map-set-dirty)
        #t)
      #f))


;;----------------------------------------------------------------------------
;; Angriss Lair generator -- procedure invoked by a step trigger to create
;; Angriss's Lair. Should return true iff it triggers to remove the step
;; generator that invokes it.
;;----------------------------------------------------------------------------
(define angriss-lair-loc (list 'p_shard 88 69))
(define (mk-angriss-lair kbeing)
  (if (eqv? kbeing 
            (kern-get-player))
      (begin
        (kern-log-msg "�ڡ����𻨤������Ƥ����\n�ڤˤ��֤��������Ƥ��ꡢ�������ֻĳ��פ���ޤ�֤鲼���äƤ��롣\n���������󥰥ꥹ�ν��߲Ȥ���������⤷��ʤ���")
        (kern-place-set-subplace p_angriss_lair 
                                 (eval-loc angriss-lair-loc))
        (kern-map-set-dirty)
        #t)
      #f))


;;----------------------------------------------------------------------------
;; Mans-Hideout generator -- 
;; procedure invoked by a step trigger to place the MAN's hideout on the world map.
;; Should return true iff it triggers to remove the step generator that invokes it.
;;----------------------------------------------------------------------------
(define the-mans-hideout-loc (list 'p_shard 92 10))
(define (mk-mans-hideout kbeing)
  (if (eqv? kbeing 
            (kern-get-player))
      (begin
        (kern-log-msg "�����ʾ��˱����줿������򸫤Ĥ�����")
        (kern-place-set-subplace p_mans_hideout
                                 (eval-loc the-mans-hideout-loc))
        (kern-map-set-dirty)
        #t)
      #f))


;;----------------------------------------------------------------------------
;; Brundegardt generator -- 
;; procedure invoked by a step trigger to place Brundegardt on the world map.
;; Should return true iff it triggers to remove the step generator that invokes it.
;;----------------------------------------------------------------------------
(define brundegardt-loc (list 'p_shard 76 40))
(define (mk-brundegardt kbeing)
  (if (eqv? kbeing 
            (kern-get-player))
      (begin
        (kern-log-msg "�����줿��ƻ�򤿤ɤ�ȡ�������ʢ���ڡ���ʤ��줿��̯�ʾ��ˤ��ɤ��夤����")
        (kern-place-set-subplace p_brundegardt
                                 (eval-loc brundegardt-loc))
        (kern-map-set-dirty)
        #t)
      #f))


;; ----------------------------------------------------------------------------
;; The Warritrix's note
;; ----------------------------------------------------------------------------
(mk-reusable-item 
 't_warritrix_orders "����̿���" s_lexicon norm
 (lambda (klexicon kuser)
   (kern-ui-page-text
   "Ʈ�Τؤ�̿���"
   "���饹�ɥ��ǺǤ���¤����żԡ�"
   "����줿��Ʋ�α������Ǽ���줿�Ԥ����ޤäƤ���"
   "���������롣"
   "������Ĵ���򳫻Ϥ��衣ƶ��������õ������ޤǤ�"
   "Υ��ƤϤʤ�ʤ���"
   "�ݻ��ᴱ�����ե꡼��"
   "�ɵ�������̿���Ϥ��������˴����뤳�ȡ�")))


;; Kraken lakes kraken trigger
(define (spawn-kraken-lakes-sea-serpent kbeing)
  (kern-log-msg "�����˲����������")
  (kern-obj-put-at (spawn-npc 'kraken 8) (mk-loc p_deepness 31 34))
  (kern-obj-put-at (spawn-npc 'kraken 8) (mk-loc p_deepness 32 35))
  (kern-obj-put-at (spawn-npc 'kraken 8) (mk-loc p_deepness 30 29))
  #t)

;; Locations referred to more than once
(define lost-halls-loc (list 'p_shard 39 75))

;; Power core for voidship
(mk-quest-obj-type 't_power_core "�����ϧ��" s_power_core layer-item obj-ifc)

;; Luximene begins the game as a Lich King, when defeated he drops his skull,
;; which can be used with the Necromancer to summon his shade.
(mk-quest-obj-type 't_lich_skull "�饯���ޥ˲���Ƭ����" s_gold_skull layer-item obj-ifc)

;; grow -- trigger hook fx to create items (eg, growing reagents, hence the name)
(define (grow-trig ktrig ktype-tag dice)
  (println "grow-trig")
  (println "  ktrig=" ktrig)
  (println "  ktype-tag=" ktype-tag)
  (println "  dice=" dice)
  (kern-obj-put-at (kern-mk-obj (eval ktype-tag) (kern-dice-roll 
                                       dice))
                   (kern-obj-get-location ktrig)))
