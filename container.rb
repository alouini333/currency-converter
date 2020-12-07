require_relative "./app/relations/exchange_rate"
require_relative "./app/relations/conversion"
require "dotenv"
class InfrastructureContainer
    extend Dry::Container::Mixin
    
    Dotenv.load(".env")

    register "db_adapter" do
        opts = {
            username: ENV["POSTGRES_USER"],
            password: ENV["POSTGRES_PASSWORD"],
            encoding: 'UTF8'
        }
        if ENV["sinatra_env"] == "test"
            config = ROM::Configuration.new(:sql, 'postgres://'+ENV["POSTGRES_URL"]+':'+ENV["POSTGRES_PORT"]+'/'+ENV["POSTGRES_DB_TEST"], opts)
        else
            config = ROM::Configuration.new(:sql, 'postgres://'+ENV["POSTGRES_URL"]+':'+ENV["POSTGRES_PORT"]+'/'+ENV["POSTGRES_DB"], opts)
        end
        config.register_relation(ExchangeRates)
        config.register_relation(Conversions)
        container = ROM.container(config)
        container
    end
end
  
Import = Dry::AutoInject(InfrastructureContainer)