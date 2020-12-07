# On boot, the app make sure that the exchange rates are uptodate, if not the case it updates them

require_relative '../app/services/currency_service'

currency_service = CurrencyService.new
currency_service.update_rates