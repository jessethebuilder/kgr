Rails.application.config.generators do |g|
  g.test_framework :rspec, :view_specs => false, :requests => false, :routing => false
end