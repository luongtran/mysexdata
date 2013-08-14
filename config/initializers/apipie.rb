Apipie.configure do |config|
  config.app_name                = "Mysexdata"
  config.api_base_url            = "https://mysexdata.herokuapp.com"
  config.doc_base_url            = "/doc"
  config.validate = false
  # were is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/*.rb"
end
