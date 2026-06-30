
LASTGOOD_FILE="/var/config/lastgood.xml"
TEST_DIR="/var/config/"
TEST_PREFIX="_tf_"
TEST_NUMBER="50"

copy_test(){
	
	index=0
	while [ "${index}" != "50" ]
	do
		cp ${LASTGOOD_FILE} ${TEST_DIR}${TEST_PREFIX}_${index}
		index=`expr ${index} + 1`
	done

	index=0
	while [ "${index}" != "50" ]
	do
		rm  ${TEST_DIR}${TEST_PREFIX}_${index}
		index=`expr ${index} + 1`
	done
}


main(){
	copy_test
}

main
