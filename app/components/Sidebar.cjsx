React = require('react')
Fluxxor = require("fluxxor")
classnames = require("classnames")
_ = require("underscore")
CategoriesMenu = require("./CategoriesMenu.cjsx")

FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

Sidebar = React.createClass

  mixins: [FluxMixin, StoreWatchMixin("CategoryStore")]

  contextTypes: {
    router: React.PropTypes.func
  }

  getStateFromFlux: ->
    flux = @getFlux()
    return {
      ProductsStore: flux.store("ProductsStore").getState()
    }

  render: ->
    flux = @getFlux()
    filterCategoryId = @context.router.getCurrentQuery().filter
    if filterCategoryId
      flux.actions.filterProducts(filterCategoryId)
    else
      flux.actions.resetProductsListing()
    
    return (
      <div className="col-sm-3 col-md-3 col-lg-2 hidden-xs">
        <CategoriesMenu />
      </div>
    )

module.exports = Sidebar