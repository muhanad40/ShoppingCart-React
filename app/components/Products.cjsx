React = require('react')
Product = require('./Product.cjsx')

ProductsComponent = React.createClass

  render: ->
    productComponents = @props.products.map((product, index)=>
      return (
        <Product key={index} details={product} />
      )
    )
    return (
      <div>
        {productComponents}
      </div>
    )

module.exports = ProductsComponent