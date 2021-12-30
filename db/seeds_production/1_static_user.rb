progressbar = ProgressBar.create(
  title: "Creating Static Users",
  total: BOT_NAMES.count
)

def create_bot(name)
  User.create username: "#{name}-bot",
              email: "#{name}#{User::BOT_EMAIL}",
              password: "012345",
              password_confirmation: "012345",
              bot: true
end


BOT_NAMES.each do |name|
  create_bot(name)
  progressbar.increment
end
