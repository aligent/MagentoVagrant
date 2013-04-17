name "web"
run_list "recipe[magento::nginx]", "recipe[magento::mysql]"

default_attributes "mysql" => {
    "bind_address" => "127.0.0.1",
    "tunable" => {
        "innodb_buffer_pool_size" => "1GB",
        "table_cache" => "1024",
        "query_cache_size" => "64M",
        "query_cache_limit" => "2M"
    },
    "server_debian_password" => "vagrant",
    "server_root_password" => "root",
    "server_repl_password" => "repl"
}