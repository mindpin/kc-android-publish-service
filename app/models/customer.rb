class Customer
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,      :type => String
  field :keystore,  :type => String
  field :storepass, :type => String
  field :keypass,   :type => String
  field :http_site, :type => String

  validates :name, :uniqueness => true
  validates :name,
            :keystore,
            :storepass,
            :keypass,
            :http_site,
            :presence => true

  has_many :versions, :order => :version.desc

  mount_uploader :keystore, KeystoreUploader
end