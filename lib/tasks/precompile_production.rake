task :ap do
  sh "RAILS_ENV=production bundle exec rake assets:precompile"
end
