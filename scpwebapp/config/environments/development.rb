Scpwebapp::Application.configure do
  
  config.cache_classes = false

  
  config.eager_load = false
  
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  
  config.action_mailer.raise_delivery_errors = false
  
  config.active_support.deprecation = :log
  
  config.active_record.migration_error = :page_load
  
  config.assets.debug = true
  
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
