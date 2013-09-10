App.config.define :test3 do

  log_level Logger::INFO

  some2 "bbb"

  bla 12

  proc_test do
    App.config.some2 + "ccc"
  end

end
