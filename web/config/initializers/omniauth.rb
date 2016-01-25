OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '791835764207019', '8505858d9b59b8d262356276db20bea2', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end