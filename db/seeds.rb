if Rails.env.development?

	User.create!(email: 'john@doe.com', password: 'password', password_confirmation: 'password')
	User.create!(email: 'anon@user.com', password: 'password', password_confirmation: 'password')

	AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

	Station.create!(name: 'Carmelo')
	Station.create!(name: 'Colonia')
	Station.create!(name: 'Conchillas')
	Station.create!(name: 'Norden')

end
