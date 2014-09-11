require 'rspec'
require 'rack/test'

# load app
ROOT_DIR = File.join(File.expand_path(File.dirname(__FILE__)), './..')
require File.join(ROOT_DIR, "instant_search.rb")
require File.join(ROOT_DIR, 'script/populate_dynmo')

ENV['RACK_ENV'] = 'test'

RSpec.configure do |conf|
      conf.include Rack::Test::Methods
end
