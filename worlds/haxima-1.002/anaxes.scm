;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(define anaxes-lvl 6)
(define anaxes-species sp_lich)
(define anaxes-occ oc_wizard)

;;----------------------------------------------------------------------------
;; Schedule
;; 
;; �֥��ǥ����ɤ�ƶ���ο���
;;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Gob
;;----------------------------------------------------------------------------
(define (anaxes-mk) nil)

;;----------------------------------------------------------------------------
;; Conv
;; 
;; ���ʥ������ϱ��λ�����ѻդΥ�å�/�Ƥǡ����Ĥƥ饯���ޥˤ˻Ť��Ƥ���
;; �������Υȿ������
;; ���ʥ������ϥ֥��ǥ����ɤμ���줿�ΰ衢ƶ���ο��¤ˤ��롣
;;----------------------------------------------------------------------------

;; Basics...
(define (anaxes-hail knpc kpc)
  (meet "�Τ��ʤ��ϸؤ餷���ʡ����Τ˻����Ǥ�����ѻդαƤȲ�ä�����")
  (say knpc "���̤����饯���ޥˤλȤ�����")
  (if (yes? kpc)
      (say knpc "¾��ï���ȡ�����ϻĵԤ����ʾФ����⤫�٤�����"
           "���̤��ϻ���������ˤä���"
           "��������򽾤碌�뤳�ȤϤǤ��̡�")
      (say knpc "����ʡ��ۤ����ȿ�դκ��õ���Ƥ��뤳�Ȥ��ΤäƤ��롪"))
  (aside kpc 'ch_nate 
         "�Τ����䤭��ö�ᡢ�饯���ޥˤϱ��Τ˻����Ϥ��Ǥ�����")
  )


(define (anaxes-default knpc kpc)
  (say knpc "������ۤäƤ��ʤ��򸫤Ƥ��롣��"))

(define (anaxes-name knpc kpc)
  (say knpc "��ϥ��ʥ����������ĤƤϽ���ͤ���ΰ�ͤǤ��ä���"))

