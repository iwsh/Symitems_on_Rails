# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# enables passenger
ENV['_PASSENGER_FORCE_HTTP_SESSION'] = "true"