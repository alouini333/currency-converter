# loading the app
require File.join(File.dirname(__FILE__), '..', 'config/environment')
# requiring test gems
require 'rack/test'
require 'rspec'
# setting env
set :environment, :test
ENV["SINATRA_ENV"] = "test"
# Creating a Mixin
module RSpecMixin
  include Rack::Test::Methods
  def app() ApplicationController end
end

RSpec.configure { |c| c.include RSpecMixin }