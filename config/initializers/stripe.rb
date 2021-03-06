if Rails.env.production?
  Rails.configuration.stripe = {
    :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
    :secret_key => ENV['STRIPE_SECRET_KEY']
  }
else
  Rails.configuration.stripe = {
    :publishable_key => 'pk_test_qfj45ls6ZBZiIC1qiMs7cAUo',
    :secret_key => 'sk_test_LLK91whNLCoYnMpu7Y8KjKNx'
  }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]