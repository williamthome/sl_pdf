defmodule SlReport do
  def print_to_pdf_test, do: SlReport.Pdf.test

  def print_to_pdf_test(n_columns, n_rows) do
     SlReport.Pdf.test(n_columns, n_rows)
  end

  def print_to_pdf, do: SlReport.Pdf.print

  def print_to_pdf(content, callback, opts) do
    SlReport.Pdf.print(content, callback, opts)
  end
end
