#/bin/sh

LD_LIBRARY_PATH=/opt/shashlik/lib64 /opt/shashlik/bin/emulator64-x86 -sysdir /opt/shashlik/android -system /opt/shashlik/android/system.img -ramdisk /opt/shashlik/android/ramdisk.img -kernel /opt/shashlik/android/kernel-qemu -memory 3000 -data /tmp/userdata.img -datadir /opt/shashlik/android/system -sdcard /tmp/sdcard.img -noskin -gpu on -selinux disabled -qemu -append ro.product.cpu.abi2=armeabi-v7a &

sleep 20
/opt/shashlik/bin/adb wait-for-device shell monkey -p com.atomicadd.tinylauncher -c android.intent.category.LAUNCHER 1

