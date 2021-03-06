React = require('react')
Router = require("react-router")
RouteHandler = Router.RouteHandler
Fluxxor = require("fluxxor")
CartActions = require("../actions/CartActions.cjsx")
CartStore = require("../stores/CartStore.cjsx")
ProductsStore = require("../stores/ProductsStore.cjsx")
CategoryStore = require("../stores/CategoryStore.cjsx")
Sidebar = require("./Sidebar.cjsx")
Header = require("./Header.cjsx")
_ = require("underscore")
classnames = require("classnames")

stores = {
  CartStore: new CartStore()
  ProductsStore: new ProductsStore()
  CategoryStore: new CategoryStore()
}

flux = new Fluxxor.Flux(stores, CartActions);
App = React.createClass

  contextTypes: {
    router: React.PropTypes.func
  }

  render:->
    return (
      <main className="col-xs-12" style={{"marginTop": '15px'}}>
        <Header flux={flux} />
        <Sidebar flux={flux} />
        <div className="col-xs-12 col-sm-9 col-md-9 col-lg-10">
          <RouteHandler flux={flux} />
        </div>
      </main>
    )

module.exports = App