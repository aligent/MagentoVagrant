name "developer"
description 'Installs all the requisite packages for development of the Magento application'
run_list(
    'recipe[chef-php-extra::xdebug]'
)

default_attributes(
    :xdebug => {
        :idekey => 'netbeans-xdebug',
    }
)
