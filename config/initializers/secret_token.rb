CS169PenpalGladiators::Application.config.secret_token = if Rails.env.development? or Rails.env.test?
  ('x' * 30)
else
  ENV['SECRET_TOKEN']
end
