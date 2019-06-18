class HomeController < ApplicationController

	def sample
	end

	def scrape
		ScrapeSite.by(url: Settings.scrapped_site)
		@results = Entry.where('updated_at <= ?', DateTime.now + 1.minute).limit(10)
	end
end
