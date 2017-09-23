import React from 'react'
import ReactDOM from 'react-dom'

import ConnectionStatus from 'connection-status'
import Uplink from 'uplink'

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <section id="dashboard">
      <div className="columns">
        <div className="column"><ConnectionStatus /></div>
        <div className="column"><Uplink name="telekom" friendlyName="Telekom" /></div>
        <div className="column"><Uplink name="vodafone" friendlyName="Vodafone" /></div>
      </div>
    </section>,
    document.body.appendChild(document.createElement('div')),
  )
})
