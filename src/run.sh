#!/bin/sh

erlc pdf.erl
erl -pa "../_build/dev/lib/**/ebin/" -eval "pdf:load()"
