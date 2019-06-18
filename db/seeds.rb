if Rails.env.development?

#	User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')


end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?