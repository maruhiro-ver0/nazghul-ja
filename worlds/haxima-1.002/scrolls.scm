;; ============================================================================
;; scrolls.scm -- �Ȥ��봬ʪ
;; ============================================================================

(kern-mk-sprite-set 'ss_scrolls 32 32 3 4 0 0 "scrolls.png")

(kern-mk-sprite 's_an_tym_scroll          ss_scrolls 1 0 #f 0) ;; stop time
(kern-mk-sprite 's_in_mani_corp_scroll    ss_scrolls 1 1 #f 0) ;; resurrect
(kern-mk-sprite 's_vas_rel_por_scroll     ss_scrolls 1 2 #f 0) ;; gate travel
(kern-mk-sprite 's_xen_corp_scroll        ss_scrolls 1 3 #f 0) ;; kill

(kern-mk-sprite 's_sanct_lor_scroll       ss_scrolls 1 4 #f 0) ;; invisibility
(kern-mk-sprite 's_in_quas_xen_scroll     ss_scrolls 1 5 #f 0) ;; clone
(kern-mk-sprite 's_in_vas_por_ylem_scroll ss_scrolls 1 6 #f 0) ;; tremor
(kern-mk-sprite 's_an_xen_ex_scroll       ss_scrolls 1 7 #f 0) ;; charm

(kern-mk-sprite 's_in_an_scroll           ss_scrolls 1 8 #f 0) ;; negate
(kern-mk-sprite 's_in_ex_por_scroll       ss_scrolls 1 9 #f 0) ;; unlock magic
(kern-mk-sprite 's_vas_mani_scroll        ss_scrolls 1 10 #f 0) ;; great heal
(kern-mk-sprite 's_wis_quas_scroll        ss_scrolls 1 11 #f 0) ;; reveal

(kern-mk-sprite 's_wis_an_ylem_scroll     ss_scrolls 1 13 #f 0) ;; xray

(kern-mk-sprite 's_rel_xen_quas_scroll    ss_scrolls 1 14 #f 0) ;; monster alignment

(define (mk-scroll tag name sprite spell)
  (mk-usable-item tag name sprite norm 
                  (lambda (kscrolltype kuser)
                    (apply spell (list kuser)))))

(define (in-wilderness? caster)
	(let ((place (loc-place (kern-obj-get-location caster))))
	(and 
		(kern-place-is-wilderness? place)
		(not (kern-place-is-combat-map? place))
	)))

;;-----------------------------------------------------------------------------------------
;; Scroll Functions
;;-----------------------------------------------------------------------------------------

(define (scroll-xen-corp caster)
	(if (in-wilderness? caster)
		result-not-here
		(user-cast-ranged-targeted-spell caster 4 cast-kill-proc)
	))
		
(define (scroll-in-quas-xen caster)
	(if (in-wilderness? caster)
		result-not-here
		(cast-ui-basic-ranged-spell powers-clone
			caster 
			(powers-clone-range 12)
			12)
	))

(define (scroll-in-vas-por-ylem caster)
	(if (in-wilderness? caster)
		result-not-here
		(powers-tremor caster caster 12)
	))

(define (scroll-an-xen-ex caster)
	(if (in-wilderness? caster)
		result-not-here
		(cast-ui-basic-ranged-spell powers-charm
			caster 
			(powers-charm-range 12)
			12)
	))
		
(define (scroll-rel-xen-quas caster)
  (if (in-wilderness? caster)
      result-not-here
      (rel-xen-quas caster))
  )

(define (scroll-rel-xen-quas caster)
  (if (in-wilderness? caster)
      result-not-here
      (rel-xen-quas caster))
  )

(define (scroll-paralyze caster)
  (paralyze caster)
  )

;;-----------------------------------------------------------------------------------------
;; Scroll List
;;-----------------------------------------------------------------------------------------

(mk-scroll 't_an_tym_scroll "������� <An Tym> �δ�ʪ" s_an_tym_scroll an-tym) ;; context-any
(mk-scroll 't_in_mani_corp_scroll "���� <In Mani Corp> �δ�ʪ" s_in_mani_corp_scroll in-mani-corp)  ;; context-any
(mk-scroll 't_vas_rel_por_scroll "�� <Vas Rel Por> �δ�ʪ" s_vas_rel_por_scroll vas-rel-por)  ;; context-any
(mk-scroll 't_xen_corp_scroll "�� <Xen Corp> �δ�ʪ" s_xen_corp_scroll scroll-xen-corp) 
(mk-scroll 't_sanct_lor_scroll "�ԲĻ� <Sanct Lor> �δ�ʪ" s_sanct_lor_scroll sanct-lor) ;; context-any
(mk-scroll 't_in_quas_xen_scroll "ʣ�� <In Quas Xen> �δ�ʪ" s_in_quas_xen_scroll scroll-in-quas-xen)
(mk-scroll 't_in_vas_por_ylem_scroll "�Ͽ� <In Vas Por Ylem> �δ�ʪ" s_in_vas_por_ylem_scroll scroll-in-vas-por-ylem) 
(mk-scroll 't_an_xen_ex_scroll "̥λ <An Xen Ex> �δ�ʪ" s_an_xen_ex_scroll scroll-an-xen-ex)
(mk-scroll 't_in_an_scroll "���� <In An> �δ�ʪ" s_in_an_scroll in-an) ;; context-any
(mk-scroll 't_in_ex_por_scroll "������� <In Ex Por> �δ�ʪ" s_in_ex_por_scroll in-ex-por)  ;; context-any??
(mk-scroll 't_vas_mani_scroll "����� <Vas Mani> �δ�ʪ" s_vas_mani_scroll vas-mani) ;; context-any
(mk-scroll 't_wis_quas_scroll "�Ļ� <Wis Quas> �δ�ʪ" s_wis_quas_scroll wis-quas) ;; context-any
(mk-scroll 't_wis_an_ylem_scroll "Ʃ�� <Wis An Ylem> �δ�ʪ" s_wis_an_ylem_scroll wis-an-ylem) ;; context-any
(mk-scroll 't_rel_xen_quas_scroll "�ø��� <Rel Xen Quas> �δ�ʪ" s_rel_xen_quas_scroll rel-xen-quas)
(mk-scroll 't_test_paralyze_scroll "��줵���ơ�" s_an_tym_scroll scroll-paralyze)