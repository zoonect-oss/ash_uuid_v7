defmodule AshUUIDv7.Test.VolatileThing do
  @moduledoc false

  use Ash.Resource, domain: AshUUIDv7.Test, extensions: [AshUUIDv7.Extension]

  attributes do
    uuid_v7_primary_key :id
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end
