defmodule AshUUIDv7.Test do
  @moduledoc false

  use Ash.Domain

  resources do
    resource AshUUIDv7.Test.Blib
    resource AshUUIDv7.Test.BlibBlob
    resource AshUUIDv7.Test.Blob
    resource AshUUIDv7.Test.Pineapple
    resource AshUUIDv7.Test.PineappleSmoothie
    resource AshUUIDv7.Test.Template
    resource AshUUIDv7.Test.VolatileThing
    resource AshUUIDv7.Test.WrapperThing
  end
end
