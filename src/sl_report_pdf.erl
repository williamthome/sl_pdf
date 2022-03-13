-module(sl_report_pdf).

-import('Elixir.SlReport', [ print_to_pdf/0, print_to_pdf/1, print_to_pdf/2 ]).

-export([ print/2, test/0 ]).

print(Template, Callback) when is_binary(Template) andalso is_binary(Callback) ->
    Pdf = print_to_pdf(Template, Callback),
    io:format("Pdf generated: ~p~n", [Pdf]),
    Pdf.

test()  ->
    Template = sl_report_view:template_hello_world(),
    Callback = <<"example.pdf">>,
    print(Template, Callback).

%%%=============================================================================
%%% Internal functions
%%%=============================================================================

% nothing here!
