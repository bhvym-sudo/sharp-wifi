# Sharp-wifi firmware and working analysis
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

## Whats "boa"
- The Boa Web Server is a lightweight, single-tasking open-source HTTP server designed for Unix-like operating systems. Known for its low memory footprint and high speed, it was historically the go-to server for embedded environments, consumer routers, and Internet of Things (IoT) devices
