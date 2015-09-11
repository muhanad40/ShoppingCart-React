React = require('react')

CartItem = React.createClass

  render: ->
    return (
      <div>
        <strong>{@props.item.product.title}</strong>
        <br/>
        <strong>Quantity:</strong> {@props.item.quantity}<br/>
        <strong>Total:</strong> &pound;{@props.item.quantity * @props.item.product.price}
        <hr/>
      </div>
    )

module.exports = CartItem