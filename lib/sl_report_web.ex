defmodule SlReportWeb do
  def pdf_view do
    quote do
      require EEx

      root = Module.get_attribute(__MODULE__, :root, "lib/sl_report_web/templates/")
      ext = Module.get_attribute(__MODULE__, :ext, ".eex")
      templates = Module.get_attribute(__MODULE__, :templates, [])

      for {function, file, assigns} <- templates do
        EEx.function_from_file(:def, function, root <> file <> ext, assigns)
      end

      @default_opts [
        size: :a4,
        landscape: true
      ]

      def print(content, callback, opts \\ @default_opts) do
        [content: content] ++ opts
        |> ChromicPDF.Template.source_and_options()
        |> ChromicPDF.print_to_pdf(output: callback)
      end
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
