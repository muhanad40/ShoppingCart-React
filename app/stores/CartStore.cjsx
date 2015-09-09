Fluxxor = require("fluxxor")
constants = require("../constants/ShoppingCartConstants.cjsx")

CartStore = Fluxxor.createStore({
  initialize: ->
    @cart = []

    @bindActions(
      constants.ADD_ITEM, @addItem
    )

  addItem: (payload) ->
    @cart.push({
      product: payload.product
      quantity: 1
    })
    @emit("change")

  getState: ->
    return {
      cart: @cart
    }
})

module.exports = CartStore