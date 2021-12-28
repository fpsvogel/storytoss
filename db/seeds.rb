Dir[Rails.root.join("db", "seeds_#{Rails.env.downcase}", "*.rb")].sort.each do |file|
  require file
end
