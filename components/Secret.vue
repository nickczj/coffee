<script setup lang="ts">
const { status, data, signOut } = useSession()
</script>

<template>
  <div class="text-center mt-10">
    <h1 class="text-2xl">
      Hi {{ data?.user?.name }}!
    </h1>
    <button v-if="status === 'authenticated'" class="absolute right-2 top-2 space-x-2 bg-red-500 text-white rounded-md py-2 px-3 text-lg" @click="signOut({ callbackUrl: '/' })">
      <span>Logout</span>
    </button>
  </div>
</template>
