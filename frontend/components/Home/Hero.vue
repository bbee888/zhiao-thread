<template>
  <section class="relative text-white overflow-hidden">
    <div
      ref="carouselRef"
      class="relative"
      @mouseenter="pause"
      @mouseleave="resume"
      @wheel.passive="onWheel"
      @pointerdown="onPointerDown"
      @pointermove="onPointerMove"
      @pointerup="onPointerUp"
      @pointercancel="onPointerUp"
    >
      <div
        class="flex will-change-transform transition-transform duration-700 ease-out"
        dir="ltr"
        :style="{ transform: `translateX(-${activeIndex * 100}%)` }"
      >
        <div
          v-for="(s, i) in slides"
          :key="i"
          class="w-full flex-shrink-0"
          :class="s.bgClass"
        >
          <div class="mx-auto max-w-[1440px] px-4 lg:px-[80px] py-12 sm:py-16 lg:py-[80px]" :dir="isRtl ? 'rtl' : 'ltr'">
            <div class="flex flex-col lg:flex-row items-start lg:items-center justify-between gap-10 lg:gap-[100px]">
              <div class="w-full lg:w-[600px]">
                <div class="inline-flex items-center rounded-full bg-white/20 px-[14px] py-[6px] sm:px-[20px] sm:py-[8px]">
                  <i
                    v-if="s.badgeIcon"
                    :class="`${s.badgeIcon} text-[14px] sm:text-[16px] leading-[1.2]`"
                    :style="{ color: s.badgeIconColor }"
                  ></i>
                  <span v-if="s.badgeIcon" class="w-2"></span>
                  <span class="text-[12px] sm:text-[14px] font-medium leading-[1.2] text-white">{{ s.badge }}</span>
                </div>

                <div class="h-[16px] sm:h-[24px] lg:h-[32px]"></div>

                <div class="text-[32px] sm:text-[44px] lg:text-[64px] leading-[1.2] font-extrabold text-white">
                  <div>{{ s.titleLine1 }}</div>
                  <div class="h-[8px]"></div>
                  <div>{{ s.titleLine2 }}</div>
                </div>

                <div class="h-[16px] sm:h-[24px] lg:h-[32px]"></div>

                <p class="text-[16px] sm:text-[18px] lg:text-[20px] leading-[1.4] sm:leading-[1.3] lg:leading-[1.2] font-light" :style="{ color: s.subtitleColor }">
                  {{ s.subtitle }}
                </p>

                <div v-if="s.params?.length" class="h-[24px] sm:h-[36px] lg:h-[48px]"></div>
                <div v-if="s.params?.length" class="space-y-[16px]">
                  <div class="grid grid-cols-2 md:grid-cols-3 gap-[12px] sm:gap-[16px]">
                    <div
                      v-for="(p, idx) in s.params.slice(0, 3)"
                      :key="idx"
                      class="rounded-[12px] bg-white/10 p-[12px] sm:p-[16px]"
                    >
                      <div class="text-[14px] leading-[1.2]" :style="{ color: s.paramLabelColor }">
                        {{ p.label }}
                      </div>
                      <div class="h-[4px]"></div>
                      <div class="text-[18px] sm:text-[20px] lg:text-[24px] leading-[1.2] font-bold text-white">
                        {{ p.value }}
                      </div>
                    </div>
                  </div>
                  <div class="grid grid-cols-2 md:grid-cols-3 gap-[12px] sm:gap-[16px]">
                    <div
                      v-for="(p, idx) in s.params.slice(3, 6)"
                      :key="idx"
                      class="rounded-[12px] bg-white/10 p-[12px] sm:p-[16px]"
                    >
                      <div class="text-[14px] leading-[1.2]" :style="{ color: s.paramLabelColor }">
                        {{ p.label }}
                      </div>
                      <div class="h-[4px]"></div>
                      <div class="text-[18px] sm:text-[20px] lg:text-[24px] leading-[1.2] font-bold text-white">
                        {{ p.value }}
                      </div>
                    </div>
                  </div>
                </div>

                <div :class="s.params?.length ? 'h-[32px] sm:h-[56px] lg:h-[80px]' : 'h-[24px] sm:h-[36px] lg:h-[48px]'"></div>

                <div class="flex flex-col sm:flex-row sm:items-center">
                  <NuxtLink
                    :to="s.primary.to"
                    class="h-[52px] sm:h-[63px] rounded-[12px] px-[24px] sm:px-[40px] py-[16px] bg-white flex items-center justify-center sm:justify-start"
                  >
                    <span class="text-[18px] leading-[1.2] font-semibold" :style="{ color: s.primary.textColor }">
                      {{ s.primary.label }}
                    </span>
                    <span class="w-2"></span>
                    <i :class="`${s.primary.icon} text-[18px]`" :style="{ color: s.primary.iconColor }"></i>
                  </NuxtLink>
                  <div class="h-3 sm:h-0 sm:w-[20px]"></div>
                  <NuxtLink
                    :to="s.secondary.to"
                    class="h-[52px] sm:h-[63px] rounded-[12px] px-[24px] sm:px-[40px] py-[16px] border-2 border-white flex items-center justify-center sm:justify-start"
                  >
                    <span class="text-[18px] leading-[1.2] font-semibold text-white">{{ s.secondary.label }}</span>
                    <span class="w-2"></span>
                    <i :class="`${s.secondary.icon} text-[18px] text-white`"></i>
                  </NuxtLink>
                </div>

                <div v-if="s.trust?.length" class="h-[24px] sm:h-[40px] lg:h-[64px]"></div>
                <div v-if="s.trust?.length" class="rounded-[12px] bg-white/10 p-[16px] sm:p-[24px]">
                  <div class="text-[14px] leading-[1.2] font-medium" :style="{ color: s.subtitleColor }">
                    {{ s.trustTitle }}
                  </div>
                  <div class="h-[16px]"></div>
                  <div class="flex flex-col sm:flex-row sm:items-start sm:justify-between gap-4">
                    <div v-for="(t, idx) in s.trust" :key="idx" class="flex items-center">
                      <div
                        class="w-[41px] h-[44px] rounded-[8px] flex items-center justify-center"
                        :style="{ backgroundColor: t.iconBg }"
                      >
                        <i :class="`${t.icon} text-[24px] leading-[1.2]`" :style="{ color: t.iconColor }"></i>
                      </div>
                      <div class="w-[12px]"></div>
                      <div>
                        <div class="text-[16px] leading-[1.2] font-semibold text-white">{{ t.title }}</div>
                        <div class="h-[4px]"></div>
                        <div class="text-[12px] leading-[1.2]" :style="{ color: t.subColor }">{{ t.subtitle }}</div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <div class="w-full lg:w-[580px] max-w-[560px] mx-auto lg:mx-0">
                <div
                  class="bg-white rounded-[16px] shadow-[0_25px_50px_rgba(0,0,0,0.25)] overflow-hidden"
                  :class="s.cardPaddingClass"
                >
                  <div class="w-full rounded-[12px] overflow-hidden" :class="s.cardImageClass">
                    <img :src="s.image" alt="" class="w-full h-full object-cover" />
                  </div>

                  <template v-if="s.cardType === 'label'">
                    <div class="h-[8px]"></div>
                    <div class="px-[16px] py-[16px] flex items-center justify-between">
                      <div>
                        <div class="text-[18px] leading-[1.2] font-semibold text-slate-800">{{ s.cardTitle }}</div>
                        <div class="h-[4px]"></div>
                        <div class="text-[14px] leading-[1.2] text-slate-500">{{ s.cardSubtitle }}</div>
                      </div>
                      <div class="bg-emerald-50 text-emerald-700 rounded-[8px] px-[12px] py-[4px]">
                        <span class="text-[12px] leading-[1.2] font-semibold">{{ s.cardTag }}</span>
                      </div>
                    </div>
                  </template>

                  <template v-else>
                    <div class="h-[16px] sm:h-[24px]"></div>
                    <div class="text-[16px] leading-[1.2] font-semibold text-slate-800">{{ s.sceneTitle }}</div>
                    <div class="h-[12px]"></div>
                    <div class="flex flex-wrap gap-[8px]">
                      <div
                        v-for="(tag, idx) in s.sceneTags"
                        :key="idx"
                        class="h-[30px] rounded-[8px] px-[10px] sm:px-[12px] py-[6px] flex items-center"
                        :style="{ backgroundColor: s.sceneTagBg }"
                      >
                        <span class="text-[13px] leading-[1.2] font-medium" :style="{ color: s.sceneTagText }">
                          {{ rt(tag) }}
                        </span>
                      </div>
                    </div>
                  </template>
                </div>
              </div>
            </div>

            <div class="h-[32px] sm:h-[48px] lg:h-[64px]"></div>
            <div class="flex justify-center">
              <div class="flex items-center gap-[12px]">
                <button
                  v-for="(_, j) in slides"
                  :key="j"
                  type="button"
                  class="h-[12px] rounded-full transition-all"
                  :class="j === activeIndex ? 'w-[34px] bg-white' : 'w-[14px] bg-white/30 hover:bg-white/50'"
                  @click="go(j)"
                ></button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
