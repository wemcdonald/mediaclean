#!/usr/bin/env ruby

require 'active_support/all'

class Mediaclean
  Dir[::File.dirname(__FILE__) + '/mediaclean/*.rb'].each {|file| require file }

  def self.init
    @config = YAML.load(::File.open(::File.dirname(__FILE__) + '/../config.yml'))
    @config.symbolize_keys!
  end
end

Mediaclean.init