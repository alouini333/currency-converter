require_relative "../repositories/exchange_rate_repo"
require_relative '../../container'
require 'money/bank/currencylayer_bank'
require "dotenv"

class CurrencyService
    def initialize
        @exchange_rate_repo = Repositories::ExhangeRatesRepo.new(InfrastructureContainer["db_adapter"])
        currency_layer_key = ENV["CURRENCY_LAYER_KEY"]
        @mclb = Money::Bank::CurrencylayerBank.new
        @mclb.access_key = currency_layer_key
    end


    def update_rates
        lastrecord = @exchange_rate_repo.last_element
        if lastrecord == nil
            update_rates_db()
        else
            today = Time.now.strftime("%d/%m/%Y")
            lastupdate = lastrecord.created_at.strftime("%d/%m/%Y")
            # Make sure to update the exchange rates
            if (today != lastupdate)
                update_rates_db() 
            end
        end
    end

    def update_rates_db
        # GET EXCHANGE RATES
        usd_chf = @mclb.get_rate('USD', 'CHF').to_f.round(3)
        usd_eur = @mclb.get_rate('USD', 'EUR').to_f.round(3)
        # # ADD EXCHANGE RATES to Db
        eur_usd = 1/usd_eur
        chf_usd = 1/usd_chf

        @exchange_rate_repo.create(usd_value: eur_usd, chf_value: chf_usd)
    end
end