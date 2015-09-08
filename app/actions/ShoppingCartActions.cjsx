constants = require("../constants/ShoppingCartConstants.cjsx")

ShoppingCartActions = {
  addItemToCart: (item)->
    @dispatch(constants.ADD_ITEM, {item: item})
}

module.exports = ShoppingCartActions