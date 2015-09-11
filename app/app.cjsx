App = require("./components/App.cjsx")
Cart = require("./components/Cart.cjsx")
Home = require("./components/Home.cjsx")
React = require("react")
Router = require("react-router")
Route = Router.Route;

# flux.on("dispatch", (type, payload)->
#   if console and console.log
#     console.log("[Dispatch]", type, payload)
# )

routes = (
  <Route handler={App} path="/">
    <Route handler={Home} />
    <Route path="/cart" handler={Cart} />
  </Route>
)

Router.run(routes, Router.HistoryLocation, (Handler)->
  React.render(<Handler />, document.getElementById('reactApp'));
)