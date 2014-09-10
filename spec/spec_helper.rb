require 'rspec'
require 'rack/test'

# load app
SPEC_DIR = File.expand_path File.dirname(__FILE__)
require File.join(SPEC_DIR, "../instant_search.rb")

ENV['RACK_ENV'] = 'test'

RSpec.configure do |conf|
      conf.include Rack::Test::Methods
end
