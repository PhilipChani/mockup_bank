defmodule MockupBank.Repo do
  use Ecto.Repo,
    otp_app: :mockup_bank,
    adapter: Ecto.Adapters.Postgres
end
