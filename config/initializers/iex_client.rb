# IEX::Api.configure do |config|
#     config.publishable_token = Rails.application.credentials.IEX[:IEX_API_PUBLISHABLE_TOKEN] # defaults to ENV['IEX_API_PUBLISHABLE_TOKEN']
#     config.secret_token = Rails.application.credentials.IEX[:IEX_API_PUBLISHABLE_TOKEN] # defaults to ENV['IEX_API_SECRET_TOKEN']
#     config.endpoint = Rails.application.credentials.IEX[:IEX_API_PUBLISHABLE_TOKEN] # use 'https://sandbox.iexapis.com/v1' for Sandbox
# end

IEX::Api.configure do |config|
    config.publishable_token = ENV['IEX_API_PUBLISHABLE_TOKEN'] # defaults to ENV['IEX_API_PUBLISHABLE_TOKEN']
    config.secret_token = ENV['IEX_API_SECRET_TOKEN'] # defaults to ENV['IEX_API_SECRET_TOKEN']
    config.endpoint = ENV['ENDPOINT'] # use 'https://sandbox.iexapis.com/v1' for Sandbox
end