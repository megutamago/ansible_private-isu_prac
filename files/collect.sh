#!/bin/bash
set -eu

cat <<EOF > /root/os-data/pattern.txt
apparmor.service
apport.service
blk-availability.service
cloud-config.service
cloud-final.service
cloud-init-local.service
cloud-init.service
console-setup.service
cron.service
dbus.service
finalrd.service
getty@tty1.service
irqbalance.service
keyboard-setup.service
kmod-static-nodes.service
lvm2-monitor.service
multipathd.service
networkd-dispatcher.service
packagekit.service
plymouth-quit-wait.service
plymouth-quit.service
plymouth-read-write.service
polkit.service
rsyslog.service
serial-getty@ttyS0.service
setvtrgb.service
snapd.apparmor.service
snapd.seeded.service
snapd.service
ssh.service
systemd-fsck-root.service
systemd-fsck@dev-disk-by\x2dlabel-UEFI.service
systemd-journal-flush.service
systemd-journald.service
systemd-logind.service
systemd-machine-id-commit.service
systemd-modules-load.service
systemd-networkd-wait-online.service
systemd-networkd.service
systemd-random-seed.service
systemd-remount-fs.service
systemd-resolved.service
systemd-sysctl.service
systemd-sysusers.service
systemd-timesyncd.service
systemd-tmpfiles-setup-dev.service
systemd-tmpfiles-setup.service
systemd-udev-trigger.service
systemd-udevd.service
systemd-update-utmp.service
systemd-user-sessions.service
ufw.service
unattended-upgrades.service
user-runtime-dir@1000.service
user@1000.service
EOF

systemctl list-units --all --type=service | grep -v inactive > /root/os-data/systemd-info.txt
grep -vf /root/os-data/pattern.txt /root/os-data/systemd-info.txt > /root/os-data/result.txt