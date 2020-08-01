#!/bin/sh

#设置安装路径，如果TMPDIR为空值，则等价于cd /tmp
cd ${TMPDIR:-/tmp}

#根据操作系统来设置安装路径和安装命令
if [ $(uname) = 'Darwin' ]; then
  TEXDIR=${TINYTEX_DIR:-~/Library/TinyTeX}
  alias download='curl -sL'
else
  TEXDIR=${TINYTEX_DIR:-~/.TinyTeX}
  alias download='wget -qO-'
fi

sh $GITHUB_WORKSPACE/scripts/install-base.sh -s - "$@"

rm -rf $TEXDIR
mkdir -p $TEXDIR
mv texlive/* $TEXDIR
rm -r texlive

echo "---------install pkgs!!!!!!----------"
#$TEXDIR/bin/*/tlmgr install $(download https://yihui.org/gh/tinytex/tools/pkgs-custom.txt | tr '\n' ' ')
#download https://yihui.org/gh/tinytex/tools/pkgs-custom.txt | tr '\n' ' ' | $TEXDIR/bin/*/tlmgr install
#$TEXDIR/bin/*/tlmgr install $(tr $GITHUB_WORKSPACE/scripts/pkgs-custom.txt '\n' ' ')
#cat $GITHUB_WORKSPACE/scripts/pkgs-custom.txt | tr '\n' ' '
#cat $GITHUB_WORKSPACE/scripts/pkgs-custom.txt | tr '\n' ' ' | $TEXDIR/bin/*/tlmgr install
$TEXDIR/bin/*/tlmgr install amsfonts amsmath atbegshi atveryend auxhook bibtex bigintcalc bitset booktabs dvips ec epstopdf-pkg etexcmds etoolbox euenc fancyvrb filehook float fontspec framed geometry gettitlestring grffile helvetic hycolor hyperref iftex inconsolata infwarerr intcalc kvdefinekeys kvoptions kvsetkeys latex-amsmath-dev latex-tools-dev latexmk letltxmacro lm-math ltxcmds lualatex-math mdwtools metafont mfware natbib pdfescape pdftexcmds refcount rerunfilecheck stringenc tex times tipa tools unicode-math uniquecounter url xcolor xkeyval xunicode zapfding unicode-math filehook xecjk xltxtra realscripts fancyhdr lastpage ctex ms cjk ulem environ trimspaces zhnumber collection-fontsrecommended
#$TEXDIR/bin/*/tlmgr install $(cat $GITHUB_WORKSPACE/scripts/pkgs-custom.txt | tr '\n' ' ')

if [ "$1" = '--admin' ]; then
  if [ "$2" != '--no-path' ]; then
    sudo $TEXDIR/bin/*/tlmgr path add
  fi
else
  $TEXDIR/bin/*/tlmgr path add || true
fi
