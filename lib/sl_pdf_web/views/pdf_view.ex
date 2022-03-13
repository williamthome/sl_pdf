defmodule SlPdfWeb.PdfView do
  @templates [
    {:hello_world, "hello_world.html", []},
    {:greeting, "greeting.html", [:name]},
    {:loop, "loop.html", [:list]},
    {:hard_work, "hard_work.html", [:columns, :rows]}
  ]
  use SlPdfWeb, :pdf_view

  def test(n_columns, n_rows) do
    columns = for column <- 1..n_columns, do: "Column#{column}"
    rows = for row <- 1..n_rows, do: for column <- 1..n_columns, do: "Row#{row}Column#{column}"

    print(hard_work(columns, rows), "hard_work.pdf")
  end
end
