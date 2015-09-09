React = require("react/addons")
Fluxxor = require("fluxxor")
TestUtils = React.addons.TestUtils

AppPath = "../../app/"

ShoppingCartActions = require("#{AppPath}actions/ShoppingCartActions.cjsx")
ProductsStore = require("#{AppPath}stores/ProductsStore.cjsx")
CartStore = require("#{AppPath}stores/CartStore.cjsx")
stores = {
  CartStore: new CartStore()
  ProductsStore: new ProductsStore()
}
flux = new Fluxxor.Flux(stores, ShoppingCartActions);

describe("Product component", ->
  AppComponent = null

  beforeEach(->

    @Components = {
      "Products": require("#{AppPath}components/Products.cjsx")
      "Product": require("#{AppPath}components/Product.cjsx")
    }

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
    @RenderedProducts = TestUtils.renderIntoDocument(<@Components.Products products={@productsList} />)
  )
  
  it("should render list of products", ->
    products = TestUtils.scryRenderedComponentsWithType(@RenderedProducts, @Components.Product)
    expect(products[0].getDOMNode().textContent).toMatch(@productsList[0].title)
    expect(products[1].getDOMNode().textContent).toMatch(@productsList[1].title)
    expect(products[2].getDOMNode().textContent).toMatch(@productsList[2].title)
    expect(products.length).toEqual(@productsList.length)
  )


)