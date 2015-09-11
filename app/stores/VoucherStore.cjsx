Fluxxor = require("fluxxor")

VoucherStore = Fluxxor.createStore({
  initialize: ->
    @vouchers = [
      {
          id: 1
          code: "DELOITTE2015"
          rules: []
      }
    ]

  getState: ->
    return {
      vouchers: @vouchers
    }
})

module.exports = VoucherStore