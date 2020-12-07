class ExchangeRates < ROM::Relation[:sql]
    schema(infer: true)
    auto_struct(true)

    def listing
        select(:id, :usd_value, :chf_value, :created_at)
    end
    def createdAtDesc
        order { created_at.desc }  
    end
end