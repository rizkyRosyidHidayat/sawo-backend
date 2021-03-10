# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sawo,
  ecto_repos: [Sawo.Repo]

# Configures the endpoint
config :sawo, SawoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+Dkp8yHk6jR9IF9qMtO4bPdER84W//0T5iObzAps4E6KeE2yKNvdtQY8WM4spM0Z",
  render_errors: [view: SawoWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Sawo.PubSub,
  live_view: [signing_salt: "diryD92U"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
