# SunspotAdmin
require 'sunspot_admin/sunspot_admin'
require 'sunspot_admin/routing'

%w{ models controllers helpers views }.each do |dir|
  path = File.expand_path(File.join(File.dirname(__FILE__), '../app', dir))
  $LOAD_PATH << path
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end

