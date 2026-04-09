<template>
  <div class="bg-gray-50 min-h-screen">
    <div class="bg-white border-b border-gray-100">
      <div class="container mx-auto max-w-7xl px-4 md:px-8 py-4">
        <nav class="flex items-center text-sm text-gray-500">
          <NuxtLink :to="localePath('/')" class="hover:text-blue-600 transition-colors">
            {{ $t('common.breadcrumbs.home') }}
          </NuxtLink>
          <i class="ri-arrow-right-s-line mx-2"></i>
          <span class="text-blue-600 font-medium">{{ $t('common.breadcrumbs.about') }}</span>
        </nav>
      </div>
    </div>

    <section class="bg-slate-900 py-16 lg:py-32 relative overflow-hidden">
      <div class="absolute inset-0 opacity-80">
        <img src="/img/aboutBg.jpg" class="w-full h-full object-cover">
      </div>
      <div class="container mx-auto px-4 relative z-10 text-center">
        <h1 class="text-3xl lg:text-4xl font-bold text-white mb-4">
          {{ $t('about.hero.title') }}
        </h1>
        <p class="text-slate-100 max-w-2xl mx-auto font-light">
          {{ $t('about.hero.subtitle') }}
        </p>
      </div>
    </section>

    <!-- <section class="bg-gradient-to-r from-blue-800 to-blue-600 py-20 px-4 md:px-8">
      <div class="container mx-auto max-w-7xl">
        <div class="mx-auto w-full max-w-3xl text-center">
          <h1 class="text-5xl font-bold text-white leading-tight">
            {{ $t('about.hero.title') }}
          </h1>
          <div class="h-4"></div>
          <p class="text-xl text-white/90 font-light">
            {{ $t('about.hero.subtitle') }}
          </p>
        </div>
      </div>
    </section> -->

    <section class="bg-white py-14 sm:py-16 md:py-20 px-4 md:px-8">
      <div class="container mx-auto max-w-7xl">
        <div :class="['grid grid-cols-1 lg:grid-cols-2 gap-12 items-center', isRtl ? 'lg:[direction:rtl]' : 'lg:[direction:ltr]']">
          <div class="rounded-xl overflow-hidden border border-gray-200 bg-white shadow-sm">
            <img
              src="/assets/images/zhiao01.jpg"
              alt="Story"
              class="w-full h-[260px] sm:h-[360px] lg:h-[420px] object-cover"
              loading="lazy"
            >
          </div>

          <div class="lg:[direction:ltr]">
            <div class="text-blue-600 font-semibold text-base">{{ $t('about.story.kicker') }}</div>
            <div class="h-2"></div>
            <h2 class="text-3xl sm:text-4xl font-bold text-slate-900">{{ $t('about.story.title') }}</h2>
            <div class="h-4"></div>
            <p class="text-slate-600 leading-relaxed">{{ $t('about.story.desc') }}</p>

            <div class="h-10"></div>
            <div class="grid grid-cols-2 sm:grid-cols-4 gap-6 sm:gap-8">
              <div v-for="(stat, index) in storyStats" :key="index">
                <div class="text-3xl sm:text-4xl font-bold text-blue-600 leading-none">{{ stat.value }}</div>
                <div class="h-2"></div>
                <div class="text-sm text-slate-600">{{ $t(`about.story.stats.${stat.key}`) }}</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="bg-gray-50 py-14 sm:py-16 px-4 md:px-8">
      <div class="container mx-auto max-w-7xl">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
          <div class="rounded-xl border border-gray-100 bg-white p-6 sm:p-8 lg:p-10 shadow-sm">
            <div class="w-14 h-14 rounded-xl bg-blue-100 flex items-center justify-center">
              <i class="ri-focus-2-line text-2xl text-blue-700"></i>
            </div>
            <div class="h-6"></div>
            <h3 class="text-2xl font-bold text-slate-900">{{ $t('about.mission.mission_title') }}</h3>
            <div class="h-4"></div>
            <p class="text-slate-600 leading-relaxed">{{ $t('about.mission.mission_desc') }}</p>
            <div class="h-6"></div>
            <ul class="space-y-3">
              <li v-for="(line, idx) in missionBullets" :key="idx" class="flex items-start gap-3 text-slate-600">
                <i class="ri-checkbox-circle-line text-emerald-500 text-lg leading-6"></i>
                <span class="leading-6">{{ rt(line) }}</span>
              </li>
            </ul>
          </div>

          <div class="rounded-xl border border-gray-100 bg-white p-6 sm:p-8 lg:p-10 shadow-sm">
            <div class="w-14 h-14 rounded-xl bg-blue-100 flex items-center justify-center">
              <i class="ri-eye-line text-2xl text-blue-700"></i>
            </div>
            <div class="h-6"></div>
            <h3 class="text-2xl font-bold text-slate-900">{{ $t('about.mission.vision_title') }}</h3>
            <div class="h-4"></div>
            <p class="text-slate-600 leading-relaxed">{{ $t('about.mission.vision_desc') }}</p>
            <div class="h-6"></div>
            <ul class="space-y-3">
              <li v-for="(line, idx) in visionBullets" :key="idx" class="flex items-start gap-3 text-slate-600">
                <i class="ri-checkbox-circle-line text-emerald-500 text-lg leading-6"></i>
                <span class="leading-6">{{ rt(line) }}</span>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </section>

    <section class="bg-white py-14 sm:py-16 md:py-20 px-4 md:px-8">
      <div class="container mx-auto max-w-7xl">
        <div class="mx-auto w-full max-w-3xl text-center">
          <h2 class="text-3xl sm:text-4xl font-bold text-slate-900">{{ $t('about.values.title') }}</h2>
          <div class="h-4"></div>
          <p class="text-slate-600">{{ $t('about.values.subtitle') }}</p>
        </div>
        <div class="h-12"></div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <div
            v-for="(item, index) in valuesItems"
            :key="index"
            class="rounded-xl border border-gray-100 bg-gray-50 p-6 sm:p-8"
          >
            <div class="w-12 h-12 rounded-xl bg-blue-100 flex items-center justify-center">
              <i :class="[valueIcons[index] || 'ri-award-line', 'text-2xl text-blue-700']"></i>
            </div>
            <div class="h-6"></div>
            <div class="text-xl font-bold text-slate-900">{{ rt(item.title) }}</div>
            <div class="h-3"></div>
            <div class="text-slate-600 leading-relaxed">{{ rt(item.desc) }}</div>
          </div>
        </div>
      </div>
    </section>
