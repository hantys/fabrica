import React, { Component } from 'react'
import { Table, Button, Alert } from 'reactstrap';
import axios from 'axios'

import RowTable from './rowTable'
import If from '../../template/if'
import Loading from '../../template/loading'

const URL = window.location.origin+"/clients/"+document.getElementById('custom_product_table').getAttribute('data-id')
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
  }

  componentDidMount() {
    this.loadList()
  }

  loadList = (loading=false, order='product_name+asc', filter='') => {
    // &q%5Bs%5D=employee+desc
    // &q%5Bproduct_name_or_product_cod_cont%5D=
    const getProductsUrl = `${URL}/product_customs?q%5Bs%5D=${order}&q%5Bproduct_name_or_product_cod_cont%5D=${filter}`
    if(loading == true){
      this.setState({...this.state, hide: false})
    }
    axios.get(getProductsUrl)
    .then(resp => {
      this.setState({...this.state, products: resp.data, hide: true})
      this.state.products.map( p => document.getElementById('row-'+p.id).removeAttribute('class'))
    })
  }

  saveList = () => {
    const postProductsUrl = URL+'/product_customs_update'
    const auxList = this.state.products.filter(p => p.updated === "true")
    const updateList = {}
    auxList.map(p => (updateList[p.id] = {value: p.value}))
    axios.put(postProductsUrl, {data: updateList})
    .then(resp => this.loadList(true))
  }

  changeValue = (e, id) => {
    const newRows = []
    const row = document.getElementById('row-'+id)
    this.state.products.forEach(item => {
      if (item.id == id) {
        item.value = e.target.value > -1 ? e.target.value : 0
        row.setAttribute("class", "table-info")
        item["updated"] = "true"
      }
      newRows.push(item)
    })
    this.setState({...this.state, products: newRows})
  }

  createList = () => {
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