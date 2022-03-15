import Config

# TODO: Split configs by env in multiple files

@chromic_pdf_common_env_config [
  {:offline, true},
  {:on_demand, true},
  {:session_pool, [{:timeout, 60_000}]}
]

case config_env() do
  :prod ->
    config :sl_report, ChromicPDF, @chromic_pdf_common_env_config
  _env ->
    config :sl_report, ChromicPDF, @chromic_pdf_common_env_config
end
