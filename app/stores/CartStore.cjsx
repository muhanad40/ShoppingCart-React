Fluxxor = require("fluxxor")
constants = require("../constants/ShoppingCartConstants.cjsx")
_ = require("underscore")

CartStore = Fluxxor.createStore({
  initialize: ->
    @items = []
    @bindActions(
      constants.ADD_ITEM, @_addItem
      constants.REMOVE_ITEM, @_removeItem
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

  getTotalCost: ->
    items = @getState().items
    total = 0
    for item in items
      total += item.product.price * item.quantity
    return total

  getState: ->
    return {
      items: @items
    }
})

module.exports = CartStore