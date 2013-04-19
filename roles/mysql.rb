name 'mysql'
description 'MySQL server'
run_list (
    'recipe[magento::mysql]'
)

default_attributes "mysql" => {
    "bind_address" => "127.0.0.1",          ## @TODO: This should be set dynamically
    "tunable" => {
        "innodb_buffer_pool_size" => "1GB",
        "table_cache" => "1024",
        "query_cache_size" => "64M",
        "query_cache_limit" => "2M"
    },
    "server_debian_password" => "vagrant",  ## @TODO: These values should be set dynamically.
    "server_root_password" => "root",
    "server_repl_password" => "repl"
}