server ENV["WAVES_STAGING_IP"], user: ENV["WAVES_STAGING_USER"],
                                roles: %w(app db web)
set :stage, :production
set :application, ENV["WAVES_STAGING_USER"]
set :deploy_to, "/var/www/#{ENV['WAVES_STAGING_USER']}"
set :environment, "production"
set :migration_role, :app
set :keep_assets, 2
