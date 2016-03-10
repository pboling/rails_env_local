module RailsEnvLocal
  # This module is prepended to Rails module
  module RailsEnv
    def env
      result = super
      if result == "development"
        msg =  %[WARNING: environment is incorrectly "development". Early access of Rails.env might be the cause, consider moving `RailsEnvLocal.set_local_environment` up in config/boot.rb]
        warn(msg)
        Rails.logger.error(msg) if Rails.logger
      end
      result
    end
  end
end