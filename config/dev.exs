config :sl_pdf, ChromicPDF, [
  {:offline, true},
  {:on_demand, true},
  {:session_pool, [{:timeout, 60_000}]}
]
