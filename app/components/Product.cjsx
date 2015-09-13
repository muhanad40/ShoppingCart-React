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
    picturesDirectory = @getFlux().store("ProductsStore").getPicturesDir()
    return (
      <div className={productClassnames}>
        <div className="panel panel-default" id={"product-"+@props.details.id}>
          <div className="panel-body">
            <img src={picturesDirectory + @props.details.pictureFilename} width="100%"/>
            <h4 className="product-title">{@props.details.title}</h4>
            {@props.details.price.before &&
              <s>&pound;{@props.details.price.before}</s>}
            <div className="add-to-cart-btn-wrapper col-xs-6">
              {addToCartBtn}
              {@props.details.stock == 0 &&
                <span className="text-muted">Out of stock</span>
              }
            </div>
            <div className="col-xs-6 text-right product-price-wrapper">
              <h4 className="text-primary">&pound;<span className="product-price">{@props.details.price.now}</span></h4>
            </div>
          </div>
        </div>
      </div>
    )

module.exports = ProductComponent