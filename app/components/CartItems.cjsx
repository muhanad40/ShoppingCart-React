React = require('react')
CartItem = require("./CartItem.cjsx")

CartItems = React.createClass

  render: ->
    cartItems = @props.items.map((cartItem, index)=>
      return (
        <CartItem key={index} item={cartItem} />
      )
    )
    return (
      <div>
        {cartItems}
      </div>
    )

module.exports = CartItems