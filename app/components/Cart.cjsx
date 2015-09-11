React = require('react')
Fluxxor = require("fluxxor")
CartItems = require("./CartItems.cjsx")
Vouchers = require("./Vouchers.cjsx")

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

  handleVoucherFormChange: (event)->
    @setState({
      newVoucher: event.target.value
    })

  submitVoucher: (e)->
    e.preventDefault()
    @getFlux().actions.addVoucherToCart(@state.newVoucher)
    @setState({newVoucher: ""})

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
        <form onSubmit={@submitVoucher}>
          <input type="text" value={@state.newVoucher} onChange={@handleVoucherFormChange} />
          <input type="submit" value="Apply Voucher" onClick={@submitVoucher} />
        </form>
        <Vouchers />
        <br/><br/>

        <strong>Total:</strong> &pound;{@getTotalCost()}

      </div>
    )


module.exports = Cart