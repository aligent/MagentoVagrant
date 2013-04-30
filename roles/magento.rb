name "magento"
description 'Installs all the requisite packages to run the Magento application'
run_list(
    'recipe[magento]',          # Installs php etc...
    'recipe[magento::nginx]',   # Installs nginx (obviously)
    'recipe[nginx::aligent]',
    'recipe[chef-php-extra::predis]',
    'recipe[chef-php-extra::module_soap]',
    'recipe[chef-php-extra::module_xml]',
    'recipe[simple_iptables]'
)

default_attributes(
    :yum => {
        :ius_release => '1.0-11',
        :remi => {
            :includepkgs => 'php-fpm'
        }
    },
    :magento => {
        :gen_cfg => false
    },
    :nginx => {
        :gzip_types => ['text/plain', 'text/html', 'text/css', 'application/x-javascript',
                        'text/xml', 'application/xml', 'application/xml+rss', 'text/javascript'],
        :keepalive_timeout => 10,
        :gzip => 'on',
        :gzip_http_version => '1.1',
        :gzip_vary => 'off'
    },
    :php => {
        :ius => ''
    }
)
