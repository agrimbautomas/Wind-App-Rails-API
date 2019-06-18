Rails.application.configure do
	# Code is not reloaded between requests.
	config.cache_classes = true

	# Rake tasks automatically ignore this option for performance.
	config.eager_load = true

	# Full error reports are disabled and caching is turned on.
	config.consider_all_requests_local = false
	config.action_controller.perform_caching = true

	# Disable serving static files from the `/public` folder by default since
	# Apache or NGINX already handles this.
	config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

	# Compress JavaScripts and CSS.
	config.assets.js_compressor = :uglifier
	# config.assets.css_compressor = :sass

	# Do not fallback to assets pipeline if a precompiled asset is missed.
	config.assets.compile = false

	# Don't care if the mailer can't send.
	ActionMailer::Base.delivery_method = :smtp
	config.action_mailer.perform_deliveries = true
	config.action_mailer.raise_delivery_errors = true
	config.action_mailer.perform_caching = false

	ActionMailer::Base.smtp_settings = {
		:address => "smtp.gmail.com",
		:port => "587",
		:domain => "gmail.com",
		:user_name => "ratalert2017@gmail.com",
		:password => "sinclair2955",
		:authentication => "plain"
	}

	config.log_level = :error

	config.log_tags = [:request_id]

	config.action_mailer.perform_caching = false

	# Enable locale fallbacks for I18n (makes lookups for any locale fall back to
	# the I18n.default_locale when a translation cannot be found).
	config.i18n.fallbacks = true

	# Send deprecation notices to registered listeners.
	config.active_support.deprecation = :notify

	# Use default logging formatter so that PID and timestamp are not suppressed.
	config.log_formatter = ::Logger::Formatter.new

	if ENV["RAILS_LOG_TO_STDOUT"].present?
		logger = ActiveSupport::Logger.new(STDOUT)
		logger.formatter = config.log_formatter
		config.logger = ActiveSupport::TaggedLogging.new(logger)
	end

	# Do not dump schema after migrations.
	config.active_record.dump_schema_after_migration = false

	config.action_mailer.raise_delivery_errors = true # not needed but helpful
	config.action_mailer.default_url_options = { host: '0.0.0.0', port: 3000 }
	config.action_mailer.asset_host = "0.0.0.0:3000"

end
