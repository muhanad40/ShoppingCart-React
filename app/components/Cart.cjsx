React = require('react')
Fluxxor = require("fluxxor")
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

  removeItem: (item, e)->
    e.preventDefault()
    flux = @getFlux()
    flux.actions.removeItemFromCart(item.product.id)

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
      voucherError = <div className="alert alert-danger">{@state.voucherError}</div>

    cartItems = @state.CartStore.items.map((cartItem, index)=>
      return (
        <tr key={index}>
          <td>
            {cartItem.product.title}<br/>
            <a href="#" onClick={@removeItem.bind(@, cartItem)}>Remove</a>
          </td>
          <td>{cartItem.quantity}</td>
          <td className="text-right">&pound;{parseFloat(cartItem.quantity * cartItem.product.price).toFixed(2)/1}</td>
        </tr>
      )
    )
    return (
      <div className="col-xs-10">
        <h3>Shopping Cart</h3>
        <br/>
        <table className="table">
          <thead>
            <tr>
              <th>Item</th>
              <th>Quantity</th>
              <th className="text-right">Price</th>
            </tr>
          </thead>
          <tbody>
            {cartItems}
            <tr>
              <td className="text-right" colSpan="2"><strong>Sub-total:</strong></td>
              <td className="text-right">&pound;{@getSubTotalCost()}</td>
            </tr>
            <tr>
              <td colSpan="3">
                <strong>Discount vouchers:</strong>
                {voucherError}
                <Vouchers />
                <form className="form-inline" onSubmit={@submitVoucher}>
                  <input type="text" className="form-control" value={@state.newVoucher} onChange={@handleVoucherFormChange} />
                  &nbsp;<input type="submit" className="btn btn-primary" value="Apply Voucher" onClick={@submitVoucher} />
                </form>
              </td>
            </tr>
            <tr>
              <td className="text-right" colSpan="2"><strong>Total:</strong></td>
              <td className="text-right">&pound;{@getTotalCost()}</td>
            </tr>
          </tbody>
        </table>
        <div className="text-right">
          <a href="#" className="btn btn-primary btn-lg">Pay</a>
        </div>
      </div>
    )

module.exports = Cart