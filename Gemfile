source 'http://rubygems.org'

gem 'rails', '3.2.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

#gem 'sqlite3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.2.3"
  gem 'coffee-rails', "~> 3.2.1"
  gem 'uglifier', '>=1.0.3'
  gem 'anjlab-bootstrap-rails', '>= 2.1', :require => 'bootstrap-rails'
end

gem 'jquery-rails'
gem "settingslogic", "2.0.6"
gem 'omniauth-facebook'
gem 'koala'
gem 'amazon-ecs'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development, :test do
  # Pretty printed test output
  gem 'debugger'
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'turn', '0.8.2', :require => false
end
group :production do
  gem "pg" 
end