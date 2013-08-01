server "192.168.2.150", :app, :web, :db, :primary => true
set :rails_env, "production"
set :user, 'rubyviet'
set :branch, :master
set :deploy_to, "/home/rubyviet/www/monittest"
# set :port, 3790

default_run_options[:pty] = true
set :default_environment, {
  'PATH' => "/home/rubyviet/.rbenv/shims:/home/rubyviet/.rbenv/bin:$PATH"
}