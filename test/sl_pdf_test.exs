defmodule SlPdfTest do
  use ExUnit.Case
  doctest SlPdf

  test "prints pdf" do
    assert SlPdf.print_to_pdf() == :ok
  end
end
