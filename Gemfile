source 'https://rubygems.org'
ruby '2.3.1'

gem 'rails',                   '5.0.0'
gem 'puma',                    '3.4.0'
gem 'sass-rails',              '5.0.5'
gem 'uglifier',                '3.0.0'
gem 'coffee-rails',            '4.2.1'
gem 'jquery-rails',            '4.1.1'
gem 'turbolinks',              '5.0.0'
gem 'jbuilder',                '2.4.1'

gem 'bcrypt',                  '3.1.11'
gem 'faker',                   '1.6.3'
gem 'carrierwave',             '0.11.2'
gem 'mini_magick',             '4.5.1'
gem 'carrierwave-aws',         '1.0.1'
gem 'will_paginate',           '3.1.0'
gem 'bootstrap-will_paginate', '0.0.10'
gem 'bootstrap-sass',          '3.3.6'
gem 'sdoc',                    '0.4.0', group: :doc
gem 'rb-readline'

group :development do
  gem 'sqlite3',               '1.3.11'
  gem 'web-console',           '3.1.1'
  gem 'listen',                '3.0.7'
  gem 'spring',                '1.7.1'
  gem 'spring-watcher-listen', '2.0.0'
  gem 'capistrano',            '3.6.1'
  gem 'capistrano-rails'
  gem 'net-ssh',               '>=4.0.0.beta3'
  gem 'bcrypt_pbkdf'
  gem 'rbnacl-libsodium'
end

group :development, :test do
  gem 'byebug',       '9.0.0', platform: :mri
  gem 'web-console',  '3.1.1'
  gem 'spring',       '1.7.1'
  gem 'dotenv-rails', '2.1.1'
end

group :test, :production do
  gem 'mysql2', '0.3.21'
end

group :test do
  gem 'rails-controller-testing', '0.1.1'
  gem 'minitest-reporters',       '1.1.9'
  gem 'mini_backtrace',           '0.1.3'
  gem 'guard',                    '2.13.0'
  gem 'guard-minitest',           '2.3.1'
  gem 'json_expressions',         '0.8.3'
end

group :production do
  gem 'rails_12factor', '0.0.2'
  gem 'unicorn',        '5.1.0'
end
