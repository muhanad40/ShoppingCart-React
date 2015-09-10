React = require('react')
Fluxxor = require("fluxxor")
Product = require("./Product.cjsx")
Products = require("./Products.cjsx")

FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

App = React.createClass
  mixins: [FluxMixin, StoreWatchMixin("CartStore")]
  
  getStateFromFlux: ->
    flux = this.getFlux()
    return {
      CartStore: flux.store("CartStore").getState()
      ProductsStore: flux.store("ProductsStore").getState()
    }

  render: ->
    return (
      <div>
        <h3>Cart: 0</h3>
        <h3>Products:</h3>
        <Products products={@state.ProductsStore.products} />
      </div>
    )


module.exports = App