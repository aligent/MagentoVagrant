#root = File.absolute_path(File.dirname(__FILE__))
root = '/home/luke/chef/'
file_cache_path root
cookbook_path [root + '/cookbooks', root + '/cookbooks-aligent', root + '/cookbooks-local']
role_path root + '/roles'
log_level :info

