React = require('react')

ProductComponent = React.createClass

  addToCart: (product)->
    @flux.actions.addItemToCart(product)

  render: ->
    return (
      <div id={"product-"+@props.details.id}>
        {@props.details.title} - <a href="#" onClick={@addToCart.bind(@, @props.details)}>Add to Cart</a>
      </div>
    )

module.exports = ProductComponent