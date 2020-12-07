# For the documentation check http://sinatrarb.com/intro.html
require_relative '../../container'
require_relative '../repositories/exchange_rate_repo'
require_relative '../repositories/conversion_repo'
require_relative '../services/currency_service'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base
	# This configuration part will inform the app where to search for the views and from where it will serve the static files
	# Add validation for requests
  	configure do
    	set :views, "app/views"
		set :public_dir, "public"
		register Sinatra::Validation
		register Sinatra::Flash
		enable :sessions
	end
	
	get '/' do
		exchange_rate_repo = Repositories::ExhangeRatesRepo.new(InfrastructureContainer["db_adapter"])
		exchange_rates = exchange_rate_repo.last_element()
		
		today = Time.now.strftime("%d/%m/%Y")
		lastupdate = exchange_rates.created_at.strftime("%d/%m/%Y")
		# Make sure to update the exchange rates
		if (today != lastupdate)
			currency_service = CurrencyService.new
			currency_service.update_rates
			exchange_rates = exchange_rate_repo.last_element()
		end
		   
		erb :index, :locals => { :exchange_rates => exchange_rates }
  	end
	
	post '/' do
		validates do
			params do
				required(:curr_from).filled(:string)
				required(:curr_to).filled(:string)
				required(:value_from).filled(:float)
				required(:value_to).filled(:float)
			end
		end
		conversion_repo = Repositories::ConversionRepo.new(InfrastructureContainer["db_adapter"])
		conversion_repo.create(
			curr_from: params[:curr_from],
			curr_to: params[:curr_to],
			value_from: params[:value_from],
			value_to: params[:value_to]
		)
		flash[:message] = params[:value_from] + ' ' + params[:curr_from] + ' = ' + params[:value_to] + ' ' + params[:curr_to]
		redirect '/'
	end

	get '/conversions' do
		conversion_repo = Repositories::ConversionRepo.new(InfrastructureContainer["db_adapter"])
		list = conversion_repo.list
		erb :list, :locals => { :list => list }
	end
end