# Sharp-wifi firmware and working analysis

## Wifi router details and specs
- `cat /proc/version`
  - Linux version 3.18.24 (lipeichao@terminal) (gcc version 4.8.5 20150209 (prerelease) (Realtek MSDK-4.8.5p1 Build 2536) ) #7 SMP Mon Aug 17 15:16:39 CST 2020 [luna SDK V3.3.0]

- `cat /proc/cpuinfo`

  - system type		: RTL9607C/RTL9603C
    machine			: RTL9607C/RTL9603C
    processor		: 0
    cpu model		: MIPS interAptiv (multi) V2.0
    BogoMIPS		: 597.60
    wait instruction	: yes
    microsecond timers	: yes
    tlb_entries		: 64
    extra interrupt vector	: yes
    hardware watchpoint	: no
    isa			: mips1 mips32r2
    ASEs implemented	: mips16 mt eva
    shadow register sets	: 1
    kscratch registers	: 0
    package			: 0
    core			: 0
    VPE			: 0
    
    processor		: 1
    cpu model		: MIPS interAptiv (multi) V2.0
    BogoMIPS		: 449.74
    wait instruction	: yes
    microsecond timers	: yes
    tlb_entries		: 64
    extra interrupt vector	: yes
    hardware watchpoint	: no
    isa			: mips1 mips32r2
    ASEs implemented	: mips16 mt eva
    shadow register sets	: 1
    kscratch registers	: 0
    package			: 0
    core			: 0
    VPE			: 1
    
    processor		: 2
    cpu model		: MIPS interAptiv (multi) V2.0
    BogoMIPS		: 597.60
    wait instruction	: yes
    microsecond timers	: yes
    tlb_entries		: 64
    extra interrupt vector	: yes
    hardware watchpoint	: no
    isa			: mips1 mips32r2
    ASEs implemented	: mips16 mt eva
    shadow register sets	: 1
    kscratch registers	: 0
    package			: 0
    core			: 1
    VPE			: 0
    
    processor		: 3
    cpu model		: MIPS interAptiv (multi) V2.0
    BogoMIPS		: 597.60
    wait instruction	: yes
    microsecond timers	: yes
    tlb_entries		: 64
    extra interrupt vector	: yes
    hardware watchpoint	: no
    isa			: mips1 mips32r2
    ASEs implemented	: mips16 mt eva
    shadow register sets	: 1
    kscratch registers	: 0
    package			: 0
    core			: 1
    VPE
- `cat /proc/meminfo`
  - MemTotal:         178592 kB<br>
    MemFree:          118960 kB<br>
    MemAvailable:     141560 kB<br>
    Buffers:            5880 kB<br>
    Cached:            25592 kB<br>
    SwapCached:            0 kB<br>
    Active:            20180 kB<br>
    Inactive:          20708 kB<br>
    Active(anon):       9436 kB<br>
    Inactive(anon):       20 kB<br>
    Active(file):      10744 kB<br>
    Inactive(file):    20688 kB<br>
    Unevictable:           0 kB<br>
    Mlocked:               0 kB<br>
    HighTotal:             0 kB<br>
    HighFree:              0 kB<br>
    LowTotal:         178592 kB<br>
    LowFree:          118960 kB<br>
    SwapTotal:             0 kB<br>
    SwapFree:              0 kB<br>
    Dirty:                 0 kB<br>
    Writeback:             0 kB<br>
    AnonPages:          9416 kB<br>
    Mapped:            11944 kB<br>
    Shmem:                40 kB<br>
    Slab:              14744 kB<br>
    SReclaimable:       3328 kB<br>
    SUnreclaim:        11416 kB<br>
    KernelStack:        1728 kB<br>
    PageTables:          500 kB<br>
    NFS_Unstable:          0 kB<br>
    Bounce:                0 kB<br>
    WritebackTmp:          0 kB<br>
    CommitLimit:       89296 kB<br>
    Committed_AS:      62156 kB<br>
    VmallocTotal:    1015800 kB<br>
    VmallocUsed:        1060 kB<br>
    VmallocChunk:     999692 kB<br>

- `free -h`
  -                     total         used         free       shared      buffers
                Mem:   178592        59548       119044           40        5880
         -/+ buffers:    53668       124924
               Swap:        0            0            0

- `cat /proc/mtd`
  -  dev:    size   erasesize  name<br>
    mtd0: 000c0000 00020000 "boot"<br>
    mtd1: 00020000 00020000 "env"<br>
    mtd2: 00020000 00020000 "env2"<br>
    mtd3: 00a80000 00020000 "config"<br>
    mtd4: 00500000 00020000 "k0"<br>
    mtd5: 01400000 00020000 "r0"<br>
    mtd6: 00500000 00020000 "k1"<br>
    mtd7: 01400000 00020000 "r1"<br>
    mtd8: 00800000 00020000 "framework1"<br>
    mtd9: 00800000 00020000 "framework2"<br>
    mtd10: 03000000 00020000 "app"<br>
    mtd11: 00001000 00020000 "Partition_011"<br>
    mtd12: 00500000 00020000 "linux"<br>
    mtd13: 01400000 00020000 "rootfs"<br>


