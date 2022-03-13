import Config

# TODO: Split configs by env in multiple files

case config_env() do
  :prod ->
    config :sl_pdf, ChromicPDF, [
      {:on_demand, false},
      {:session_pool, [{:timeout, 60_000}]}
    ]
  _ ->
    config :sl_pdf, ChromicPDF, [
      {:offline, true},
      {:on_demand, true},
      {:session_pool, [{:timeout, 60_000}]}
    ]
end
