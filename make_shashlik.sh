#!/bin/sh
# ©2017 YUICHIRO NAKADA

ver=0.9.3
tdir=/tmp/shashlik
cdir=`pwd`
[ -r shashlik_${ver}.deb ] || wget http://static.davidedmundson.co.uk/shashlik/shashlik_${ver}.deb

mkdir ${tdir}
pushd ${tdir}
ar vx ${cdir}/shashlik_${ver}.deb
tar xvJf data.tar.xz

cp -a ${cdir}/adb ./opt/shashlik/bin
cp -a ${cdir}/aapt ./opt/shashlik/bin
cp -a ${cdir}/lib64 ./opt/shashlik/bin/
cp -a ${cdir}/shashlik-install ./opt/shashlik/bin
#cp -a *.apk ./opt/shashlik/data

# diet
e2fsck -f ./opt/shashlik/android/userdata.img
resize2fs ./opt/shashlik/android/userdata.img 4M
e2fsck -f ./opt/shashlik/android/system.img
resize2fs ./opt/shashlik/android/system.img 420M

rm -rf ./opt/shashlik/bin/__pycache__
rm -rf ./opt/shashlik/lib
rm -rf ./opt/shashlik/lib64/libEGL_translator.so
rm -rf ./opt/shashlik/lib64/libGLES_CM_translator.so
rm -rf ./opt/shashlik/lib64/libGLES_V2_translator.so
rm -rf ./opt/shashlik/lib64/libOpenglRender.so
rm -rf ./opt/shashlik/lib64/libut_rendercontrol_dec.so
#rm -rf ./opt/shashlik/bin/aapt

cp -a ${cdir}/shashlik.spec ./opt/shashlik/
pushd ./opt
tar cvJf shashlik-${ver}.tar.bz2 shashlik
rm -rf shashlik
rpmbuild -ta shashlik-${ver}.tar.bz2
popd

popd
rm -rf ${tdir}

