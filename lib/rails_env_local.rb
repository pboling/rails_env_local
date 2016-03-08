require "rails_env_local/version"
require "rails"

# Usage:
#
# In config/boot.rb you have:
#
#     require 'bundler/setup'
#
# After that line (or before, see NOTE below) add:
#
#     require 'rails_env_local'
#     RailsEnvLocal.set_local_environment
#
# NOTE: If you need your custom local environment to be set before some of the other gems you use,
#       because they rely on the environment being set early,
#       then just place the two lines above *before* the `require 'bundler/setup'`.  Simple as that.
#
# Options:
#
#   environment: a string (default is "local")
#     Effect: will set the Rails environment (Rails.env) to the given string
#     Example: RailsEnvLocal.set_local_environment(environment: "panda")
#
#   verbose: true or false (default is false)
#     Effect: will print the environment to STDOUT as it is being set
#     Example: RailsEnvLocal.set_local_environment(verbose: true)
#
#   set_rack_env: true or false (default is true)
#     Effect: will additionally set RAILS_ENV to match Rails.env
#     Example: RailsEnvLocal.set_local_environment(set_rack_env: false)
#
#   set_rails_env: true or false (default is true)
#     Effect: will additionally set RACK_ENV to match Rails.env
#     Example: RailsEnvLocal.set_local_environment(set_rails_env: false)

module RailsEnvLocal
  DEVELOPMENT_ENVIRONMENT = "development"
  def self.set_local_environment(environment: "local", **options)
    if ENV["RAILS_ENV"] == DEVELOPMENT_ENVIRONMENT || Rails.env == DEVELOPMENT_ENVIRONMENT
      Rails.env = environment
      options = {set_rails_env: true, set_rack_env: true, verbose: false}.merge(options)
      ENV["RAILS_ENV"] = Rails.env if options[:set_rails_env]
      ENV["RACK_ENV"] = Rails.env if options[:set_rack_env]
      puts "switching to custom local development environment: #{environment}" if options[:verbose]
    end
  end
end
