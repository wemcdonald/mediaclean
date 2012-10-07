require 'rubygems'
require 'rspec'
require 'simplecov'

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'fakefs/safe'
require 'fakefs/spec_helpers'
require 'mediaclean'


RSpec.configure do |config|
  config.mock_framework = :rr
  config.formatter = 'Fivemat'

  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end

