AWS.config(
  region: 'us-east-1',
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  access_key_id: ENV['AWS_ACCESS_KEY_ID']
)
