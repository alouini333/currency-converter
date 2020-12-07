# frozen_string_literal: true

ROM::SQL.migration do
  change do
    # EURO VALUES PER DAY
    create_table :exchange_rates do
      primary_key :id
      column :usd_value, Float, null: false
      column :chf_value, Float, null: false
      column :created_at, DateTime, null: false, default: Sequel.lit("(now() at time zone 'utc')")
    end
  end
end
