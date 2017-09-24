import React from "react"
import Moment from "moment"

export default class Location extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      updatedAt: null,
      lat: 0,
      lon: 0
    }
  }

  componentDidMount() {
    const self = this

    App.cable.subscriptions.create({
      channel: 'StatusChannel',
      type: 'location'
    }, {
      received: (data) => {
        self.setState({
          updatedAt: data['updated_at'],
          lat: data['lat'].toFixed(5),
          lon: data['lon'].toFixed(5)
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
            <i className="fa fa-location-arrow" aria-hidden="true"></i>&nbsp;Location&nbsp;<span className="has-text-grey-light">({updatedAtString})</span>
          </p>
        </header>
        <div className="card-content">
          <div className="content">
            <p className="has-text-centered"><span className="is-size-5">{this.state.lat}</span><br/><span className="is-size-7">Latitude</span></p>
            <p className="has-text-centered"><span className="is-size-5">{this.state.lon}</span><br/><span className="is-size-7">Longitude</span></p>
          </div>
        </div>
      </div>
    )
  }
}
