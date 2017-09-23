import React from "react"
import Moment from "moment"

export default class Uplink extends React.Component {
  constructor() {
    super();

    this.state = {
      bars: 0,
      technology: '–',
      currentDownload: 0,
      currentUpload: 0,
      totalDownload: 0,
      totalUpload: 0
    }
  }

  componentDidMount() {
    const self = this

    App.cable.subscriptions.create({
      channel: 'StatusChannel',
      type: 'uplink_' + this.props.name
    }, {
      received: (data) => {
        self.setState({
          updatedAt: data['updated_at'],
          bars: data['bars'],
          technology: data['technology'],
          currentDownload: data['current_download'],
          currentUpload: data['current_upload'],
          totalDownload: data['total_download'],
          totalUpload: data['total_upload']
        })

        setInterval(this.forceUpdate.bind(this), 5000);
      }
    })
  }

  render() {
    var barColor;
    switch(this.state.bars) {
      case 0:
      case 1:
      case 2:
        barColor = 'is-bad'
        break
      case 3:
        barColor = 'is-avg'
        break
      case 4:
      case 5:
        barColor = 'is-good'
        break
    }

    var updatedAtString;
    if(this.state.updatedAt) {
      updatedAtString = Moment(this.state.updatedAt).fromNow()
    } else {
      updatedAtString = 'not updated'
    }

    var bars = [];
    for(var i = 0; i < 5; i++) {
      if(i < this.state.bars) {
        bars.push(<div className={`dashboard--bars-bar ${barColor}`} key={i}></div>)
      } else {
        bars.push(<div className="dashboard--bars-bar is-fill" key={i}></div>)
      }
    }

    return (
      <div className="card dashboard--card">
        <header className="card-header">
          <p className="card-header-title is-centered">
            <i className="fa fa-arrow-up"></i>&nbsp;{this.props.friendlyName} Uplink&nbsp;<span className="has-text-grey-light">({updatedAtString})</span>
          </p>
        </header>
        <div className="card-content">
          <div className="content has-text-centered">
            <div className="dashboard--bars">{bars}</div>
            <small>{this.state.technology}</small>
            <table className="table is-narrow dashboard--table">
              <tbody>
                <tr>
                  <td>Current</td>
                  <td className="has-text-centered"><i className="fa fa-download"></i>&nbsp;{this.state.currentDownload} MB&nbsp;|&nbsp;<i className="fa fa-upload"></i>&nbsp;{this.state.currentUpload} MB</td>
                </tr>
                <tr>
                  <td>Total</td>
                  <td className="has-text-centered"><i className="fa fa-download"></i>&nbsp;{this.state.totalDownload} MB&nbsp;|&nbsp;<i className="fa fa-upload"></i>&nbsp;{this.state.totalUpload} MB</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    )
  }
}
