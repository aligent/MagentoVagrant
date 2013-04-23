name 'mysql'
description 'MySQL server'
run_list (
    'recipe[magento::mysql]'
)

default_attributes "mysql" => {
    "bind_address" => "127.0.0.1",          ## @TODO: This should be set dynamically
    "tunable" => {
        "max_connections" => 300,
        "key_buffer_size" => "1G",
        "max_allowed_packet" => "16M",
        "thread_stack" => "512K",
        "thread_cache_size" => 96,
        "thread_concurrency" => 30,
        "sort_buffer_size" => "24M",
        "join_buffer_size" => "64M",
        "table_open_cache" => 12288,
        "table_cache" => 12288,
        "open_files_limit" => 24576,
        "query_cache_limit" => "4M",
        "query_cache_size" => "8G",
        "long_query_time" => "0.2",
        "max_binlog_size" => "1024M",
        "innodb_additional_mem_pool_size" => "64M",
        "innodb_buffer_pool_size" => "32M",
        "innodb_log_buffer_size" => "32M",
        "innodb_buffer_pool_instances" => 4,
        "innodb_read_io_threads" => 8
    },
    "server_debian_password" => "vagrant",  ## @TODO: These values should be set dynamically.
    "server_root_password" => "root",
    "server_repl_password" => "repl"
}