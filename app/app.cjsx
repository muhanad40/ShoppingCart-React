App = require("./components/App.cjsx")
React = require("react")
Fluxxor = require("fluxxor")
ShoppingCartActions = require("./actions/ShoppingCartActions.cjsx")
CartStore = require("./stores/CartStore.cjsx")
ProductsStore = require("./stores/ProductsStore.cjsx")

stores = {
  CartStore: new CartStore()
  ProductsStore: new ProductsStore()
}

flux = new Fluxxor.Flux(stores, ShoppingCartActions);

# flux.on("dispatch", (type, payload)->
#   if console and console.log
#     console.log("[Dispatch]", type, payload)
# )

React.render(
  <App flux={flux} />,
  document.getElementById('reactApp')
)