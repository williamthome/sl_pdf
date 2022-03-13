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
erlc sl_report.erl sl_report_view.erl sl_report_pdf.erl
erl \
  -pa "../_build/dev/lib/**/ebin/" \
  -eval "sl_report:start(\"$elixir_path\")"