<!-- 生产流程 -->
    <section class="bg-gray-50 py-14 sm:py-16 md:py-20 px-4 md:px-8">
      <div class="container mx-auto max-w-7xl">
        <div class="mx-auto w-full max-w-3xl text-center">
          <div class="text-blue-600 font-semibold text-base">{{ $t('about.process.kicker') }}</div>
          <div class="h-2"></div>
          <h2 class="text-3xl sm:text-4xl font-bold text-slate-900">{{ $t('about.process.title') }}</h2>
          <div class="h-4"></div>
          <p class="text-slate-600">{{ $t('about.process.subtitle') }}</p>
        </div>
        <div class="h-12"></div>

        <div class="space-y-8">
          <div
            v-for="(step, index) in processSteps"
            :key="index"
            class="rounded-xl border border-gray-100 bg-white overflow-hidden"
          >
            <div v-if="step.layout === 'stack'" class="p-6 md:p-10">
              <div class="rounded-xl overflow-hidden border border-gray-100 bg-gray-50">
                <img :src="step.image" alt="Process" class="w-full h-[240px] md:h-[320px] object-cover" loading="lazy">
              </div>
              <div class="h-8"></div>
              <div class="flex items-start gap-4">
                <div class="w-9 h-9 rounded-full bg-blue-700 text-white flex items-center justify-center font-bold">
                  {{ index + 1 }}
                </div>
                <div class="flex-1">
                  <div class="text-xl font-bold text-slate-900">{{ rt(step.title) }}</div>
                  <div class="h-3"></div>
                  <div class="text-slate-600 leading-relaxed">{{ rt(step.desc) }}</div>
                  <div class="h-5"></div>
                  <div class="flex flex-wrap gap-x-8 gap-y-3">
                    <div v-for="(b, bIdx) in (step.bullets || [])" :key="bIdx" class="flex items-center gap-2 text-sm text-slate-600">
                      <i class="ri-checkbox-circle-line text-emerald-500"></i>
                      <span>{{ rt(b) }}</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div v-else class="grid grid-cols-1 lg:grid-cols-2">
              <div class="p-6 md:p-10 lg:p-0">
                <div class="rounded-xl overflow-hidden border border-gray-100 bg-gray-50 lg:rounded-none lg:border-0">
                  <img :src="step.image" alt="Process" class="w-full h-[260px] lg:h-full object-cover" loading="lazy">
                </div>
              </div>
              <div class="p-6 md:p-10">
                <div class="flex items-start gap-4">
                  <div class="w-9 h-9 rounded-full bg-blue-700 text-white flex items-center justify-center font-bold">
                    {{ index + 1 }}
                  </div>
                  <div class="flex-1">
                    <div class="text-xl font-bold text-slate-900">{{ rt(step.title) }}</div>
                    <div class="h-3"></div>
                    <div class="text-slate-600 leading-relaxed">{{ rt(step.desc) }}</div>
                    <div class="h-5"></div>
                    <div class="flex flex-wrap gap-x-8 gap-y-3">
                      <div v-for="(b, bIdx) in (step.bullets || [])" :key="bIdx" class="flex items-center gap-2 text-sm text-slate-600">
                        <i class="ri-checkbox-circle-line text-emerald-500"></i>
                        <span>{{ rt(b) }}</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

