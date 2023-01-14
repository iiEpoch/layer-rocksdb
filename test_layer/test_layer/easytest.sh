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

#准备
./write_layer.sh 1024 1 ${back_g} 200 ${db_path} ${db_data_pmem} ${db_data_ssd} ${wal_path} ${report_path} ${layer_level}

#value_size  dataset
./write_layer.sh 1024 ${threads} ${back_g} 200 ${db_path} ${db_data_pmem} ${db_data_ssd} ${wal_path} ${report_path} ${layer_level}

#value_size  duration  dataset  use_direct_reads  cache_szie
./read_layer.sh 1024 ${threads} ${back_g} 14400 200 ${db_path} ${db_data_pmem} ${db_data_ssd} ${wal_path} true 10 ${report_path} ${layer_level}
