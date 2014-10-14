require "rails_helper"

RSpec.describe Customer, :type => :model do
  it "xxx" do
    customer1 = Customer.create!(
      :name      => "111",
      :keystore  => "app.keystore",
      :storepass => "12345678",
      :keypass   => "12345678",
      :http_site => "http://xxx.com/y"
      )

      customer2 = Customer.create!(
      :name      => "1112",
      :keystore  => "app.keystore",
      :storepass => "12345678",
      :keypass   => "12345678",
      :http_site => "http://xxx.com/y"
      )
      expect(Customer.count).to eq(2)
  end
end