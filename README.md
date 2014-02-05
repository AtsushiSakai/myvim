vimの環境の移し方

1.ホームディレクトリにmyvimをクローン
git https://gist.github.com/8822390.git

2. シンボリックリンクを使って、vimのそれらのファイルを認識させる。
ln -s ~/myvim/.vimrc ~/.vimrc
ln -s ~/myvim/.vim ~/.vim

3. 

