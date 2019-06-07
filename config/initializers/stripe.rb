Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
  secret_key:      ENV['STRIPE_SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

StripeEvent.signing_secret = Rails.application.secrets.stripe_signing_secret

StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded', StripeEventHelper::ChargeSucceeded.new
  events.subscribe 'charge.failed', StripeEventHelper::ChargeFailed.new
end
