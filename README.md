# chromebook-usb-autoformat

autoformat.sh is a script to format your USB drive,
for booting linux on Depthcharge based ARM chromebooks.
It gives you a 16MiB kernel partition,
and uses the rest for ext4 RootFS.

It does NOT install chromeOS, or any other distro, 
it is only meant to make partitioning easier.

you dd at your own risk. 

Tested for booting c100p "veyron_minnie" from USB.
Others models may work but are untested.

Formatting eMMC is and remains untested