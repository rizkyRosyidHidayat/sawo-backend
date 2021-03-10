defmodule Sawo.Repo do
  use Ecto.Repo,
    otp_app: :sawo,
    adapter: Ecto.Adapters.Postgres
end
