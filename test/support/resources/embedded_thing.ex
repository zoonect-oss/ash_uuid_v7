defmodule AshUUIDv7.Test.EmbeddedThing do
  @moduledoc false

  use Ash.Resource, data_layer: :embedded, extensions: [AshUUIDv7.Extension]

  attributes do
    uuid_v7_primary_key :id

    attribute :name, :string, public?: true
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*

    action :argument_test, AshUUIDv7 do
      argument :id, AshUUIDv7, allow_nil?: false

      run fn input, _context ->
        {:ok, input.arguments.id}
      end
    end
  end
end
