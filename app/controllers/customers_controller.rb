class CustomersController < ApplicationController
  def index
    result = Customer.all.map do |customer|
      {
        :name              => customer.name,
        :keystore_file_url => customer.keystore.url,
        :storepass         => customer.storepass,
        :keypass           => customer.keypass,
        :http_site         => customer.http_site,
        :newest_version    => newest_version(customer)
      }
    end
    render :json => result
  end

  private 
  def newest_version(customer)
    return "0.0.0" if customer.versions.count == 0
    customer.versions.first.version
  end
end