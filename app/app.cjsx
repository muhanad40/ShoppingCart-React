HomeComponent = require("./components/Home.cjsx")
React = require("react")
Fluxxor = require("fluxxor")
ShoppingCartActions = require("./actions/ShoppingCartActions.cjsx")
ShoppingCartStore = require("./stores/ShoppingCartStore.cjsx")

stores = {
  ShoppingCartStore: new ShoppingCartStore()
}

flux = new Fluxxor.Flux(stores, ShoppingCartActions);

# flux.on("dispatch", (type, payload)->
#   if console and console.log
#     console.log("[Dispatch]", type, payload)
# )

React.render(
  <HomeComponent flux={flux} />,
  document.getElementById('reactApp')
)