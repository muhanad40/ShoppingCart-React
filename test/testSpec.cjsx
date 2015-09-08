React = require("react/addons")
HomeComponent = require("../app/components/Home.cjsx")
Fluxxor = require("fluxxor")
TestUtils = React.addons.TestUtils

ShoppingCartActions = require("../app/actions/ShoppingCartActions.cjsx")
ShoppingCartStore = require("../app/stores/ShoppingCartStore.cjsx")
stores = {
  ShoppingCartStore: new ShoppingCartStore()
}
flux = new Fluxxor.Flux(stores, ShoppingCartActions);

describe("Component", ->
  component = null

  beforeEach(->
    component = TestUtils.renderIntoDocument(<HomeComponent flux={flux} />)
  )
  
  it("should be blah", ->
    expect(component.getDOMNode().textContent).toEqual("Add to Cart")
  )
)