require 'data_mapper'
require 'bcrypt'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/Sinatratests_#{env}")

require_relative './links'
require_relative './tags'
require_relative './user'

DataMapper.finalize

DataMapper.auto_upgrade!