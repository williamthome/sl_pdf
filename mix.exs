defmodule SlReport.MixProject do
  use Mix.Project

  def project do
    [
      app: :sl_report,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {SlReport.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {
        :chromic_pdf,
        git: "https://github.com/williamthome/chromic_pdf.git",
        branch: "main"
      }
    ]
  end
end
