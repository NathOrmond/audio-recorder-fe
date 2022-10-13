<template>
  <div class="container">
    
    
    <div class="buttons">
      <nuxt-link class="nav_element" to="/record">
        <span>Record Audio</span>
      </nuxt-link>
      <nuxt-link class="nav_element" to="/stream">
        <span>Stream Audio</span>
      </nuxt-link>
    </div>

  </div>
</template>

<script>
export default {
  components: {
  },
  methods: {
  }
}
</script>

<style>

.container {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center stretch;
  align-content: stretch;
  padding: 0px;
  margin: 0px;
  width: 100%;
  height: 100%;
}

.buttons {
  flex-direction: row;
  justify-content: center;
  align-items: center;
  padding: 0px;
  margin: 0px;
  width: 100%;
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
