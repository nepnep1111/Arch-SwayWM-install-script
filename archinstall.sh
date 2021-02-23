#!bin/bash

#mount root btrfs partition

#mount /dev/sda2 /mnt

#create btrfs subvolumes

#btrfs subvolume create /mnt/@
#btrfs subvolume create /mnt/@var
#btrfs subvolume create /mnt/@home
#btrfs subvolume create /mnt/@snapshots
#btrfs subvolume create /mnt/@tmp

#unmount root and mount subvol

#umount /mnt

#mount -o noatime,compress=zstd,space_cache,subvol=@ /dev/sda2 /mnt
#mkdir /mnt/{boot,var,home,.snapshots,tmp}
#mount -o noatime,compress=zstd,space_cache,subvol=@var /dev/sda2 /mnt/var
#mount -o noatime,compress=zstd,space_cache,subvol=@home /dev/sda2 /mnt/home
#mount -o noatime,compress=zstd,space_cache,subvol=@snapshots /dev/sda2 /mnt/.snapshots
#mount -o noatime,compress=zstd,space_cache,subvol=@tmp /dev/sda2 /mnt/tmp


#mount efi partition

#pacstrap and stuff

#----------------------------------------------------------

#install arch on x240 with gpt with root, boot partition, f2fs, refind/systemdboot, gpt, and zswap

#format and mount root f2fs
pacman -S f2fs-tools
mkfs.f2fs -f -l root -O extra_attr,inode_checksum,sb_checksum,compression /dev/sda2
mkdir /mnt
mount -o compress_algorithm=zstd /dev/sda2 /mnt

#mount boot fat32
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

#create swapfile
dd if=/dev/zero of=/mnt/swapfile bs=1M count=16386
chmod 600 /mnt/swapfile
swapon /mnt/swapfile

#install reflector and run to get mirrors
pacman -S reflector
reflector --country United States --48 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syu

#pacstrap install
pacstrap /mnt base linux linux-firmware nano man-db man-pages texinfo f2fs-tools btrfs-progs
