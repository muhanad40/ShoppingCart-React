React = require('react')
Fluxxor = require("fluxxor")
Product = require("./Product.cjsx")
Products = require("./Products.cjsx")

FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

Home = React.createClass
  mixins: [FluxMixin, StoreWatchMixin("CartStore")]

  getTotalCartItems: ->
    flux = @getFlux()
    return flux.store("CartStore").getTotalItems()

  getSubTotalCost: ->
    flux = @getFlux()
    return flux.store("CartStore").getSubTotalCost()
  
  getStateFromFlux: ->
    flux = @getFlux()
    return {
      CartStore: flux.store("CartStore").getState()
    }

  render: ->
    flux = @getFlux()
    products = flux.store("ProductsStore").getState().products
    return (
      <h3>Products:</h3>
      <Products products={products} />
    )


module.exports = Home