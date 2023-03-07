<script setup lang="ts">
const { status, data, signIn } = useSession()
</script>

<template>
  <NuxtLink v-if="status === 'authenticated' && data?.user?.image" to="/profile">
    <nuxt-img
      :src="data.user.image"
      class="w-6 h-6 rounded-full"
      placeholder="public/user-avatar.png"
      @error="$event.target.src = 'public/user-avatar.svg'"
    />
  </NuxtLink>
  <button v-else @click="signIn()">
    <div class="dark:i-carbon:user-avatar i-carbon:user-avatar-filled" />
  </button>
</template>
