if Rails.env.development?

	User.create!(email: 'john@doe.com', password: 'password', password_confirmation: 'password')
	User.create!(email: 'anon@user.com', password: 'password', password_confirmation: 'password')

	AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

	Station.create!(name: 'Carmelo', slug: 'carmelo')
	Station.create!(name: 'Colonia', slug: 'colonia')
	Station.create!(name: 'Conchillas', slug: 'conchillas')
	Station.create!(name: 'Norden', slug: 'norden')
	Station.create!(name: 'Windguru', slug: 'windguru')

end
