defmodule AshUUIDv7.Test.Application do
  @moduledoc false

  @doc false
  def start(_type, _args) do
    children = [
      AshUUIDv7.Test.Repo
    ]

    opts = [strategy: :one_for_one, name: AshPostgres.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
