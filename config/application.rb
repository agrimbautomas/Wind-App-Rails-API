require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WindApp
	class Application < Rails::Application

		config.load_defaults 5.2

		config.web_console.development_only = false

		# Production server runs in another timezone
		config.time_zone = 'America/Argentina/Buenos_Aires'

		config.autoload_paths << "#{Rails.root}/app/interactors"
		config.autoload_paths << "#{Rails.root}/app/errors"
		config.autoload_paths << "#{Rails.root}/app/validators"
	end
end
