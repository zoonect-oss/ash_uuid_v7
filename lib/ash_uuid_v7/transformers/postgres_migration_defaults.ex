defmodule AshUUIDv7.Transformers.PostgresMigrationDefaults do
  @moduledoc "Set default values"

  use Spark.Dsl.Transformer

  alias AshPostgres.DataLayer.Info
  alias Spark.Dsl.Transformer

  def transform(dsl_state) do
    dsl_state
    |> Transformer.get_persisted(:data_layer)
    |> transform_by_data_layer(dsl_state)
    |> then(fn dsl_state -> {:ok, dsl_state} end)
  end

  defp transform_by_data_layer(AshPostgres.DataLayer, dsl_state) do
    repo = Info.repo(dsl_state, :mutate)

    if Enum.member?(repo.installed_extensions(), AshUUIDv7.PostgresExtension) do
      attributes = Transformer.get_entities(dsl_state, [:attributes])

      migration_defaults =
        attributes
        |> Enum.filter(fn
          %{type: AshUUIDv7, default: default} when not is_nil(default) -> true
          _ -> false
        end)
        |> Enum.map(fn
          %{name: name, type: AshUUIDv7} -> {name, "fragment(\"uuid_generate_v7()\")"}
        end)
        |> Keyword.merge(Transformer.get_option(dsl_state, [:postgres], :migration_defaults))

      dsl_state
      |> Transformer.set_option([:postgres], :migration_defaults, migration_defaults)
    else
      dsl_state
    end
  end

  defp transform_by_data_layer(_, dsl_state), do: dsl_state
end
