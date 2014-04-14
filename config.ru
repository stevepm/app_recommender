require_relative 'boot'

DB = Sequel.connect(ENV['DATABASE_URL'])
AppRepository.attach_db(DB)
run App