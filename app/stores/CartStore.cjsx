Fluxxor = require("fluxxor")
constants = require("../constants/ShoppingCartConstants.cjsx")
VoucherStore = require("./VoucherStore.cjsx")
_ = require("underscore")

CartStore = Fluxxor.createStore({
  initialize: ->
    testProductsList = [
      {
        id: 18
        title: "Prod 1"
        categoryId: 1
        price: 2.45
      }
      {
        id: 45
        title: "Prod 2"
        categoryId: 2
        price: 4.99
      }
      {
        id: 56
        title: "Prod 3"
        categoryId: 6
        price: 9
      }
    ]
    @items = [
      {
        quantity: 3
        product: testProductsList[0]
      }
      {
        quantity: 19
        product: testProductsList[1]
      }
      {
        quantity: 4
        product: testProductsList[2]
      }
    ]
    @vouchers = []
    @bindActions(
      constants.ADD_ITEM, @_addItem
      constants.REMOVE_ITEM, @_removeItem
      constants.ADD_VOUCHER, @_addVoucher
      constants.REMOVE_VOUCHER, @_removeVoucher
    )

  _addItem: (payload) ->
    product = payload.product
    # find the product inside the cart
    cartProduct = _.find(@items, (cartItem)->
      return cartItem.product.id == product.id
    )
    # product already added?
    if cartProduct
      # increment quantity
      cartProduct.quantity += 1
    else
      # otherwise, add it
      @items.push({
        product: product
        quantity: 1
      })
    @emit("change")

  getTotalItems: ->
    items = @getState().items
    cartQuantities = _.map(items, (obj)->
      return obj.quantity
    )
    totalItems = _.reduce(cartQuantities, (total, num)->
      return total + num
    )
    if totalItems == undefined
      totalItems = 0
    return totalItems

  _removeItem: (payload) ->
    productId = payload.productId
    items = @items
    @items = _.reject(items, (obj)->
      return obj.product.id == productId
    )
    @emit("change")

  _addVoucher: (payload)->
    voucher = payload.voucher
    appliedVouchers = @getState().vouchers
    voucherStore = new VoucherStore()
    findVoucher = _.where(voucherStore.vouchers, {code: voucher})
    if findVoucher.length < 1
      throw new Error("The voucher you've entered is invalid")
    if voucher not in appliedVouchers and findVoucher.length > 0
      appliedVouchers.push(voucher)
    @emit("change")

  _removeVoucher: (payload)->
    voucher = payload.voucher
    appliedVouchers = @getState().vouchers
    newVouchersList = _.reject(appliedVouchers, (appliedVoucher)->
      return appliedVoucher == voucher
    )
    @vouchers = newVouchersList
    @emit("change")

  getSubTotalCost: ->
    items = @getState().items
    total = 0
    for item in items
      total += item.product.price * item.quantity
    return parseFloat(total).toFixed(2)/1

  getTotalCost: ->
    if @vouchers.length > 0
      voucherStore = new VoucherStore()
      return voucherStore.applyVoucher(@vouchers[0], @)
    else
      return @getSubTotalCost()

  getState: ->
    return {
      items: @items
      vouchers: @vouchers
    }
})

module.exports = CartStore