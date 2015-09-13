App = require("./components/App.cjsx")
Cart = require("./components/Cart.cjsx")
Home = require("./components/Home.cjsx")
React = require("react")
Router = require("react-router")
Route = Router.Route;

require("jquery")
require("../node_modules/bootstrap/dist/css/bootstrap-theme.css")
require("../node_modules/bootstrap/dist/css/bootstrap.css")
require("../node_modules/bootstrap/dist/js/bootstrap.js")

routes = (
  <Route handler={App} path="/">
    <Route path="/" handler={Home} />
    <Route path="/cart" handler={Cart} />
  </Route>
)

Router.run(routes, (Handler)->
  React.render(<Handler />, document.getElementById('reactApp'));
)