## How i gained access to root shell using telnet
- I explored the router configuration file more which i downloaded from router local website 192.168.1.1, I downloaded the file named lastgood.xml which is configuration file of router.
- After digging through the configuration file , I found out credentials for telnet and ftp.
- when i telnet into the wifi using `telnet 192.168.1.1` , instead of getting root shell , I got a shell which is made and configured by the Manufacturer and have limited set of commands
- So to explore the filesystem i logged into ftp using creds i got from the configuration file, and what i found out was the router had linux in it.
- My ftp shell logged into /var/tmp, so I changed my dir to /var, and found out the passwd file is in /var, then whats in /etc/passwd?
- when i checked passwd file in /etc/passwd, it was the symlink of /var/passwd, that means we could change the passwd file in var and router automatically configures using that passwd file
- once i downloaded the passwd file i noticed that my user which is "admin", have access to the manufacturer shell which is /bin/cli, i just changed the /bin/cli to /bin/sh to give the admin access to linux shell
- after logging in into telnet again, boom i got the access to linux shell, i could navigate the files now.

## Extracting firmware from router
- The linux router had firmware stored in /dev/mtdblock13 block of its storage, i opened a listening port using netcat on my machine which will write the incoming data into firmware.bin file
- `nc -lvp 8000 > firmware.bin`, and in my router `nc 192.168.1.31 8000 < /dev/mtdblock13/` which will send the router firmware to my listening port. 192.168.1.31 is ip of my machine
- boom i got the root file system of my router

## Analysing firmware
- My main goal is to modify the website file , and do some experiments with the led and optic fiber cable attached to it.
- `file firmware.bin` showed me that rootfile system is squashfs which is very common
- i unpacked the bin firmware using `unsquashfs firmware.bin`, and started exploring.
- I analysed the binaries stored in /bin, and some some startup scripts, which were written by manufacturer.
- I found the website files in /home/httpd/web/ with dynamic asp files, and /home/httpd/boa.conf for server configuration of router.
- I modified the login page changed the background to dark grey and packed the firmware using `sudo mksquashfs rootfs new_rootfs.squashfs -comp xz -b 128k -noappend`
- i uploaded the squashfs file into dev directory of the router , why dev? cause dev and other write read directories works on ram.
- i telnetted into the router and ran the command `cat /dev/new_rootfs.squashfs > dev/mtdblock13`, this command will flash the new fs into the mtdblock13 of router which is rootfs
- Rebooted the router using `reboot`, waited for router startup and when i navigated to 192.168.1.1 on browser , the changes were made successfully, I got the dark grey background instead of default and my own title too.

## Making /bin/sh permanent in the passwd file
- Everytime i reboot the router , the changes i made to passwd file , gets reset again to /bin/cli, and then again I have to put my modified passwd file there
- So I decided to make the /bin/sh permanent.
- passwd file is in var dir which is loaded on ramfs, means some script or executable writes the changes to /var/passwd everytime the router reboots and starts
- We just need to find that executable or script which is responsible for this and then reverse engineer it.
- I ran the command to search for string /var/passwd in the strings of executables in /bin, I got interesting output which is bin/startup. There were other binaries too but this got my attention.
- I loaded the bin/startup into ghidra , and searched for string /var/passwd, and i found out the exact function which was responsible for making change to /var/passwd file
- I found the vfunction named fprintf(pFVar5,FORMAT3,&user_name,hash,&PW_HOME_DIR,&PW_CMD_SHELL);, notice the arguements of this function which matches the exact format in the passwd file admin:$1$$HjFU9UGk4tmzjQWcc9rcN1:0:0::/tmp:/bin/sh.
- the variable PW_CMD_SHELL is our goal, we have to find its location and modify its value which is PW_CMD_SHELL="/bin/cli" changing it to "/bin/sh"
- After digging deeper , I found out that this is a global variable and the binary is getting this variable from somewhere else.
- So to look for this variable in root file system I ran the command `grep -rl 'PW_CMD_SHELL' .` and i got the output<br>
  - ./lib/features/libvs_omciapi.so<br>
  ./lib/libmib.so<br>
  ./bin/boa<br>
  ./bin/startup<br>
  ./bin/eponoamd<br>
  ./bin/cli<br>
  ./bin/bin/boa<br>
  ./bin/bin/startup<br>
  ./bin/bin/eponoamd<br>
  ./bin/bin/cli<br>
  ./bin/bin/cwmpClient<br>
  ./bin/cwmpClient<br>
- libmib.so caught my attention, so I imported it into ghidra, searched for PW_CMD_SHELL and I got the variable , with "/bin/cli" written in front of it. that means the binary "startup" was importing variables from this library.
- next thing I opened that address into bytes editor of ghidra, carefully changed /bin/cli to /bin/sh, cause i dont want to mess up the table.
- Exported the libmib.so, as patched version, replaced it with the original libmib.so and flashed the patched firmware.
- i rebooted the router , logged in using telnet and I got the linux shell which is now permanent.


## Whats "boa"
- The Boa Web Server is a lightweight, single-tasking open-source HTTP server designed for Unix-like operating systems. Known for its low memory footprint and high speed, it was historically the go-to server for embedded environments, consumer routers, and Internet of Things (IoT) devices

## Contribution
- Contributions are welcome in the form of analysis , and creating pull request of your analysis.
