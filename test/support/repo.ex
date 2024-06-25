defmodule AshUUIDv7.Test.Repo do
  @moduledoc false

  use AshPostgres.Repo, otp_app: :ash_uuid_v7

  @doc false
  @impl AshPostgres.Repo
  def installed_extensions do
    ["ash-functions", "uuid-ossp", "citext", AshUUIDv7.PostgresExtension]
  end
end
