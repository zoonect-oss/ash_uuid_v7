defmodule AshUUIDv7.Test.PineappleSmoothie do
  @moduledoc false

  use Ash.Resource, domain: AshUUIDv7.Test, data_layer: AshPostgres.DataLayer, extensions: [AshUUIDv7.Extension]

  postgres do
    table "pineapple_smoothies"
    repo AshUUIDv7.Test.Repo
  end

  attributes do
    uuid_v7_primary_key :id

    create_timestamp :inserted_at
  end

  relationships do
    has_many :pineapples, AshUUIDv7.Test.Pineapple
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end
