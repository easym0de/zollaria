Amazon::Ecs.configure do |options|
  options[:associate_tag] = Settings.amazon.associate_tag
  options[:AWS_access_key_id] = Settings.amazon.access_key_id
  options[:AWS_secret_key] = Settings.amazon.secret_access_key
end