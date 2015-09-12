Fluxxor = require("fluxxor")
constants = require("../constants/ShoppingCartConstants.cjsx")
_ = require("underscore")

ProductsStore = Fluxxor.createStore({
  initialize: ->
    @products = [
      {
        id: 1
        title: "Almond Toe Court Shoes, Patent Blac"
        categoryId: 1
        price: {
          before: null
          now: 99
        }
        stock: 5
      }
      {
        id: 2
        title: "Suede Shoes, Blue"
        categoryId: 1
        price: {
          before: null
          now: 42
        }
        stock: 4
      }
      {
        id: 3
        title: "Leather Driver Saddle Loafers, Tan"
        categoryId: 2
        price: {
          before: null
          now: 34
        }
        stock: 12
      }
      {
        id: 4
        title: "Flip Flops, Red"
        categoryId: 2
        price: {
          before: null
          now: 19
        }
        stock: 6
      }
      {
        id: 5
        title: "Flip Flops, Blue"
        categoryId: 2
        price: {
          before: null
          now: 19
        }
        stock: 0
      }
      {
        id: 6
        title: "Gold Button Cardigan, Black"
        categoryId: 2
        price: {
          before: null
          now: 167
        }
        stock: 6
      }
      {
        id: 7
        title: "Cotton Shorts, Medium Red"
        categoryId: 2
        price: {
          before: null
          now: 30
        }
        stock: 5
      }
      {
        id: 8
        title: "Fine Stripe Short Sleeve Shirt, Grey"
        categoryId: 4
        price: {
          before: null
          now: 49.99
        }
        stock: 9
      }
      {
        id: 9
        title: "Fine Stripe Short Sleeve Shirt, Green"
        categoryId: 4
        price: {
          before: 49.99
          now: 39.99
        }
        stock: 3
      }
      {
        id: 10
        title: "Sharkskin Waistcoat, Charcoal"
        categoryId: 6
        price: {
          before: null
          now: 75
        }
        stock: 2
      }
      {
        id: 11
        title: "Lightweight Patch Pocket Blazer, Deer"
        categoryId: 6
        price: {
          before: null
          now: 175.50
        }
        stock: 1
      }
      {
        id: 12
        title: "Bird Print Dress, Black"
        categoryId: 5
        price: {
          before: null
          now: 270
        }
        stock: 10
      }
      {
        id: 13
        title: "Mid Twist Cut­Out Dress, Pink"
        categoryId: 5
        price: {
          before: null
          now: 540
        }
        stock: 5
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