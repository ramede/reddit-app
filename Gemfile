# frozen_string_literal: true

source "https://rubygems.org"
ruby "2.6.3"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Gems
gem 'cocoapods', '1.10.1'

plugins_path = File.join(File.dirname(__FILE__), 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
