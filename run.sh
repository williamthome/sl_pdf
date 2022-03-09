#!/bin/sh
mix compile

cd ./src

erlc pdf.erl
erl \
  -pa "../_build/dev/lib/**/ebin/" \
  -eval "pdf:load()" \
  -eval "pdf:test(pdf:template_loop(), <<\"loop.pdf\">>)"
