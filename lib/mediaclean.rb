#!/usr/bin/env ruby

require 'active_support/all'
BASE_DIR = "#{File.dirname(__FILE__)}/.."

class Mediaclean
  Dir["#{BASE_DIR}/lib/mediaclean/*.rb"].each {|file| require file }

  def self.init
    @config = Mediaclean::Config.new
  end
end

Mediaclean.init