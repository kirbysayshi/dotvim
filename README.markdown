Installation:
=============

Windows:

    git clone git://github.com/kirbysayshi/dotvim.git ~/.vim
	mklink /H C:\Users\%USERNAME%\.vimrc C:\Users\%USERNAME%\.vim\.vimrc
	mklink /H C:\Users\%USERNAME%\.gvimrc C:\Users\%USERNAME%\.vim\.gvimrc

Everything else:

    git clone git://github.com/kirbysayshi/dotvim.git ~/.vim
    ln -s ~/.vim/.vimrc ~/.vimrc
    ln -s ~/.vim/.gvimrc ~/.gvimrc

And install plugins:
	:PlugInstall

