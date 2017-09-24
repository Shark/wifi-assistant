import React from 'react'
import ReactDOM from 'react-dom'

import ConnectionStatus from 'connection-status'
import Uplink from 'uplink'
import SpeedTest from 'speed-test'
import Location from 'location'

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <section id="dashboard">
      <div className="columns">
        <div className="column"><ConnectionStatus /></div>
        <div className="column"><Uplink name="telekom" friendlyName="Telekom" /></div>
        <div className="column"><Uplink name="vodafone" friendlyName="Vodafone" /></div>
      </div>
      <div className="columns">
        <div className="column"><SpeedTest /></div>
        <div className="column"><Location /></div>
        <div className="column"></div>
      </div>
    </section>,
    document.body.appendChild(document.createElement('div')),
  )
})
