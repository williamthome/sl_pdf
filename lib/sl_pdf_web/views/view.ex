defmodule SlPdfWeb.View do
  use SlPdfWeb, templates: [
    {:hello_world, "hello_world.html", []},
    {:greeting, "greeting.html", [:name]}
  ]
end
