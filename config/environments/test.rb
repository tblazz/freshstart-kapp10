Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure static file server for tests with Cache-Control for performance.
  config.serve_static_files   = true
  config.static_cache_control = 'public, max-age=3600'

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Randomize the order test cases are executed.
  config.active_support.test_order = :random

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  #configuration des loggers
  config.log_level = :debug
  Resque.logger.level = MonoLogger::DEBUG

  WKHTMLTOIMAGE_PATH = '/Users/IBI/.rvm/gems/ruby-2.3.0/bin/wkhtmltoimage'

  ENV["REDIS_URL"] ||= "redis://h:pdrsrc5v6f12a31i5ed1nhsfufd@ec2-46-137-82-111.eu-west-1.compute.amazonaws.com:25929"
  ENV["MIN_PUMA_WORKERS_COUNT"] ||= "1"
  ENV["MAX_PUMA_WORKERS_COUNT"] ||= "8"

  #config S3
  ENV['AWS_REGION'] ||= "eu-west-1"
  ENV['S3_BUCKET'] ||= "kapp10finishline"
  ENV['AWS_ACCESS_KEY_ID'] ||= "AKIAIT5MGBQ56BK3QPSQ"
  ENV['AWS_SECRET_ACCESS_KEY'] ||= "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"

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
