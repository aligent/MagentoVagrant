name "magento"
description 'Installs all the requisite packages to run the Magento application'
run_list(
    'recipe[magento]',          # Installs php etc...
    'recipe[magento::nginx]',   # Installs nginx (obviously)
    'recipe[nginx::aligent]',
    'recipe[chef-php-extra::predis]',
    'recipe[chef-php-extra::module_soap]',
    'recipe[chef-php-extra::module_xml]',
    'recipe[timezone-ii]',
    'recipe[simple_iptables]',
    #'recipe[magento::iptables]',
    'recipe[magento::postfix]',
    'recipe[magento::n98magerun]',
    'recipe[magento::modman]',
    'recipe[composer]',
)

default_attributes(
    :yum => {
        :ius_release => '1.0-11',
        :remi => {
            :includepkgs => 'php-fpm'
        }
    },
    :magento => {
        :gen_cfg => false,
        :nginx => {
            :fastcgi_process => 'unix:/var/run/php-fcgi.sock'
        }
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
    },
    :tz => 'Australia/Adelaide',
    :composer => {
        :install_dir => '/usr/local/bin'
    }
)
