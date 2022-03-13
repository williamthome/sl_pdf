config :sl_pdf, ChromicPDF, [
  {:on_demand, false},
  {:session_pool, [{:timeout, 60_000}]}
]
