defmodule GlitchText.Repo do
  use Ecto.Repo,
    otp_app: :glitchText,
    adapter: Ecto.Adapters.Postgres
end
