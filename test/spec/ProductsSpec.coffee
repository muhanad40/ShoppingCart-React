React = require("react/addons")
Fluxxor = require("fluxxor")
TestUtils = React.addons.TestUtils

CartActions = require("../../app/actions/CartActions.cjsx")
ProductsStore = require("../../app/stores/ProductsStore.cjsx")
CartStore = require("../../app/stores/CartStore.cjsx")
stores = {
  CartStore: new CartStore()
  ProductsStore: new ProductsStore()
}
flux = new Fluxxor.Flux(stores, CartActions)

testProductsList = [
  {
    id: 18
    title: "Prod 1"
    categoryId: 1
  }
  {
    id: 45
    title: "Prod 2"
    categoryId: 2
  }
  {
    id: 56
    title: "Prod 3"
    categoryId: 6
  }
]

describe("CartStore", ->
  it("should add a product to the cart", ->
    flux.actions.addItemToCart(testProductsList[0])
    flux.actions.addItemToCart(testProductsList[2])
    expectedCartItems = [
      {
        product: testProductsList[0]
        quantity: 1
      }
      {
        product: testProductsList[2]
        quantity: 1
      }
    ]
    cartItems = stores.CartStore.getState().cart
    expect(cartItems).toEqual(expectedCartItems)
  )
)
