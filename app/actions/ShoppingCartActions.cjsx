constants = require("../constants/ShoppingCartConstants.cjsx")

ShoppingCartActions = {
  addItemToCart: (product)->
    @dispatch(constants.ADD_ITEM, {product: product})
}

module.exports = ShoppingCartActions