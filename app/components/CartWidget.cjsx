React = require('react')
Fluxxor = require("fluxxor")

FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

CartWidget = React.createClass

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
      ProductsStore: flux.store("ProductsStore").getState()
    }

  render: ->
    return (
      <div className="navbar-text">
        <strong>Cart:</strong> {@getTotalCartItems()} items (&pound;{@getSubTotalCost()}) - <a href="/#/cart">View cart</a>
      </div>
    )

module.exports = CartWidget