(kern-mk-sprite-set 'ss_reagents 32 32 1 9 0 0 "reagents.png")

(kern-mk-sprite 's_spider_silk ss_reagents    1 0 #f 0)
(kern-mk-sprite 's_sulphorous_ash ss_reagents 1 1 #f 0)
(kern-mk-sprite 's_ginseng ss_reagents        1 2 #f 0)
(kern-mk-sprite 's_blood_moss ss_reagents     1 3 #f 0)
(kern-mk-sprite 's_garlic ss_reagents         1 4 #f 0)
(kern-mk-sprite 's_black_pearl ss_reagents    1 5 #f 0)
(kern-mk-sprite 's_nightshade ss_reagents     1 6 #f 0)
(kern-mk-sprite 's_mandrake ss_reagents       1 7 #f 0)
(kern-mk-sprite 's_royal_cape ss_reagents 1 8 #f 0)


;; Extend the basic object interface to support mixing. Currently mix does
;; nothing in the script, but it's important to let the kernel know that this
;; type of object can be used with the M)ix command.
(define reagent-ifc
  (ifc obj-ifc
       (method 'mix (lambda () '()))))

(define (mk-reagent-type tag name sprite)
  (mk-obj-type tag name sprite layer-item reagent-ifc))

(define reagent-types
  (list
   (list 'sulphorous_ash "Î²²«¤Î³¥"       s_sulphorous_ash)
   (list 'ginseng        "¿Í»²"           s_ginseng)
   (list 'garlic         "ÂçÉÇ"           s_garlic)
   (list 'spider_silk    "ÃØéá¤Î»å"       s_spider_silk)
   (list 'blood_moss     "·ì¤ÎÂİ"         s_blood_moss)
   (list 'black_pearl    "¹õ¿¿¼î"         s_black_pearl)
   (list 'nightshade     "¥Ê¥¤¥È¥·¥§¥¤¥É" s_nightshade)
   (list 'mandrake       "¥Ş¥ó¥É¥ì¥¤¥¯"   s_mandrake)
   (list 't_royal_cape   "¥í¥¤¥ä¥ë¥±¡¼¥×Âû" s_royal_cape)
   ))

(map (lambda (type) (apply mk-reagent-type type)) reagent-types)