const { t, tm, rt, locale } = useI18n()
const localePath = useLocalePath()

const isRtl = computed(() => locale.value === 'ar')

const slides = computed(() => [
  {
    bgClass: 'bg-gradient-to-br from-[#1E40AF] to-[#3B82F6]',
    badgeIcon: 'ri-star-fill',
    badgeIconColor: 'rgba(250,204,21,1)',
    badge: t('home.hero_carousel.slide1.badge'),
    titleLine1: t('home.hero_carousel.slide1.title_line1'),
    titleLine2: t('home.hero_carousel.slide1.title_line2'),
    subtitleColor: 'rgba(224,231,255,1)',
    subtitle: t('home.hero_carousel.slide1.subtitle'),
    primary: {
      label: t('home.hero_carousel.slide1.primary'),
      to: localePath('/products'),
      icon: 'ri-arrow-right-line',
      textColor: 'rgba(29,78,216,1)',
      iconColor: 'rgba(37,99,235,1)'
    },
    secondary: {
      label: t('home.hero_carousel.slide1.secondary'),
      to: localePath('/inquiry'),
      icon: 'ri-customer-service-2-line'
    },
    trustTitle: t('home.hero_carousel.slide1.trust_title'),
    trust: [
      {
        icon: 'ri-award-fill',
        iconBg: 'rgba(250,204,21,0.2)',
        iconColor: 'rgba(250,204,21,1)',
        title: t('home.hero_carousel.slide1.trust.iso.title'),
        subtitle: t('home.hero_carousel.slide1.trust.iso.subtitle'),
        subColor: 'rgba(191,219,254,1)'
      },
      {
        icon: 'ri-time-fill',
        iconBg: 'rgba(250,204,21,0.2)',
        iconColor: 'rgba(250,204,21,1)',
        title: t('home.hero_carousel.slide1.trust.delivery.title'),
        subtitle: t('home.hero_carousel.slide1.trust.delivery.subtitle'),
        subColor: 'rgba(191,219,254,1)'
      },
      {
        icon: 'ri-palette-fill',
        iconBg: 'rgba(250,204,21,0.2)',
        iconColor: 'rgba(250,204,21,1)',
        title: t('home.hero_carousel.slide1.trust.custom.title'),
        subtitle: t('home.hero_carousel.slide1.trust.custom.subtitle'),
        subColor: 'rgba(191,219,254,1)'
      }
    ],
    cardType: 'label',
    cardPaddingClass: 'p-[8px]',
    cardImageClass: 'h-[320px] sm:h-[420px] lg:h-[580px]',
    image: '/img/ba1.jpg',
    cardTitle: t('home.hero_carousel.slide1.card.title'),
    cardSubtitle: t('home.hero_carousel.slide1.card.subtitle'),
    cardTag: t('home.hero_carousel.slide1.card.tag')
  },
  {
    bgClass: 'bg-gradient-to-br from-[#075985] to-[#0EA5E9]',
    badgeIcon: '',
    badgeIconColor: '',
    badge: t('home.hero_carousel.slide2.badge'),
    titleLine1: t('home.hero_carousel.slide2.title_line1'),
    titleLine2: t('home.hero_carousel.slide2.title_line2'),
    subtitleColor: 'rgba(224,242,254,1)',
    subtitle: t('home.hero_carousel.slide2.subtitle'),
    paramLabelColor: 'rgba(186,230,253,1)',
    params: [
      { label: t('home.hero_carousel.common.params.density'), value: '40S/2' },
      { label: t('home.hero_carousel.common.params.tenacity'), value: '≥4.5 cN/dtex' },
      { label: t('home.hero_carousel.common.params.elongation'), value: '20±3%' },
      { label: t('home.hero_carousel.common.params.wash_temp'), value: '≤95℃' },
      { label: t('home.hero_carousel.common.params.color_fastness'), value: t('home.hero_carousel.slide2.values.color_fastness') },
      { label: t('home.hero_carousel.common.params.package'), value: '3000Y/5000Y' }
    ],
    primary: {
      label: t('home.hero_carousel.slide2.primary'),
      to: localePath('/inquiry'),
      icon: 'ri-arrow-right-line',
      textColor: 'rgba(7,89,133,1)',
      iconColor: 'rgba(14,116,144,1)'
    },
    secondary: {
      label: t('home.hero_carousel.slide2.secondary'),
      to: localePath('/inquiry'),
      icon: 'ri-mail-send-line'
    },
    cardType: 'scene',
    cardPaddingClass: 'p-[16px] sm:p-[24px]',
    cardImageClass: 'h-[260px] sm:h-[320px] lg:h-[400px]',
    image: '/img/ba2.jpg',
    sceneTitle: t('home.hero_carousel.common.scene_title'),
    sceneTags: tm('home.hero_carousel.slide2.scene_tags') || [],
    sceneTagBg: 'rgba(239,246,255,1)',
    sceneTagText: 'rgba(7,89,133,1)'
  },
  {
    bgClass: 'bg-gradient-to-br from-[#064E3B] to-[#10B981]',
    badgeIcon: 'ri-leaf-fill',
    badgeIconColor: 'rgba(110,231,183,1)',
    badge: t('home.hero_carousel.slide3.badge'),
    titleLine1: t('home.hero_carousel.slide3.title_line1'),
    titleLine2: t('home.hero_carousel.slide3.title_line2'),
    subtitleColor: 'rgba(209,250,229,1)',
    subtitle: t('home.hero_carousel.slide3.subtitle'),
    paramLabelColor: 'rgba(167,243,208,1)',
    params: [
      { label: t('home.hero_carousel.common.params.density'), value: '20S/2' },
      { label: t('home.hero_carousel.common.params.tenacity'), value: '≥5.0 cN/dtex' },
      { label: t('home.hero_carousel.common.params.elongation'), value: '18±3%' },
      { label: t('home.hero_carousel.common.params.heat_resistance'), value: '≤180℃' },
      { label: t('home.hero_carousel.common.params.abrasion'), value: t('home.hero_carousel.slide3.values.abrasion') },
      { label: t('home.hero_carousel.common.params.package'), value: '2000Y/3000Y' }
    ],
    primary: {
      label: t('home.hero_carousel.slide2.primary'),
      to: localePath('/inquiry'),
      icon: 'ri-arrow-right-line',
      textColor: 'rgba(6,78,59,1)',
      iconColor: 'rgba(4,120,87,1)'
    },
    secondary: {
      label: t('home.hero_carousel.slide2.secondary'),
      to: localePath('/inquiry'),
      icon: 'ri-mail-send-line'
    },
    cardType: 'scene',
    cardPaddingClass: 'p-[16px] sm:p-[24px]',
    cardImageClass: 'h-[260px] sm:h-[320px] lg:h-[400px]',
    image: '/img/ba3.jpg',
    sceneTitle: t('home.hero_carousel.common.scene_title'),
    sceneTags: tm('home.hero_carousel.slide3.scene_tags') || [],
    sceneTagBg: 'rgba(236,253,245,1)',
    sceneTagText: 'rgba(6,78,59,1)'
  }
])

