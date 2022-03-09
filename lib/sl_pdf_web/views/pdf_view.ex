defmodule SlPdfWeb.PdfView do
  @templates [
    {:hello_world, "hello_world.html", []},
    {:greeting, "greeting.html", [:name]},
    {:loop, "loop.html", [:list]}
  ]
  use SlPdfWeb, :pdf_view
end
