class PackageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include AttachmentUploaderMethods

  # 存储方式 本地硬盘存储
  storage :file

  def extension_white_list
    %w(apk)
  end

end
