<template>
  <section class="relative bg-gradient-to-r from-blue-800 to-blue-600 text-white overflow-hidden">
    <div class="container mx-auto max-w-7xl px-4 md:px-8 py-16 md:py-24">
      <div class="flex flex-col lg:flex-row items-center justify-between gap-12">
        <!-- Left Content -->
        <div class="lg:w-1/2 space-y-8 z-10">
          <h1 class="text-4xl md:text-5xl lg:text-6xl font-bold leading-tight">
            {{ $t('home.hero.title') }}
          </h1>
          <p class="text-xl md:text-2xl font-light text-blue-100">
            {{ $t('home.hero.subtitle') }}
          </p>
          
          <div class="flex flex-wrap gap-4 pt-4">
            <NuxtLink to="/products" class="bg-white text-blue-700 px-8 py-4 rounded-lg font-bold text-lg hover:bg-blue-50 transition-all shadow-lg">
              {{ $t('home.hero.browse') }}
            </NuxtLink>
            <NuxtLink to="/contact" class="bg-blue-900 bg-opacity-30 border border-white border-opacity-30 backdrop-blur-sm text-white px-8 py-4 rounded-lg font-bold text-lg hover:bg-opacity-40 transition-all">
              {{ $t('home.hero.contact') }}
            </NuxtLink>
          </div>

          <!-- Trust Badges -->
          <div class="flex flex-wrap items-center gap-8 pt-8 border-t border-white border-opacity-10">
            <div class="flex items-center space-x-2">
              <div class="w-10 h-10 rounded-full bg-blue-500 bg-opacity-20 flex items-center justify-center">
                <i class="ri-shield-check-line text-xl text-blue-200"></i>
              </div>
              <span class="text-sm font-medium">{{ $t('home.hero.certification') }}</span>
            </div>
            <div class="flex items-center space-x-2">
              <div class="w-10 h-10 rounded-full bg-blue-500 bg-opacity-20 flex items-center justify-center">
                <i class="ri-history-line text-xl text-blue-200"></i>
              </div>
              <span class="text-sm font-medium">{{ $t('home.hero.delivery') }}</span>
            </div>
            <div class="flex items-center space-x-2">
              <div class="w-10 h-10 rounded-full bg-blue-500 bg-opacity-20 flex items-center justify-center">
                <i class="ri-customer-service-2-line text-xl text-blue-200"></i>
              </div>
              <span class="text-sm font-medium">{{ $t('home.hero.customization') }}</span>
            </div>
          </div>
        </div>

        <!-- Right Image -->
        <div class="lg:w-1/2 relative">
          <div
            ref="carouselRef"
            class="relative z-10 rounded-2xl overflow-hidden shadow-2xl transform lg:rotate-2 hover:rotate-0 transition-transform duration-500"
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
              :style="{ transform: `translateX(-${activeIndex * 100}%)` }"
            >
              <div v-for="(slide, i) in slides" :key="i" class="w-full flex-shrink-0 relative">
                <img
                  :src="slide.image"
                  :alt="$t('common.header.logo')"
                  loading="lazy"
                  class="w-full h-[360px] md:h-[420px] object-cover"
                  :class="slide.kenBurnsClass"
                />
                <div class="absolute inset-0 bg-gradient-to-t from-slate-900/30 via-transparent to-transparent"></div>
              </div>
            </div>

            <button
              type="button"
              class="absolute left-3 top-1/2 -translate-y-1/2 w-10 h-10 rounded-full bg-white/20 hover:bg-white/30 backdrop-blur-sm border border-white/20 flex items-center justify-center transition-colors"
              @click="prev"
            >
              <i class="ri-arrow-left-s-line text-2xl"></i>
            </button>
            <button
              type="button"
              class="absolute right-3 top-1/2 -translate-y-1/2 w-10 h-10 rounded-full bg-white/20 hover:bg-white/30 backdrop-blur-sm border border-white/20 flex items-center justify-center transition-colors"
              @click="next"
            >
              <i class="ri-arrow-right-s-line text-2xl"></i>
            </button>

            <div class="absolute bottom-4 left-1/2 -translate-x-1/2 flex items-center gap-2">
              <button
                v-for="(_, i) in slides"
                :key="i"
                type="button"
                class="h-2 rounded-full transition-all"
                :class="i === activeIndex ? 'w-10 bg-white' : 'w-2 bg-white/60 hover:bg-white/80'"
                @click="go(i)"
              ></button>
            </div>
          </div>
          <!-- Decorative elements -->
          <div class="absolute -top-10 -right-10 w-40 h-40 bg-blue-400 rounded-full mix-blend-multiply filter blur-3xl opacity-20 animate-pulse"></div>
          <div class="absolute -bottom-10 -left-10 w-40 h-40 bg-indigo-400 rounded-full mix-blend-multiply filter blur-3xl opacity-20 animate-pulse delay-700"></div>
        </div>
      </div>
    </div>

    <!-- Background Decoration -->
    <div class="absolute top-0 right-0 w-1/3 h-full overflow-hidden opacity-10 pointer-events-none">
      <svg class="w-full h-full" viewBox="0 0 100 100" preserveAspectRatio="none">
        <path d="M0 0 L100 0 L100 100 Z" fill="currentColor"></path>
      </svg>
    </div>
  </section>
</template>

<script setup>
const slides = [
  { image: '/img/ba1.jpg', kenBurnsClass: 'animate-kenburns-1' },
  { image: '/img/ba2.jpg', kenBurnsClass: 'animate-kenburns-2' },
  { image: '/img/ba3.jpg', kenBurnsClass: 'animate-kenburns-3' }
]

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
  activeIndex.value = mod(i, slides.length)
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

<style scoped>
@keyframes kenburns1 {
  0% {
    transform: scale(1) translate3d(0, 0, 0);
  }
  100% {
    transform: scale(1.08) translate3d(-2%, -1%, 0);
  }
}
@keyframes kenburns2 {
  0% {
    transform: scale(1) translate3d(0, 0, 0);
  }
  100% {
    transform: scale(1.08) translate3d(2%, -1%, 0);
  }
}
@keyframes kenburns3 {
  0% {
    transform: scale(1) translate3d(0, 0, 0);
  }
  100% {
    transform: scale(1.08) translate3d(0, 2%, 0);
  }
}

.animate-kenburns-1 {
  animation: kenburns1 8s ease-in-out infinite alternate;
}
.animate-kenburns-2 {
  animation: kenburns2 8s ease-in-out infinite alternate;
}
.animate-kenburns-3 {
  animation: kenburns3 8s ease-in-out infinite alternate;
}
</style>
