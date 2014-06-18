require 'data_mapper'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/Sinatratests_#{env}")

require_relative './link'

DataMapper.finalize

DataMapper.auto_upgrade!