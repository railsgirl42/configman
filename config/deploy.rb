require "bundler/capistrano"
set :application, "configman"
set :repository,  "git://github.com/railsgirl42/configman.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "192.168.1.111"                          # Your HTTP server, Apache/etc
role :app, "192.168.1.111"                          # This may be the same as your `Web` server
role :db,  "192.168.1.111", :primary => true # This is where Rails migrations will run
set :deploy_to, "/home/www/configman"

ssh_options[:forward_agent] = true
set :deploy_via, :remote_cache
set :branch, "master"
set :use_sudo, false
set :user, "deploy"

set :rvm_ruby_string, 'ruby-1.9.3-p194@configman'
set :rvm_type, :system
require "rvm/capistrano"

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

#If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end
 after "deploy", "rvm:trust_rvmrc"
 before "deploy:setup", "rvm:create_gemset"

namespace :deploy do
  desc "Symlinks the configuration files"
  task :symlink_config, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
  end
 before 'deploy:assets:precompile', 'deploy:symlink_config'
end

