defmodule SlPdf do
  use GenServer

  alias SlPdfWeb.PdfView

  @print_timeout 60_000

  ## Client API

  def start_link(init_arg \\ []) do
    GenServer.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def print_to_pdf(
    content \\ SlPdfWeb.PdfView.hello_world,
    callback \\ "example.pdf",
    opts \\ []
  ), do: GenServer.call(__MODULE__, {:print_to_pdf, content, callback, opts}, @print_timeout)

  ## Callbacks

  @impl true
  def init(init_arg), do: {:ok, init_arg}

  @impl true
  def handle_call({:print_to_pdf, content, callback, opts}, _from, state) do
    pdf = content |> PdfView.print(callback, opts)
    {:reply, pdf, state}
  end
end
