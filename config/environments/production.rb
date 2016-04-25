Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Enable Rack::Cache to put a simple HTTP cache in front of your application
  # Add `rack-cache` to your Gemfile before enabling this.
  # For large-scale production use, consider using a caching reverse proxy like
  # NGINX, varnish or squid.
  # config.action_dispatch.rack_cache = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.serve_static_files = true

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # `config.assets.precompile` and `config.assets.version` have moved to config/initializers/assets.rb

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = :warn

  # Prepend all log lines with the following tags.
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups.
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = 'http://assets.example.com'

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  # config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Do not dump schema after migrations.
  # config.active_record.dump_schema_after_migration = false

  Resque.logger.level = MonoLogger::WARN

  WKHTMLTOIMAGE_PATH = Rails.root.join('bin', 'wkhtmltoimage').to_s

  ENV['REDIS_URL'] ||= 'redis://h:pdrsrc5v6f12a31i5ed1nhsfufd@ec2-46-137-82-111.eu-west-1.compute.amazonaws.com:25929'
  ENV['MIN_PUMA_WORKERS_COUNT'] ||= '1'
  ENV['MAX_PUMA_WORKERS_COUNT'] ||= '8'

  #config S3
  ENV['AWS_REGION'] ||= 'eu-west-1'
  ENV['S3_BUCKET'] ||= 'kapp10finishline'
  ENV['AWS_ACCESS_KEY_ID'] ||= 'AKIAIT5MGBQ56BK3QPSQ'
  ENV['AWS_SECRET_ACCESS_KEY'] ||= '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'

  ENV['ALLMYSMS_LOGIN'] ||= 'kappsports1'
  ENV['ALLMYSMS_API_KEY'] ||= '26796fefc15acae'

  ENV['BITLY_API_TOKEN'] ||='56535209c321e128c3569d1eceaefed77e375b7a'

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.smtp_settings = {
      address:              'ssl0.ovh.net',
      port:                 587,
      domain:               'kapp10.com',
      user_name:            'contact@kapp10.com',
      password:             'footix3@0',
      authentication:       'plain',
      enable_starttls_auto: true
  }
end
