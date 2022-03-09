defmodule SlPdfWeb do
  defmacro __using__(_opts) do
    quote do
      require EEx
      @root "lib/sl_pdf_web/templates/"
      @ext ".eex"
      EEx.function_from_file(
        :def,
        :hello_world,
        @root <> "hello_world.html" <> @ext,
        []
      )
    end
  end
end
