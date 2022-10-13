<template>
    <div class="container">
      <h1>TODO: STREAM PAGE</h1>

      <div
      v-if="state === State.STREAMING"
      > 
        <p>Currently Streaming Audio to Back End</p>
      </div>

      <div
      v-if="state === State.POST"
      > 
        <p>Processing Audio</p>
      </div>

    </div>
  </template>
  
  <script>
  const State = Object.freeze({ STREAMING: 1, POST: 2 });
  export default {
    components: {
    },
    methods: {
      streaming: function() {
        alert('Stream: TODO')
        /**
         * If you choose streaming, the UI will continuously stream audio to the backend.
         */
      },
      stopStreamingEvent: function() {
        alert('Stream: TODO')
        /** 
         * (After Time) FE will send a msg to stop steaming, and get a final response
         * from the backend, that needs to be displayed in FE. The user should be
         * able to listen to what they streamed to BE.
         */
      }
    },
    data() { 
      return { 
        State,
        state: State.STREAMING
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
  