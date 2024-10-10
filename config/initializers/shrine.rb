require "shrine"
require "shrine/storage/s3"

s3_options = {
  access_key_id:     Rails.application.credentials.dig(:aws, :access_key_id),
  secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key),
  region:            Rails.application.credentials.dig(:aws, :region),
  bucket:            Rails.application.credentials.dig(:aws, :bucket),
}

Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options), # temporary
  store: Shrine::Storage::S3.new(prefix: "store", **s3_options), # permanent
}

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for retaining the cached file across form redisplays
Shrine.plugin :restore_cached_data    # for re-extracting metadata when attaching a cached file
Shrine.plugin :validation_helpers
Shrine.plugin :validation
