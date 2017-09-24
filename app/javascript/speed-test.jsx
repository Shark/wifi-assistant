import React from "react"
import Moment from "moment"

export default class SpeedTest extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      updatedAt: null,
      downloadRate: 0,
      uploadRate: 0,
      latency: 0
    }
  }

  componentDidMount() {
    const self = this

    App.cable.subscriptions.create({
      channel: 'StatusChannel',
      type: 'speed_test'
    }, {
      received: (data) => {
        self.setState({
          updatedAt: data['updated_at'],
          downloadRate: (data['download_rate'] / 1024 / 1024).toFixed(2),
          uploadRate: (data['upload_rate'] / 1024 / 1024).toFixed(2),
          latency: Math.round(data['latency'])
        })

        setInterval(this.forceUpdate.bind(this), 5000);
      }
    })
  }

  render() {
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
            <i className="fa fa-bolt" aria-hidden="true"></i>&nbsp;Speed Test&nbsp;<span className="has-text-grey-light">({updatedAtString})</span>
          </p>
        </header>
        <div className="card-content">
          <div className="content">
            <dl className="dashboard--speed-test">
              <dt><span className="icon is-medium"><i className="fa fa-2x fa-download" aria-hidden="true"></i></span></dt>
              <dd className="is-size-5">{this.state.downloadRate} MBit/s</dd>
            </dl>
            <dl className="dashboard--speed-test">
              <dt><span className="icon is-medium"><i className="fa fa-2x fa-upload" aria-hidden="true"></i></span></dt>
              <dd className="is-size-5">{this.state.uploadRate} MBit/s</dd>
            </dl>
            <dl className="dashboard--speed-test">
              <dt><span className="icon is-medium"><i className="fa fa-2x fa-clock-o" aria-hidden="true"></i></span></dt>
              <dd className="is-size-5">{this.state.latency} ms</dd>
            </dl>
          </div>
        </div>
      </div>
    )
  }
}
