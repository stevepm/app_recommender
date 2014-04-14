begin
  require 'dotenv'
  Dotenv.load
  rescue LoadError
end

require 'sequel'
require_relative 'lib/app_repository'
require_relative 'app'