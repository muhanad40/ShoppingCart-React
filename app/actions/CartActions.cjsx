constants = require("../constants/ShoppingCartConstants.cjsx")

CartActions = {
  addItemToCart: (product)->
    @dispatch(constants.ADD_ITEM, {product: product})
  removeItemFromCart: (productId)->
    @dispatch(constants.REMOVE_ITEM, {productId: productId})
  addVoucherToCart: (voucher)->
    @dispatch(constants.ADD_VOUCHER, {voucher: voucher})
}

module.exports = CartActions