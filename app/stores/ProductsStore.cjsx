Fluxxor = require("fluxxor")

ProductsStore = Fluxxor.createStore({
  initialize: ->
    @products = [
      {
          id: 1
          title: "Product 1"
          categoryId: 1
          price: 2.45
      }
      {
          id: 2
          title: "Product 2"
          categoryId: 2
          price: 4.99
      }
      {
          id: 3
          title: "Product 3"
          categoryId: 3
          price: 9
      }
    ]

  getState: ->
    return {
      products: @products
    }
})

module.exports = ProductsStore