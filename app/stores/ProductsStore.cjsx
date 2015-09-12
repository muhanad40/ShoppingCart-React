Fluxxor = require("fluxxor")
constants = require("../constants/ShoppingCartConstants.cjsx")
_ = require("underscore")

ProductsStore = Fluxxor.createStore({
  initialize: ->
    @products = [
      {
          id: 1
          title: "Product 1"
          categoryId: 1
          price: 2.45
          stock: 5
      }
      {
          id: 2
          title: "Product 2"
          categoryId: 2
          price: 4.99
          stock: 34
      }
      {
          id: 3
          title: "Product 3"
          categoryId: 3
          price: 9
          stock: 7
      }
      {
          id: 4
          title: "Product 4"
          categoryId: 3
          price: 9
          stock: 0
      }
    ]
    @filteredProducts = []
    @filteredMode = false
    @bindActions(
      constants.FILTER_PRODUCTS, @_filterProducts
      constants.RESET_PRODUCTS_LISTING, @_resetProductsListing
    )

  _filterProducts: (payload)->
    categoryId = parseInt(payload.categoryId)
    @filteredMode = true
    @filteredProducts = _.filter(@products, (productObj)->
      return productObj.categoryId == categoryId
    )
    @emit("change")

  _resetProductsListing: ->
    @filteredMode = false

  getState: ->
    if @filteredMode == true
      products = @filteredProducts
    else
      products = @products
    return {
      products: products
    }
})

module.exports = ProductsStore