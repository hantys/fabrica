// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

const Hello = props => (
  <div>
    Hello {props.name}, {props.teste} e {props.id}!
  </div>
)

Hello.defaultProps = {
  name: 'David',
  teste: 'testando react',
  id: '12321'
}

Hello.propTypes = {
  name: PropTypes.string
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Hello />,
    document.getElementById('budget_search').appendChild(document.createElement('div')),
  )
})


// https://www.npmjs.com/package/react-currency-format