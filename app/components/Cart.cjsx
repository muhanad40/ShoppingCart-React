React = require('react')
Fluxxor = require("fluxxor")
CartItems = require("./CartItems.cjsx")
Vouchers = require("./Vouchers.cjsx")

FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

Cart = React.createClass
  mixins: [FluxMixin, StoreWatchMixin("CartStore")]

  getSubTotalCost: ->
    flux = @getFlux()
    return flux.store("CartStore").getSubTotalCost()

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
    @setState({voucherError: null})
    try
      @getFlux().actions.addVoucherToCart(@state.newVoucher)
      @setState({newVoucher: ""})
    catch e
      @setState({
        voucherError: e.message
      })

  render: ->
    if @state.voucherError
      voucherError = <div>{@state.voucherError}</div>
    return (
      <div className="col-xs-10">
        <h3>Shopping Cart</h3>
        <h3>Items:</h3>
        <CartItems items={@state.CartStore.items} />

        <br/>

        <strong>Sub-total:</strong> &pound;{@getSubTotalCost()}

        <br/><br/>

        <strong>Vouchers:</strong>
        {voucherError}
        <Vouchers />
        <form onSubmit={@submitVoucher}>
          <input type="text" value={@state.newVoucher} onChange={@handleVoucherFormChange} />
          <input type="submit" value="Apply Voucher" onClick={@submitVoucher} />
        </form>
        <br/>
        <strong>Total:</strong> &pound;{@getTotalCost()}

      </div>
    )


module.exports = Cart