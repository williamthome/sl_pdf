defmodule SlReport.Pdf do
  use Supervisor

  def start_link(chromic_pdf_opts) do
    Supervisor.start_link(__MODULE__, chromic_pdf_opts, name: __MODULE__)
  end

  @impl true
  def init(chromic_pdf_opts) do
    children = [
      # Start the ChromicPDF supervisor
      {ChromicPDF, chromic_pdf_opts},
      # TODO: remove changing to start_child and kill when done
      SlReport.Pdf.Maker
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
