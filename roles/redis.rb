name "redis"
run_list "recipe[yum::epel]", "recipe[redis2::cache]"

default_attributes "redis2" => {
    "install_from" => "package"
}
