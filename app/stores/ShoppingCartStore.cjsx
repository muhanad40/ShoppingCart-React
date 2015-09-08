Fluxxor = require("fluxxor")
constants = require("../constants/ShoppingCartConstants.cjsx")

ShoppingCartStore = Fluxxor.createStore({
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

module.exports = ShoppingCartStore