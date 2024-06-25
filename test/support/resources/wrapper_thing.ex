defmodule AshUUIDv7.Test.WrapperThing do
  @moduledoc false

  use Ash.Resource, domain: AshUUIDv7.Test, data_layer: AshPostgres.DataLayer, extensions: [AshUUIDv7.Extension]

  postgres do
    table "wrapper_things"
    repo AshUUIDv7.Test.Repo
  end

  attributes do
    uuid_v7_primary_key :id

    attribute :embed, AshUUIDv7.Test.EmbeddedThing, public?: true

    attribute :embeds, {:array, AshUUIDv7.Test.EmbeddedThing}, public?: true
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end
