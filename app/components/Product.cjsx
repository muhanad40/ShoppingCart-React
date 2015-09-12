React = require('react')
Fluxxor = require("fluxxor")
FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

ProductComponent = React.createClass

  mixins: [FluxMixin, StoreWatchMixin("CartStore")],

  getStateFromFlux: ->
    flux = @getFlux()
    return {
      CartStore: flux.store("CartStore").getState()
      ProductsStore: flux.store("ProductsStore").getState()
    }

  addToCart: (product)->
    @getFlux().actions.addItemToCart(product)

  render: ->
    if @props.details.stock > 0
      addToCartBtn = <span> - <a href="#" onClick={@addToCart.bind(@, @props.details)}>Add to Cart</a></span>
    return (
      <div id={"product-"+@props.details.id}>
        {@props.details.title}
        <br/>
        &pound;{@props.details.price}
        {addToCartBtn}
        <br/><br/>

      </div>
    )

module.exports = ProductComponent