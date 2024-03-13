# migrate

Migrate is a database migration tool for PostgreSQL and SQLite.

## Installation

To get the most up to date instal, you can install via the
[Homewbrew](https://brew.sh) tap
[tombell/formulae](https://github.com/tombell/homebrew-formulae).

    brew tap tombell/formulae
    brew install tombell/formulae/migrate

To install the latest from source, you can use `go install`.

    go install github.com/tombell/migrate/cmd/migrate@latest

## Usage

To begin you'll need to create your migrations in a directory. The files will
need a prefix that is a time stamp, so that the migrations can be ordered.

### Migrations

The format is `YYYYMMDDHHmmss_{migration name}.sql`. The rest of the name can be
anything you like.

The contents of the migration should have an up and down section, denoted by
specific comments.

Example:

    -- migrate:up

    CREATE TABLE "tracks" (
      "id"      UUID          PRIMARY KEY,
      "artist"  VARCHAR (256) NOT NULL,
      "name"    VARCHAR (256) NOT NULL,
      "genre"   VARCHAR (128) NOT NULL,
      "bpm"     DECIMAL       NOT NULL,
      "key"     VARCHAR (8)   NOT NULL,
      "created" TIMESTAMP     NOT NULL,
      "updated" TIMESTAMP     NOT NULL
    );

    -- migrate:down

    DROP TABLE IF EXISTS "tracks";

Once you've created your migrations, you're ready to run the `migrate` command.

### Applying migrations

The `apply` sub command runs through the migrations in the specified directory,
and applies any migrations not already applied.

You will need to specify the `--db`, `--dsn`, and `--migrations` options. The
`--db` option can be omitted if you're using PostgreSQL, as this is the default
value.

    migrate apply --dsn "my_local_db" --migrations ./migrations

### Rolling back migrations

The `rollback` sub command, will roll back the last applied migration(s). The
`--steps` option is used to specify the number of migrations to roll back, the
default is 1. You will also need the `--db`, `--dsn`, and `--migrations`
options.

    migrate rollback --dsn "my_local_db" --migrations ./migrations
