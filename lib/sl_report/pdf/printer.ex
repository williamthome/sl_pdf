defmodule SlReport.Pdf.Printer do
  use GenServer

  alias SlReportWeb.PdfView

  @print_timeout 60_000

  ## Client API

  def start_link(init_arg \\ []) do
    GenServer.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def print(content, callback, opts) do
    GenServer.cast(__MODULE__, {:print, content, callback, opts})
  end

  def test(n_columns, n_rows) do
    GenServer.cast(__MODULE__, {:test, n_columns, n_rows})
  end

  def send_pdf(pid, gen_pdf_fun) when is_function(gen_pdf_fun, 0) do
    spawn(fn ->
      {microseconds, pdf_result} = :timer.tc(gen_pdf_fun)
      seconds = microseconds_to_seconds(microseconds)
      pdf = {pdf_result, {:seconds, seconds}}

      GenServer.call(pid, {:pdf_received, pdf}, @print_timeout)
    end)
  end

  ## Callbacks

  @impl true
  def init(init_arg), do: {:ok, init_arg}

  @impl true
  def handle_cast({:print, content, callback, opts}, state) do
    self_send_pdf(fn ->
      content |> PdfView.print(callback, opts)
    end)

    {:noreply, state}
  end

  def handle_cast({:test, n_columns, n_rows}, state) do
    self_send_pdf(fn ->
      PdfView.test(n_columns, n_rows)
    end)

    {:noreply, state}
  end

  @impl true
  def handle_call({:pdf_received, pdf}, _from, state) do
    IO.inspect pdf, label: "Pdf received"

    {:reply, pdf, state}
  end

  ## Internal functions

  defp microseconds_to_seconds(microseconds), do: microseconds / 1_000_000

  defp self_send_pdf(fun), do: self() |> send_pdf(fun)

end
