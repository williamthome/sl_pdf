import Config

# TODO: Split configs by env in multiple files

case config_env() do
  :prod ->
    config :sl_report, ChromicPDF, [
      {:offline, true},
      {:on_demand, true},
      {:session_pool, [{:timeout, 60_000}]}
    ]
  _env ->
    config :sl_report, ChromicPDF, [
      {:offline, true},
      {:on_demand, true},
      {:session_pool, [{:timeout, 60_000}]}
    ]
end
