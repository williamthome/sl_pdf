defmodule SlReportTest do
  use ExUnit.Case
  doctest SlReport

  test "prints pdf" do
    assert SlReport.print_to_pdf() == :ok
  end
end
