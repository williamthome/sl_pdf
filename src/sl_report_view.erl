-module(sl_report_view).

-import('Elixir.SlReportWeb.PdfView', [
    hello_world/0, greeting/1, loop/1
]).

-export([
    template_hello_world/0,
    template_greeting/1,
    template_loop/0, template_loop/1
]).

template_hello_world() ->
    hello_world().

template_greeting(Name) ->
    greeting(Name).

template_loop() ->
    List = ["car", "plane", "something", {x, "x"}, {y, "y"}],
    template_loop(List).

template_loop(List) ->
    loop(List).

%%%=============================================================================
%%% Internal functions
%%%=============================================================================

% nothing here!
