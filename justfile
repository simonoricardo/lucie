set positional-arguments

[private]
default:
  just --list

@start-db:
  docker compose up -d

@start: start-db
  iex -S mix phx.server

@i18n:
  mix gettext.extract
  mix gettext.merge priv/gettext --locale fr
  mix gettext.merge priv/gettext --locale en
