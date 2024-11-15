# spec/support/devise.rb

RSpec.configure do |config|
    config.include Devise::Test::IntegrationHelpers, type: :request
    config.include Warden::Test::Helpers, type: :request
    
    # Reset Warden after each test
    config.after(:each) do
      Warden.test_reset! # This will clear the Warden session after each test
    end
  end
  