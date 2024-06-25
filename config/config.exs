import Config

config :spark, :formatter,
  remove_parens?: true,
  "Ash.Resource": [
    section_order: [
      :resource,
      :code_interface,
      :postgres,
      :attributes,
      :relationships,
      :identities,
      :validations,
      :calculations,
      :actions
    ]
  ]

if Mix.env() == :dev do
  config :git_ops,
    mix_project: Mix.Project.get!(),
    changelog_file: "CHANGELOG.md",
    repository_url: "https://github.com/zoonect-oss/ash_uuid_v7",
    manage_mix_version?: true,
    manage_readme_version: ["README.md"],
    version_tag_prefix: "v"
end

if Mix.env() == :test do
  config :ash_uuid_v7, AshUUIDv7.Test.Repo,
    parameters: [plan_cache_mode: "force_custom_plan"],
    pool: Ecto.Adapters.SQL.Sandbox,
    prepare: :named,
    show_sensitive_data_on_connection_error: true,
    stacktrace: true,
    timeout: 1_000,
    url: System.get_env("DATABASE_URL", "postgres://postgres@127.0.0.1:51016/ash_uuid_v7_test"),
    migration_primary_key: [name: :id, type: AshUUIDv7],
    migration_timestamps: [type: :utc_datetime_usec]

  config :ash_uuid_v7,
    ecto_repos: [AshUUIDv7.Test.Repo],
    ash_domains: [AshUUIDv7.Test]

  # Ash: type shorthands
  # config :ash, :custom_types, uuid_v7: AshUUIDv7

  # config :ash, :default_belongs_to_type, AshUUIDv7
end
