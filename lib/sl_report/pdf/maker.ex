defmodule SlReport.Pdf.Maker do
  use GenServer

  alias SlReportWeb.PdfView

  @print_timeout 60_000

  ## Client API

  def start_link(init_arg \\ []) do
    GenServer.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def print_to_pdf(
    content \\ PdfView.hello_world,
    callback \\ "priv/reports/example.pdf",
    opts \\ []
  ), do: GenServer.call(__MODULE__, {:print_to_pdf, content, callback, opts}, @print_timeout)

  def test(
    n_columns \\ 10,
    n_rows \\ 500
  ), do: GenServer.call(__MODULE__, {:test, n_columns, n_rows}, @print_timeout)

  def cast_test(
    n_columns \\ 10,
    n_rows \\ 15_000
  ), do: GenServer.cast(__MODULE__, {:test, n_columns, n_rows})

  ## Callbacks

  @impl true
  def init(init_arg), do: {:ok, init_arg}

  @impl true
  def handle_call({:print_to_pdf, content, callback, opts}, _from, state) do
    pdf = content |> PdfView.print(callback, opts)
    {:reply, pdf, state}
  end

  @impl true
  def handle_call({:test, n_columns, n_rows}, _from, state) do
    {microseconds, pdf_result} = :timer.tc(fn ->
      PdfView.test(n_columns, n_rows)
    end)
    seconds = microseconds / 1_000_000
    reply = {pdf_result, {:seconds, seconds}}
    {:reply, reply, state}
  end

  def handle_call({:pdf_ready, reply}, _from, state) do
    IO.inspect reply, label: "Pdf received"
    {:reply, reply, state}
  end

  @impl true
  def handle_cast({:test, n_columns, n_rows}, state) do
    pid = self()

    spawn(fn ->
      reply = test(n_columns, n_rows)
      GenServer.call(pid, {:pdf_ready, reply}, @print_timeout)
    end)

    {:noreply, state}
  end
end
