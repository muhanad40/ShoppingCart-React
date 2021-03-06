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
        <tr key={index} className="cart-item">
          <td>
            <span className="cart-item-title">{cartItem.product.title}</span>
            <br/>
            <a href="#" className="remove-cart-item-btn" onClick={@removeItem.bind(@, cartItem)}>Remove</a>
          </td>
          <td className="cart-item-quantity">{cartItem.quantity}</td>
          <td className="text-right">
            &pound;<span className="cart-item-total-price">{parseFloat(cartItem.quantity * cartItem.product.price.now).toFixed(2)/1}</span>
          </td>
        </tr>
      )
    )

    if @state.CartStore.items.length > 0
      cartBody = (
        <div>
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
                <td className="text-right">&pound;<span id="cart-subtotal">{@getSubTotalCost()}</span></td>
              </tr>
              <tr>
                <td colSpan="3">
                  <strong>Discount vouchers:</strong>
                  {voucherError}
                  <Vouchers />
                  <form className="form-inline" onSubmit={@submitVoucher}>
                    <input type="text" id="voucher-input" className="form-control" value={@state.newVoucher} onChange={@handleVoucherFormChange} />
                    &nbsp;<input type="submit" id="add-voucher-btn" className="btn btn-primary" value="Apply Voucher" onClick={@submitVoucher} />
                  </form>
                </td>
              </tr>
              <tr>
                <td className="text-right" colSpan="2"><strong>Total:</strong></td>
                <td className="text-right">&pound;<span id="cart-total">{@getTotalCost()}</span></td>
              </tr>
            </tbody>
          </table>
          <div className="text-right">
            <input type="button" className="btn btn-primary btn-lg" value="Pay" />
          </div>
        </div>
      )
    else
      cartBody = <div id="no-cart-items-msg">You have no items in your shopping cart.</div>
        
    return (
      <div>
        <h3>Shopping Cart</h3>
        <br/>
        {cartBody}
      </div>
    )

module.exports = Cart