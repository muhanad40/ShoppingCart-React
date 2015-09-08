React = require('react')
Fluxxor = require("fluxxor")

FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

Home = React.createClass
  mixins: [FluxMixin, StoreWatchMixin("ShoppingCartStore")]
  
  getStateFromFlux: ->
    @flux = this.getFlux()
    return @flux.store("ShoppingCartStore").getState()

  addToCart: ->
    @flux.actions.addItemToCart("asd")

  render: ->
    (<div onClick={@addToCart}>Add to Cart</div>)

module.exports = Home