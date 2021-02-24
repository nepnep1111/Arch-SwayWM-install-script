#!/bin/bash

#---------------------------------------------btrfs install w.i.p
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

#-----------------------------------------------------------------

#install arch on x240 with gpt with root, boot partition, f2fs, refind/systemdboot, gpt, and zswap

#format and mount root f2fs
#pacman -S f2fs-tools
#mkfs.f2fs -f -l root -O extra_attr,inode_checksum,sb_checksum,compression /dev/sda2
#mkdir /mnt
#mount -o compress_algorithm=zstd /dev/sda2 /mnt

#mount boot fat32
#mkdir /mnt/boot
#mount /dev/sda1 /mnt/boot

#create swapfile
#dd if=/dev/zero of=/mnt/swapfile bs=1M count=16386
#chmod 600 /mnt/swapfile
#swapon /mnt/swapfile

#install reflector and run to get mirrors
#pacman -S reflector
#reflector --country United States --48 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
#pacman -Syu

#pacstrap install
#pacstrap /mnt base linux linux-firmware nano man-db man-pages texinfo f2fs-tools btrfs-progs


#Text attributes'
bold='\033[1m'
underscore='\033[4m'
blink='\033[5m'
reverseVideo='\033[7m'
conceal='\033[8m'
AO='\033[0m' # alloff

#text color

black='\033[30m'
red='\033[31m'
green='\033[32m'
yellow='\033[33m'
blue='\033[34m'
magenta='\033[35m'
cyan='\033[36m'
white='\033[37m'

#background colors

bblack='\033[40m'
bred='\033[41m'
bgreen='\033[42m'
byellow='\033[43m'
bblue='\033[44m'
bmagenta='\033[45m'
bcyan='\033[46m'
bwhite='\033[47m'

oldname="test"
newname="testme"

#archpackages
archbase="base linux linux-firmware nano man-db man-pages texinfo f2fs-tools btrfs-progs sudo yay"
archswaygit=""
archextra=""
archdesktop=""
archx240="tlp"
archgpdwinmax="tlp"
chaoticaurkeymirror="chaotic-keyring chaotic-mirrorlist"

#MAIN MENU
echo "
${green}Main Menu${AO}
1. Partition Drive
2. Format Partitions
3. Install Arch
4. Arch-chroot/postinstall
5. #
88. Exit
99. Shut Down"
read -r select
case $select in
    
    1)
        #Partition Drive MENU
        echo -e "
    ${yellow}Partition Drive${AO}
    1. #
    2. #
    3. #
    4. #
    5. #
    6. #
    7. #
    8. #
    9. #
    10. #
    88. Return to Main Menu
        99. Shutdown"
        read -r PartitionDrive
        case $PartitionDrive in
            
            1) #
                #
            ;;
            2) #
                #
            ;;
            3) #
                #
            ;;
            4) #
                #
            ;;
            5) #
                #
            ;;
            6) #
                #
            ;;
            7) #
                #
            ;;
            8) #
                #
            ;;
            9) #
                #
            ;;
            10) #
                #
            ;;
            88) #return to main MENU
                ./archinstall.sh
            ;;
            99) #Shutdown
                poweroff
            ;;
        esac
    ;;
    2)
        
        #Format Partitions MENU
        echo "
      ${yellow}Format Partitions${AO}
      1. Format SATA SSD for F2FS
      2. Format NVME SSD for F2FS
      3. Format SATA BOOTorESP partition
      4. Format NVME BootorESP parition
      5. Create SwapFile
      88. Return to main menu
        99. Shutdown"
        read -r formatpartitions
        case $formatpartitions in
            
            1) #Format SATA SSD for F2FS
                echo "checking if f2fs-tools are installed"
                pacman -S f2fs-tools
                echo "what drive letter and partition? EX: /dev/sda2"
                read -r f2fspartionformat
                mkfs.f2fs -f -l root -O extra_attr,inode_checksum,sb_checksum,compression $f2fspartionformat
            ;;
            2) # #
                #
            ;;
            3) ##
                #
            ;;
            4) #
                #
            ;;
            5) #Create swapfile
                echo "creating swapfile
                How many MB should the swapfile be? ex: 16386 for 16GB"
                read -r swapsize
                dd if=/dev/zero of=/mnt/swapfile bs=1M count=$swapsize
                chmod 600 /mnt/swapfile
                swapon /mnt/swapfile
            ;;
            88) #Return to main menu
                ./archinstall.sh
            ;;
            99)
                poweroff
            ;;
        esac
        
        
    ;;
    3)
        
        #Install Arch Menu
        echo "
      ${yellow}Install Arch Menu${AO}
      1. Install arch base
      2. genfstab
      3. Chroot to arch install
      88. Return to Main Menu
        99. Shutdown"
        read -r installarch
        case $installarch in
            1)#Install arch base
                #
            ;;
            2) #genfstab
                echo "generating fstab"
                genfstab -U /mnt >> /mnt/etc/fstab
                sudo pacman -S nano
                nano /mnt/etc/fstab
            ;;
            3) #Chroot
                echo "chrooting into arch install"
                arch-chroot /mnt
            ;;
            88) #return to main MENU
            ./archinstall.sh;;
            99)
            poweroff;;
        esac
        
    ;;
    4)
        
        #Arch-chroot/postinstall MENU
        echo "
      ${yellow}Arch-chroot/postinstall MENU${AO}
      1. Add Chaotic Aur
      2. Install swaywm-git and waybar-git (needs choatic aur)
      3. Edit and gen locale
      4. Set hostname
      5. mkinitcpio
      6. Set root password
      7. install grub
      8. install refind
      9. install systemdboot
      10. install intel microcode
      11. install amd microcode
      12. edit pacman.conf
      13. create user
      88. Return to Main Menu
        99. Shutdown"
        read postinstall
        case $postinstall in
            1) #Add chaotic aur
                echo "installing mirrorlist and keyring"
                yay -S $chaoticaurkeymirror
                echo "adding to /etc/pacman.d"
                echo "[chaotic-aur]" >> /etc/pacman.d
                echo "Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.d
                echo "running pacman -Syu"
                pacman -Syu
            ;;
            2) #Install Swaywm/waybar-git
                #
            ;;
            3) #Edit and gen locale
                nano /etc/locale.conf
                nano /etc/vconsole.conf
            ;;
            4) #Set hostname
                nano /etc/hostname
            ;;
            5) #mkinitcpio
                mkinitcpio -P
            ;;
            6) #set root password
                passwd
            ;;
            7) #install grub
            ;;
            8) #install refind
            ;;
            9) #install systemdboot
            ;;
            10) #install intel microcode
                pacman -S intel-ucode
            ;;
            11) #install amd microcode
                pacman -S amd-ucode
            ;;
            12)#edit pacmanconf
                nano /etc/pacman.conf
            ;;
            13) #useradd
                echo "username?"
                read username
                useradd -m -G wheel $username
                echo "running passwd to set password"
                passwd $username
            ;;
            88) #return to main menu
            ./archinstall.sh;;
            99)#Shutdown
            poweroff;;
        esac
        
    ;;
    5)
        
        #
        echo "
      ${yellow}#${AO}
      1. #
        "
        read -r placeholder
        case $placeholder in
            1)
            ;;
            2)
            ;;
            3)
            ;;
            88)
            ./archinstall.sh;;
            99)
            poweroff;;
        esac
        
        
    ;;
    88)
        Exit
    ;;
    99)
        poweroff
    ;;
esac
