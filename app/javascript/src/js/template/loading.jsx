import React from 'react'
import If from './if'
export default props => {
  if(props.test) {
    return (
      <If test={props.test}>
        <div className="w-100 d-flex justify-content-center">
          <div className="reverse-spinner"></div>
        </div>
      </If>
    )
  } else {
    return false
  }
}

