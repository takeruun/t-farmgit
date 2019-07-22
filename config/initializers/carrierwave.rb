require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|

  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.application.credentials.aws[:s3_access_key_id],
    aws_secret_access_key: Rails.application.credentials.aws[:s3_secret_access_key],
    region: Rails.application.credentials.aws[:region],
    path_style: true
  }

  if Rails.env.production?
    config.fog_directory = 't-farm-bucket'
  elsif Rails.env.development?
    config.fog_directory = 't-farm-bucket-for-dev'
  end

end
 
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/