require 'rom/sql/rake_task'
require 'rom-sql'
require "dotenv"

namespace :db do
    Dotenv.load(".env")
    task :setup do
        opts = {
            username: ENV["POSTGRES_USER"],
            password: ENV["POSTGRES_PASSWORD"],
            encoding: 'UTF8'
        }
        if ENV["SINATRA_ENV"] == "test"
            puts "Heere"
            ROM::Configuration.new(:sql, 'postgres://'+ENV["POSTGRES_URL"]+':'+ENV["POSTGRES_PORT"]+'/'+ENV["POSTGRES_DB_TEST"], opts)
        else
            ROM::Configuration.new(:sql, 'postgres://'+ENV["POSTGRES_URL"]+':'+ENV["POSTGRES_PORT"]+'/'+ENV["POSTGRES_DB"], opts)
        end
    end
end