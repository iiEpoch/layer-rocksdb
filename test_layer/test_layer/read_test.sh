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

#layer_level
layer_level=3

threads=1

back_g=24

for j in {56,112} #dataset
do
	for i in {256,512,1024,4096} #value size
	do

		#测试
		./write_layer.sh ${i} 1 ${back_g} ${j} ${db_path} ${db_data_pmem} ${db_data_ssd} ${wal_path} ${report_path} ${layer_level}

		sleep 300

		./read_layer.sh ${i} ${threads} ${back_g} 14400 ${j} ${db_path} ${db_data_pmem} ${db_data_ssd} ${wal_path} true 10 ${report_path} ${layer_level}
		
		 sleep 300

		./read_layer.sh ${i} ${threads} ${back_g} 14400 ${j} ${db_path} ${db_data_pmem} ${db_data_ssd} ${wal_path} true 10 ${report_path} ${layer_level}
		
		 sleep 300

	done
done
