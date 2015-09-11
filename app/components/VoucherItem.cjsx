React = require('react')
Fluxxor = require("fluxxor")

FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

VoucherItem = React.createClass
  
  mixins: [FluxMixin, StoreWatchMixin("CartStore")]

  removeVoucher: (voucher, e)->
    e.preventDefault()
    flux = @getFlux()
    flux.actions.removeVoucherFromCart(voucher)

  getStateFromFlux: ->
    flux = @getFlux()
    return {
      CartStore: flux.store("CartStore").getState()
      ProductsStore: flux.store("ProductsStore").getState()
    }

  render: ->
    return (
      <div>
        {@props.data} - <a href="#" onClick={@removeVoucher.bind(@, @props.data)}>x Remove</a>
      </div>
    )

module.exports = VoucherItem