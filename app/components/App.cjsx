React = require('react')
Fluxxor = require("fluxxor")
Product = require("./Product.cjsx")
Products = require("./Products.cjsx")

FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

App = React.createClass
  mixins: [FluxMixin, StoreWatchMixin("CartStore")]

  getTotalCartItems: ->
    flux = @getFlux()
    return flux.store("CartStore").getTotalItems()
  
  getStateFromFlux: ->
    flux = @getFlux()
    return {
      CartStore: flux.store("CartStore").getState()
      ProductsStore: flux.store("ProductsStore").getState()
    }

  render: ->
    return (
      <div>
        <h3>Cart: {@getTotalCartItems()}</h3>
        <h3>Products:</h3>
        <Products products={@state.ProductsStore.products} />
      </div>
    )


module.exports = App