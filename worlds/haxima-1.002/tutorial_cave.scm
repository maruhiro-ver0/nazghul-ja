;;----------------------------------------------------------------------------
;; Map
;;----------------------------------------------------------------------------
(mk-dungeon-room
 'p_tutorial_cave "���塼�ȥꥢ���ƶ��"
 (list
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
      "rr %% %% rr rr tt .. .. .. tt rr rr rr {{ rr rr rr rr rr "
      "rr %% rr rr || .. .. .. .. .. || rr rr tt {{ rr rr rr rr "
      "rr %% rr tt %% bb .. .. .. bb %% || rr .. tt rr rr rr rr "
      "rr %% rr %% %% %% %% .. .. %% %% tt rr .. tt rr rr rr rr "
      "rr rr rr tt %% bb %% .. .. bb %% %% rr .. {{ rr rr rr rr "
      "rr .. || || %% %% .. .. .. %% %% %% rr {{ {{ rr rr rr rr "
      "rr .. rr || %% bb .. %% %% bb %% %% rr {{ {{ rr rr rr rr "
      "rr tt rr tt %% .. .. .. %% %% tt tt rr .. {{ rr rr rr rr "
      "rr tt rr %% %% bb .. .. .. bb || || rr .. {{ rr rr rr rr "
      "rr tt rr rr tt %% .. .. .. tt || rr rr .. tt rr rr rr rr "
      "rr .. tt rr rr rr .. .. .. rr rr rr .. .. tt rr rr rr rr "
      "rr .. .. .. && rr .. .. .. rr .. .. .. tt || rr rr rr rr "
      "rr .. .. .. .. rr .. .. .. rr .. .. tt || rr rr rr rr rr "
      "rr rr tt .. .. rr rr .. rr rr tt tt || rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
  )
 (put (spawn-pt 'bat) 7 7)
 (put (mk-step-clue "'u'�����Ǿ�����Ȥ��Ȥ褤�Ǥ��礦��") 7 15)
 (put (mk-step-clue "���������ݤ����塢'f'�����򲡤��Ƥ������Ĵ�٤Ƥߤޤ��礦��"
                    "Ĵ�ٽ���ä��顢�Ϥ�������ä�'e'�����򲡤����ФäƽФ��ޤ���")
      7 14)
 (put (mk-ladder-up 'p_tutorial_wilderness 9 15) 7 17)
 )
