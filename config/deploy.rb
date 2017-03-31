set :repo_url, "git@gitlab.wavesapp.uk:waves/wavesapp.git"

append :linked_files,
       "config/database.yml",
       "config/secrets.yml",
       "config/application.yml",
       ".env"

append :linked_dirs,
       "log",
       "tmp/pids",
       "tmp/cache",
       "tmp/sockets",
       "public/system",
       "uploads"

# before "deploy:migrate", "database:backup"
# namespace :database do
#   task :backup do
#     invoke "pg_backup:dump:create"
#   end
# end

after "deploy:publishing", "deploy:restart"
namespace :deploy do
  task :restart do
    invoke "delayed_job:restart"
  end
end
