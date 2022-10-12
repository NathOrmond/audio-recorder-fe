<template>
    <div class="container">
      <h1>RECORD PAGE</h1>

      <div class="record_container">
        <AppButton 
          label="Start Recording"
          alt_text="Click button to begin recording"
          @handleClicked="recordClicked"
        />
      </div>

      <div class="recording_container"> 
        <AppButton 
          label="Stop Recording"
          alt_text="Click button to stop recording"
          @handleClicked="recordClicked"
        />
      </div>


      <div class="stats_container"> 
        <!-- Display response: Duration, sample rate etc. -->
      </div>

    </div>
  </template>
  
  <script>
import AppButton from '../../components/common/AppButton.vue';
  export default {
    components: {
      AppButton
    },
    methods: {
      recordClicked: function() {
        alert('Record: TODO');
        /**
         * Begin recording audio here
         */
      }, 
      stopClicked: function(){ 
        /**
         * Stop recording audio here
         */
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
  