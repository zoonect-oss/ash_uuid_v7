defmodule AshUUIDv7.Test.Pineapple do
  @moduledoc false

  use Ash.Resource, domain: AshUUIDv7.Test, data_layer: AshPostgres.DataLayer, extensions: [AshUUIDv7.Extension]

  postgres do
    table "pineapples"
    repo AshUUIDv7.Test.Repo
  end

  attributes do
    uuid_v7_primary_key :id
    attribute :secondary_id, AshUUIDv7

    create_timestamp :inserted_at
  end

  relationships do
    belongs_to :pineapple_smoothie, AshUUIDv7.Test.PineappleSmoothie, attribute_public?: true
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end
