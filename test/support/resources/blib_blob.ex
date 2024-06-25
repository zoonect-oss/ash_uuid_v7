defmodule AshUUIDv7.Test.BlibBlob do
  @moduledoc false

  use Ash.Resource, domain: AshUUIDv7.Test, data_layer: AshPostgres.DataLayer, extensions: [AshUUIDv7.Extension]

  postgres do
    table "blibs_blobs"
    repo AshUUIDv7.Test.Repo
  end

  attributes do
  end

  relationships do
    belongs_to :blib, AshUUIDv7.Test.Blib, primary_key?: true, allow_nil?: false, attribute_public?: true
    belongs_to :blob, AshUUIDv7.Test.Blob, primary_key?: true, allow_nil?: false, attribute_public?: true
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end
