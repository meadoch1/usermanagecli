require "bundler/gem_tasks"
require 'cucumber'
require 'cucumber/rake/task'
require 'rubygems/package_task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty -x"
  t.fork = false
end

spec = eval(File.read('usermanagecli.gemspec'))

Rake::PackageTask.new(spec) do |pkg|
end
