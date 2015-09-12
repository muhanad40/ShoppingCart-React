React = require('react')
Router = require("react-router")
RouteHandler = Router.RouteHandler
Fluxxor = require("fluxxor")
CartActions = require("../actions/CartActions.cjsx")
CartStore = require("../stores/CartStore.cjsx")
ProductsStore = require("../stores/ProductsStore.cjsx")
CategoryStore = require("../stores/CategoryStore.cjsx")
CartWidget = require("./CartWidget.cjsx")
_ = require("underscore")
classnames = require("classnames")

stores = {
  CartStore: new CartStore()
  ProductsStore: new ProductsStore()
  CategoryStore: new CategoryStore()
}

flux = new Fluxxor.Flux(stores, CartActions);
App = React.createClass

  contextTypes: {
    router: React.PropTypes.func
  }

  render:->
    filterCategoryId = @context.router.getCurrentQuery().filter
    if filterCategoryId
      flux.actions.filterProducts(filterCategoryId)
    else
      flux.actions.resetProductsListing()

    categoriesNav = _.map(stores.CategoryStore.getState().categories, (category, index)=>
      itemClasses = classnames({
        "active": parseInt(filterCategoryId) == category.id
      })
      return (
        <li className={itemClasses} key={index}><a href={"#/?filter="+category.id} onClick={@filterProducts}>{category.name}</a></li>
      )
    )
    return (
      <div className="col-xs-12" style={{"marginTop": '15px'}}>
        <nav className="navbar navbar-default">
          <div className="container-fluid">
            <div className="nav navbar-nav navbar-right">
              <CartWidget flux={flux} />
            </div>
            <div className="navbar-header">
              <a className="navbar-brand" href="#">
                Store.com
              </a>
            </div>
          </div>
        </nav>
        <div className="col-xs-2">
          <strong>Categories:</strong>
          <ul className="nav nav-pills nav-stacked">
            <li className={classnames({"active": !filterCategoryId})}><a href="#/">All</a></li>
            {categoriesNav}
          </ul>
        </div>
        <RouteHandler flux={flux} />
      </div>
    )

module.exports = App