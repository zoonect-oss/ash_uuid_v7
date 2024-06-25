# zoonect-oss/ash-uuid-v7

## Development

Db postgres port: `51016`

Setup commands:

    cd ash-uuid-v7
    brew bundle
    mise install
    mix local.rebar --if-missing --force && mix local.hex --if-missing --force
    mix deps.get
    mix ash_postgres.drop
    mix ash_postgres.generate_migrations
    mix ash_postgres.create
    mix ash_postgres.migrate
    mix test

## Release git with tag

Commands:

    mix git_ops.release

---
