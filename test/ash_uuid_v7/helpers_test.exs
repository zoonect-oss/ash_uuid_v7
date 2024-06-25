defmodule AshUUIDv7.HelpersTest do
  @moduledoc false

  use ExUnit.Case, async: true

  describe "AshUUIDv7.UUID" do
    test "generate/1 is working" do
      uuid = AshUUIDv7.Helpers.generate()

      assert <<_::64, ?-, _::32, ?-, "7", _::24, ?-, _::32, ?-, _::96>> = uuid
    end

    test "generate/1 is ordered" do
      uuids =
        for _ <- 1..10_000 do
          AshUUIDv7.Helpers.generate()
        end

      assert uuids == Enum.sort(uuids)
    end

    test "bingenerate/1 is ordered" do
      uuids =
        for _ <- 1..10_000 do
          AshUUIDv7.Helpers.bingenerate()
        end

      assert uuids == Enum.sort(uuids)
    end

    test "encode/1 is working" do
      hex_uuid = AshUUIDv7.Helpers.generate()
      raw_uuid = AshUUIDv7.Helpers.bingenerate()

      encoded_hex_uuid = AshUUIDv7.Helpers.encode(hex_uuid)
      encoded_raw_uuid = AshUUIDv7.Helpers.encode(raw_uuid)

      assert is_binary(encoded_hex_uuid)
      assert AshUUIDv7.Helpers.decode(hex_uuid) == AshUUIDv7.Helpers.decode(encoded_hex_uuid)

      assert is_binary(encoded_raw_uuid)
      assert raw_uuid == AshUUIDv7.Helpers.decode(encoded_raw_uuid)

      assert :error = AshUUIDv7.Helpers.encode("error")
    end

    test "decode/1 is working" do
      hex_uuid = AshUUIDv7.Helpers.generate()
      raw_uuid = AshUUIDv7.Helpers.bingenerate()

      decoded_hex_uuid = AshUUIDv7.Helpers.decode(hex_uuid)
      decoded_raw_uuid = AshUUIDv7.Helpers.decode(raw_uuid)

      assert is_binary(decoded_hex_uuid)
      assert hex_uuid == AshUUIDv7.Helpers.encode(decoded_hex_uuid)

      assert is_binary(decoded_raw_uuid)
      assert AshUUIDv7.Helpers.encode(raw_uuid) == AshUUIDv7.Helpers.encode(decoded_raw_uuid)

      assert :error == AshUUIDv7.Helpers.decode("error")
    end
  end
end
