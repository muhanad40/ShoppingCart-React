Fluxxor = require("fluxxor")
constants = require("../constants/ShoppingCartConstants.cjsx")

ProductsStore = Fluxxor.createStore({
  initialize: ->
    @categories = [
      {
          id: 1
          slug: "womens-footware"
          name: "Women's footwear"
      }
      {
          id: 2
          slug: "mens-footwear"
          name: "Men's footwear"
      }
      {
          id: 3
          slug: "womens-casualwear"
          name: "Women's casualwear"
      }
      {
          id: 4
          slug: "mens-casualwear"
          name: "Men's casualwear"
      }
      {
          id: 5
          slug: "womens-formalwear"
          name: "Women's formalwear"
      }
      {
          id: 6
          slug: "mens-formalwear"
          name: "Men's formalwear"
      }
    ]
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
      categories: @categories
    }
})

module.exports = ProductsStore