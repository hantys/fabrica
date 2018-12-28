// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import TableProduct from './component/tableProduct'


if (document.getElementById('custom_product_table')) {

  document.addEventListener('DOMContentLoaded', () => {
    ReactDOM.render(
      <TableProduct />,
      document.getElementById('custom_product_table'),
      )
    })
} else {
  console.log('elemtento não existe')
}

// https://www.npmjs.com/package/react-currency-format