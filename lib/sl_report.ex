defmodule SlReport do
  def print_to_pdf, do: SlReport.Pdf.Maker.print_to_pdf

  def print_to_pdf(content, callback, opts) do
    SlReport.Pdf.Maker.print_to_pdf(content, callback, opts)
  end
end
