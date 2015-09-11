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
    price: 2.45
  }
  {
    id: 45
    title: "Prod 2"
    categoryId: 2
    price: 4.99
  }
  {
    id: 56
    title: "Prod 3"
    categoryId: 6
    price: 9
  }
]

describe("CartStore", ->

  beforeEach(->
    # empty the cart
    stores.CartStore.items = []
  )

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
    cartItems = stores.CartStore.getState().items
    expect(cartItems).toEqual(expectedCartItems)
  )

  it("should increment an item's quantity if it's already in the cart", ->
    flux.actions.addItemToCart(testProductsList[0])
    flux.actions.addItemToCart(testProductsList[2])
    flux.actions.addItemToCart(testProductsList[2])
    expectedCartItems = [
      {
        product: testProductsList[0]
        quantity: 1
      }
      {
        product: testProductsList[2]
        quantity: 2
      }
    ]
    cartItems = stores.CartStore.getState().items
    expect(cartItems).toEqual(expectedCartItems)
  )

  it("should return total number of items in the cart", ->
    flux.actions.addItemToCart(testProductsList[0])
    flux.actions.addItemToCart(testProductsList[1])
    flux.actions.addItemToCart(testProductsList[2])
    flux.actions.addItemToCart(testProductsList[2])
    expectedTotalCartItems = 4
    totalCartItems = stores.CartStore.getTotalItems()
    expect(totalCartItems).toEqual(expectedTotalCartItems)
  )

  it("should remove an item from the cart", ->
    cartItems = [
      {
        quantity: 1
        product: testProductsList[0]
      }
      {
        quantity: 1
        product: testProductsList[1]
      }
      {
        quantity: 1
        product: testProductsList[2]
      }
      {
        quantity: 1
        product: testProductsList[2]
      }
    ]
    stores.CartStore.items = cartItems
    productIdToRemove = testProductsList[2].id
    expectedTotalCartItems = 2
    flux.actions.removeItemFromCart(productIdToRemove)
    totalCartItems = stores.CartStore.getTotalItems()
    expect(totalCartItems).toEqual(expectedTotalCartItems)
  )

  it("should calculate the total cost of the items", ->
    cartItems = [
      {
        quantity: 1
        product: testProductsList[0]
      }
      {
        quantity: 3
        product: testProductsList[1]
      }
      {
        quantity: 2
        product: testProductsList[2]
      }
    ]
    stores.CartStore.items = cartItems
    expectedCartTotalCost = 35.42
    totalCartItems = stores.CartStore.getTotalCost()
    expect(totalCartItems).toEqual(expectedCartTotalCost)
  )

)
