# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :conversions do
      primary_key :id
      # Currency from
      column :curr_from, String, null: false
      # Currency to
      column :curr_to, String, null: false
      column :value_from, Float, null: false
      column :value_to, Float, null: false
      column :created_at, DateTime, null: false, default: Sequel.lit("(now() at time zone 'utc')")
    end
  end
end
