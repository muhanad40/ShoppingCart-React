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
      addToCartBtn = <a href="#" className="btn btn-primary" onClick={@addToCart.bind(@, @props.details)}>Add to Cart</a>
    return (
      <div className="col-xs-4 panel panel-default" id={"product-"+@props.details.id}>
        <div className="panel-body">
          <h3>{@props.details.title}</h3>
          <h4><span className="label label-default">&pound;{@props.details.price}</span></h4>
          {addToCartBtn}
        </div>
      </div>
    )

module.exports = ProductComponent