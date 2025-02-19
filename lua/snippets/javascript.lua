local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("javascript", {
  s("rscene", { t({ "$(document).on('knack-scene-render." }), i(1), t({ "', (event, scene) => {", "  ", "});" }) }),
  s("rview", { t({ "$(document).on('knack-view-render." }), i(1), t({ "', (event, view, data) => {", "  ", "});" }) }),
  s("revent", { t({ "$(document).on(constructEvents(" }), i(1), t({ "), (event, _, data) => {", "  ", "});" }) }),
  s("$view", { t({ "const $view = $(`#${view.key}`)", "" }), i(1) }),
  s("$scene", { t({ "const $scene = $(`#${scene.key}`)", "" }), i(1) }),
})
