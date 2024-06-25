defmodule AshUUIDv7.Test.Template do
  @moduledoc false

  use Ash.Resource, domain: AshUUIDv7.Test, data_layer: AshPostgres.DataLayer, extensions: [AshUUIDv7.Extension]

  postgres do
    table "templates"
    repo AshUUIDv7.Test.Repo
  end

  attributes do
    uuid_v7_primary_key :id
  end

  relationships do
    belongs_to :from_template, AshUUIDv7.Test.Template, allow_nil?: true, attribute_public?: true

    has_many :derived_templates, AshUUIDv7.Test.Template, destination_attribute: :from_template_id
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end
