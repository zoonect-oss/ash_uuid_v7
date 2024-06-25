defmodule AshUUIDv7.Macros do
  @moduledoc false

  defmacro uuid_v7_primary_key(name, opts \\ []) do
    default =
      quote do
        fn -> AshUUIDv7.generate() end
      end

    field_opts =
      opts
      |> Keyword.put_new(:public?, true)
      |> Keyword.put_new(:writable?, false)
      |> Keyword.put_new(:default, default)
      |> Keyword.put_new(:primary_key?, true)
      |> Keyword.put_new(:allow_nil?, false)

    quote do
      attribute unquote(name), AshUUIDv7, unquote(field_opts)
    end
  end
end
