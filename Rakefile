require 'foodcritic'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RuboCop::RakeTask.new(:rubocop)

FoodCritic::Rake::LintTask.new do |t|
  t.options = {
    fail_tags: ['any']
  }
end

RSpec::Core::RakeTask.new(:spec)

task default: %w[foodcritic rubocop spec]
