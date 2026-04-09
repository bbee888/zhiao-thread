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
const route = useRoute()
const requestURL = useRequestURL()

const canonicalUrl = computed(() => {
  return `${requestURL.origin}${route.path}`
})

useHead(() => ({
  title: t('home.seo.title'),
  meta: [
    { name: 'description', content: t('home.seo.description'), key: 'description' },
    { name: 'keywords', content: t('home.seo.keywords'), key: 'keywords' },
    { property: 'og:title', content: t('home.seo.title'), key: 'og:title' },
    { property: 'og:description', content: t('home.seo.description'), key: 'og:description' },
    { property: 'og:type', content: 'website', key: 'og:type' },
    { property: 'og:url', content: canonicalUrl.value, key: 'og:url' },
    { name: 'twitter:card', content: 'summary_large_image', key: 'twitter:card' },
    { name: 'twitter:title', content: t('home.seo.title'), key: 'twitter:title' },
    { name: 'twitter:description', content: t('home.seo.description'), key: 'twitter:description' }
  ],
  link: [{ rel: 'canonical', href: canonicalUrl.value }]
}))
</script>
