React = require('react')
Fluxxor = require("fluxxor")
FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

CartItem = React.createClass
  mixins: [FluxMixin, StoreWatchMixin("CartStore")]

  removeItem: (item, e)->
    e.preventDefault()
    flux = @getFlux()
    flux.actions.removeItemFromCart(item.product.id)

  getStateFromFlux: ->
    flux = @getFlux()
    return {
      CartStore: flux.store("CartStore").getState()
      ProductsStore: flux.store("ProductsStore").getState()
    }

  render: ->
    return (
      <div>
        <strong>{@props.item.product.title}</strong>
        <br/>
        <strong>Quantity:</strong> {@props.item.quantity}
        <br/>
        <strong>Total:</strong> &pound;{parseFloat(@props.item.quantity * @props.item.product.price).toFixed(2)/1}
        <br/>
        <a href="#" onClick={@removeItem.bind(@, @props.item)}>x Remove</a>
        <hr/>
      </div>
    )

module.exports = CartItem