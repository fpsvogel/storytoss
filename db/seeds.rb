env = Rails.env.downcase

Dir[Rails.root.join("db", "seeds_#{env}", "*.rb")].sort.each do |file|
  require file
end
