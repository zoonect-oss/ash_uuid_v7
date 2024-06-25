defmodule AshUUIDv7.ExtensionTest do
  @moduledoc false

  use ExUnit.Case, async: true

  # alias Ash.Changeset

  def checkout(_ctx \\ nil) do
    Ecto.Adapters.SQL.Sandbox.checkout(AshUUIDv7.Test.Repo)
  end

  setup :checkout

  describe "AshUUIDv7.Extension" do
    test "testing pineapples" do
      pineapple_smoothie =
        AshUUIDv7.Test.PineappleSmoothie
        |> Ash.Changeset.for_create(:create, %{})
        |> Ash.create!()

      pineapple =
        AshUUIDv7.Test.Pineapple
        |> Ash.Changeset.for_create(:create, %{pineapple_smoothie_id: pineapple_smoothie.id})
        |> Ash.create!()

      pineapple_smoothie = Ash.load!(pineapple_smoothie, :pineapples)
      pineapple_id = pineapple.id

      assert %AshUUIDv7.Test.Pineapple{} = pineapple
      assert [%AshUUIDv7.Test.Pineapple{id: ^pineapple_id}] = pineapple_smoothie.pineapples
      assert pineapple_smoothie.id == pineapple.pineapple_smoothie_id
    end

    test "testing blibs, blobs and blib_blobs" do
      blib =
        AshUUIDv7.Test.Blib
        |> Ash.Changeset.for_create(:create, %{})
        |> Ash.create!()

      blob =
        AshUUIDv7.Test.Blob
        |> Ash.Changeset.for_create(:create, %{})
        |> Ash.create!()

      blib_blob =
        AshUUIDv7.Test.BlibBlob
        |> Ash.Changeset.for_create(:create, %{blib_id: blib.id, blob_id: blob.id})
        |> Ash.create!()

      assert %AshUUIDv7.Test.Blib{} = blib
      assert %AshUUIDv7.Test.Blob{} = blob
      assert %AshUUIDv7.Test.BlibBlob{} = blib_blob

      {:ok, [blob]} = AshUUIDv7.Test.read(AshUUIDv7.Test.Blob)

      assert %AshUUIDv7.Test.Blob{} = blob

      [blib_blob] = blob.blibs_blobs

      assert %AshUUIDv7.Test.BlibBlob{} = blib_blob

      blib = blib_blob.blib

      assert %AshUUIDv7.Test.Blib{} = blib
    end

    test "testing templates" do
      source_template =
        AshUUIDv7.Test.Template
        |> Ash.Changeset.for_create(:create, %{})
        |> Ash.create!()

      assert %AshUUIDv7.Test.Template{} = source_template

      derived_template =
        AshUUIDv7.Test.Template
        |> Ash.Changeset.for_create(:create, %{from_template_id: source_template.id})
        |> Ash.create!()

      assert %AshUUIDv7.Test.Template{} = derived_template

      template_with_source = Ash.load!(derived_template, :from_template)
      source_template_id = source_template.id

      assert %AshUUIDv7.Test.Template{id: ^source_template_id} = template_with_source.from_template

      assert source_template.id == derived_template.from_template_id

      template_with_derivations = Ash.load!(source_template, :derived_templates)
      derived_template_id = derived_template.id

      assert [%AshUUIDv7.Test.Template{id: ^derived_template_id}] = template_with_derivations.derived_templates
    end

    test "testing volatile things" do
      volatile_thing =
        AshUUIDv7.Test.VolatileThing
        |> Ash.Changeset.for_create(:create, %{})
        |> Ash.create!()

      assert %AshUUIDv7.Test.VolatileThing{} = volatile_thing
    end

    test "testing embedded things" do
      embedded_thing =
        AshUUIDv7.Test.EmbeddedThing
        |> Ash.Changeset.for_create(:create, %{}, domain: AshUUIDv7.Test)
        |> Ash.create!()

      assert %AshUUIDv7.Test.EmbeddedThing{} = embedded_thing
    end

    test "testing wrapper things" do
      wrapper_thing =
        AshUUIDv7.Test.WrapperThing
        |> Ash.Changeset.for_create(:create, %{embed: %{name: "test1"}, embeds: [%{name: "test2"}, %{name: "test3"}]})
        |> Ash.create!()

      assert %AshUUIDv7.Test.WrapperThing{} = wrapper_thing

      assert %AshUUIDv7.Test.EmbeddedThing{} = wrapper_thing.embed

      reloaded_wrapper_thing = Ash.reload!(wrapper_thing)
      wrapper_thing_id = wrapper_thing.id

      assert %AshUUIDv7.Test.WrapperThing{id: ^wrapper_thing_id} = reloaded_wrapper_thing
      assert %AshUUIDv7.Test.EmbeddedThing{name: "test1"} = reloaded_wrapper_thing.embed

      assert [%AshUUIDv7.Test.EmbeddedThing{name: "test2"}, %AshUUIDv7.Test.EmbeddedThing{name: "test3"}] =
               reloaded_wrapper_thing.embeds
    end

    test "testing arguments" do
      raw_uuid = "8b264e66-70f3-44f4-af16-16f5535855bb"

      result =
        AshUUIDv7.Test.EmbeddedThing
        |> Ash.ActionInput.for_action(:argument_test, %{id: raw_uuid}, domain: AshUUIDv7.Test)
        |> Ash.run_action()

      assert {:ok, ^raw_uuid} = result
    end

    test "testing malformed inputs" do
      result =
        AshUUIDv7.Test.EmbeddedThing
        |> Ash.ActionInput.for_action(:argument_test, %{id: "malformed"}, domain: AshUUIDv7.Test)
        |> Ash.run_action()

      assert {:error, %Ash.Error.Invalid{}} = result
    end
  end
end