<!-- 参观工厂 -->
    <section class="bg-blue-700 py-12 sm:py-16 px-4 md:px-8">
      <div class="container mx-auto max-w-7xl">
        <div :class="['flex flex-col gap-8', isRtl ? 'lg:flex-row-reverse' : 'lg:flex-row', 'lg:items-center lg:justify-between']">
          <div class="w-full max-w-2xl">
            <h2 class="text-3xl sm:text-4xl font-bold text-white">{{ $t('about.cta.title') }}</h2>
            <div class="h-3"></div>
            <p class="text-white/90">{{ $t('about.cta.subtitle') }}</p>
          </div>

          <div class="flex flex-col sm:flex-row gap-4 w-full lg:w-auto">
            <NuxtLink
              :to="localePath('/contact')"
              class="inline-flex items-center justify-center rounded-xl bg-white text-blue-700 font-semibold px-8 py-4 hover:bg-blue-50 transition-colors"
            >
              {{ $t('about.cta.primary') }}
            </NuxtLink>
            <NuxtLink
              :to="localePath('/products')"
              class="inline-flex items-center justify-center rounded-xl bg-blue-800 text-white font-semibold px-8 py-4 hover:bg-blue-900 transition-colors border border-blue-600"
            >
              {{ $t('about.cta.secondary') }}
            </NuxtLink>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
const localePath = useLocalePath()
const { t, locale, tm, rt } = useI18n()
const isRtl = computed(() => locale.value === 'ar')
const requestURL = useRequestURL()
const route = useRoute()

const canonicalUrl = computed(() => {
  return `${requestURL.origin}${route.path}`
})

useHead(() => ({
  title: t('about.seo.title'),
  meta: [
    { name: 'description', content: t('about.seo.description'), key: 'description' },
    { name: 'keywords', content: t('about.seo.keywords'), key: 'keywords' },
    { property: 'og:title', content: t('about.seo.title'), key: 'og:title' },
    { property: 'og:description', content: t('about.seo.description'), key: 'og:description' },
    { property: 'og:type', content: 'website', key: 'og:type' },
    { property: 'og:url', content: canonicalUrl.value, key: 'og:url' },
    { name: 'twitter:card', content: 'summary_large_image', key: 'twitter:card' },
    { name: 'twitter:title', content: t('about.seo.title'), key: 'twitter:title' },
    { name: 'twitter:description', content: t('about.seo.description'), key: 'twitter:description' }
  ],
  link: [{ rel: 'canonical', href: canonicalUrl.value }]
}))

const storyStats = [
  { key: 'experience', value: '20+' },
  { key: 'capacity', value: '5,000+' },
  { key: 'countries', value: '50+' },
  { key: 'customers', value: '2,000+' }
]


const valuesItems = computed(() => tm('about.values.items') || [])
const valueIcons = [
  'ri-medal-line',
  'ri-hand-heart-line',
  'ri-lightbulb-line',
  'ri-shield-check-line',
  'ri-team-line',
  'ri-leaf-line'
]

const missionBullets = computed(() => tm('about.mission.mission_bullets') || [])
const visionBullets = computed(() => tm('about.mission.vision_bullets') || [])

const processStepMeta = [
  {
    layout: 'side',
    image: '/img/ba1.jpg'
  },
  {
    layout: 'stack',
    image: '/img/ba2.jpg'
  },
  {
    layout: 'side',
    image: '/img/ba5.jpg'
  },
  {
    layout: 'stack',
    image: '/img/ba4.jpg'
  },
  {
    layout: 'side',
    image: '/img/ba6.jpg'
  },
  {
    layout: 'stack',
    image: '/img/ba7.jpg'
  }
]

const processSteps = computed(() => {
  const steps = tm('about.process.steps') || []
  return steps.map((s, idx) => ({
    ...s,
    ...(processStepMeta[idx] || {})
  }))
})

</script>
