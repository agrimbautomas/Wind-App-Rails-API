class ScraperController < ApplicationController

	def scrape
		ScrapeSite.by(url: Settings.scraped_url)
		@results = Entry.where('updated_at <= ?', DateTime.now + 1.minute).limit(10)
	end

end
