OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Settings.facebook.app_id, Settings.facebook.app_secret
end