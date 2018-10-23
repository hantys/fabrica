import React, { Component } from 'react'
import { Table } from 'reactstrap';
import axios from 'axios'

import RowTable from './rowTable'

const URL = "http://127.0.0.1:3000"
export default class TableProduct extends Component {
  constructor(props) {
    super(props)
    this.state = {
      cod: "Código",
      name: "Nome",
      value: "Preço",
      products: []
    }
    this.loadList()
    this.changeValue = this.changeValue.bind(this)
  }

  loadList() {
    const getProductsUrl = URL+'/products.json'
    // window.location.pathname
    axios.get(getProductsUrl).then(resp => this.setState({...this.state, products: resp.data}))
  }

  changeValue(e, id) {
    // const cod = this.state.products[index].cod
    const teste = []
    this.state.products.forEach(item => {
      if (item.id == id) {
        item.price = e.target.value
      }
      teste.push(item)
    })
    this.setState({...this.state, products: teste})
  }

  render() {
    const { cod, name, value, products } = this.state
    return(
      <Table hover bordered striped className='text-center'>
        <thead>
          <tr>
            <th>{cod}</th>
            <th>{name}</th>
            <th>{value}</th>
          </tr>
        </thead>
        <tbody>
          {products.map( p => <RowTable key={p.id} id={p.id} cod={p.cod} changeValue={this.changeValue} name={p.name} inputName='product[value]' inputId={p.id} inputValue={p.price} /> )}
        </tbody>
      </Table>
    )
  }
}