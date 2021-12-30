# TODO: require login when logged out user tries to like or continue

env = "production" # Rails.env.downcase
Dir[Rails.root.join("db", "seeds_#{env}", "*.rb")].sort.each do |file|
  require file
end
