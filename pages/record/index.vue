<template>
    <div class="container">
      <h1>RECORD PAGE</h1>

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
        <!-- Display response: Duration, sample rate etc. -->
        <AppButton 
          label="Finish"
          alt_text="Click button if finished reviewing stats"
          @handleClicked="finishClicked"
        />
      </div>

    </div>
  </template>
  
  <script>
import AppButton from '../../components/common/AppButton.vue';

const State = Object.freeze({ PRIOR: 1, RECORDING: 2, POST: 3 });

  export default {
    components: {
      AppButton
    },
    methods: {
      recordClicked: function() {
        this.state = State.RECORDING;
        /**
         * TODO:
         * Begin recording audio here 
         * Record audio in browser
         */
      }, 
      stopClicked: function(){ 
        this.state = State.POST;
        /**
         * TODO: 
         * Stop recording audio here 
         * Stop recording audio in browser 
         * Send audio to Back-end for results 
         * Display results
         */
      },
      finishClicked: function(){ 
         /**
         * Reset any global vars
         */
        this.state = State.PRIOR;
      }
    }, 
    data() { 
      return { 
        State,
        state: State.PRIOR
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
  
  </style>
  