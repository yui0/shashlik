
mount -t binfmt_misc binfmt_misc /proc/sys/fs/binfmt_misc
cp /system/etc/binfmt_misc/arm_exe /proc/sys/fs/binfmt_misc/register
cp /system/etc/binfmt_misc/arm_dyn /proc/sys/fs/binfmt_misc/register

rm /data/system/called_pre_boots.dat

settings --user 0 put secure user_setup_complete 1
settings put global install_non_market_apps 1

#mkdir -p /data/app/com.apkpure.aegon/lib/arm/
#ln -s /system/app/com.apkpure.aegon/lib/arm/libjlibtorrent.so /data/app/com.apkpure.aegon/lib/arm/
#ln -s /system/app/com.apkpure.aegon /data/app/
#pm install /system/com.apkpure.aegon.apk

