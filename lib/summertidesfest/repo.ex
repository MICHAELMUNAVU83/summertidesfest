defmodule Summertidesfest.Repo do
  use Ecto.Repo,
    otp_app: :summertidesfest,
    adapter: Ecto.Adapters.Postgres
end
