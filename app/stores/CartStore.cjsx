Fluxxor = require("fluxxor")
constants = require("../constants/ShoppingCartConstants.cjsx")
_ = require("underscore")

CartStore = Fluxxor.createStore({
  initialize: ->
    @cart = []
    @bindActions(
      constants.ADD_ITEM, @addItem
    )

  addItem: (payload) ->
    product = payload.product
    cartProduct = _.find(@cart, (cartItem)->
      return cartItem.product.id == product.id
    )
    if cartProduct
      cartProduct.quantity += 1
    else
      @cart.push({
        product: product
        quantity: 1
      })
    @emit("change")

  getState: ->
    return {
      cart: @cart
    }
})

module.exports = CartStore