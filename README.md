# README

このプロジェクトをダウンロードして実行するためには、以下のコマンドを実行してください

    $ git clone https://github.com/juniortwelve/LINE_freee.git
    $ bundle install
    $ rails db:migrate
    $ rails s

その後、自身のブラウザにてlocalhost:3000に接続すると、アプリを開くことができます。

また、アプリ自身について説明させて頂きます。

このアプリは「友だち一覧」、「トーク」、「友だち追加」、「プロフィール編集」の四つの画面からなっております。

それぞれの画面の機能は以下の通りです。

 * 友だち一覧：友だち、承認待ちの申請、届いている友だち申請の一覧が確認できます。友だちの方の名前またはプロフィール画像をクリックすれば、その人とトークを始めることができます。

 * トーク：今までのトークが並んでおり、また各トークの最後のメッセージを確認できます。この画面からも、各トークに移動できます。

 * 友だち追加：このアプリのユーザー一覧が表示されており、各ユーザーに友だち申請を送ることができます。また、検索バーがあり、ユーザー名で検索することで、表示されるユーザーを絞り込むことができます。

 * プロフィール編集：自分のプロフィールを編集できます。

トークは友だち同士でしかできないため、特定の人とトークを始めるためには、友だち追加から目的のユーザーに申請を送り、そのユーザーが承認することで友だちになる必要があります。
