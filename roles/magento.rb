name "magento"
description 'Installs all the requisite packages to run the Magento application'
run_list(
    'recipe[magento]',          # Installs php etc...
    'recipe[magento::nginx]',   # Installs nginx (obviously)
    'recipe[simple_iptables]'
)

default_attributes(
    :magento => {
        :gen_cfg => false
    }
)
