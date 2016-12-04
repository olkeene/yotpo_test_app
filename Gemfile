ruby '2.3.1'
source 'https://rubygems.org'

gem 'rake'
gem 'padrino', '0.13.3.3'
gem 'interactor', '~> 3'

gem 'foreman', require: false

group :development, :test do
#   # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
#   # gem 'rspec'
#   # gem 'dotenv-rails'
  gem 'rspec'
end

group :test do
  gem 'fuubar' # specs progress
  gem 'rack-test', require: 'rack/test'
end
