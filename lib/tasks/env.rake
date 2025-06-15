task :env do
  exec "bin/rails credentials:edit"
end
