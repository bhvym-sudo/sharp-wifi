#!/bin/sh

exeCmd="eponoamd "
i=0
result=`flash get EPON_LLID_TBL.$i.macAddr | sed 's/macAddr=//g'`
if [ "$result" == "" ]
then
    macaddr=`flash get ELAN_MAC_ADDR | sed 's/ELAN_MAC_ADDR=//g'`
    exeCmd=$exeCmd" -mac "$i" "$macaddr" "
    i=$((i+1))
    result=`flash get EPON_LLID_TBL.$i.macAddr | sed 's/macAddr=//g'`
# Added by peichao for bug#0003477
else
	cpu_mac_tmp=`flash get ELAN_MAC_ADDR | sed 's/ELAN_MAC_ADDR=//g'`
	cpu_mac=0x`echo $cpu_mac_tmp`
	pon_mac_tmp=`flash get EPON_LLID_TBL.$i | sed 's/macAddr=//g'`
	pon_mac0=`echo $pon_mac | sed 's/:[0-9a-fA-F]*:[0-9a-fA-F]*:://g'`
	pon_mac1=`echo $pon_mac | sed 's/:[0-9a-fA-F]*:://g' | sed 's/[0-9a-fA-F]*://g'`
	pon_mac2=`echo $pon_mac | sed 's/^[0-9a-fA-F]*:[0-9a-fA-F]*://g' | sed 's/:://g'`
	pon_mac0=`echo "0x"$pon_mac0`
	pon_mac1=`echo "0x"$pon_mac1`
	pon_mac2=`echo "0x"$pon_mac2`
	pon_mac_tmp=`printf %04x%04x%04x $pon_mac0 $pon_mac1 $pon_mac2`
	pon_mac=0x`echo $pon_mac_tmp`
if [ cpu_mac -eq pon_mac ];then
	echo "mac normal !"
else
	echo "mac changed !"
    macaddr=`flash get ELAN_MAC_ADDR | sed 's/ELAN_MAC_ADDR=//g'`
    exeCmd=$exeCmd" -mac "$i" "$macaddr" "
    i=$((i+1))
    result=`flash get EPON_LLID_TBL.$i.macAddr | sed 's/macAddr=//g'`
fi
# End of bug#0003477 
fi

while [ "$result" != "" ]
do
macaddr=`flash get EPON_LLID_TBL.$i.macAddr | sed 's/macAddr=//g'`
count=`echo $macaddr | awk -v RS=':' 'END {print --NR}'`
if [ ${count} == 3 ]
then
	tmp=`echo $macaddr | sed 's/:://g'`
	macaddr=`printf %s:0:: ${tmp}`
elif [ ${count} == 2 ]
then
	tmp=`echo $macaddr | sed 's/:://g'`
	macaddr=`printf %s:0:0:: ${tmp}`
fi
macaddr0=`echo $macaddr | sed 's/:[0-9a-fA-F]*:[0-9a-fA-F]*:://g'`
macaddr1=`echo $macaddr | sed 's/:[0-9a-fA-F]*:://g' | sed 's/[0-9a-fA-F]*://g'`
macaddr2=`echo $macaddr | sed 's/^[0-9a-fA-F]*:[0-9a-fA-F]*://g' | sed 's/:://g'`
macaddr0=`echo "0x"$macaddr0`
macaddr1=`echo "0x"$macaddr1`
macaddr2=`echo "0x"$macaddr2`
macaddr=`printf %04x%04x%04x $macaddr0 $macaddr1 $macaddr2`

exeCmd=$exeCmd"-mac "$i" "$macaddr" "

i=$((i+1))
result=`flash get EPON_LLID_TBL.$i.macAddr | sed 's/macAddr=//g'`

result1=`echo $result | grep 'fail'`
if [ "$result1" != "" ]
then
    break
fi

done

$exeCmd &

