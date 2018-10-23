import React from 'react'
import { Input } from 'reactstrap';


export default props => (
  <tr>
    <th scope="row">{props.cod}</th>
    <td>{props.name}</td>
    <td>
      <Input className='text-center' onChange={(e) => props.changeValue(e, props.id)} type="number" name={props.inputName} id={props.inputId} value={props.inputValue} />
    </td>
  </tr>
)
