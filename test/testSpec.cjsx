React = require("react/addons")
Products = require("../app/components/Products.cjsx")
Product = require("../app/components/Product.cjsx")
Fluxxor = require("fluxxor")
TestUtils = React.addons.TestUtils

ShoppingCartActions = require("../app/actions/ShoppingCartActions.cjsx")
ProductsStore = require("../app/stores/ProductsStore.cjsx")
CartStore = require("../app/stores/CartStore.cjsx")
stores = {
  CartStore: new CartStore()
  ProductsStore: new ProductsStore()
}
flux = new Fluxxor.Flux(stores, ShoppingCartActions);

describe("App", ->
  AppComponent = null

  beforeEach(->
    @productsList = [
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
    Products = TestUtils.renderIntoDocument(<Products products={@productsList} />)
  )
  
  it("should render list of products", ->
    products = TestUtils.scryRenderedComponentsWithType(Products, Product)
    expect(products.length).toEqual(@productsList.length)
  )
)