Fluxxor = require("fluxxor")
constants = require("../constants/ShoppingCartConstants.cjsx")

ProductsStore = Fluxxor.createStore({
  initialize: ->
    @products = [
      {
          id: 1
          title: "Product 1"
          categoryId: 1

      }
      {
          id: 2
          title: "Product 2"
          categoryId: 2

      }
      {
          id: 3
          title: "Product 3"
          categoryId: 3

      }
    ]
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