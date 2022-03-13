defmodule SlReport.Application do
  @chromic_pdf_opts Application.compile_env(:sl_report, ChromicPDF, [])

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the ChromicPDF supervisor
      {ChromicPDF, @chromic_pdf_opts},
      # Pdf supervisor
      {SlReport, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SlReport.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
