require "foreman/version"
require 'yaml'
module Foreman

  class AppDoesNotExist < Exception; end

  def self.runner
    File.expand_path("../../bin/foreman-runner", __FILE__)
  end

  def self.jruby?
    defined?(RUBY_PLATFORM) and RUBY_PLATFORM == "java"
  end

  def self.windows?
    defined?(RUBY_PLATFORM) and RUBY_PLATFORM =~ /(win|w)32$/
  end

end
