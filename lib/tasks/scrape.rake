namespace :scrape do
	desc 'Scrape Site'

	#
	# Schedules Tasks
	#

	task :wind_logs => :environment do
		GetCarpNordenLogs.default
		GetCarpColoniaLogs.default
	end


	task :hourly_tasks => :environment do
		GetWindguruBsasLogs.default
		CreateWindAvgs.default
	end

	#
	# NOT Schedules Tasks
	#

	task :stations => :environment do
		GetCarpStations.default
	end

	task :norden_logs => :environment do
		GetCarpNordenLogs.default
	end

	task :colonia_logs => :environment do
		GetCarpColoniaLogs.default
	end

	task :windguru_logs => :environment do
		GetWindguruBsasLogs.default
	end

	task :create_avgs => :environment do
		CreateWindAvgs.default
	end

end
