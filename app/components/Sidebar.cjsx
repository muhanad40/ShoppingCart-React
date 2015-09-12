React = require('react')
Fluxxor = require("fluxxor")
classnames = require("classnames")
_ = require("underscore")

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
    # get category id from GET param
    filterCategoryId = @context.router.getCurrentQuery().filter
    if filterCategoryId
      # filter param? filter listing
      flux.actions.filterProducts(filterCategoryId)
    else
      # reset listing incase it was filtered previously
      flux.actions.resetProductsListing()

    categoriesNav = _.map(flux.store("CategoryStore").getState().categories, (category, index)=>
      itemClasses = classnames({
        "active": parseInt(filterCategoryId) == category.id
      })
      return (
        <li className={itemClasses} key={index}><a href={"#/?filter="+category.id} onClick={@filterProducts}>{category.name}</a></li>
      )
    )
    
    return (
      <div className="col-xs-2">
        <strong>Categories:</strong>
        <ul className="nav nav-pills nav-stacked">
          <li className={classnames({"active": !filterCategoryId})}><a href="#/">All</a></li>
          {categoriesNav}
        </ul>
      </div>
    )

module.exports = Sidebar