const activeIndex = ref(0)
const autoplayTimer = ref()
const wheelLock = ref(false)
const carouselRef = ref()

const pointer = reactive({
  startX: 0,
  deltaX: 0,
  dragging: false
})

const mod = (n, m) => ((n % m) + m) % m

const go = (i) => {
  activeIndex.value = mod(i, slides.value.length)
}

const next = () => {
  go(activeIndex.value + 1)
}

const prev = () => {
  go(activeIndex.value - 1)
}

const pause = () => {
  if (autoplayTimer.value) clearInterval(autoplayTimer.value)
  autoplayTimer.value = undefined
}

const resume = () => {
  pause()
  autoplayTimer.value = setInterval(() => {
    next()
  }, 4500)
}

const onWheel = (e) => {
  if (wheelLock.value) return
  wheelLock.value = true
  if (e.deltaY > 0) next()
  else prev()
  setTimeout(() => {
    wheelLock.value = false
  }, 420)
}

const onPointerDown = (e) => {
  if (!carouselRef.value) return
  const target = e.target
  if (target && target.closest?.('a,button,input,select,textarea,label')) return
  pointer.dragging = true
  pointer.startX = e.clientX
  pointer.deltaX = 0
  pause()
  carouselRef.value.setPointerCapture?.(e.pointerId)
}

const onPointerMove = (e) => {
  if (!pointer.dragging) return
  pointer.deltaX = e.clientX - pointer.startX
}

const onPointerUp = () => {
  if (!pointer.dragging) return
  pointer.dragging = false
  const threshold = 60
  if (pointer.deltaX <= -threshold) next()
  else if (pointer.deltaX >= threshold) prev()
  pointer.deltaX = 0
  resume()
}

onMounted(() => {
  resume()
})

onBeforeUnmount(() => {
  pause()
})
</script>
