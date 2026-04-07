<template>
  <footer class="bg-slate-900 text-slate-300 pt-16 pb-8">
    <div class="container mx-auto max-w-7xl px-4 md:px-8">
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-12 mb-12">
        <!-- Brand Info -->
        <div class="flex flex-col space-y-6">
          <NuxtLink to="/" class="flex items-center space-x-3 text-white">
            <div class="w-10 h-10 bg-blue-600 rounded-lg flex items-center justify-center">
              <i class="ri-shining-line text-2xl"></i>
            </div>
            <span class="text-xl font-bold tracking-tight">{{ $t('common.header.logo') }}</span>
          </NuxtLink>
          <p class="text-sm leading-relaxed">
            {{ $t('common.footer.desc') }}
          </p>
          <div class="flex space-x-4">
            <a href="#" class="w-10 h-10 rounded-full bg-slate-800 flex items-center justify-center hover:bg-blue-600 transition-colors">
              <i class="ri-facebook-fill"></i>
            </a>
            <a href="#" class="w-10 h-10 rounded-full bg-slate-800 flex items-center justify-center hover:bg-blue-600 transition-colors">
              <i class="ri-linkedin-fill"></i>
            </a>
            <a href="#" class="w-10 h-10 rounded-full bg-slate-800 flex items-center justify-center hover:bg-blue-600 transition-colors">
              <i class="ri-twitter-x-fill"></i>
            </a>
            <a href="#" class="w-10 h-10 rounded-full bg-slate-800 flex items-center justify-center hover:bg-blue-600 transition-colors">
              <i class="ri-youtube-fill"></i>
            </a>
          </div>
        </div>

        <!-- Quick Links -->
        <div>
          <h4 class="text-white font-bold mb-6">{{ $t('common.footer.quick_links') }}</h4>
          <ul class="space-y-4 text-sm">
            <li><NuxtLink to="/" class="hover:text-blue-400 transition-colors">{{ $t('common.nav.home') }}</NuxtLink></li>
            <li><NuxtLink to="/products" class="hover:text-blue-400 transition-colors">{{ $t('common.nav.products') }}</NuxtLink></li>
            <li><NuxtLink to="/news" class="hover:text-blue-400 transition-colors">{{ $t('common.nav.news') }}</NuxtLink></li>
            <li><NuxtLink to="/about" class="hover:text-blue-400 transition-colors">{{ $t('common.nav.about') }}</NuxtLink></li>
            <li><NuxtLink to="/contact" class="hover:text-blue-400 transition-colors">{{ $t('common.nav.contact') }}</NuxtLink></li>
          </ul>
        </div>

        <!-- Product Categories -->
        <div>
          <h4 class="text-white font-bold mb-6">{{ $t('common.footer.product_categories') }}</h4>
          <ul class="space-y-4 text-sm">
            <li><a href="#" class="hover:text-blue-400 transition-colors">涤纶缝纫线</a></li>
            <li><a href="#" class="hover:text-blue-400 transition-colors">高强力线</a></li>
            <li><a href="#" class="hover:text-blue-400 transition-colors">尼龙缝纫线</a></li>
            <li><a href="#" class="hover:text-blue-400 transition-colors">棉质缝纫线</a></li>
            <li><a href="#" class="hover:text-blue-400 transition-colors">特种缝纫线</a></li>
          </ul>
        </div>

        <!-- Contact Info -->
        <div>
          <h4 class="text-white font-bold mb-6">{{ $t('common.footer.contact') }}</h4>
          <ul class="space-y-4 text-sm">
            <li class="flex items-start space-x-3">
              <i class="ri-map-pin-line text-blue-500 mt-1"></i>
              <span>{{ $t('common.footer.address') }}</span>
            </li>
            <li class="flex items-center space-x-3">
              <i class="ri-phone-line text-blue-500"></i>
              <span>+86 138 0000 0000</span>
            </li>
            <li class="flex items-center space-x-3">
              <i class="ri-mail-line text-blue-500"></i>
              <span>sales@sewpro.com</span>
            </li>
            <li class="flex items-center space-x-3">
              <i class="ri-time-line text-blue-500"></i>
              <span>{{ $t('common.footer.contact_hours') }}</span>
            </li>
          </ul>
        </div>
      </div>

      <!-- Bottom Bar -->
      <div class="pt-8 border-t border-slate-800 flex flex-col md:flex-row justify-between items-center text-xs space-y-4 md:space-y-0">
        <p>&copy; {{ new Date().getFullYear() }} {{ $t('common.header.logo') }}. {{ $t('common.footer.copyright') }}</p>
        <div class="flex space-x-6">
          <a href="#" class="hover:text-white transition-colors">{{ $t('common.footer.privacy') }}</a>
          <a href="#" class="hover:text-white transition-colors">{{ $t('common.footer.terms') }}</a>
          <a href="#" class="hover:text-white transition-colors">{{ $t('common.footer.sitemap') }}</a>
        </div>
      </div>
    </div>
  </footer>
</template>

<script setup>
// Footer logic here
</script>
