require 'rails_helper'

describe "Customer API" do
    it "sends subscrption info for a customer" do

        create(:customer)
        test_customer = Customer.first

        headers = {"CONTENT_TYPE" => "application/json"}
        body =  { 
            "data":{
                "type": "customer",
                "attributes":{
                    "id": test_customer.id
                    }
                }
            }

        post '/api/v0/customer', headers: headers, params: JSON.generate(body)

        expect(response).to be_successful

        customer = JSON.parse(response.body, symbolize_names: true)

        expect(customer).to have_key(:data)
        expect(customer[:data]).to have_key(:type)
        expect(customer[:data][:type]).to eq("customer")
        expect(customer[:data]).to have_key(:id)
        expect(customer[:data][:id]).to eq(test_customer.id.to_s)
        
        expect(customer[:data]).to have_key(:attributes)
        expect(customer[:data][:attributes]).to have_key(:first_name)
        expect(customer[:data][:attributes][:first_name]).to eq(test_customer.first_name)
        expect(customer[:data][:attributes]).to have_key(:last_name)
        expect(customer[:data][:attributes][:last_name]).to eq(test_customer.last_name)
        expect(customer[:data][:attributes]).to have_key(:email)
        expect(customer[:data][:attributes][:email]).to eq(test_customer.email)
        expect(customer[:data][:attributes]).to have_key(:address)
        expect(customer[:data][:attributes][:address]).to eq(test_customer.address)

    end
end