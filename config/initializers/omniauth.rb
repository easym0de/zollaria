OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Settings.facebook.app_id, Settings.facebook.app_secret,
  :iframe => true
end

OmniAuth.config.full_host = Settings.app.full_host