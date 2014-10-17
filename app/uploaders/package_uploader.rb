class PackageUploader < CarrierWave::Uploader::Base
  include AttachmentUploaderMethods

  # 存储方式 本地硬盘存储
  #storage :file

  def extension_white_list
    %w(apk)
  end

  def filename
    if original_filename.present?
      ext = file.extension.blank? ? '' : ".#{file.extension}"
      "#{model.customer.name}_kc_android_#{model.version}#{ext}"
    end
  end

end
