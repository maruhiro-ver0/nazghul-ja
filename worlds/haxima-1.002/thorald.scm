;; �����ɤϥ��塼�ȥꥢ����о��ʪ�Ǥ��롣


(define (thorald-mixi knpc kpc)
  (say knpc "Ĵ�礹�뤿��ˤϡ��ޤ�'m'�����򲡤���"
       "�����ơ���ʸ�Τ��줾��κǽ��ʸ�������Ϥ���Enter�򲡤���"
       "�㤨�С�In Ex Por �ʤ� i, e, p, Enter ����")
  (prompt-for-key)
  (say knpc "���ˡ������򥹥ڡ����С������֡�")
  (prompt-for-key)
  (say knpc "�Ǹ�ˡ�Ĵ�礷��������������Ϥ�Enter�򲡤���"
       "����1��Ĵ�礹��Ф褤��")
  (prompt-for-key)
  (say knpc "�ɤμ�ʸ��Ĵ�礷������'z'���ޥ�ɤǸ��뤳�Ȥ��Ǥ��롣"
       "1��Ĵ�礷�ƤߤƤϤɤ��������ޤ����ä���ޤ��ä������Ƥ��졣")
  (kern-conv-end)
  )

(define conv-thorald
  (ifc nil
       (method 'bye
               (lambda (knpc kpc)
                 (say knpc "�������ޤ��񤪤���")))
       (method 'default 
               (lambda (knpc kpc)
                 (say knpc "����ϼ�����Ǥ���ʡ�")))
       (method 'hail
               (lambda (knpc kpc)
                 (kern-log-msg "���ʤ������������Ϸ�ͤ��ä���������")
                 (if (in-inventory? kpc in_ex_por)
                     (say knpc "In Ex Por �μ�ʸ�ϤǤ����褦���ʡ�"
                          "�ɤ������뤫�狼��ʤ��ä���ʹ���Ƥ��졣")
                     (say knpc "���塼�ȥꥢ��ؤ褦��������λŻ��ˤĤ��Ƥ����ͤƤߤƤϤɤ�����"
                          "����Ȥ���Τ��Ȥ��Τꤿ���Τ��͡�")
                     )))
       (method 'join
               (lambda (knpc kpc)
                 (say knpc "�褷���ǤϹԤ�����"
                      "'f'�򲡤��Ȼ�Ϥ����λؼ��˽�����"
                      "�����θ��Ĥ��Ƥ����ߤ����ʤ�⤦����'f'�򲡤��Ф褤��"
                      "�����Ƥ������ԤäƤ���֤˻��õ�������ߤ�������'2'�򲡤��Τ���"
                      "'f'�򲡤��Фɤ��ˤ��Ƥ���äƤ��ơ��ƤӸ�ˤĤ��ƹԤ�����")
                 (join-player knpc)
                 (kern-conv-end)
                 ))
       (method 'name
               (lambda (knpc kpc)
                 (say knpc "��ϥ����ɤ����������")))
       (method 'job
               (lambda (knpc kpc)
                 (say knpc "��Ϥ����������뤿��˸ۤ��Ƥ���Τ���")))
       (method 'door
               (lambda (knpc kpc)
                 (say knpc "��������Ϥ�����ˡ���������줿��򳫤���ʸ���ΤäƤ��롣"
                      "�ͤ��衪���ϲ���ʹ���Ф褤����")
                 ))
       (method 'spel
               (lambda (knpc kpc)
                 (say knpc "���������򤯤Τ� In Ex Por �μ�ʸ�Ǥ��롣"
                      "�����Ƥ����Ĵ�礹��ˤ�β���γ��ȷ���ݤ�ɬ�פ���"
                      "Ĵ�礹����ˡ�����ʤ���Ф����ͤ衣")))
       (method 'mix thorald-mixi)
       (method 'mixi thorald-mixi)
       (method 'cast
               (lambda (knpc kpc)
                 (say knpc "��ʸ�򾧤���ˤ�'c'�򲡤�����ˡ�Τ��줾��κǽ��ʸ�������Ϥ��롣"
                      "�㤨�С�In Ex Por �򾧤���ʤ�'i', 'e', ������'p'����"
                      "�狼��ʤ��ʤä���Хå����ڡ����򲡤��Ф褤��"
                      "��ʸ�����������ϤǤ����ʤ顢Enter�򲡤��ƾ����롣"
                      "In Ex Por ����򼨤�ɬ�פ����뤾��")))
       ))

(define (thorald-ai kchar) #t)

(define (mk-thorald)
  (kern-mk-char 
   'ch_thorald ; tag
   "�����ɡ����쥤�٥�����"   ; name
   sp_human              ; species
   oc_wrogue             ; occ
   s_companion_wizard    ; sprite
   faction-player        ; starting alignment
   0 10 2                ; str/int/dex
   0 1                   ; hp mod/mult
   10 5                  ; mp mod/mult
   240 -1 8 0 8             ; hp/xp/mp/AP_per_turn/lvl
   #f                    ; dead
   'conv-thorald         ; conv
   nil                   ; sched
   'thorald-ai           ; special ai
   nil                   ; container
   (list t_sling
         t_armor_leather
         )
   nil
   ))

(kern-dictionary
       "�ȥӥ�"     "door" "��"
       "������"   "spel" "��ʸ"
       "���祦����" "mix"  "Ĵ��"
       "�ȥʥ���"   "cast" "������")
