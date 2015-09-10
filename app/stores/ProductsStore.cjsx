Fluxxor = require("fluxxor")
constants = require("../constants/ShoppingCartConstants.cjsx")

ProductsStore = Fluxxor.createStore({
  initialize: ->
    @products = []
    @bindActions(
      constants.GET_PRODUCT, @getProduct
    )

  getProduct: (payload) ->
    @emit("change")

  getState: ->
    return {
      products: @products
    }
})

module.exports = ProductsStore