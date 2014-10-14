class CustomersController < ApplicationController
  def index
    result = Customer.all.map do |customer|
      {
        :name              => customer.name,
        :keystore_file_url => customer.keystore.url,
        :storepass         => customer.storepass,
        :keypass           => customer.keypass,
        :http_site         => customer.http_site,
        :newest_version    => customer.versions.first.version
      }
    end
    render :json => result
  end
end