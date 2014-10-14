class Version
  include Mongoid::Document
  include Mongoid::Timestamps

  field :version,          :type => String
  field :is_milestone,     :type => Boolean
  field :package,          :type => String

  belongs_to :customer

  validates :version,
            :uniqueness => {:scope => :customer_id}

  validates :version,
            :is_milestone,
            :package,
            :presence => true

  validates :version, format: { with: /\A[0-9]+[\.][0-9]+[\.][0-9]+\z/ }

  validate :new_version_must_high, :on => :create
  def new_version_must_high
    versions = self.customer.versions-[self]
    return true if versions.count == 0
    newest_version = versions[0].version
    if newest_version > self.version
      errors.add(:version, "version must > #{newest_version}")
    end
  end

  mount_uploader :package, PackageUploader
end