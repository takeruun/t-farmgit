CarrierWave.configure do |config|

  storage :fog
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.application.credentials.aws[:s3_access_key_id],
    aws_secret_access_key: Rails.application.credentials.aws[:s3_secret_access_key],
    region: Rails.application.credentials.aws[:aws_region],
    path_style: true
  }

  config.fog_directory = 't-farm-backet' if Rails.env.production?
  config.fog_directory = 't-farm-for-dev' if Rails.env.development?

end
 
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/