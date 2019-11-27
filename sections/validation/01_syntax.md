!SLIDE smbullets
# Syntax Highlighting

<img src="./_images/syntax_highlighting.png" style="width:446px;height:326px;" alt="Syntax Highlighting"/>

* Easier to read and edit
* Faster troubleshooting
* Available for most editors

!SLIDE small printonly
#Syntax Highlighting

Install vim Pathogen: https://github.com/tpope/vim-pathogen

    @@@Sh
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

    vim ~/.vimrc
    execute pathogen#infect()
    syntax on
    filetype plugin indent on

Install syntax-highlighting, enabled by Pathogen: https://github.com/rodjek/vim-puppet

* Just clone the repository into your ~/.vim/bundle directory and syntax-highlighting is enabled for all \*.pp files:

`git clone https://github.com/rodjek/vim-puppet.git ~/.vim/bundle`


!SLIDE
# Syntax Checking

Manually with: **puppet parser validate {FILE NAME}.pp**

    @@@Sh
    $ puppet parser validate apache/manifests/init.pp
    Error: Could not parse for environment production: \
      Syntax error at end of file; expected '}' at \
      /home/training/puppet/modules/apache/manifests/init.pp:17

**Note:** `Syntastic` (https://github.com/scrooloose/syntastic) is a syntax checking plugin for Vim that runs files through external syntax checkers and displays any resulting errors to the user. This can be done on demand, or automatically as files are saved. Syntastic provides also check plugins for Puppet.

~~~SECTION:handouts~~~

****

Syntastic is available from: https://github.com/scrooloose/syntastic

~~~ENDSECTION~~~
