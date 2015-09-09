Fluxxor = require("fluxxor")
constants = require("../constants/ShoppingCartConstants.cjsx")

CartStore = Fluxxor.createStore({
  initialize: ->
    @cart = []

    @bindActions(
      constants.ADD_ITEM, @addItem
    )

  addItem: (payload) ->
    @emit("change")

  getState: ->
    return {
      cart: @cart
    }
})

module.exports = CartStore