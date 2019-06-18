class UserMailer < ApplicationMailer
	default from: 'wind-app@papensen.com'

	def new_entry_email(entry:, subscriber:)
		@entry = entry
		@subscriber = subscriber

		mail_to = @subscriber.email
		mail(bcc: mail_to, subject: 'RatAlert - ' + entry.title)
	end

	def admin_email(error)
		@error = error
		mail(bcc: 'tomas@amalgama.co', subject: 'RatAlert Exception')
	end

end