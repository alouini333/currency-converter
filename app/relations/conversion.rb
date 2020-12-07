class Conversions < ROM::Relation[:sql]
    schema(infer: true)
    auto_struct(true)

    def listing
        select(:id, :curr_from, :curr_to, :value_from, :value_to,:created_at)
    end
    def createdAtDesc
        order { created_at.desc }  
    end
end