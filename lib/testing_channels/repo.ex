defmodule TestingChannels.Repo do
  use Ecto.Repo,
    otp_app: :testing_channels,
    adapter: Ecto.Adapters.Postgres
end
