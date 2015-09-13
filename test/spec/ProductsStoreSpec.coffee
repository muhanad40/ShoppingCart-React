React = require("react/addons")
Fluxxor = require("fluxxor")
TestUtils = React.addons.TestUtils

CartActions = require("../../app/actions/CartActions.cjsx")
ProductsStore = require("../../app/stores/ProductsStore.cjsx")
CartStore = require("../../app/stores/CartStore.cjsx")
VoucherStore = require("../../app/stores/VoucherStore.cjsx")

stores = {
  CartStore: new CartStore()
  ProductsStore: new ProductsStore()
  VoucherStore: new VoucherStore()
}
flux = new Fluxxor.Flux(stores, CartActions)

testProductsList = [
  {
    id: 1
    title: "Almond Toe Court Shoes, Patent Blac"
    categoryId: 1
    price: {
      before: null
      now: 99
    }
    stock: 2
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
]

describe("ProductsStore", ->

  beforeEach(->
    stores.ProductsStore.products = testProductsList
  )

  it("should filter products by category ID", ->
    filterCategoryId = 2
    flux.actions.filterProducts(filterCategoryId)
    expectedProductsList = [
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
    ]
    productsList = stores.ProductsStore.getState().products
    expect(productsList).toEqual(expectedProductsList)
  )

  it("should return empty list if no product is found in a given category", ->
    filterCategoryId = 4563
    flux.actions.filterProducts(filterCategoryId)
    productsList = stores.ProductsStore.getState().products
    expect(productsList).toEqual([])
  )
  
)