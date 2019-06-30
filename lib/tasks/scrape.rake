namespace :scrape do
	desc 'Scrape Site'

	task :stations => :environment do
		GetCarpStations.default
	end

	task :wind_logs => :environment do
		GetCarpNordenLogs.default
		GetCarpColoniaLogs.default
	end

	task :norden_logs => :environment do
		GetCarpNordenLogs.default
	end

	task :colonia_logs => :environment do
		GetCarpColoniaLogs.default
	end

	task :windguru_logs => :environment do
		GetWindguruData.default
	end

end
