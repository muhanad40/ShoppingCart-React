React = require('react')
Fluxxor = require("fluxxor")
CartItems = require("./CartItems.cjsx")

FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

Cart = React.createClass
  mixins: [FluxMixin, StoreWatchMixin("CartStore")]

  getTotalCost: ->
    flux = @getFlux()
    return flux.store("CartStore").getTotalCost()
  
  getStateFromFlux: ->
    flux = @getFlux()
    return {
      CartStore: flux.store("CartStore").getState()
      ProductsStore: flux.store("ProductsStore").getState()
    }

  render: ->
    return (
      <div>
        <h3>Shopping Cart</h3>
        <h3>Items:</h3>
        <CartItems items={@state.CartStore.items} />

        <br/>

        <strong>Sub-total:</strong> &pound;{@getTotalCost()}

        <br/><br/>

        <strong>Vouchers:</strong>
        <form>
          <input type="text" />
          <input type="submit" value="Apply Voucher" />
        </form>
        Voucher name goes here
        <br/><br/>

        <strong>Total:</strong> &pound;{@getTotalCost()}

      </div>
    )


module.exports = Cart