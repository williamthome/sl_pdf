#!/bin/sh

# Vars
config_file="./run.config"

# Default vars
# Use 'key=value' syntax in the config file to override the default vars
elixir_path="/home/williamthome/.asdf/installs/elixir/1.13.1/lib/"

# Overrides default vars
[ -d $config_file ] && . $config_file

# Compiles Elixir
mix compile

# Change dir to src
cd ./src

# Compiles and run Erlang
erlc pdf.erl
erl \
  -pa "../_build/dev/lib/**/ebin/" \
  -eval "pdf:load(\"$elixir_path\")"
