defmodule SlPdfWeb do
  defmacro __using__(opts) do
    quote(bind_quoted: [opts: opts]) do
      require EEx

      root = Keyword.get(opts, :root, "lib/sl_pdf_web/templates/")
      ext = Keyword.get(opts, :ext, ".eex")
      templates = Keyword.get(opts, :templates, [])

      for {function, file, assigns} <- templates do
        EEx.function_from_file(:def, function, root <> file <> ext, assigns)
      end
    end
  end
end
