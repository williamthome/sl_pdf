defmodule SlPdfWeb do
  def pdf_view do
    quote do
      require EEx

      root = Module.get_attribute(__MODULE__, :root, "lib/sl_pdf_web/templates/")
      ext = Module.get_attribute(__MODULE__, :ext, ".eex")
      templates = Module.get_attribute(__MODULE__, :templates, [])

      for {function, file, assigns} <- templates do
        EEx.function_from_file(:def, function, root <> file <> ext, assigns)
      end
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
