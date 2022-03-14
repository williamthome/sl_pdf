defmodule SlReport.Pdf do
  use Supervisor

  alias SlReportWeb.PdfView

  def start_link(chromic_pdf_opts) do
    Supervisor.start_link(__MODULE__, chromic_pdf_opts, name: __MODULE__)
  end

  @impl true
  def init(chromic_pdf_opts) do
    children = [
      # Start the ChromicPDF supervisor
      {ChromicPDF, chromic_pdf_opts},
      # TODO: remove changing to start_child and kill when done
      SlReport.Pdf.Printer
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def print(
    content \\ PdfView.hello_world,
    callback \\ "priv/reports/example.pdf",
    opts \\ []
  ) do
    SlReport.Pdf.Printer.print(content, callback, opts)
  end

  def test(n_columns \\ 10, n_rows \\ 500) do
    SlReport.Pdf.Printer.test(n_columns, n_rows)
  end
end
