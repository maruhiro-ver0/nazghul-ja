;; ----------------------------------------------------------------------------
;; ť���ΤϤ��� 1��
;; ----------------------------------------------------------------------------
(mk-dungeon-room
 'p_traps_1 "�Ǥ������"
 (list
  "rr rr rr rr rr rr rr xx xx xx xx xx xx xx xx xx xx rr rr "
  "rr rr rr xx xx xx xx xx ,, ,, ,, xx xx ,, ,, ,, xx rr rr "
  "rr rr rr xx ,, ,, ,, ,, ,, ,, ,, ,, x! ,, ,, ,, x! rr rr "
  "rr rr rr xx ,, ,, ,, ,, ,, ,, ,, ,, xx ,, ,, ,, xx rr rr "
  "rr rr xx xx ,, xx xx xx xx ,, xx xx xx xx ,, xx xx rr rr "
  "rr rr xx ,, ,, ,, xx xx ,, ,, ,, xx xx ,, ,, ,, xx rr rr "
  "rr rr xx ,, ,, ,, xx xx ,, ,, ,, xx xx ,, ,, ,, xx rr rr "
  "rr rr xx ,, ,, ,, xx xx ,, ,, ,, xx xx ,, ,, ,, xx rr rr "
  "rr rr xx ,, ,, ,, xx xx ,, ,, ,, xx xx ,, ,, ,, xx rr rr "
  "rr rr xx ,, ,, ,, xx xx ,, ,, ,, xx xx ,, ,, ,, xx rr rr "
  "rr rr xx ,, ,, ,, xx xx ,, ,, ,, xx xx ,, ,, ,, xx rr rr "
  "rr rr xx ,, ,, ,, xx xx ,, ,, ,, xx xx ,, ,, ,, xx rr rr "
  "rr rr xx ,, ,, ,, xx xx ,, ,, ,, xx xx ,, ,, ,, xx rr rr "
  "rr rr xx ,, ,, ,, xx xx ,, ,, ,, xx xx ,, ,, ,, xx rr rr "
  "rr rr xx xx ,, xx xx xx xx ,, xx xx xx xx ,, xx xx rr rr "
  "rr rr xx ,, ,, ,, xx ,, ,, ,, ,, ,, ,, ,, ,, xx rr rr rr "
  "rr rr x! ,, ,, ,, x! ,, ,, ,, ,, ,, ,, ,, ,, xx rr rr rr "
  "rr rr xx ,, ,, ,, xx xx ,, ,, ,, xx xx xx xx xx rr rr rr "
  "rr rr xx xx xx xx xx xx xx xx xx xx rr rr rr rr rr rr rr "
  )
 (put (mk-riddle "���ޥ�" 't_lava 3 5 3 9 #f
                 "�������̤��Ȥ����ΤϤ������򤯤٤���\n\n"
                 "�����Τ��Ȥ��������Ф���Ʋ��\n"
                 "�����Τ��Ȥ����餫�ʥ����ƥ�\n"
                 "���徽���������\n"
                 "������Τ�󤴤������\n"
                 "�����κ֤���Ϥʤ�\n"
                 "������������ϲ����첫�����ޤ�롣"
                 ) 4 14)
 (put (mk-riddle "few" 't_lava 8 5 3 9 #f
                 "�������̤��Ȥ����ΤϤ������򤯤٤���\n\n"
                 "����ϣ�ʸ����ñ��򱣤����ġ�\n"
                 "������ä���ȡ���꾯�ʤ��ʤ롣\n"
                 "  I know a word of letters three.\n"
                 "  Add two, and fewer there will be.\n"
                 "����ա��Ѹ�������뤳�ȡ�Tab�����򲡤��ȥ��޻�������ե��٥åȤ��ڤ��ؤ�롣��"
                 ) 9 4)
 (put (mk-riddle "eye" 't_lava 13 5 3 9 #f
                 "�������̤��Ȥ����ΤϤ������򤯤٤���\n\n"
                 "��ȯ���ϣ�ʸ��\n"
                 "��������ɮ���ϣ�ʸ��\n"
                 "������ʸ������\n"
                 "�������ƣ��ĤΤ߲���档\n"
                 "�����ʣ����������ñ����\n"
                 "���������Ĥ���������\n"
                 "������꤫���ɤ�Ǥ�\n"
                 "����ΰ�̣��Ʊ����\n"
                 "  Pronounced as one letter,\n"
                 "  but written with three.\n"
                 "  Two letters there are\n"
                 "  and two only in me.\n"
                 "  I'm double, and single,\n"
                 "  and black, blue and gray.\n"
                 "  When read from both ends\n"
                 "  I'm the same either way.\n"
                 "����ա��Ѹ�������뤳�ȡ���"
                 ) 14 14)
 (put (mk-ladder-down 'p_traps_2 9 15) 14 2)
 (put (mk-ladder-up 'p_bole 43 6) 4 16)
 )

(mk-place-music p_traps_1 'ml-dungeon-town)

(kern-place-add-on-entry-hook p_traps_1 'quest-thiefrune-den1)
