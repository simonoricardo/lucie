defmodule Lucie.Repo do
  use Ecto.Repo,
    otp_app: :lucie,
    adapter: Ecto.Adapters.Postgres
end
