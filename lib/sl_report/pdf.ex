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
      # PDF task supervisor
      {Task.Supervisor, name: SlReport.Pdf.TaskSupervisor},
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def print(
    content \\ PdfView.hello_world,
    callback \\ "priv/reports/example.pdf",
    opts \\ []
  ) do
    Task.Supervisor.start_child(
      SlReport.Pdf.TaskSupervisor,
      fn ->
        IO.inspect self(), label: "#{inspect self()} is printing"

        {microseconds, pdf_result} = :timer.tc(fn ->
          PdfView.print(content, callback, opts)
        end)
        seconds = microseconds / 1_000_000
        pdf = {pdf_result, {:seconds, seconds}}

        IO.inspect pdf
      end,
      timeout: 60_0000
    )
  end

  def test(
    n_columns \\ 5..20 |> Enum.random(),
    n_rows \\ 200..5000 |> Enum.random()
  ) do
    columns = for column <- 1..n_columns, do: "Column#{column}"
    rows = for row <- 1..n_rows, do: for column <- 1..n_columns, do: "Row#{row}Column#{column}"

    content = PdfView.hard_work(columns, rows)
    callback = "priv/reports/hard_work.pdf"

    print(content, callback)
  end
end
