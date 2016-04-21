IMGKit.configure do |config|
  config.wkhtmltoimage = Rails.root.join('bin', 'wkhtmltoimage').to_s
  config.default_options = {
      :quality => 80
  }
end