begin
  require 'dotenv'
  Dotenv.load
  rescue LoadError
end

require 'sequel'