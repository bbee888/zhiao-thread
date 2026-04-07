<template>
  <section class="py-20 bg-white">
    <div class="container mx-auto max-w-7xl px-4 md:px-8">
      <!-- Section Header -->
      <div class="text-center max-w-3xl mx-auto mb-16">
        <h2 class="text-3xl md:text-4xl font-bold text-slate-900 mb-4">
          {{ $t('home.advantages.title') }}
        </h2>
        <div class="w-20 h-1.5 bg-blue-600 mx-auto mb-6 rounded-full"></div>
        <p class="text-lg text-slate-600">
          {{ $t('home.advantages.subtitle') }}
        </p>
      </div>

      <!-- Advantage Cards -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
        <div 
          v-for="(item, index) in items" 
          :key="index"
          class="p-8 rounded-xl border border-gray-100 hover:border-blue-100 hover:shadow-xl transition-all duration-300 group bg-gray-50"
        >
          <div class="w-14 h-14 rounded-xl bg-blue-600 flex items-center justify-center text-white mb-6 group-hover:scale-110 transition-transform">
            <i :class="icons[index]" class="text-2xl"></i>
          </div>
          <h3 class="text-xl font-bold text-slate-900 mb-4">{{ rt(item.title) }}</h3>
          <p class="text-slate-600 leading-relaxed text-sm">
            {{ rt(item.desc) }}
          </p>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
const { tm, rt } = useI18n()

const items = computed(() => tm('home.advantages.items') || [])

const icons = [
  'ri-award-line',
  'ri-lightbulb-flash-line',
  'ri-global-line',
  'ri-leaf-line'
]
</script>
