require 'spec_helper'

describe SessionsController do
  it ' should return guest token' do
    get  :guest_token
    response.status.should be(200)
    expect(response.body).to include("\"user\":\"Guest\"")
    expect(response.body).to include("\"remember_token\":")
  end
end
