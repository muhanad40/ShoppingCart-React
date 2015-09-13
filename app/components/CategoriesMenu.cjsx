React = require('react')
classnames = require("classnames")
_ = require("underscore")
Fluxxor = require("fluxxor")

FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

CategoriesMenu = React.createClass

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

    categoriesNav = _.map(flux.store("CategoryStore").getState().categories, (category, index)=>
      itemClasses = classnames({
        "active": parseInt(filterCategoryId) == category.id
      })
      return (
        <li data-toggle="collapse" data-target="#categoriesMenu" className={itemClasses} key={index}><a href={"#/?filter="+category.id} onClick={@filterProducts}>{category.name}</a></li>
      )
    )
    return (
      <div>
        <strong>Categories:</strong>
        <ul className="nav nav-pills nav-stacked">
          <li data-toggle="collapse" data-target="#categoriesMenu" className={classnames({"active": !filterCategoryId})}><a href="#/">All</a></li>
          {categoriesNav}
        </ul>
      </div>
    )

module.exports = CategoriesMenu