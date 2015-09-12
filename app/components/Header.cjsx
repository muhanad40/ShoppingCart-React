React = require('react')
Fluxxor = require("fluxxor")
CartWidget = require("./CartWidget.cjsx")
CategoriesMenu = require("./CategoriesMenu.cjsx")

FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

Header = React.createClass

  mixins: [FluxMixin, StoreWatchMixin("CartStore")]

  getStateFromFlux: ->
    flux = @getFlux()
    return {
      CartStore: flux.store("CartStore").getState()
    }

  render: ->
    return (


      <nav className="navbar navbar-default">
        <div className="container-fluid">
          <div className="navbar-header">
            <button type="button" className="navbar-toggle collapsed" data-toggle="collapse" data-target="#categoriesMenu" aria-expanded="false">
              <span className="sr-only">Toggle navigation</span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
            </button>
            <a className="navbar-brand" href="/#/">Store.com</a>
          </div>
          <div className="nav navbar-nav navbar-right hidden-xs">
            <CartWidget />
          </div>

          <div className="collapse navbar-collapse" id="categoriesMenu">
            <div className="visible-xs">
              <CartWidget />
              <CategoriesMenu />
            </div>
          </div>
        </div>
      </nav>
    )

module.exports = Header