progressbar = ProgressBar.create(
  title: 'Creating Users',
  total: USERS_TO_CREATE
)

USERS_TO_CREATE.times do
  first_name = Faker::Name.unique.first_name
  last_name = Faker::Name.unique.last_name
  username = "#{first_name}-#{last_name}".downcase
  User.create username: username,
              email: Faker::Internet.unique.email,
              password: '012345',
              password_confirmation: '012345'
  progressbar.increment
end