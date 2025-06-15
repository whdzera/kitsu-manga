task :env do
  sh 'VISUAL="code --wait" bin/rails credentials:edit'
end
