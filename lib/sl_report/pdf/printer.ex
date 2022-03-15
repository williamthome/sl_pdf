defmodule SlReport.Pdf.Printer do
  use GenServer

  @print_timeout 60_000

  alias SlReportWeb.PdfView

  ## Client API

  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg)
  end

  # Dynamic supervisor expects start_link/2
  def start_link([], init_arg) do
    start_link(init_arg)
  end

  def print(pid) do
    GenServer.cast(pid, :print)
  end

  ## Callbacks

  @impl true
  def init(init_arg) do
    {:ok, init_arg}
  end

  @impl true
  def handle_cast(:print, [content, callback, opts] = state) do
    pid = IO.inspect self(), label: "#{inspect self()} is printing"

    Task.start_link(fn ->
      {microseconds, pdf_result} = :timer.tc(fn ->
        PdfView.print(content, callback, opts)
      end)
      seconds = microseconds / 1_000_000
      pdf = {pdf_result, {:seconds, seconds}}

      GenServer.call(pid, {:pdf_ready, pdf}, @print_timeout)
    end)

    {:noreply, state}
  end

  @impl true
  def handle_call({:pdf_ready, pdf}, _from, state) do
    IO.inspect pdf, label: "#{inspect self()} received pdf"

    {:stop, :normal, pdf, state}
  end
end
