<script setup lang="ts">
const { status, signOut } = useSession()
</script>

<template>
  <div class="text-center mt-10">
    <h1 class="text-2xl font-bold">
      I'm a secret!
    </h1>
    <button v-if="status === 'authenticated'" class="items-center justify-center space-x-2 bg-red-500 text-white rounded-md py-2 px-3 text-lg" @click="signOut({ callbackUrl: '/' })">
      <span>Logout</span>
    </button>
  </div>
</template>
