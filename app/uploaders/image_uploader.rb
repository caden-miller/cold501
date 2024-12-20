# frozen_string_literal: true

# ImageUploader
class ImageUploader < Shrine
  Attacher.validate do
    validate_mime_type %w[image/jpeg image/png image/webp]
  end
end
