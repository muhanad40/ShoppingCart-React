React = require('react')
Router = require("react-router")
RouteHandler = Router.RouteHandler
Fluxxor = require("fluxxor")
CartActions = require("../actions/CartActions.cjsx")
CartStore = require("../stores/CartStore.cjsx")
ProductsStore = require("../stores/ProductsStore.cjsx")

stores = {
  CartStore: new CartStore()
  ProductsStore: new ProductsStore()
}

flux = new Fluxxor.Flux(stores, CartActions);
App = React.createClass
  render:->
    return (
      <div>
        <RouteHandler flux={flux} />
      </div>
    )

module.exports = App