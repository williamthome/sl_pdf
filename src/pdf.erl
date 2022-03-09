-module(pdf).

-export([
    load/0, load/1, load/2, load/3,
    test/0
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

test() ->
    ok = load(),
    ok = 'Elixir.SlPdf.Pdf':print_to_pdf(),
    io:format("Pdf generated~n").

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