(define (anaxes-luxi knpc kpc)
  (say knpc "�饯���ޥˤϿͤǤϤʤ������̤򤷤�����Ǥ��롪"
       "ȿ��μ��ޤ����꤬�Ф�Ф���򴢤��äƤ�����"
       "�����ƺ��ǤϿ����फ������ˡ��õ�äƤ��롣")
  (prompt-for-key)
  (say knpc "�ۤϤ��ο��¤ˤ��Τ��������Ƥ�褦̿������"
       "�в᤮�����Ȥ��������ۤ��ؿ������餫�ˤʤä���")
  (prompt-for-key)
  (say knpc "�䤬�����Ƥ���֤ϡ����Υ֥�̤ο��¤�������뤳�ȤϤʤ���")
  (aside kpc 'ch_nate "�������Ǹ�ο���̾���ʱ��˺���줿���ȻפäƤ�����")
  (cond ((has? kpc t_lich_skull 1)
         (say knpc "�Ԥơ�����ϲ���������ϥ饯���ޥˤ�Ƭ������غ��������Ϥɤ��������Ȥ����饯���ޥˤϻ����Τ���")
         (yes? kpc)
         (say knpc "����Ϥ��ʤ���̵�뤷��������ܤθ����ä��Ϥᡢ���Ϥ������ȼ夯�ʤä����Ͻ���ä��Τ���")
         (prompt-for-key kpc)
         (say knpc "�����������������ϡĥ����󡪡ĥ�����")
         (aside kpc 'ch_nate "�����Ĥη��ϲ���ʪ����")
         (kern-conv-end)
         (kern-char-kill knpc))))

(define (anaxes-gods knpc kpc)
  (say knpc "�����ϲ桹�������¤����ܤꥷ���ɤ��������������"
       "�饯���ޥˤ��ۤ��ɿ�Ԥϡ��Ǹ���襤�ǾƤ��Ԥ������γ���Ů���Ǥ�����"
       "��������¤Ǥ��졪"))

(define (anaxes-brun knpc kpc)
  (say knpc "�����ϲ���ο����֥�̤ο��¤Ǥ��롣"
       "��Ϥ����˥饯���ޥˤ�������Ƥ�Ȥ����Ѥ���٤�̿���ȿ������"
       "�����ƥ֥�̤μ������������������Ƥ���Τ���")
  )

(define (anaxes-vigi knpc kpc)
  (say knpc "�桹�ϲ����˺��Ƥ����Τ���"
       "�饯���ޥˤϳ��򵽤�³�����������Ʋ桹�Ϻ����������ʧ��ͤФʤ�̤Τ���"))

(define (anaxes-fail knpc kpc)
  (say knpc "�桹�Ͽ���΢�ڤä����ְ㤤�ʤ����ϲ桹�򸫼ΤƤ������"))

(define (anaxes-twel knpc kpc)
  (say knpc "��ϥ饯���ޥˤν���ͤν����Ԥΰ�ͤ��ä���"
       "�Ѥ��٤����Ȥˡ�����ۤ������ۤ�������򤷤Ƥ��ޤä��Τ���"
       "�������ۼԤ������ɤ������⤿�餷��"
       "�����Ƽ���줿�Ԥμٶ��򲡤������ळ�Ȥ��Ǥ���ȹͤ��Ƥ�����"
       "����������΢�ڤ�줿�Τ���"))

(define (anaxes-accu knpc kpc)
  (say knpc "�������󥰤θ塢"
       "�����Ԥ������������"
       "���μԤ����Ͽ������ۼԤǤ���ȼ�ĥ�������ζ򤫤ʹ԰٤ǿ��ؤο��Ĥ��������")
  (prompt-for-key)
  (say knpc "�饯���ޥˤβ��ǲ桹�Ϥ��μٶ��̤�������ä���"
       "�����ơ�����λʺפ�����з��˽褷�����δ�����Τ褦�ʻٻ��Ԥ�Ϥˤ�������"))

(define (anaxes-bye knpc kpc)
  (say knpc "������¤���Ԥʤꡪ����񹳤��롣"
       "���Ȥ������襤�ǵ���Ƥ⡢��θ����������Ǥ�³����Ǥ�����")
  (aside kpc 'ch_nate "�ΤĤ֤䤭�ϴ��ˤ������Ƥ��롪")
  (kern-being-set-base-faction knpc faction-monster)
  )

(define (anaxes-job knpc kpc)
  (say knpc "��ϥ饯���ޥˤν���ͤΰ�ͤǡ�"
       "�����ˤ���֤ȴƻ���Ǥλش���Ǥ����Ƥ�����"
       "�������饯���ޥˤϤ��ο��¤����¤�̿������"
       "�椨�˻��ȿ�դ����ΤǤ��롪")
  (aside kpc 'ch_nate 
         "�Τ����䤭�Ϥ��Υ�å��ϼ�ʬ���饯���ޥˤλ���������Ƥ���ȻפäƤ��ޤ�����")
  )

(define (anaxes-fort knpc kpc)
  (say knpc "���Υ֥�̤ο��¤ȴƻ���ϡ��֥�̤μ�ȸƤФ�Ƥ��롣"
       "���κ֤򹶤���Ȥ����ȤϤǤ��̤Ǥ�����"))

(define (anaxes-towe knpc kpc)
  (say knpc "�֥�̤μ�δƻ���ϡ���������������ʥ�������ƶ���ĥ�äƤ��롣"
       "�����������������󥰤������顢�����ǲ��δ��Ⱦ��������ƻ뤷³���Ƥ���Τ���"))

(define (anaxes-sund knpc kpc)
  (say knpc "�������󥰤Ȥ���������������ۤɤ�����ư�Τ��ȤǤ��롣"
       "̵�����̤����Τ�̤Ǥ�����"
       "������ۤ����褿����Ǥ�ʤ��¤�ϡ�"))

(define anaxes-conv
  (ifc nil

       ;; basics
       (method 'accu anaxes-accu)
       (method 'assa anaxes-luxi)
       (method 'bye anaxes-bye)
       (method 'brun anaxes-brun)
       (method 'default anaxes-default)
       (method 'defe anaxes-fort)
       (method 'fail anaxes-fail)
       (method 'fait anaxes-vigi)
       (method 'fort anaxes-fort)
       (method 'god  anaxes-gods)
       (method 'gods anaxes-gods)
       (method 'hail anaxes-hail)
       (method 'job  anaxes-job)
       (method 'luxi anaxes-luxi)
       (method 'mast anaxes-luxi)
       (method 'name anaxes-name)
       (method 'rebe anaxes-luxi)
       (method 'shri anaxes-vigi)
       (method 'sund anaxes-sund)
       (method 'towe anaxes-towe)
       (method 'twel anaxes-twel)
       (method 'vigi anaxes-vigi)
       ))

(define (mk-anaxes)
  (let ((kchar
         (bind 
          (kern-char-force-drop
           (kern-mk-char 
            'ch_lux          ; tag
            "���ʥ�����"     ; name
            anaxes-species   ; species
            anaxes-occ       ; occ
            s_lich           ; sprite
            faction-men      ; starting alignment
            0 0 0            ; str/int/dex
            0 0              ; hp mod/mult
            0 0              ; mp mod/mult
            max-health       ; hp
            -1               ; xp
            max-health       ; mp
            0
            anaxes-lvl       ; level
            #f               ; dead
            'anaxes-conv     ; conv
            nil              ; sched
            'lich-ai         ; special ai
            (mk-inventory
             ;; hack: as the kernel is currently written, he won't drop his
             ;; readied arms on death, and he won't ready arms from inventory
             ;; (its all messed up), but he will drop his inventory. So put
             ;; some decent arms in as loot.
             (list (list 1 t_armor_chain)
                   (list 1 t_chain_coif)
                   (list 1 t_morning_star)
                   (list 1 t_shield)
                   (list 3 mandrake)
                   (list 3 nightshade)
                   (list 8 sulphorous_ash)
                   (list 5 blood_moss)
                   (list 5 black_pearl)
                   (list 50 t_gold_coins)
                   (list 1 t_anaxes_letter)
                   (list 1 t_lichs_blood)
                   ))
            ;; readied
            (list
             t_armor_chain_4
             t_chain_coif_4
             t_morning_star_2
             t_shield_4
             )
            ) ; kern-mk-char
           #t) ; kern-char-force-drop
          (anaxes-mk)) ; bind
         ))
    (map (lambda (eff) (kern-obj-add-effect kchar eff nil))
         undead-effects)
    kchar))
