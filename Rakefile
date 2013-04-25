require 'bundler/setup'

task :test do
  sh 'berks install --path vendor/cookbooks'
  sh 'strainer test'
end

task :default => :test
