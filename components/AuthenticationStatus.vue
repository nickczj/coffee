<script setup lang="ts">
const { status, data, signIn } = useSession()
</script>

<template>
  <NuxtLink v-if="status === 'authenticated' && data?.user?.image" to="/profile">
    <img
      :src="data.user.image"
      class="w-6 h-6 rounded-full"
      alt="User Avatar"
    >
  </NuxtLink>
  <button v-else @click="signIn()">
    <div class="dark:i-carbon:user-avatar i-carbon:user-avatar-filled" />
  </button>
</template>
