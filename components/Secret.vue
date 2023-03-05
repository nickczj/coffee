<script lang="ts">
export default {
  props: {
    protectionType: String,
    href: String,
  },
}
</script>

<template>
  <div class="text-center mt-10">
    <h1 class="text-2xl font-bold">
      I'm a secret!
    </h1>
    <h3>My protection works via an <a :href="href" target="_blank">{{ protectionType }} middleware</a>.</h3>
  </div>
</template>
