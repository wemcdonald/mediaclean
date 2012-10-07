#!/usr/bin/env ruby

BASE_DIR = "#{File.dirname(__FILE__)}/.."
FAKEFS = defined?(FakeFS)

require 'active_support/all'
Dir["#{BASE_DIR}/lib/core_ext/**/*.rb"].each {|file| require file }

class Mediaclean
  Dir["#{BASE_DIR}/lib/mediaclean/*.rb"].each {|file| require file }
end