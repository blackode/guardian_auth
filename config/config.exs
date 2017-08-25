# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :guardian_auth,
  ecto_repos: [GuardianAuth.Repo]

# Configures the endpoint
config :guardian_auth, GuardianAuthWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ptdpIU8+xv9JhBkrdAdnFyNWEd8bxlazKBOU/qqRxUR2eIfxihJhoBn3C9gNuzD0",
  render_errors: [view: GuardianAuthWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GuardianAuth.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

  config :guardian, Guardian,
    allowed_algos: ["HS512"], # optional
    verify_module: Guardian.JWT,  # optional
    issuer: "guardian_auth",
    ttl: { 30, :days },
    allowed_drift: 2000,
    verify_issuer: true, # optional
    secret_key: System.get_env("GUARDIAN_SECRET") || "Yddhc10dCoOTN1/Lk6+nYmfGp1hW48k8G6r6RF6HUoT62KZtfY+FKCqOIL/RamdQ",
    serializer: GuardianAuth.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
