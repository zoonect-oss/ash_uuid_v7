defmodule AshUUIDv7.Extension do
  @moduledoc false

  use Spark.Dsl.Extension, imports: [AshUUIDv7.Macros], transformers: [AshUUIDv7.Transformers.PostgresMigrationDefaults]
end
