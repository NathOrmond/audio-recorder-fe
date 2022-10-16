<template>
    <div class="container">

      <div
      v-if="state === State.PRIOR" 
      class="record_container">
        <AppButton 
          label="Start Recording"
          alt_text="Click button to begin recording"
          @handleClicked="recordClicked"
        />
      </div>

      <div 
      v-if="state === State.RECORDING" 
      class="recording_container"
      >  
        <AppButton 
        label="Stop Recording"
        alt_text="Click button to stop recording"
        @handleClicked="stopClicked"
        />
      </div>


      <div 
      v-if="state === State.POST" 
      class="stats_container"
      >  
        <div>
          <!-- Display response: Duration, sample rate etc. -->
          <h1>RESPONSE:</h1>
          <div 
          v-if="response === undefined"
          >
            <h2>Awaiting...</h2>
          </div>
          <div 
          v-if="response !== undefined"
          >
            <h2>{{response.data}}</h2>
          </div>      
        </div> 

        <div>
          <AppButton 
            label="Reset"
            alt_text="Click button if finished reviewing stats"
            @handleClicked="finishClicked"
          />
          <nuxt-link class="nav_element" to="/">
            <span>Home</span>
          </nuxt-link>
        </div>

      </div>

    </div>
  </template>
  
  <script>
import AppButton from '../../components/common/AppButton.vue';
import axios from 'axios';
import urls from '../../resources/endpoints.json'

const State = Object.freeze({ PRIOR: 1, RECORDING: 2, POST: 3 });

  export default {
    components: {
      AppButton
    },
    async onMounted() {
      console.log('Mounted!')
    },
    methods: {
      getAudioMediaDevices: async function(){ 
        if((!this.hasAudioPermissions) || (this.streamBeingCaptured === undefined)){ 
          try {
            if (!(navigator.mediaDevices && navigator.mediaDevices.getUserMedia)) throw new Error(this.userMediaErrorMessage);
            this.streamBeingCaptured = await navigator.mediaDevices.getUserMedia({ audio: true });
          } catch(e) { 
            console.log(e)
            if (e.message.includes(this.userMediaErrorMessage)) {       
                    console.log("To record audio, use browsers like Chrome and Firefox.");
            }
          }
        }
      },
      createMediaRecorder: function(){ 
        try { 
          this.mediaRecorder = new MediaRecorder(this.streamBeingCaptured);     
          this.mediaRecorder.ondataavailable = (e) => {
              this.audioBlobs.push(e.data);
              this.isDataAvailable = true;
          };
          this.mediaRecorder.onstart = () => {
            console.log('Media Recorder Started!');
            this.isDataAvailable = false;
          }
          this.mediaRecorder.onstop = () => { 
            console.log('Media Recorder Stopped');
          }
        } catch(e) { 
          console.log(e);
        }
      },
      startAudioRecorder: function(){ 
        try { 
          if(this.mediaRecorder !== undefined) this.mediaRecorder.start();
        } catch(e) { 
          console.log(e);
        }
      },
      stopAudioRecorder: async function(){ 
        try { 
          if(this.mediaRecorder !== undefined) this.mediaRecorder.stop();
        } catch(e){ 
          console.log(e);
        }
      },
      blobToBase64: function(blob) {
        return new Promise((resolve, _) => {
          const reader = new FileReader();
          reader.onloadend = () => resolve(reader.result);
          reader.readAsDataURL(blob);
        });
      },
      /**
      * Begin recording audio here 
      * Record audio in browser
      */
      recordClicked: async function() {
        this.state = State.RECORDING;
        if(this.mediaRecorder === undefined){
          await this.getAudioMediaDevices();
          this.createMediaRecorder();
        }
        this.startAudioRecorder();        
      }, 
      /**
      * Stop recording audio here 
      * Stop recording audio in browser 
      * Send audio to Back-end for results 
      * Display results
      */
      stopClicked: async function(){ 
        this.state = State.POST;
        this.stopAudioRecorder();
        let count = 0;
        while(!this.isDataAvailable && (count <= 10)){
          console.log(`Awaiting data availalbe: ${count}`);
          await this.sleep(1000);
          count++;
        }
        
        if(this.isDataAvailable){
          let base64data = await this.blobToBase64(new Blob( this.audioBlobs , { 'type': this.mediaRecorder.mimeType})); 
          try{
            // Note axios only supports sending data in params on GET so use POST/PUT
            // See debate: https://github.com/rotki/rotki/issues/576
              this.response =  await axios({
                method: "post",
                url: `/api/${this.urlEndpoints.record.mapping}`,
                data: base64data,
                headers: { "Content-Type": "text/plain" },
              })
          } catch(e) { 
            console.log(e);
          }

          console.log('RESPONSE:')
          if(this.response !== undefined) console.log(this.response.data);
        } else { 
          this.response = {
            "data": "Audio Data Never Became Available"
          }
          console.log(this.response);
        }
      },
      /**
      * Reset any global vars here
      */
      finishClicked: function(){ 
        this.state = State.PRIOR;
        this.audioBlobs = [];
        this.response = undefined;
        this.mediaRecorder = undefined;
        this.streamBeingCaptured = undefined;
      },
      sleep: function(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
      },
    }, 
    data() { 
      return { 
        mediaRecorder: undefined,
        audioBlobs: [], 
        streamBeingCaptured: undefined,
        State,
        state: State.PRIOR,
        response: undefined,
        urlEndpoints: urls,
        userMediaErrorMessage: 'mediaDevices API or getUserMedia method is not supported in this browser.',
        hasAudioPermissions: false,
        isDataAvailable: false
      }
    }
  }
  </script>
  
  <style>
  
  .container {
    display: flex;
    flex-direction: column;
    justify-content: center;
    text-align: center;
    padding: 20%;
    margin: auto;
  } 

  .nav_element {
  display: inline-block;
  border-radius: 4px;
  background-color: #006699;
  border: none;
  color: #FFFFFF;
  text-align: center;
  font-size: 28px;
  padding: 20px;
  width: 200px;
  transition: all 0.5s;
  cursor: pointer;
  margin: 5px;
}

.nav_element span {
  cursor: pointer;
  display: inline-block;
  position: relative;
  transition: 0.5s;
}

.nav_element span:after {
  content: '\00bb';
  position: absolute;
  opacity: 0;
  top: 0;
  right: -20px;
  transition: 0.5s;
}

.nav_element:hover span {
  padding-right: 25px;
}

.nav_element:hover span:after {
  opacity: 1;
  right: 0;
}
  
  </style>
  