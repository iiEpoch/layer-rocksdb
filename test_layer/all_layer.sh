#db_path
path="./db_test"

#pmem_path
path1="./pmem_test"

#ssd_path
path2="./ssd_test"

#wal_path(pmem)
path3="./db_test"

#wal_path(ssd)
path4="./db_test"

#report path
path5="/mnt/222"

threads=1

back_g=24

#write参数：value_size threads max_backgroungjobs dataset db path_pmem path_ssd wal_path report_file

#read参数：value_size reads max_backgroungjobs duration dataset  db path_pmem path_ssd wal_path use_direct_read read_cache_size report_file

#readrandomwriterandom参数:value_size threads max_backgroungjobs dataset duration db path_pmem path_ssd wal_path use_direct_read read_cache_size report_file

#准备

./write_p.sh 128 ${threads} ${back_g} 2 ${path} ${path1} ${path2} ${path3} ${path5} & sleep 300

for j in {56,112}
do
	for i in {256,512,1024,4096}
	do
		./write_s.sh ${i} ${threads} ${back_g} ${j} ${path} ${path1} ${path2} ${path4} ${path5} & sleep 300

		./write_compaction_none.sh ${i} ${threads} ${back_g} ${j} ${path} ${path1} ${path2} ${path3} ${path5} & sleep 300

		./write_p.sh ${i} ${threads} ${back_g} ${j} ${path} ${path1} ${path2} ${path3} ${path5} & sleep 300

		./read_layer.sh ${i} ${threads} ${back_g} 14400 ${j} ${path} ${path1} ${path2} ${path3} false 0 ${path5} & sleep 300

		./read_layer.sh ${i} ${threads} ${back_g} 14400 ${j} ${path} ${path1} ${path2} ${path3} true 10 ${path5} & sleep 300	
	done
done

for j in {56,112}
do
	for i in {256,512,1024,4096}
	do
	
	./write_p.sh ${i} 1 ${back_g} ${j} ${path} ${path1} ${path2} ${path3} ${path5} & sleep 300

	./readrandomwriterandom_layer.sh ${i} ${threads} ${back_g} ${j} 14400 ${path} ${path1} ${path2} ${path3} true 10 ${path5} & sleep 300

	./readrandomwriterandom_layer.sh ${i} ${threads} ${back_g} ${j} 14400 ${path} ${path1} ${path2} ${path3} false 0 ${path5} & sleep 300	

	done
done

