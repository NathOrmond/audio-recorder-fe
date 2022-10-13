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
      class="recording_container"> 
        
        <AppButton 
        label="Stop Recording"
        alt_text="Click button to stop recording"
        @handleClicked="stopClicked"
        />

      </div>


      <div 
      v-if="state === State.POST" 
      class="stats_container"> 
        
        <div>
          <!-- Display response: Duration, sample rate etc. -->
          <h1>RESPONSE:</h1>
          <h2 
          v-if="response !== undefined"
          >
          {{response}}
          </h2>
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
      /**
      * Begin recording audio here 
      * Record audio in browser
      */
      recordClicked: async function() {
        this.state = State.RECORDING;
        try {
          if(this.recorder === undefined){
            let stream = await navigator.mediaDevices.getUserMedia({ audio: true });
            this.recorder = new MediaRecorder(stream);
            this.recorder.ondataavailable = (e) => {
              this.audioData.push(e.data);
            };
          }
          this.recorder.start();
        } catch (err) {
          /* handle the error */
          console.log(err);
        }
      }, 
      /**
      * Stop recording audio here 
      * Stop recording audio in browser 
      * Send audio to Back-end for results 
      * Display results
      */
      stopClicked: async function(){ 
        this.state = State.POST;
        if(this.recorder !== undefined) this.recorder.stop();
        let audioBlob = new Blob( this.audioData, { 'type': 'audio/mp3;' });
        let audioFormData = new FormData();
        audioFormData.append('audio', audioBlob); 

        console.log('HERE!')
        // TODO: TEST API - REMOVE LATER
        this.response = await axios.get(`/api/${this.urlEndpoints.record.mapping}`);

        // try{
        //   // Note axios only supports sending data in params on GET so use POST/PUT
        //   // See debate: https://github.com/rotki/rotki/issues/576
        //   this.response =  await axios({
        //     method: "post",
        //     url: `${this.urlEndpoints.url}/${this.urlEndpoints.record.mapping}`,
        //     data: audioFormData,
        //     headers: { "Content-Type": "multipart/form-data" },
        //   })
        // } catch(e) { 
        //   console.log(e);
        // }

        /**
        * Expected response format: 
        * Duration, sample rate etc)
        * {
        *  "audio_received": bool, 
        *  "duration": TIMESTAMP, 
        *  sample_rate: long
        * }
        */
        console.log(this.response);
      },
      /**
      * Reset any global vars here
      */
      finishClicked: function(){ 
        this.state = State.PRIOR;
        this.audioData = [];
      }
    }, 
    data() { 
      return { 
        State,
        state: State.PRIOR,
        recorder: undefined,
        audioData: [], 
        response: undefined,
        urlEndpoints: urls
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
  