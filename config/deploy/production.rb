server ENV["WAVES_PRODUCTION_IP"], user: ENV["WAVES_PRODUCTION_USER"], 
                                   roles: %w(app db web)
set :stage, :production
set :application, ENV["WAVES_PRODUCTION_USER"]
set :deploy_to, "/var/www/#{ENV['WAVES_PRODUCTION_USER']}"
set :environment, "production"
set :migration_role, :app
set :keep_assets, 2
