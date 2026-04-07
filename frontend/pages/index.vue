<template>
  <main>
    <!-- Hero Section -->
    <HomeHero />
    
    <!-- Core Advantages -->
    <HomeAdvantages />
    
    <!-- Featured Products -->
    <HomeFeaturedProducts />
    
    <!-- Application Areas -->
    <HomeApplications />
    
    <!-- Quality Control / Trust Section -->
    <HomeTrust />
    
    <!-- News / Blog Section -->
    <HomeBlog />
  </main>
</template>

<script setup>
const { t } = useI18n()

useHead({
  title: t('home.seo.title'),
  meta: [
    { name: 'description', content: t('home.seo.description'), key: 'description' },
    { name: 'keywords', content: t('home.seo.keywords'), key: 'keywords' }
  ]
})
</script>
