defmodule SlPdfWeb.PdfView do
  @templates [
    {:hello_world, "hello_world.html", []},
    {:greeting, "greeting.html", [:name]}
  ]
  use SlPdfWeb, :pdf_view
end
