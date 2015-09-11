Fluxxor = require("fluxxor")
constants = require("../constants/ShoppingCartConstants.cjsx")
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
        quantity: 1
        product: testProductsList[0]
      }
      {
        quantity: 3
        product: testProductsList[1]
      }
      {
        quantity: 2
        product: testProductsList[2]
      }
    ]
    @vouchers = []
    @bindActions(
      constants.ADD_ITEM, @_addItem
      constants.REMOVE_ITEM, @_removeItem
      constants.ADD_VOUCHER, @_addVoucher
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
    vouchers = @getState().vouchers
    if voucher not in vouchers
      vouchers.push(voucher)
    @emit("change")

  getTotalCost: ->
    items = @getState().items
    total = 0
    for item in items
      total += item.product.price * item.quantity
    return total

  getState: ->
    return {
      items: @items
      vouchers: @vouchers
    }
})

module.exports = CartStore