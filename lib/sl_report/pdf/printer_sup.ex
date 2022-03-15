defmodule SlReport.Pdf.PrinterSup do
  use DynamicSupervisor

  alias SlReport.Pdf.Printer

  def start_link(_init_arg) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def print(args) do
    spec = {Printer, args}
    {:ok, pid} = DynamicSupervisor.start_child(__MODULE__, spec)
    IO.puts "#{inspect pid} starting"
    pid |> Printer.print()
  end

  @impl true
  def init(:ok), do: DynamicSupervisor.init(strategy: :one_for_one)

end
