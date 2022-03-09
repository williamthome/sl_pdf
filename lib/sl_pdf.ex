defmodule SlPdf do
  use GenServer

  ## Client API

  def start_link(init_arg \\ []) do
    GenServer.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def print_to_pdf(
    content \\ "<div>Hello, World!</div>",
    callback \\ "example.pdf"
  ), do: GenServer.call(__MODULE__, {:print_to_pdf, content, callback})

  ## Callbacks

  @impl true
  def init(init_arg), do: {:ok, init_arg}

  @impl true
  def handle_call({:print_to_pdf, content, callback}, _from, state) do
    pdf =
      [content: content, size: :a4]
      |> ChromicPDF.Template.source_and_options()
      |> ChromicPDF.print_to_pdf(output: callback)
    {:reply, pdf, state}
  end
end
