#!/sbin/sh

suff=$(getprop ro.boot.slot_suffix)
if [ -z "$suff" ]; then
	sufx=$(getprop ro.boot.slot)
	suff="_$sufx"
fi

venpath="/dev/block/bootdevice/by-name/vendor$suff"

mkdir /v
mount -t ext4 -o ro "$venpath" /v

tai="/v/lib/modules/touch_core_base.ko"
taim="/v/lib/modules/ftm4.ko"
taime="/v/lib/modules/lge_battery.ko"

wall="/v/lib/modules/synaptics_dsx_core_htc.ko"
walle="/v/lib/modules/htc_battery.ko"

if [[ $(getprop ro.hardware) == "taimen" ]] && [ -f "$tai" ] && [ -f "$taim" ] && [ -f "$taime" ]; then
  insmod "$tai"
  insmod "$taim"
  insmod "$taime"
 
elif [[ $(getprop ro.hardware) == "walleye" ]] && [ -f "$wall" ] && [ -f "$walle" ]; then
  insmod "$wall"
  insmod "$walle"

fi

umount /v
