(mk-tower
 'p_tutorial_town "���塼�ȥꥢ���Į"
 (list
      "xx xx xx xx xx xx xx xx xx ,, xx xx xx xx xx xx xx xx xx "
      "xx xx xx xx xx xx xx xx xx ,, xx xx xx xx xx xx xx xx xx "
      "xx xx xx xx xx xx xx xx xx ,, ,, ,, ,, ,, xx xx xx xx xx "
      "xx xx xx xx xx xx xx xx xx xx xx xx xx ,, xx xx xx xx xx "
      "xx xx xx xx xx xx xx xx xx xx xx xx xx ,, xx xx xx xx xx "
      "xx xx xx xx xx xx xx xx xx xx xx xx ,, ,, ,, xx xx xx xx "
      "xx xx xx xx xx ,, ,, ,, ,, ,, xx xx ,, ,, ,, xx xx xx xx "
      "xx xx xx xx xx xx ,, xx xx ,, xx xx ,, ,, ,, xx xx xx xx "
      "xx xx xx xx xx xx ,, xx xx ,, xx xx xx ,, xx xx xx xx xx "
      "xx xx xx xx xx xx ,, xx xx ,, xx xx ,, ,, ,, xx xx xx xx "
      "xx xx xx xx xx ,, ,, xx xx xx xx ,, ,, ,, ,, xx xx xx xx "
      "xx xx xx xx xx xx ,, xx xx xx xx xx ,, ,, ,, xx xx xx xx "
      "xx xx xx xx xx xx ,, xx xx xx xx xx xx ,, xx xx xx xx xx "
      "xx xx xx xx xx xx ,, ,, ,, ,, ,, ,, ,, ,, xx xx xx xx xx "
      "xx xx xx xx xx xx xx xx xx ,, xx xx xx xx xx xx xx xx xx "
      "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx "
      "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx "
      "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx "
      "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx "

  )
  (list ;entrances
  	(list north 9 0)
  )
 (put (mk-chest 
       nil 
       '( 
        ( 10 t_torch)
        ( 1 t_sword)
        ( 1 t_armor_leather)
        ( 1 t_shield)
        ( 1 t_halberd)
        ))
      5 6)
 (put (spawn-pt 'snake) 11 13)
 (put (kern-tag 'p1 (mk-portcullis)) 6 11)
 (put (mk-lever 'p1) 5 10)
 (put (kern-tag 'p2 (mk-portcullis)) 10 13)
 (put (mk-lever 'p2) 9 14)
 (put (mk-step-clue "������Ȣ������ޤ���'o'�����򲡤����塢��������򲡤��ȳ����뤳�Ȥ��Ǥ��ޤ���"
                    "���θ�'g'�����򲡤����塢��������򲡤��ơ���äƤ���������") 
      6 6)
 (put (mk-step-clue "�����ɶ���襤���������ۤ����褤�Ǥ��礦��"
                    "'r'�����򲡤��Ƥ�����������Υ�����ɥ��������ɶ�����򤷡����ڡ����С��������������곰������Ǥ��ޤ��������Ȼ�Ƥߤޤ��礦��"
                    "��ʬ���Ȼפä���ESC�����򲡤���äƤ���������"
                    )
      6 8)
 (put (mk-step-clue "�������ǧ���뤿���'z'�����򲡤��Ƥ���������"
                    "��������������򲡤��ȥ�����ɥ����ڤ��ؤ��ޤ���"
                    "ESC�򲡤������ޤ���"
                    )
      6 9)
 (put (mk-step-clue "�ʻҸͤ򳫤���ˤϺ��Υ�С�������ɬ�פ�����ޤ���"
                    "'h'�����򲡤�����������ǽ�������������С��ˤ��碌��Enter�����򲡤��ޤ���")
      6 10)
 (put (mk-step-clue "�ޤ��ˤ����ΤˤĤ����Τꤿ���Ȥ���'x'�����򲡤��Ƥ���������"
                    "��������Τξ�˥�������򤢤碌���ޤ���"
                    "�ץ쥤�䡼�Ǥʤ�����饯����(NPC)���㤨�ХإӤΤ褦�ʤ�ΤϻͳѤǶ�Ĵ����Ƥ��ޤ���"
                    "�ֿ���Ũ��Ū���п���ͧ��Ū�������Ϥɤ���Ǥ�ʤ����Ȥ�ɽ���Ƥ��ޤ���"
                    "Ũ��Ū��NPC�Ϥ��ʤ��򸫤Ĥ���ȹ��⤷�Ƥ���Ǥ��礦��"
                    "ESC�����򲡤������ޤ���")
      6 13)
 (put (mk-step-clue "�ʻҸͤ򳫤���ȥإӤ����ʤ���Фʤ�ʤ��Ǥ��礦��"
                    "���⤹��Ȥ���'a'�����򲡤��������������ɸ�˹�碌��Enter�����򲡤��ޤ���")
      9 13)

 (put (mk-step-clue "����̤��Ȥ�������ǳ����ޤ���") 13 13)
 (put (mk-door) 13 12)

 (put (mk-step-clue "˴����'s'���������������Ĵ�٤Ƥߤޤ��礦�����Υ��ޥ�ɤϸ����ʤ���Τ�õ������ˤ�Ȥ��ޤ���") 12 10)
 (put (mk-corpse2 (list (list 20 't_picklock) 
                        (list 10 'sulphorous_ash)
                        (list 10 'blood_moss)
                        )) 11 10)

 (put (mk-locked-door) 13 8)
 (put (mk-step-clue "˴�������äƤ���������ƻ���ȤäƤ�����򳫤��ޤ��礦��"
                    "'u'�����򲡤������ܤ����ӡ������ɸ�򤢤碌�ޤ���"
                    "������ƻ�񤬲���Ƥ⡢���٤��Ƥ���������"
                    ) 13 9)

 (put (kern-tag 'p3 (mk-portcullis)) 12 13)
 (put (mk-lever 'p3) 11 14)

 (put (mk-magic-locked-door) 13 4)
 (put (mk-thorald) 12 5)
 (put (mk-step-clue "'t'�����򲡤���NPC����ɸ�򤢤碌��Ȳ��äǤ��ޤ���"
                    "ʹ������������ɤ����Ϥ�Enter�򲡤��Ƥ����������ۤȤ�ɤ�NPC�ϡ�̾���פ�ֻŻ��פ��Ф��Ƥ������ޤ���"
                    "¿���ξ��NPC�Τ������ˤϿ�����������ɤμ꤬���꤬�ޤޤ�Ƥ��ޤ���"
                    "���ä򽪤��뤿��ˤϡ֤���ʤ�ס��ޤ��ϲ������Ϥ�����Enter�����򲡤��ޤ���"
                    "NPC�򤢤ʤ�����֤˲ä������ȹͤ����ʤ顢����֡פȤ����ͤƤߤƤ���������"
                    "�����ɤȲ��ä�����ˤĤ��Ƥ����ͤƤߤޤ��礦��")
      13 7)


 (put (mk-step-clue "���ʤ���Į�������˽Ф褦�Ȥ��Ƥޤ���"
                    "Į�γ��ǤϤ��ʤ�����֤�1�ĤΥ��������ɽ������ޤ���")
      9 0)
 )
