#!/bin/bash
declare -i data=${4}\*1024\*1024\*1024\/${1}
./db_bench --benchmarks="fillrandom,stats,levelstats" \
--enable_write_thread_adaptive_yield=false \
--disable_auto_compactions=false \
--compression_type=snappy \
--max_background_jobs=${3} \
--value_size=${1} --key_size=16 --enable_pipelined_write=true \
--allow_concurrent_memtable_write=true \
--batch_size=1 \
--db=${5} \
--db_paths_1=${6} \
--db_paths_2=${7} \
--wal_dir=${8} \
--use_direct_io_for_flush_and_compaction=true \
--target_file_size_base=67108864 \
--sync=false \
--num=${data}  \
--threads=${2} \
--report_interval_seconds=5 \
--report_file=${9}/layer-write-ValueSize_${1}_DataSet_${4}_wal_ssd.csv \
| tee ${9}/layer-write-ValueSize_${1}_DataSet_${4}_wal_ssd.txt 2>&1
