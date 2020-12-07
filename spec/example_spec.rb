require 'spec_helper'

describe 'Currency converter' do
  it "works!" do
    get '/'
    expect(last_response.status).to eq 200
    expect(last_response.body).to include('<title>Currency converter</title>')
  end

  it "converts successfully" do
    params = {
      "curr_from" => "EUR",
      "curr_to" => "USD",
      "value_from" => 1.0,
      "value_to" => 1.2
    }
    post '/', params

    expect(last_response.status).to eq 302
  end

  it "throws an error when missing parameter" do
    post '/'
    expect(last_response.status).to eq 400
  end

  it "shows list of conversions" do
    get '/conversions'
    expect(last_response.status).to eq 200
  end
end