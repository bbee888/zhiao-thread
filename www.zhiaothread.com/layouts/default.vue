<template>
  <div :class="{ 'rtl': isRtl }" :dir="isRtl ? 'rtl' : 'ltr'">
    <TheHeader />
    <main>
      <slot />
    </main>
    <TheFooter />
  </div>
</template>

<script setup>
const { locale } = useI18n()
const isRtl = computed(() => locale.value === 'ar')

useHead({
  htmlAttrs: {
    lang: locale.value,
    dir: isRtl.value ? 'rtl' : 'ltr'
  }
})
</script>
