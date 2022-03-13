-module(sl_report).

-export([ start/1, start/2, start/3 ]).

start(ElixirPath) ->
    LocalPath = "../_build/dev/lib/",
    start(ElixirPath, LocalPath).

start(ElixirPath, LocalPath) ->
    BinFolder = "/ebin/",
    start(ElixirPath, LocalPath, BinFolder).

start(ElixirPath, LocalPath, BinFolder) ->
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
        sl_report
    ],
    Apps = [
        MainApps,
        {{ElixirPath, BinFolder}, ElixirApps},
        {{LocalPath, BinFolder}, LocalApps}
    ],
    start_apps(Apps).

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
