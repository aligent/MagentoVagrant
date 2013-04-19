name "redis"
description 'Redis server'
run_list(
    'recipe[yum::epel]',
    'recipe[redis2]'
)

default_attributes(
    :redis2 => {
        :install_from => 'package'
    }
)
