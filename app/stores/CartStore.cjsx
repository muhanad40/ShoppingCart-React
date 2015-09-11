Fluxxor = require("fluxxor")
constants = require("../constants/ShoppingCartConstants.cjsx")
_ = require("underscore")

CartStore = Fluxxor.createStore({
  initialize: ->
    @items = []
    @bindActions(
      constants.ADD_ITEM, @addItem
    )

  addItem: (payload) ->
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

  getState: ->
    return {
      items: @items
    }
})

module.exports = CartStore