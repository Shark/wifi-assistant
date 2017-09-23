import React from "react"
import Moment from "moment"

export default class ConnectionStatus extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      updatedAt: null,
      isWorking: false,
      uplinkName: '–'
    }
  }

  componentDidMount() {
    const self = this

    App.cable.subscriptions.create({
      channel: 'StatusChannel',
      type: 'connection'
    }, {
      received: (data) => {
        self.setState({
          updatedAt: data['updated_at'],
          isWorking: data['is_working'],
          uplinkName: data['uplink_name']
        })

        setInterval(this.forceUpdate.bind(this), 5000);
      }
    })
  }

  render() {
    var iconClass, colorClass
    if(this.state.isWorking) {
      iconClass = 'fa-thumbs-o-up'
      colorClass = 'has-text-success'
    } else {
      iconClass = 'fa-thumbs-o-down'
      colorClass = 'has-text-danger'
    }

    var updatedAtString;
    if(this.state.updatedAt) {
      updatedAtString = Moment(this.state.updatedAt).fromNow()
    } else {
      updatedAtString = 'not updated'
    }

    return (
      <div className="card dashboard--card">
        <header className="card-header">
          <p className="card-header-title is-centered">
            <i className="fa fa-question-circle-o" aria-hidden="true"></i>&nbsp;Connection Status&nbsp;<span className="has-text-grey-light">({updatedAtString})</span>
          </p>
        </header>
        <div className="card-content">
          <div className="content">
            <p className="has-text-centered">
              <span className={`icon is-large ${colorClass}`}>
                <i className={`fa fa-3x ${iconClass}`} aria-hidden="true"></i>
              </span>
            </p>
            <p className="has-text-centered">{this.state.uplinkName}</p>
          </div>
        </div>
      </div>
    )
  }
}
