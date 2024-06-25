defmodule AshUUIDv7Test do
  @moduledoc false

  use ExUnit.Case, async: true

  doctest AshUUIDv7

  test "it define the type correctly" do
    assert :uuid = Ash.Type.storage_type(AshUUIDv7)
    assert true == Ash.Type.ash_type?(AshUUIDv7)
    assert false == Ash.Type.builtin?(AshUUIDv7)
    assert AshUUIDv7.EctoType = Ash.Type.ecto_type(AshUUIDv7)
  end

  test "it works" do
    hex_uuid = "0188aadc-f449-7818-8862-5eff12733f64"
    raw_uuid = AshUUIDv7.Helpers.decode(hex_uuid)

    assert {:ok, ^hex_uuid} = Ash.Type.cast_input(AshUUIDv7, hex_uuid)
    assert {:ok, ^hex_uuid} = Ash.Type.cast_input(AshUUIDv7, raw_uuid)

    assert {:ok, ^hex_uuid} = Ash.Type.cast_stored(AshUUIDv7, hex_uuid)
    assert {:ok, ^hex_uuid} = Ash.Type.cast_stored(AshUUIDv7, raw_uuid)

    assert {:ok, ^raw_uuid} = Ash.Type.dump_to_native(AshUUIDv7, hex_uuid)
    assert {:ok, ^raw_uuid} = Ash.Type.dump_to_native(AshUUIDv7, raw_uuid)

    assert true == Ash.Type.equal?(AshUUIDv7, raw_uuid, hex_uuid)

    assert {:ok, ^raw_uuid} = Ash.Type.apply_constraints(AshUUIDv7, raw_uuid, [])
  end

  test "it casts binary UUIDs version 7 to string" do
    uuid_v7 = "01903fa1-2523-7580-a9d6-84620dcbf2ba"

    assert %StreamData{} = AshUUIDv7.generator([])

    assert {:ok, binary_uuid_v7} = Ash.Type.dump_to_native(AshUUIDv7, uuid_v7)
    assert {:ok, ^uuid_v7} = Ash.Type.cast_input(AshUUIDv7, binary_uuid_v7)
  end
end
