React = require('react')

CartItem = React.createClass

  render: ->
    return (
      <div>{@props.item.product.title} - Qty. {@props.item.quantity}</div>
    )

module.exports = CartItem