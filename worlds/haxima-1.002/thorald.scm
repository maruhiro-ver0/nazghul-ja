;; ソラルドはチュートリアルの登場人物である。


(define (thorald-mixi knpc kpc)
  (say knpc "調合するためには、まず'm'キーを押す。"
       "そして、呪文のそれぞれの最初の文字を入力し、Enterを押す。"
       "例えば、In Ex Por なら i, e, p, Enter だ。")
  (prompt-for-key)
  (say knpc "次に、秘薬をスペースバーで選ぶ。")
  (prompt-for-key)
  (say knpc "最後に、調合し生成する数を入力しEnterを押す。"
       "今は1つ調合すればよい。")
  (prompt-for-key)
  (say knpc "どの呪文を調合したかは'z'コマンドで見ることができる。"
       "1つ調合してみてはどうだ？うまくいったらまた話しかけてくれ。")
  (kern-conv-end)
  )

(define conv-thorald
  (ifc nil
       (method 'bye
               (lambda (knpc kpc)
                 (say knpc "おお、また会おう。")))
       (method 'default 
               (lambda (knpc kpc)
                 (say knpc "それは手助けできんな。")))
       (method 'hail
               (lambda (knpc kpc)
                 (kern-log-msg "あなたは退屈そうな老人に話しかけた。")
                 (if (in-inventory? kpc in_ex_por)
                     (say knpc "In Ex Por の呪文はできたようだな。"
                          "どう唱えるかわからなかったら聞いてくれ。")
                     (say knpc "チュートリアルへようこそ。私の仕事についてたずねてみてはどうだ？"
                          "それとも扉のことを知りたいのかね？")
                     )))
       (method 'join
               (lambda (knpc kpc)
                 (say knpc "よし、では行こう。"
                      "'f'を押すと私はお前の指示に従う。"
                      "お前の後をついてきて欲しいならもう一度'f'を押せばよい。"
                      "そしてお前が待っている間に私に探索して欲しい場合は'2'を押すのだ。"
                      "'f'を押せばどこにいても戻ってきて、再び後について行くぞ。")
                 (join-player knpc)
                 (kern-conv-end)
                 ))
       (method 'name
               (lambda (knpc kpc)
                 (say knpc "私はソラルドだ。よろしく。")))
       (method 'job
               (lambda (knpc kpc)
                 (say knpc "私はただ説明するために雇われているのだ。")))
       (method 'door
               (lambda (knpc kpc)
                 (say knpc "そう、私はこの魔法で封印された扉を開く呪文を知っている。"
                      "考えよ！次は何を聞けばよいか？")
                 ))
       (method 'spel
               (lambda (knpc kpc)
                 (say knpc "扉の封印を解くのは In Ex Por の呪文である。"
                      "そしてそれを調合するには硫黄の灰と血の苔が必要だ。"
                      "調合する方法が解らなければたずねよ。")))
       (method 'mix thorald-mixi)
       (method 'mixi thorald-mixi)
       (method 'cast
               (lambda (knpc kpc)
                 (say knpc "呪文を唱えるには'c'を押し、魔法のそれぞれの最初の文字を入力する。"
                      "例えば、In Ex Por を唱えるなら'i', 'e', そして'p'だ。"
                      "わからなくなったらバックスペースを押せばよい。"
                      "呪文を正しく入力できたなら、Enterを押して唱える。"
                      "In Ex Por は扉を示す必要があるぞ。")))
       ))

(define (thorald-ai kchar) #t)

(define (mk-thorald)
  (kern-mk-char 
   'ch_thorald ; tag
   "ソラルド・グレイベアード"   ; name
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
       "トビラ"     "door" "扉"
       "ジュモン"   "spel" "呪文"
       "チョウゴウ" "mix"  "調合"
       "トナエル"   "cast" "唱える")
