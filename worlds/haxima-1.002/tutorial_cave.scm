;;----------------------------------------------------------------------------
;; Map
;;----------------------------------------------------------------------------
(mk-dungeon-room
 'p_tutorial_cave "チュートリアルの洞窟"
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
 (put (mk-step-clue "'u'キーで松明を使うとよいでしょう！") 7 15)
 (put (mk-step-clue "コウモリを倒した後、'f'キーを押してあたりを調べてみましょう。"
                    "調べ終わったら、はしごに戻って'e'キーを押すと登って出られます。")
      7 14)
 (put (mk-ladder-up 'p_tutorial_wilderness 9 15) 7 17)
 )
