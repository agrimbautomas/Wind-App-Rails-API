namespace :wind-app do
	desc 'Scrape Site'
	task :entries => :environment do
		5.times do
			ScrapeSite.by(url: Settings.scrapped_site)
			sleep(10.seconds)
		end
	end
end
