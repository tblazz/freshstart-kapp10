IMGKit.configure do |config|
  config.wkhtmltoimage = WKHTMLTOIMAGE_PATH
  config.default_options = {
      :quality => 60
  }
end