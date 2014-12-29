Scpwebapp::Application.configure do
  
  config.cache_classes = true
  
  config.eager_load = true
  
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  
  config.serve_static_assets = false
  
  config.assets.js_compressor = :uglifier
  
  config.assets.compile = false

  config.assets.digest = true

  
  config.assets.version = '1.0'
  
  config.log_level = :info
  
  config.active_support.deprecation = :notify
  
  config.log_formatter = ::Logger::Formatter.new
  
  config.action_mailer.default_url_options = { host: "scpweb.herokuapp.com" }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "smtp.mandrillapp.com",
    port: 587,
    domain: "scpweb.herokuapp.com",
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: "briandiaz@outlook.com",
    password: "2Iw8DNBtBOgZPydn_9sfhg"
  }
end
