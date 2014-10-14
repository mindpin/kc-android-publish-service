module AttachmentUploaderMethods
  # 给上传的文件重新命名
  def filename
    if original_filename.present?
      ext = file.extension.blank? ? '' : ".#{file.extension}"
      "#{secure_token}#{ext}"
    end
  end

  def store_dir
    RUtil.get_static_file_path("uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}")
  end

  def url
    _file_name = model[mounted_as]
    return default_url if _file_name.blank?

    prefix = version_name.blank? ? '' : "#{version_name}_"

    RUtil.get_static_file_url("uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}/#{prefix}#{_file_name}")
  end

  private
    def secure_token
      var = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(var) || model.instance_variable_set(var, randstr)
    end

    def randstr(length=8)
      base = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
      size = base.size
      re = '' << base[rand(size-10)]
      (length - 1).times {
        re << base[rand(size)]
      }
      re
    end
end