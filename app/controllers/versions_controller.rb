class VersionsController < ApplicationController
  def upload
    customer_name = params[:customer_name]
    package = params[:package]
    version = params[:version]
    is_milestone = (params[:is_milestone] == "true" ? true : false)

    if customer_name.blank? || package.blank? || version.blank?
      return render :json => {:result => 'fail'}, :status => 400
    end

    customer = Customer.where(:name => customer_name).first
    if customer.blank?
      return render :json => {:result => 'fail'}, :status => 422
    end

    ver = customer.versions.create(
      :is_milestone => is_milestone,
      :version      => version,
      :package      => package
    )

    if !ver.valid?
      return render :json => {:result => 'fail'}, :status => 422
    end

    render :json => {:result => 'ok'}
  end

  def download
    customer = Customer.where(:name => params[:customer_name]).first
    if params[:version] == "newest"
      version = customer.versions.first
    else
      version = customer.versions.where(:version => params[:version]).first
    end
    
    send_file version.package.path,
      :disposition => 'attachment',
      :filename => "kc_android_#{version.version}.apk"
  end
end