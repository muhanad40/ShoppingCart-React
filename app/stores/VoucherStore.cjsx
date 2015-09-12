Fluxxor = require("fluxxor")
_ = require("underscore")

VoucherStore = Fluxxor.createStore({
  initialize: ->
    @vouchers = [
      {
        id: 1
        code: "DELOITTE2015"
        rules: []
        discount: 5.00
      }
      {
        id: 2
        code: "RABBIT9"
        rules: [
          {minTotal: 50.01}
        ]
        discount: 10.00
      }
      {
        id: 3
        code: "FOOT15"
        rules: [
          {minTotal: 75.01}
          {categoryIds: [1,2]}
        ]
        discount: 15.00
      }
    ]

  applyVoucher: (voucher, cartStore)->
    voucher = @_getVoucher(voucher)
    amount = cartStore.getSubTotalCost()
    if voucher.rules.length > 0
      # go through each rule, if false return sub-total amount without any deductions
      for rule in voucher.rules
        # RULE: Don't deduct if amount is less than required minimum
        if rule.hasOwnProperty("minTotal") and rule.minTotal > amount
          return amount
        # RULE: Don't deduct if none of the products belong to a required category
        if rule.hasOwnProperty("categoryIds") and rule.categoryIds
          results = _.map(cartStore.getState().items, (itemObj)->
            return itemObj.product.categoryId in rule.categoryIds
          )
          # if no items belong to any of the required categories, return sub-total amount
          if !_.some(results)
            return amount
    return parseFloat(amount - voucher.discount).toFixed(2)/1

  _getVoucher: (voucher)->
    return _.find(@vouchers, (voucherObj)->
      voucherObj.code == voucher
    )

  getState: ->
    return {
      vouchers: @vouchers
    }
})

module.exports = VoucherStore