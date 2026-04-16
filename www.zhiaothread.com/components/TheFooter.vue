<template>
  <footer class="bg-slate-900 text-slate-300 pt-12 sm:pt-16 pb-8">
    <div class="container mx-auto max-w-7xl px-4 md:px-8">
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-10 lg:gap-12 mb-10 sm:mb-12">
        <!-- Brand Info -->
        <div class="flex flex-col space-y-6">
          <NuxtLink :to="localePath('/')" class="flex items-center space-x-3 text-white">
            <div class="w-10 h-10 bg-blue-600 rounded-lg flex items-center justify-center">
              <i class="ri-shining-line text-2xl"></i>
            </div>
            <span class="text-xl font-bold tracking-tight">{{ $t('common.header.logo') }}</span>
          </NuxtLink>
          <p class="text-sm leading-relaxed">
            {{ $t('common.footer.desc') }}
          </p>
          <div class="flex flex-wrap gap-3 sm:gap-4">
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
            <li><NuxtLink :to="localePath('/')" class="hover:text-blue-400 transition-colors">{{ $t('common.nav.home') }}</NuxtLink></li>
            <li><NuxtLink :to="localePath('/products')" class="hover:text-blue-400 transition-colors">{{ $t('common.nav.products') }}</NuxtLink></li>
            <li><NuxtLink :to="localePath('/news')" class="hover:text-blue-400 transition-colors">{{ $t('common.nav.news') }}</NuxtLink></li>
            <li><NuxtLink :to="localePath('/about')" class="hover:text-blue-400 transition-colors">{{ $t('common.nav.about') }}</NuxtLink></li>
            <li><NuxtLink :to="localePath('/contact')" class="hover:text-blue-400 transition-colors">{{ $t('common.nav.contact') }}</NuxtLink></li>
          </ul>
        </div>

        <!-- Product Categories -->
        <div>
          <h4 class="text-white font-bold mb-6">{{ $t('common.footer.product_categories') }}</h4>
          <ul class="space-y-4 text-sm">
            <li v-for="c in footerCategories" :key="c.id">
              <NuxtLink
                :to="localePath({ path: '/products', query: { cateId: String(c.id) } })"
                class="hover:text-blue-400 transition-colors"
              >
                {{ c.name }}
              </NuxtLink>
            </li>
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
      <div class="pt-8 border-t border-slate-800 flex flex-col md:flex-row justify-center items-center text-xs gap-4">
        <p>&copy; {{ new Date().getFullYear() }} {{ $t('common.header.logo') }}. {{ $t('common.footer.copyright') }}</p>
      </div>
    </div>
  </footer>
</template>

<script setup>
const { t, locale } = useI18n()
const localePath = useLocalePath()
const config = useRuntimeConfig()
const apiBase = process.server ? config.apiBase : config.public.apiBase

const unwrapListData = (res) => {
  if (!res) return []
  if (Array.isArray(res)) return res
  if (res && typeof res === 'object') {
    const d = res.data ?? res
    if (Array.isArray(d)) return d
    if (Array.isArray(d.items)) return d.items
    if (Array.isArray(d.list)) return d.list
    if (d && typeof d === 'object' && Array.isArray(d.data)) return d.data
  }
  return []
}

const pickLangValue = (langData) => {
  if (!langData || typeof langData !== 'object') return ''
  return langData?.[locale.value] ?? langData?.zh ?? Object.values(langData)[0] ?? ''
}

const flattenCategoryTree = (nodes) => {
  const res = []
  const stack = Array.isArray(nodes) ? [...nodes] : []
  while (stack.length) {
    const n = stack.shift()
    if (!n) continue
    res.push(n)
    if (Array.isArray(n.children) && n.children.length) {
      stack.unshift(...n.children)
    }
  }
  return res
}

const { data: categoryRes } = await useFetch('/products/categories', {
  baseURL: apiBase,
  query: { status: 1 },
  watch: [locale],
})

const footerCategories = computed(() => {
  const list = flattenCategoryTree(unwrapListData(categoryRes.value))
  return list.slice(0, 5).map((c) => ({
    id: c.id,
    name: pickLangValue(c.langData) || t('common.labels.category_fallback', { id: c.id }),
  }))
})
</script>
