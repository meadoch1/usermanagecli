require 'rspec'
require 'pathname'
APP_PATH = Pathname.new File.expand_path(File.join(File.dirname(__FILE__), '..'))

# Require all ruby files in the lib folder
Dir[APP_PATH + "lib" + "**" + "*.rb"].each {|f| require f}
