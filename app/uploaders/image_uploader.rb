# frozen_string_literal: true

# class handling image upload
class ImageUploader < Shrine
  Attacher.validate do
    validate_mime_type %w[image/jpeg image/png image/jpg image/svg]
    validate_max_size 1 * 1024 * 1024
  end
end
