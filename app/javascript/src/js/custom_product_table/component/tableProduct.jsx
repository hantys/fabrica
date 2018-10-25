import React, { Component } from 'react'
import { Table, Button, Alert } from 'reactstrap';
import axios from 'axios'

import RowTable from './rowTable'
import If from '../../template/if'
import Loading from '../../template/loading'

const URL = "http://127.0.0.1:3000"+window.location.pathname
export default class TableProduct extends Component {
  constructor(props) {
    super(props)
    this.state = {
      cod: "Código",
      name: "Nome",
      value: "Preço",
      products: [],
      hide: false,
      visible: false
    }
    this.changeValue = this.changeValue.bind(this)
    this.createList = this.createList.bind(this)
    this.loadList = this.loadList.bind(this)
    this.saveList = this.saveList.bind(this)

    this.loadList()
  }

  loadList() {
    const getProductsUrl = URL+'/product_customs'
    // window.location.pathname
    axios.get(getProductsUrl).then(resp => this.setState({...this.state, products: resp.data, hide: true}))
  }

  saveList() {
    const updateList = this.state.products.filter(p => p.updated === "true")
    console.log(updateList)
  }

  changeValue(e, id) {
    // const cod = this.state.products[index].cod
    const teste = []
    const row = document.getElementById('row-'+id)
    this.state.products.forEach(item => {
      if (item.id == id) {
        item.value = e.target.value > -1 ? e.target.value : 0
        row.setAttribute("class", "table-info")
        item["updated"] = "true"
      }
      teste.push(item)
    })
    this.setState({...this.state, products: teste})
  }

  createList() {
    const getCreateListUrl = URL+'/create_product_customs'
    this.setState({...this.state,hide: false})
    axios.get(getCreateListUrl).then(resp => this.setState({...this.state, products: resp.data, hide: true, visible: true})).then(resp => setTimeout(() => (this.setState({...this.state, visible: false})), 2000))
  }

  render() {
    const { cod, name, value, products, hide, visible } = this.state
    return(
      <div >
        <Alert className='text-center' color="success" isOpen={visible} toggle={this.onDismiss}>
          Tabela personalizada criada com sucesso!
        </Alert>
        <Loading test={hide == false} />
        <If test={hide == true && products.length == 0}>
          <div className="w-100 d-flex justify-content-center">
            <Button color="info" onClick={this.createList} className='mb-2 float-right'>Gerar tabela</Button>
          </div>
        </If>
        <If test={!products.length == 0}>
          <Button color="success" className='mb-2 float-right' onClick={this.saveList}>Salvar</Button>
          <Table hover bordered striped className='text-center'>
            <thead>
              <tr>
                <th>{cod}</th>
                <th>{name}</th>
                <th>{value}</th>
              </tr>
            </thead>
            <tbody>
              {products.map( p => <RowTable key={p.id} id={p.id} cod={p.product.cod} changeValue={this.changeValue} name={p.product.name} inputName='value' inputId={`product-custom-${p.id}`} inputValue={p.value} /> )}
            </tbody>
          </Table>
          <Button className="float-right" color="success" onClick={this.saveList}>Salvar</Button>
        </If>
      </div>
    )
  }
}