require_relative "../../container"

module Repositories
    class ExhangeRatesRepo < ROM::Repository[:exchange_rates]
        commands :create

        def list
            exchange_rates.to_a
        end

        def laststats
            exchange_rates.createdAtDesc.limit(5)
        end

        def last_element
            exchange_rates.createdAtDesc.first()
        end 

        def by_id(id)
            exchange_rates.by_pk(id).one
        end
    end
end