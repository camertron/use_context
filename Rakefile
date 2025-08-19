# frozen_string_literal: true

require "rake/testtask"
require "rubygems/package_task"

Bundler::GemHelper.install_tasks

Rake::TestTask.new("test") do |t|
  t.warning = false
  t.libs << "test"
  t.test_files = FileList[
    "test/**/*_test.rb"
  ]
end

task default: [:test]
