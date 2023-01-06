#db_path
db_path="./db_test"

#pmem_path
db_data_pmem="./pmem_test"

#ssd_path
db_data_ssd="./ssd_test"

#wal_path
wal_path="./db_test"

#report path
report_path="/mnt/222"

threads=1

back_g=24

for j in {56,112} #dataset
do
	for i in {256,512,1024,4096}  #value_size
	do
		
		#准备
		./write_p.sh ${i} 1 ${back_g} ${j} ${db_path} ${db_data_pmem} ${db_data_ssd} ${wal_path} ${report_path}

		 sleep 300

		#测试
		./write_p.sh ${i} ${threads} ${back_g} ${j} ${db_path} ${db_data_pmem} ${db_data_ssd} ${wal_path} ${report_path}

		 sleep 300

	done
done
