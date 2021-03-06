require "rails_env_local/version"
require "rails"
require "rails_env_local/rails_env"

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
#   environment: a string (default is "localdev")
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
#
#   force: true or false (default is false)
#     Effect: will set Rails.env to environment no matter what.
#     Example: RailsEnvLocal.set_local_environment(force: true)

module RailsEnvLocal
  ORIGINAL_RAILS_DEVELOPMENT_ENVIRONMENT = "development"
  # Q: Why not just "local"?
  # A: It is too generic.  "local" is often used in the same ordinal position as, but with a different meaning than,
  #     the environment name.  For one example of this see: https://github.com/bkeepers/dotenv#multiple-rails-environments
  ALTERNATE_RAILS_DEVELOPMENT_ENVIRONMENT = "localdev"
  def self.set_local_environment(environment: ALTERNATE_RAILS_DEVELOPMENT_ENVIRONMENT, **options)
    options = {set_rails_env: true, set_rack_env: true, verbose: false, force: false}.merge(options)
    if was_development? || was_default? || options[:force]
      Rails.env = environment
      ENV["RAILS_ENV"] = Rails.env if options[:set_rails_env]
      ENV["RACK_ENV"] = Rails.env if options[:set_rack_env]
      puts "switching to custom local development environment: #{environment}" if options[:verbose]
    elsif [ENV["RAILS_ENV"], ENV["RACK_ENV"], Rails.env].compact.uniq.length > 1
      msg =  %(ENV["RAILS_ENV"], ENV["RACK_ENV"] and Rails.env are out of sync) if options[:verbose]
      warn(msg)
      Rails.logger.error(msg) if Rails.logger
    end
  end

  private
  def self.environment_variables
    [ENV["RAILS_ENV"], ENV["RACK_ENV"]]
  end

  def self.was_development?
    environment_variables.include?(ORIGINAL_RAILS_DEVELOPMENT_ENVIRONMENT)
  end

  def self.was_default?
    environment_variables.compact.empty?
  end
end

Rails.singleton_class.send(:prepend, RailsEnvLocal::RailsEnv)