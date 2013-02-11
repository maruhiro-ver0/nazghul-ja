(mk-tower
 'p_tutorial_town "チュートリアルの町"
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
 (put (mk-step-clue "左に宝箱があります。'o'キーを押した後、矢印キーを押すと開けることができます。"
                    "その後'g'キーを押した後、矢印キーを押して、取ってください。") 
      6 6)
 (put (mk-step-clue "武器と防具で戦いに備えたほうがよいでしょう。"
                    "'r'キーを押してください。上のウィンドウで武器や防具を選択し、スペースバーで装備したり取り外したりできます。色々と試してみましょう。"
                    "十分だと思ったらESCキーを押し戻ってください。"
                    )
      6 8)
 (put (mk-step-clue "装備を確認するために'z'キーを押してください。"
                    "左右の矢印キーを押すとウィンドウが切り替わります。"
                    "ESCを押すと戻ります。"
                    )
      6 9)
 (put (mk-step-clue "格子戸を開けるには左のレバーを操作する必要があります。"
                    "'h'キーを押し、矢印キーで十字カーソルをレバーにあわせ、Enterキーを押します。")
      6 10)
 (put (mk-step-clue "まわりにあるものについて知りたいときは'x'キーを押してください。"
                    "見たいものの上にカーソルをあわせられます。"
                    "プレイヤーでないキャラクター(NPC)、例えばヘビのようなものは四角で強調されています。"
                    "赤色は敵対的、緑色は友好的、黄色はどちらでもないことを表しています。"
                    "敵対的なNPCはあなたを見つけると攻撃してくるでしょう。"
                    "ESCキーを押すと戻ります。")
      6 13)
 (put (mk-step-clue "格子戸を開けるとヘビと戦わなければならないでしょう。"
                    "攻撃するときは'a'キーを押し、カーソルを目標に合わせ、Enterキーを押します。")
      9 13)

 (put (mk-step-clue "扉は通ろうとするだけで開きます。") 13 13)
 (put (mk-door) 13 12)

 (put (mk-step-clue "亡骸を's'キーと矢印キーで調べてみましょう。このコマンドは見えないものを探すためにも使えます。") 12 10)
 (put (mk-corpse2 (list (list 20 't_picklock) 
                        (list 10 'sulphorous_ash)
                        (list 10 'blood_moss)
                        )) 11 10)

 (put (mk-locked-door) 13 8)
 (put (mk-step-clue "亡骸が持っていた鍵開け道具を使ってこの扉を開けましょう。"
                    "'u'キーを押し、項目を選び、扉に目標をあわせます。"
                    "鍵開け道具が壊れても、何度も試してください！"
                    ) 13 9)

 (put (kern-tag 'p3 (mk-portcullis)) 12 13)
 (put (mk-lever 'p3) 11 14)

 (put (mk-magic-locked-door) 13 4)
 (put (mk-thorald) 12 5)
 (put (mk-step-clue "'t'キーを押し、NPCに目標をあわせると会話できます。"
                    "聞きたいキーワードを入力しEnterを押してください。ほとんどのNPCは「名前」や「仕事」に対してこたえます。"
                    "多くの場合NPCのこたえには新しいキーワードの手がかりが含まれています。"
                    "会話を終えるためには「さよなら」、または何も入力せずにEnterキーを押します。"
                    "NPCをあなたの仲間に加えたいと考えたなら、「仲間」とたずねてみてください。"
                    "ソラルドと会話して扉についてたずねてみましょう。")
      13 7)


 (put (mk-step-clue "あなたは町を去り荒野に出ようとしてます。"
                    "町の外ではあなたと仲間は1つのアイコンで表示されます。")
      9 0)
 )
