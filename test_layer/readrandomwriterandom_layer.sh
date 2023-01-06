#!/bin/bash
declare -i cache=${11}\*1024\*1024\*1024
declare -i data=${4}\*1024\*1024\*1024\/${1}
./db_bench --benchmarks="readrandomwriterandom,stats,levelstats" \
--use_existing_db=1 \
--enable_write_thread_adaptive_yield=false \
--allow_concurrent_memtable_write=true \
--readwritepercent=80 \
--disable_auto_compactions=false \
--compression_type=snappy \
--max_background_jobs=${3} \
--value_size=${1} --key_size=16 --enable_pipelined_write=true \
--allow_concurrent_memtable_write=true \
--batch_size=1 \
--db=${6} \
--db_paths_1=${7} \
--db_paths_2=${8} \
--wal_dir=${9} \
--histogram=true \
--statistics=true \
--target_file_size_base=67108864 \
--use_direct_io_for_flush_and_compaction=true \
--use_direct_reads=${10} \
--threads=${2} \
--read_cache_size=${11} \
--duration=${5} \
--num=${data} \
--report_interval_seconds=5 \
--report_file=${12}/layer-readrandomwriterandom-ValueSize_${1}_DataSet_${4}_DirectReads_${10}.csv \
| tee ${12}/layer-readrandomwriterandom-ValueSize_${1}_DataSet_${4}_DirectReads_${10}.txt 2>&1
