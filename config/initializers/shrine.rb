require "shrine"
require "shrine/storage/s3"

s3_options = {
  access_key_id:     ENV.fetch("AWS_ACCESS_KEY_ID"),
  secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"),
  region:            ENV.fetch("AWS_REGION"),
  bucket:            ENV.fetch("AWS_BUCKET"),
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
