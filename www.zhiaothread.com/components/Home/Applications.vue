<template>
  <section id="applications" class="py-16 md:py-24 bg-white overflow-hidden scroll-mt-24">
    <div class="container mx-auto max-w-7xl px-4 md:px-8">
      <div class="text-center max-w-3xl mx-auto mb-10 md:mb-20">
        <h2 class="text-3xl md:text-4xl font-bold text-slate-900 mb-4">{{ $t('home.applications.title') }}</h2>
        <div class="w-20 h-1.5 bg-blue-600 mx-auto mb-6 rounded-full"></div>
        <p class="text-lg text-slate-600">{{ $t('home.applications.subtitle') }}</p>
      </div>

      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-6 gap-4">
        <div
          v-for="(app, index) in applications"
          :key="index"
          class="group relative h-[220px] sm:h-[280px] lg:h-[400px] rounded-lg overflow-hidden cursor-pointer"
        >
          <!-- Background Image -->
          <img :src="app.image" :alt="app.title" class="absolute inset-0 w-full h-full object-cover group-hover:scale-110 transition-transform duration-700" />
          
          <!-- Overlay -->
          <div class="absolute inset-0 bg-gradient-to-t from-slate-900 via-slate-900/40 to-transparent opacity-80 group-hover:opacity-90 transition-opacity duration-300"></div>
          
          <!-- Content -->
          <div class="absolute inset-0 p-3 sm:p-4 lg:p-4 flex flex-col justify-end transform translate-y-3 sm:translate-y-4 group-hover:translate-y-0 transition-transform duration-300">
            <div class="w-10 h-10 sm:w-12 sm:h-12 bg-blue-600 rounded-2xl flex items-center justify-center text-white mb-3 sm:mb-6 transform -rotate-12 group-hover:rotate-0 transition-transform duration-500">
              <i :class="app.icon" class="text-xl sm:text-2xl"></i>
            </div>
            <h3 class="text-base sm:text-xl font-bold text-white">{{ app.title }}</h3>

          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
const applications = [
  {
    title: $t('home.applications.clothing'),
    image: '/img/b1.jpg',
    icon: 'ri-shirt-line'
  },
  {
    title: $t('home.applications.footwear'),
    image: '/img/b2.jpg',
    icon: 'ri-footprint-line'
  },
  {
    title: $t('home.applications.automotive'),
    image: '/img/b3.jpg',
    icon: 'ri-briefcase-line'
  },
  {
    title: $t('home.applications.home'),  
    image: '/img/b4.jpg',
    icon: 'ri-armchair-line'
  },
  {
    title: $t('home.applications.embroidery'),
    image: '/img/b5.jpg',
    icon: 'ri-infinity-line'
  },
  {
    title: $t('home.applications.textiles'),
    image: '/img/b6.jpg',
    icon: 'ri-t-shirt-air-line'
  }
]
</script>
