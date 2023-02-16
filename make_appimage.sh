#!/bin/sh
# Berry OS: Make Berry
#	©2023 YUICHIRO NAKADA

: "functions" && {
  # https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
  msg() {
      RED="\033[1;31m"
      GREEN="\033[0;32m"  # <-- [0 means not bold
      YELLOW="\033[1;33m" # <-- [1 means bold
      CYAN="\033[1;36m"
      INFO="\033[1;36m"

      NC="\033[0m" # No Color

      # printf "${(P)1}${2} ${NC}\n" # <-- zsh
      printf "${!1}${2} ${NC}\n" # <-- bash
  }
}

if ! type dpkg >/dev/null 2>&1; then
  msg RED "You need dpkg_1.21.20_amd64.deb from http://ftp.debian.org/debian/pool/main/d/dpkg/, libmd."
  msg RED "ln -s /usr/lib64/libbz2.so /usr/lib64/libbz2.so.1.0"
  msg RED "https://packages.ubuntu.com/"
  echo
fi

curdir=`pwd`
workdir=/tmp

: "main" && {
  msg RED "Berry OS"
  msg RED "©2023 YUICHIRO NAKADA"
  echo
  msg INFO "Making..."

  pushd $workdir
  git clone https://github.com/AppImage/AppImages.git appimages
  cd appimages/
  cp -a ${curdir}/appimage/* .
  ARCH=x86_64 ./pkg2appimage shashlik.yml
  popd
}
