<script setup lang="ts">
definePageMeta({ auth: false })
const { data, status, getCsrfToken, getProviders } = useSession()
const providers = await getProviders()
const csrfToken = await getCsrfToken()
</script>

<template>
  <div class="max-w-5xl mx-auto mt-5 px-5" />
</template>
