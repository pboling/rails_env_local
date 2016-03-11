module RailsEnvLocal
  # This module is prepended to Rails module
  module RailsEnv
    def env
      result = super
      case result
      when "development" then
        msg =  %[WARNING: environment is incorrectly "development". Early access of Rails.env might be the cause, consider moving `RailsEnvLocal.set_local_environment` up in config/boot.rb]
        warn(msg)
        Rails.logger.error(msg) if Rails.logger
      when "local"
        msg =  %[WARNING: environment name "local" is partly incompatible with dotenv gem, and probably others]
        warn(msg)
        Rails.logger.error(msg) if Rails.logger
      else
        # If other bad environment names are found add them to the case statement.
        # Share the knowledge about environment name incompatibility!
      end
      result
    end
  end
end
