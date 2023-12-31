

(kern-mk-place 
 'p_tutorial_wilderness
 "チュートリアルの荒野"
 nil          ; sprite 
 (kern-mk-map
  nil 19 19 pal_expanded
  (list
      "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ ^^ ^^ ^^ "
      "__ __ __ .. .. .. .. .. .. .. .. .. .. .. __ __ ^^ .. ^^ "
      "__ __ .. .. .. .. .. .. .. .. .. .. .. .. __ __ __ ee __ "
      "__ .. .. .. .. .. .. .. .. .. .. .. .. .. __ __ __ __ __ "
      "__ .. .. .. .. .. .. .. .. .. .. .. .. .. __ __ __ __ __ "
      "__ .. .. .. .. .. .. .. .. .. .. .. .. .. ee __ __ __ __ "
      "__ .. .. .. .. .. .. .. .. .. .. .. .. .. __ __ __ __ __ "
      "__ .. .. .. .. .. .. .. .. .. .. .. .. .. __ __ __ __ __ "
      "__ .. .. .. .. .. .. .. ^^ ^^ ^^ .. .. .. __ __ __ __ __ "
      "__ .. .. .. .. .. .. .. ^^ .. ^^ .. .. .. __ __ __ __ __ "
      "__ .. .. .. .. .. .. .. ^^ .. ^^ .. .. .. __ __ __ __ __ "
      "__ .. .. .. .. .. .. .. .. .. .. .. .. .. __ __ __ __ __ "
      "__ .. .. .. .. .. .. .. .. .. .. .. .. .. __ __ __ __ __ "
      "__ .. .. .. .. .. .. .. .. .. .. .. .. .. __ .. .. .. __ "
      "__ .. .. .. .. .. .. .. ^^ .. ^^ .. .. .. __ .. .. .. __ "
      "__ .. .. .. .. .. .. ^^ ^^ .. ^^ ^^ .. .. __ .. .. .. __ "
      "__ __ .. .. .. .. .. .. ^^ ^^ ^^ .. .. .. __ __ .. __ __ "
      "__ __ __ .. .. .. .. .. .. .. .. .. .. .. __ __ __ __ __ "
      "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
  )  )
 #f  ;; wraps
 #f  ;; underground
 #t  ;; wilderness
 #f  ;; tmp combat place

 ;; subplaces:
 (list
  (list p_tutorial_town 9 9)
  )

 nil ; neighborss

 ;; objects:
 (list

  (put (mk-step-clue "南にいる盗賊と戦いましょう。"
                     "戦闘は別の地図上で行われます。"
                     "戦いは、'<'を押すか、端まで移動すると終了します。")
       9 10)
  (put (mk-npc-party 'bandit-party-l1) 9 13)
  (put (mk-step-clue "荒野ではキャンプで体力を回復することができます。ここで試してみましょう。('k'コマンド)") 9 13)
 
  (put (mk-step-clue "下の洞窟には重なると入れます。")
       9 14)
  (put (mk-dungeon 'p_tutorial_cave 7 17) 9 15)

  (put (mk-step-clue "船の上に移動して'b'を押すと乗ることができます。"
                     "北東の端まで矢印キーで移動し上陸しましょう。") 14 5)
  (put (mk-step-clue "'f'キーと矢印キーを押して島にいる盗賊を砲撃しましょう。"
                     "船は側面の方向のみ砲撃できます。よって少し考えて操作しなければなりません。") 
       15 4)
  (put (mk-step-clue "'f'キーと矢印キーを押して島にいる盗賊を砲撃しましょう。"
                     "船は側面の方向のみ砲撃できます。よって少し考えて操作しなければなりません。") 
       15 6)
  (put (mk-step-clue "'f'キーと矢印キーを押して島にいる盗賊を砲撃しましょう。"
                     "船は側面の方向のみ砲撃できます。よって少し考えて操作しなければなりません。") 
       16 5)

  (put (mk-ship) 15 5)
  (put (mk-npc-party 'bandit-party-l1) 16 14)

  (put (mk-step-clue "これでチュートリアルは終わりです。説明書にはもっと多くの情報が書かれています。"
                     "それはこのゲームをインストールした場所のdocディレクトリ、または"
                     "オンラインのウェブサイトにあります。"
                     "'q'キーを押すとチュートリアルを終了します。"
                     "それでは本編をお楽しみください！") 17 1)
       
  ) ;; end of objects

 nil ; hooks
 nil ; edge entrances
 )
