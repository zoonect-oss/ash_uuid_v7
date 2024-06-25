defmodule AshUUIDv7.Test.Blob do
  @moduledoc false

  use Ash.Resource, domain: AshUUIDv7.Test, data_layer: AshPostgres.DataLayer, extensions: [AshUUIDv7.Extension]

  postgres do
    table "blobs"
    repo AshUUIDv7.Test.Repo
  end

  attributes do
    uuid_v7_primary_key :id
  end

  relationships do
    many_to_many :blibs, AshUUIDv7.Test.Blib do
      through AshUUIDv7.Test.BlibBlob
      join_relationship :blibs_blobs

      source_attribute_on_join_resource :blob_id
      destination_attribute_on_join_resource :blib_id
    end
  end

  preparations do
    prepare build(load: [blibs_blobs: [:blib]])
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end
