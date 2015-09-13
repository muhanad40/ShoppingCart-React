Fluxxor = require("fluxxor")
constants = require("../constants/ShoppingCartConstants.cjsx")
_ = require("underscore")

ProductsStore = Fluxxor.createStore({
  initialize: ->
    @products = [
      {
        id: 1
        title: "Almond Toe Court Shoes, Patent Blac"
        pictureFilename: "almond-toe-court-shoes-patent-blac.jpg"
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
        pictureFilename: "suede-shoes-blue.png"
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
        pictureFilename: "leather-driver-saddle-loafers.jpeg"
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
        pictureFilename: "red-flip-flops.jpg"
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
        pictureFilename: "blue-flip-flops.jpg"
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
        pictureFilename: "gold-button-cardigan-black.jpg"
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
        pictureFilename: "cotton-shorts-medium-red.jpeg"
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
        pictureFilename: "fine-stripe-short-sleeve-shirt-grey.jpg"
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
        pictureFilename: "fine-stripe-short-sleeve-shirt-green.jpeg"
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
        pictureFilename: "sharkskin-waistcoat-charcoal.jpg"
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
        pictureFilename: "lightweight-patch-pocket-blazer-deer.jpeg"
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
        pictureFilename: "bird-print-dress-black.jpeg"
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
        pictureFilename: "mid-twist-cutout-dress-pink.jpeg"
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

  getPicturesDir: ->
    return "/img/"

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