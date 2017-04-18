set :repo_url, ENV["CI_REPOSITORY_URL"]

append :linked_files, ".env", "config/database.yml"

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
