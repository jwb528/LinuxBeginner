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
$TEXDIR/bin/*/tlmgr install $(download https://yihui.org/gh/tinytex/tools/pkgs-custom.txt | tr '\n' ' ')
#download https://yihui.org/gh/tinytex/tools/pkgs-custom.txt | tr '\n' ' ' | $TEXDIR/bin/*/tlmgr install
#$TEXDIR/bin/*/tlmgr install $(tr $GITHUB_WORKSPACE/scripts/pkgs-custom.txt '\n' ' ')
cat $GITHUB_WORKSPACE/scripts/pkgs-custom.txt | tr '\r\n' ' ' | $TEXDIR/bin/*/tlmgr install
#$TEXDIR/bin/*/tlmgr install $(cat $GITHUB_WORKSPACE/scripts/pkgs-custom.txt | tr '\n' ' ')

if [ "$1" = '--admin' ]; then
  if [ "$2" != '--no-path' ]; then
    sudo $TEXDIR/bin/*/tlmgr path add
  fi
else
  $TEXDIR/bin/*/tlmgr path add || true
fi
