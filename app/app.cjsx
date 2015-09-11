Home = require("./components/Home.cjsx")
React = require("react")
Router = require("react-router")
Route = Router.Route;
RouteHandler = Router.RouteHandler
Fluxxor = require("fluxxor")
CartActions = require("./actions/CartActions.cjsx")
CartStore = require("./stores/CartStore.cjsx")
ProductsStore = require("./stores/ProductsStore.cjsx")

stores = {
  CartStore: new CartStore()
  ProductsStore: new ProductsStore()
}

flux = new Fluxxor.Flux(stores, CartActions);

# flux.on("dispatch", (type, payload)->
#   if console and console.log
#     console.log("[Dispatch]", type, payload)
# )

App = React.createClass
  render:->
    return (
      <div>
        <RouteHandler flux={flux} />
      </div>
    )

routes = (
  <Route handler={App} path="/">
    <Route handler={Home} />
  </Route>
)

Router.run(routes, Router.HistoryLocation, (Handler)->
  React.render(<Handler />, document.getElementById('reactApp'));
)