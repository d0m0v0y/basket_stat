Apipie.configure do |config|
  config.app_name                = "BasketStat Api"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apidoc"
  config.default_version         = '1.0'
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/**/*.rb"
end
