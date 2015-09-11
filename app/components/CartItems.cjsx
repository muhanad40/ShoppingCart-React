React = require('react')
CartItem = require("./CartItem.cjsx")

CartItems = React.createClass

  render: ->
    cartItems = @props.items.map((cartItem)=>
      return (
        <CartItem item={cartItem} />
      )
    )
    return (
      <div>
        {cartItems}
      </div>
    )

module.exports = CartItems