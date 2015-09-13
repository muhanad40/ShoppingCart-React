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
    return flux.store("CartStore").getTotalCost()
  
  getStateFromFlux: ->
    flux = @getFlux()
    return {
      CartStore: flux.store("CartStore").getState()
      ProductsStore: flux.store("ProductsStore").getState()
    }

  render: ->
    return (
      <div className="navbar-text" id="cart-widget">
        <strong>Cart:</strong> <span id="cart-widget-total-items">{@getTotalCartItems()}</span> items (&pound;<span id="cart-widget-total-cost">{@getSubTotalCost()}</span>) - <a data-toggle="collapse" data-target="#categoriesMenu" href="/#/cart">View cart</a>
      </div>
    )

module.exports = CartWidget