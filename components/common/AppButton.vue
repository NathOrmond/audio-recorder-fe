<template>
    <button>
        {{label}}
    </button>
</template>

<script>

export default {
  name: 'AppButton',
  components: {
  },
  props: {
    label: {
			type: String, 
			default: undefined,
			required: true
		},
    alt_text: {
			type: String, 
			default: undefined,
			required: true
		}
  },
  data() {
    return {
    };
  },
};
</script>

<style scoped>

</style>
  