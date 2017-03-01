
mount -t binfmt_misc binfmt_misc /proc/sys/fs/binfmt_misc
cp /system/etc/binfmt_misc/arm_exe /proc/sys/fs/binfmt_misc/register
cp /system/etc/binfmt_misc/arm_dyn /proc/sys/fs/binfmt_misc/register

