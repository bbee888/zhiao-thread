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
          <div class="relative z-10 rounded-2xl overflow-hidden shadow-2xl transform lg:rotate-2 hover:rotate-0 transition-transform duration-500">
            <img 
              src="/img/a1.jpg" 
              :alt=" $t('common.header.logo') " 
              loading="lazy"
              class="w-full h-auto object-cover"
            />
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
// Hero section logic
</script>
