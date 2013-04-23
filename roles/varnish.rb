name "varnish"
description 'Installs the Varnish web server'
run_list(
    'recipe[chef-varnish]'
)

default_attributes(
    :varnish => {
        :VARNISH_LISTEN_PORT => 6081,
        :VARNISH_BACKEND_PORT => 80
    }
)
