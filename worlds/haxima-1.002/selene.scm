;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define selene-lvl 5)
(define selene-species sp_human)
(define selene-occ nil)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; �ť��֥���å�
;;----------------------------------------------------------------------------
(define selene-bed oa-bed3)
(define selene-mealplace oa-tbl2)
(define selene-workplace oa-baths)
(define selene-leisureplace oa-temple)
(kern-mk-sched 'sch_selene
               (list 0  0 selene-bed          "sleeping")
               (list 7  0 selene-mealplace    "eating")
               (list 8  0 selene-workplace    "working")
               (list 12 0 selene-mealplace    "eating")
               (list 13 0 selene-workplace    "working")
               (list 18 0 selene-mealplace    "eating")
               (list 19 0 selene-leisureplace "idle")
               (list 22 0 selene-bed          "sleeping")
               )

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (selene-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ����ͤϼ���줿�Ԥζ����˽��������Ǥ��롣
;; ������԰���ǡ���ƻ���ǡ�����Ƥ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (selene-hail knpc kpc)
  (say knpc "�Τ��μ㤤�����Ϥ��ʤ��򤤤�����äݤ��ܤǸ��Ƥ��롣��"))

(define (selene-default knpc kpc)
  (say knpc "��������Բ��ʲ���Ω�ƤƾФä�����"))

(define (selene-name knpc kpc)
  (say knpc "����͡�"))

(define (selene-join knpc kpc)
  (say knpc "�������Ƭ�򿶤ꡢ�Ϥä�����Ǥä�����"))

(define (selene-job knpc kpc)
  (say knpc "������ϸ��򤹤��᤿����ʪ��ͷ��Ǥ���Ρ�"))

(define (selene-bye knpc kpc)
  (say knpc "������Ϥ��ʤ�����ä��塢�����Ǹ��ä����Ϥޤ��񤤤ޤ��礦����ͺ����"))

(define (selene-play knpc kpc)
  (say knpc "ʪ�Ŀ͡ġ�"))

(define (selene-peop knpc kpc)
  (say knpc "�ͤ򤷤����褦�ˤ���Τ������ʤΡ�"))

(define (selene-want knpc kpc)
  (say knpc "���������Ȳ��Ǥ⡣¾�Ϥɤ��Ǥ⤤���Ρ������ͤ򤷤����褦�ˤ���Τ�������"
       "�⤷�ͤ��������ʤ��ä���ġ�����ϸ��򤹤��ᡢ���������ȾФä�����"))

(define (selene-accu knpc kpc)
  (say knpc "����ʤ˰����ʤ��Ρ���ͺ���󡣤ɤ��餫�ȸ����ȳڤ����Ρ�"))

(define (selene-fun knpc kpc)
  (say knpc "����줿�Ԥˤʤꤿ���������󤤤��衪��ϵ����δ֤�������"))

(define (selene-sacr knpc kpc)
  (say knpc "��ʬ��õ���ʤ������Х���"))

(define (selene-denn knpc kpc)
  (say knpc "��򤷤����褦�ˤ���Τϴ�ñ�ʤΡ���ϻ���ݤ��äƤ롣"
       "�����ƻ���ߤ����äƤ��롣"))

(define (selene-sila knpc kpc)
  (say knpc "��������������Ӥ����褦�˸������������ƶ�˽�ˤʤä�����"
       "���ǻ�򺤤餻��Ρ����ä��Ԥäơ�")
  (kern-conv-end))

(define selene-conv
  (ifc basic-conv

       ;; basics
       (method 'default selene-default)
       (method 'hail selene-hail)
       (method 'bye  selene-bye)
       (method 'job  selene-job)
       (method 'name selene-name)
       (method 'join selene-join)

       (method 'play selene-play)
       (method 'peop selene-peop)
       (method 'men  selene-peop)
       (method 'want selene-want)
       (method 'accu selene-accu)
       (method 'fun  selene-fun)
       (method 'sacr selene-sacr)
       (method 'denn selene-denn)
       (method 'sila selene-sila)
       ))

(define (mk-selene)
  (bind 
   (kern-mk-char 
    'ch_selene           ; tag
    "�����"             ; name
    selene-species         ; species
    selene-occ              ; occ
    s_townswoman     ; sprite
    faction-men      ; starting alignment
    0 2 1            ; str/int/dex
    0 0              ; hp mod/mult
    0 0              ; mp mod/mult
    max-health ; hp
    -1                   ; xp
    max-health ; mp
    0
    selene-lvl
    #f               ; dead
    'selene-conv         ; conv
    sch_selene           ; sched
    'townsman-ai              ; special ai
    nil              ; container
    (list t_dagger)              ; readied
    )
   (selene-mk)))
