# this file is related to the rackup command
# first it loads the whole app
require_relative './config/environment'
require_relative './config/boot'
# then it runs the main controller
run ApplicationController