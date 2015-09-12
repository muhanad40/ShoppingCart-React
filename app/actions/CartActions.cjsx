constants = require("../constants/ShoppingCartConstants.cjsx")

CartActions = {
  addItemToCart: (product)->
    @dispatch(constants.ADD_ITEM, {product: product})
  removeItemFromCart: (productId)->
    @dispatch(constants.REMOVE_ITEM, {productId: productId})
  addVoucherToCart: (voucher)->
    @dispatch(constants.ADD_VOUCHER, {voucher: voucher})
  removeVoucherFromCart: (voucher)->
    @dispatch(constants.REMOVE_VOUCHER, {voucher: voucher})
  filterProducts: (categoryId)->
    @dispatch(constants.FILTER_PRODUCTS, {categoryId: categoryId})
  resetProductsListing: ->
    @dispatch(constants.RESET_PRODUCTS_LISTING)
}

module.exports = CartActions