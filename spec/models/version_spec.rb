require "rails_helper"

RSpec.describe Version, :type => :model do
  it "不能创建比已有版本低的版本" do
    customer = Customer.create!(
      :name      => "111",
      :keystore  => "app.keystore",
      :storepass => "12345678",
      :keypass   => "12345678",
      :http_site => "http://xxx.com/y"
      )

    customer.versions.create!(
      :version      => "0.0.2",
      :is_milestone => true,
      :package      => "app.apk"
      )

    v = customer.versions.create(
      :version      => "0.0.1",
      :is_milestone => true,
      :package      => "app.apk"
      )

    expect(v.valid?).to eq(false)
  end
end