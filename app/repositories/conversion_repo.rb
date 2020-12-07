require_relative "../../container"

module Repositories
    class ConversionRepo < ROM::Repository[:conversions]
        commands :create

        def list
            conversions.createdAtDesc.to_a
        end
    end
end