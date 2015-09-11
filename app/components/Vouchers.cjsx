React = require('react')
VoucherItem = require("./VoucherItem.cjsx")
Fluxxor = require("fluxxor")
CartItems = require("./CartItems.cjsx")

FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

Voucher = React.createClass

  mixins: [FluxMixin, StoreWatchMixin("CartStore")]

  getStateFromFlux: ->
    flux = @getFlux()
    return {
      CartStore: flux.store("CartStore").getState()
      ProductsStore: flux.store("ProductsStore").getState()
    }

  render: ->
    voucherComponents = @state.CartStore.vouchers.map((voucher)=>
      return (
        <VoucherItem data={voucher} />
      )
    )
    return (
      <div>
        {voucherComponents}
      </div>
    )

module.exports = Voucher