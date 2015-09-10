constants = require("../constants/ShoppingCartConstants.cjsx")

CartActions = {
  addItemToCart: (product)->
    @dispatch(constants.ADD_ITEM, {product: product})
}

module.exports = CartActions