#!/bin/sh
# ©2017 YUICHIRO NAKADA

ver=0.9.3
tdir=/tmp/shashlik
cdir=`pwd`
[ -r shashlik_${ver}.deb ] || wget http://static.davidedmundson.co.uk/shashlik/shashlik_${ver}.deb
[ -r ARM*.zip ] || curl https://onedrive.live.com/download?cid=B17EA188564F33FD&resid=B17EA188564F33FD%213048&authkey=AFPBxDccIE8yqZs

mkdir ${tdir}
pushd ${tdir}
ar vx ${cdir}/shashlik_${ver}.deb
tar xvJf data.tar.xz

cp -a ${cdir}/adb ./opt/shashlik/bin
cp -a ${cdir}/aapt ./opt/shashlik/bin
cp -a ${cdir}/lib64 ./opt/shashlik/bin/
cp -a ${cdir}/mksdcard ./opt/shashlik/bin
cp -a ${cdir}/shashlik.sh ./opt/shashlik/bin
cp -a ${cdir}/shashlik-install ./opt/shashlik/bin
cp -a ${cdir}/shashlik-run ./opt/shashlik/bin
cp -a ${cdir}/config.ini ./opt/shashlik/android
#cp -a *.apk ./opt/shashlik/data

# for arm emu
#unzip -x ${cdir}/ARM_Translation_Marshmallow.zip
unzip -x ${cdir}/ARM_Translation_Lollipop_20160402.zip
sdir=/tmp/sys
mkdir ${sdir}
mount -oloop ${tdir}/opt/shashlik/android/system.img ${sdir}
cp -a ./system/* ${sdir}/
cp -a ${cdir}/build.prop ${sdir}/

#cp -a ${cdir}/com.apkpure.aegon ${sdir}/app/
#ln -s /system/app/com.apkpure.aegon/lib/x86/libjlibtorrent.so ${sdir}/lib/
#cp -a ${cdir}/*.apk ${sdir}/

cp -a ${cdir}/com.atomicadd.tinylauncher ${sdir}/app/
cp -a ${cdir}/org.fdroid.fdroid ${sdir}/app/
cp -a ${cdir}/com.android.vending ${sdir}/app/
cp -a ${cdir}/com.google.android.gms ${sdir}/app/
cp -a ${cdir}/com.google.android.gsf ${sdir}/app/

cat ${cdir}/init.sh >> ${sdir}/etc/init.goldfish.sh
umount ${sdir}
rmdir ${sdir}

rdir=/tmp/ramdisk
mkdir ${rdir}
mv ${tdir}/opt/shashlik/android/ramdisk.img ${rdir}/ramdisk.gz
pushd ${rdir}
zcat ${rdir}/ramdisk.gz | cpio -i
rm ${rdir}/ramdisk.gz
cp -a ${cdir}/default.prop ${rdir}/
#find . | cpio -o -H newc | gzip > ${tdir}/opt/shashlik/android/ramdisk.img
popd
${cdir}/mkbootfs ${rdir} | gzip -9 > ${tdir}/opt/shashlik/android/ramdisk.img
rm -rf ${rdir}

# diet
#e2fsck -f ./opt/shashlik/android/userdata.img
#resize2fs ./opt/shashlik/android/userdata.img 11M
rm ./opt/shashlik/android/userdata.img
e2fsck -f ./opt/shashlik/android/system.img
#resize2fs ./opt/shashlik/android/system.img 420M
#resize2fs ./opt/shashlik/android/system.img 500M
resize2fs ./opt/shashlik/android/system.img 600M

rm -rf ./opt/shashlik/android/emulator-user.ini
rm -rf ./opt/shashlik/bin/__pycache__
rm -rf ./opt/shashlik/lib
rm -rf ./opt/shashlik/lib64/libEGL_translator.so
rm -rf ./opt/shashlik/lib64/libGLES_CM_translator.so
rm -rf ./opt/shashlik/lib64/libGLES_V2_translator.so
rm -rf ./opt/shashlik/lib64/libOpenglRender.so
rm -rf ./opt/shashlik/lib64/libut_rendercontrol_dec.so

cp -a ${cdir}/shashlik.spec ./opt/shashlik/
pushd ./opt
tar cvJf shashlik-${ver}.tar.bz2 shashlik
rm -rf shashlik
rpmbuild -ta shashlik-${ver}.tar.bz2
popd

popd
rm -rf ${tdir}

