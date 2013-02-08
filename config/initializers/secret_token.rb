# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Plants::Application.config.secret_token =
  if Rails.env.production?
    ENV['PLANTS_SESSION_TOKEN']
  else
    '04bc45f18ea6360207e5db89b9d8ebf910d3585e42c747c778606bb986617f9054448bcdf65bc0b34af4d3baa79aa39e52f9155808f6333b0a4ea6ec0f4d4a78'
  end
