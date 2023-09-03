// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annOTated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    this.apiKey = this.data.get("apiKey")
    this.sessionId = this.data.get("sessionId")
    this.token = this.data.get("token")
    this.initializeSession()

  this.broadcastOptions = {
    outputs: {
      hls: {},
      rtmp: [
        {
          id: "foo",
          serverUrl: "rtmp://myfooserver/myfooapp",
          streamName: "myfoostream",
        },
        {
          id: "bar",
          serverUrl: "rtmp://mybarserver/mybarapp",
          streamName: "mybarstream",
        },
      ],
    },
    maxDuration: 5400,
    resolution: "640x480",
    layout: {
      type: "verticalPresentation",
    },
  };
  }

  disconnect() {
    if(this.session){
      this.session.disconnect()
    }
  }

  initializeSession(){
    this.session = OT.initSession(this.apiKey, this.sessionId)

    this.session.on('streamCreated', this.streamCreated.bind(this))
    console.log(this.data.get("userId"))
    if(this.data.get("userId")==1){
      this.publisher = OT.initPublisher(this.element,{
        insertMode: 'append',
        width: '100%',
        height: '100%',
        name: this.data.get("name")
      }, this.handleError.bind(this))
    }

    this.session.connect(this.token,this.streamConnected.bind(this))
  }

  streamConnected(error){
    if(error){
      console.error(error.message)
    }
    else{
      if(this.data.get("userId")==1){
        this.session.publish(this.publisher, this.handleError.bind(this))
      }
    }
  }

  streamCreated(event){
    this.session.subscribe(event.stream, this.element ,{
      insertMode: 'append',
      width: '100%',
      height: '100%',
    }, this.handleError.bind(this))
  }

  handleError(error){
    if(error){
      console.error(error.message)
    }
  }

}
