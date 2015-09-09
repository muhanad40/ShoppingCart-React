React = require('react')
Product = require('./Product.cjsx')

ProductsComponent = React.createClass

  render: ->
    productComponents = @props.products.map((product)=>
      return (
        <Product key={product.id} details={product} />
      )
    )
    return (
      <div>
        {productComponents}
      </div>
    )

module.exports = ProductsComponent