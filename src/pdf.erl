-module(pdf).

-import('Elixir.SlPdf', [
    print_to_pdf/0, print_to_pdf/1, print_to_pdf/2
]).

-import('Elixir.SlPdfWeb.PdfView', [
    hello_world/0, greeting/1, loop/1
]).

-export([
    load/0, load/1, load/2, load/3,
    test/0, test/1, test/2,

    template_hello_world/0,
    template_greeting/1,
    template_loop/0, template_loop/1
]).

load() ->
    ElixirPath = "/home/williamthome/.asdf/installs/elixir/1.13.1/lib/",
    load(ElixirPath).

load(ElixirPath) ->
    LocalPath = "../_build/dev/lib/",
    load(ElixirPath, LocalPath).

load(ElixirPath, LocalPath) ->
    BinFolder = "/ebin/",
    load(ElixirPath, LocalPath, BinFolder).

load(ElixirPath, LocalPath, BinFolder) ->
    MainApps = [
        compiler
    ],
    ElixirApps = [
        elixir,
        eex,
        logger
    ],
    LocalApps = [
        jason,
        nimble_pool,
        telemetry,
        chromic_pdf,
        sl_pdf
    ],
    Apps = [
        MainApps,
        {{ElixirPath, BinFolder}, ElixirApps},
        {{LocalPath, BinFolder}, LocalApps}
    ],
    start_apps(Apps).

template_hello_world() ->
    hello_world().

template_greeting(Name) ->
    greeting(Name).

template_loop() ->
    List = ["car", "plane", "something", {x, "x"}, {y, "y"}],
    template_loop(List).

template_loop(List) ->
    loop(List).

test() ->
    test(<<"example.pdf">>).

test(Callback) ->
    test(template_hello_world(), Callback).

test(Template, Callback) when is_binary(Template) andalso is_binary(Callback) ->
    %% Remember to run load/0 before test
    io:format("Pdf generated: ~p~n", [print_to_pdf(Template, Callback)]).

%%%=============================================================================
%%% Internal functions
%%%=============================================================================

start_apps([]) ->
    io:format("All apps started~n");

start_apps([{Path, Apps} | RestOfApps]) ->
    [ start_app(App, Path) || App <- Apps ],
    start_apps(RestOfApps);

start_apps([Apps | RestOfApps]) ->
    [ do_start_app(App) || App <- Apps ],
    start_apps(RestOfApps).

start_app(App, {Root, BinFolder}) ->
    Path = bin_path(App, Root, BinFolder),
    start_app(App, Path);

start_app(App, Path) ->
    do_add_path(Path),
    do_start_app(App).

bin_path(App, Root, BinFolder) ->
    lists:concat([Root, atom_to_list(App), BinFolder]).

do_add_path(Path) ->
    code:add_path(Path).

do_start_app(App) ->
    application:start(App),
    io:format("App started: ~p~n", [App]).
