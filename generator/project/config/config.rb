# Defaults configs
# enved configs can redefine this
# also, can create config/config.yml (by capistrano for example) and its loads automatically

App.config.define :default do

  # Set log level for App.logger
  log_level Logger::INFO

end
