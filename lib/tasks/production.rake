task :p do
  exec "RAILS_ENV=production rails s -b 0.0.0.0 -p 3080"
end
