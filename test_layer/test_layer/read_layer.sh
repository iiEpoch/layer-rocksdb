#!/bin/bash
declare -i cache=${11}\*1024\*1024\*1024
declare -i data=${5}\*1024\*1024\*1024\/${1}
../db_bench --benchmarks="readrandom,stats,levelstats" \
--use_existing_db=1 \
--use_existing_keys=1 \
--enable_write_thread_adaptive_yield=false \
--disable_auto_compactions=false \
--compression_type=snappy \
--max_background_jobs=${3} \
--value_size=${1} --key_size=16 --enable_pipelined_write=true \
--allow_concurrent_memtable_write=true \
--batch_size=1 \
--db=${6} \
--db_paths_1=${7} \
--db_paths_2=${8} \
--layer_level=${13} \
--wal_dir=${9} \
--histogram=true \
--target_file_size_base=67108864 \
--use_direct_io_for_flush_and_compaction=true \
--use_direct_reads=${10} \
--num=${data} \
--statistics=true \
--reads=${2} \
--duration=${4} \
--block_size=1 \
--read_cache_size=${cache} \
--report_interval_seconds=5 \
--report_file=${12}/layer-read-ValueSize_${1}_DataSet_${5}_DirectReads_${10}.csv \
| tee ${12}/layer-read-ValueSize_${1}_DataSet_${5}_DirectReads_${10}_LayerLevel_${13}.txt 2>&1


