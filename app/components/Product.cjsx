React = require('react')
Fluxxor = require("fluxxor")
classnames = require("classnames")
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

  addToCart: (product, e)->
    e.preventDefault()
    @getFlux().actions.addItemToCart(product)

  render: ->
    if @props.details.stock > 0
      addToCartBtn = <a href="#" className="add-to-cart-btn btn btn-primary" onClick={@addToCart.bind(@, @props.details)}>Add to Cart</a>
    productClassnames = classnames({
      "product": true
      "product-out-of-stock": @props.details.stock == 0
      "col-xs-12": true
      "col-sm-6 col-md-4": true
    })
    return (
      <div className={productClassnames}>
        <div className="panel panel-default" id={"product-"+@props.details.id}>
          <div className="panel-body">
            <h3 className="product-title">{@props.details.title}</h3>
            {@props.details.price.before &&
              <s>&pound;{@props.details.price.before}</s>}
            <h4><span className="label label-default">&pound;<span className="product-price">{@props.details.price.now}</span></span></h4>
            {addToCartBtn}
          </div>
        </div>
      </div>
    )

module.exports = ProductComponent