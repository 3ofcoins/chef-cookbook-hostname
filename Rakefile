require 'bundler/setup'

task :test do
  sh 'berks install --path vendor/cookbooks'
  sh 'strainer test'
end

task :default => :test

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
rescue LoadError
  puts ">>>>> Kitchen gem not loaded, omitting tasks" unless ENV['CI']
end
