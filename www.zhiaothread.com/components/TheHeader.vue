<template>
  <header class="w-full">
    <!-- Top Bar -->
    <div class="bg-blue-700 text-white py-2 px-4 md:px-8">
      <div class="container mx-auto max-w-7xl flex flex-row justify-between items-center text-sm">
        <div class="flex items-center space-x-2">
          <i class="ri-truck-line"></i>
          <span>{{ $t('common.header.welcome') }}</span>
        </div>
        <div class="flex items-center space-x-4 sm:space-x-6">
          <!-- Language Selector -->
          <div
            ref="localeDropdownRef"
            class="relative flex items-center"
            @mouseenter="openLocaleMenu"
            @mouseleave="scheduleCloseLocaleMenu"
          >
            <button
              type="button"
              class="flex items-center space-x-1 cursor-pointer select-none"
              @click.stop="toggleLocaleMenu"
              @keydown.escape.prevent.stop="closeLocaleMenu"
            >
              <i class="ri-global-line"></i>
              <span>{{ currentLocaleName }}</span>
              <i class="ri-arrow-down-s-line"></i>
            </button>

            <div
              v-show="isLocaleMenuOpen"
              :class="['absolute top-full mt-2 bg-white text-slate-800 shadow-lg rounded-md overflow-hidden z-50 min-w-[140px]', isRtl ? 'left-0' : 'right-0']"
              @mouseenter="openLocaleMenu"
              @mouseleave="scheduleCloseLocaleMenu"
            >
              <button
                v-for="l in availableLocales"
                :key="l.code"
                type="button"
                class="w-full px-4 py-2 text-left hover:bg-blue-50 transition-colors"
                @click.stop="handleLocaleSelect(l.code)"
              >
                {{ l.name }}
              </button>
            </div>
          </div>
          <!-- Currency -->
          <!-- <div class="flex items-center space-x-1">
            <i class="ri-money-dollar-circle-line"></i>
            <span>USD</span>
            <i class="ri-arrow-down-s-line"></i>
          </div> -->
          <!-- Phone -->
          <!-- <div class="flex items-center space-x-1">
            <i class="ri-phone-line"></i>
            <span>+86 138 0000 0000</span>
          </div> -->
        </div>
      </div>
    </div>

    <!-- Main Nav -->
    <nav class="bg-white shadow-sm py-4 px-4 md:px-8 sticky top-0 z-40">
      <div class="container mx-auto max-w-7xl flex justify-between items-center">
        <!-- Logo -->
        <NuxtLink :to="localePath('/')" class="flex items-center space-x-3">
          <div class="w-10 h-10 bg-blue-700 rounded-lg flex items-center justify-center text-white">
            <i class="ri-shining-line text-2xl"></i>
          </div>
          <div class="flex flex-col">
            <span class="text-2xl font-bold text-slate-800 leading-tight">{{ $t('common.header.logo') }}</span>
          </div>
        </NuxtLink>

        <!-- Desktop Menu -->
        <div class="hidden lg:flex items-center space-x-8">
          <template v-for="item in navItems" :key="item.label">
            <div
              v-if="item.hasChild"
              class="relative"
              @mouseenter="openProductsMenu"
              @mouseleave="scheduleCloseProductsMenu"
            >
              <NuxtLink
                :to="resolveTo(item)"
                class="text-slate-600 hover:text-blue-600 font-medium transition-colors"
                active-class="text-blue-600"
              >
                {{ $t(item.label) }}
                <i class="ri-arrow-down-s-line ml-1"></i>
              </NuxtLink>
              <div
                v-show="isProductsMenuOpen"
                class="absolute top-full left-1/2 -translate-x-1/2 mt-3 bg-white border border-gray-100 rounded-xl shadow-xl z-50 min-w-56 overflow-hidden"
                @mouseenter="openProductsMenu"
                @mouseleave="scheduleCloseProductsMenu"
              >
                <NuxtLink
                  v-for="c in productCategories"
                  :key="c.id"
                  :to="localePath({ path: '/products', query: { cateId: String(c.id) } })"
                  class="block px-4 py-3 text-sm text-slate-600 hover:bg-blue-50 hover:text-blue-600 transition-colors"
                >
                  {{ c.name }}
                </NuxtLink>
              </div>
            </div>
            <NuxtLink
              v-else
              :to="resolveTo(item)"
              class="text-slate-600 hover:text-blue-600 font-medium transition-colors"
              active-class="text-blue-600"
            >
              {{ $t(item.label) }}
            </NuxtLink>
          </template>
        </div>

        <!-- Toolbar -->
        <div class="flex items-center space-x-4">
          <NuxtLink
            :to="localePath('/inquiry')"
            class="hidden md:block bg-blue-700 text-white px-6 py-2 rounded-lg font-semibold hover:bg-blue-800 transition-colors"
          >
            {{ $t('common.header.get_quote') }}
          </NuxtLink>
          <!-- Mobile Menu Toggle -->
          <button class="lg:hidden text-slate-600 text-2xl" @click="isMobileMenuOpen = !isMobileMenuOpen">
            <i :class="isMobileMenuOpen ? 'ri-close-line' : 'ri-menu-line'"></i>
          </button>
        </div>
      </div>

      <!-- Mobile Menu -->
      <Transition
        enter-active-class="transition duration-200 ease-out"
        enter-from-class="opacity-0 -translate-y-4"
        enter-to-class="opacity-100 translate-y-0"
        leave-active-class="transition duration-150 ease-in"
        leave-from-class="opacity-100 translate-y-0"
        leave-to-class="opacity-0 -translate-y-4"
      >
        <div v-if="isMobileMenuOpen" class="lg:hidden absolute top-full left-0 w-full bg-white shadow-xl border-t z-50 py-4 px-6 flex flex-col space-y-4">
          <template v-for="item in navItems" :key="item.label">
            <div v-if="item.hasChild" class="border-b border-gray-50 pb-2">
              <button
                type="button"
                class="w-full flex items-center justify-between text-slate-600 hover:text-blue-600 font-medium py-2"
                @click="isProductsMobileOpen = !isProductsMobileOpen"
              >
                <span>{{ $t(item.label) }}</span>
                <i :class="isProductsMobileOpen ? 'ri-arrow-up-s-line' : 'ri-arrow-down-s-line'"></i>
              </button>
              <div v-if="isProductsMobileOpen" class="pb-2">
                <NuxtLink
                  v-for="c in productCategories"
                  :key="c.id"
                  :to="localePath({ path: '/products', query: { cateId: String(c.id) } })"
                  class="block pl-4 py-2 text-sm text-slate-600 hover:text-blue-600"
                  @click="isMobileMenuOpen = false"
                >
                  {{ c.name }}
                </NuxtLink>
              </div>
            </div>
            <NuxtLink
              v-else
              :to="resolveTo(item)"
              class="text-slate-600 hover:text-blue-600 font-medium py-2 border-b border-gray-50"
              @click="isMobileMenuOpen = false"
            >
              {{ $t(item.label) }}
            </NuxtLink>
          </template>
          <NuxtLink
            :to="localePath('/inquiry')"
            class="bg-blue-700 text-white px-6 py-3 rounded-lg font-semibold text-center"
            @click="isMobileMenuOpen = false"
          >
            {{ $t('common.header.get_quote') }}
          </NuxtLink>
        </div>
      </Transition>
    </nav>
  </header>
</template>

<script setup>
const { t, locale, locales, setLocale } = useI18n()
const localePath = useLocalePath()
const config = useRuntimeConfig()
const apiBase = config.public.apiBase
const isMobileMenuOpen = ref(false)
const isRtl = computed(() => locale.value === 'ar')
const isLocaleMenuOpen = ref(false)
const localeDropdownRef = ref()
const closeLocaleTimer = ref()
const isProductsMobileOpen = ref(false)
const isProductsMenuOpen = ref(false)
const closeProductsTimer = ref()

const currentLocaleName = computed(() => {
  return locales.value.find(l => l.code === locale.value)?.name || 'English'
})

const availableLocales = computed(() => {
  return locales.value
})

const navItems = [
  { label: 'common.nav.home', path: '/' },
  { label: 'common.nav.products', path: '/products', hasChild: true },
  { label: 'common.nav.news', path: '/news' },
  { label: 'common.nav.about', path: '/about' },
  { label: 'common.nav.contact', path: '/contact' }
]

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

const productCategories = computed(() => {
  const list = flattenCategoryTree(unwrapListData(categoryRes.value))
  return list.map((c) => ({
    id: c.id,
    name: pickLangValue(c.langData) || t('common.labels.category_fallback', { id: c.id }),
  }))
})

const openProductsMenu = () => {
  if (closeProductsTimer.value) clearTimeout(closeProductsTimer.value)
  isProductsMenuOpen.value = true
}

const closeProductsMenu = () => {
  if (closeProductsTimer.value) clearTimeout(closeProductsTimer.value)
  isProductsMenuOpen.value = false
}

const scheduleCloseProductsMenu = () => {
  if (closeProductsTimer.value) clearTimeout(closeProductsTimer.value)
  closeProductsTimer.value = setTimeout(() => {
    closeProductsMenu()
  }, 180)
}

const openLocaleMenu = () => {
  if (closeLocaleTimer.value) clearTimeout(closeLocaleTimer.value)
  isLocaleMenuOpen.value = true
}

const closeLocaleMenu = () => {
  if (closeLocaleTimer.value) clearTimeout(closeLocaleTimer.value)
  isLocaleMenuOpen.value = false
}

const scheduleCloseLocaleMenu = () => {
  if (closeLocaleTimer.value) clearTimeout(closeLocaleTimer.value)
  closeLocaleTimer.value = setTimeout(() => {
    isLocaleMenuOpen.value = false
  }, 180)
}

const toggleLocaleMenu = () => {
  if (isLocaleMenuOpen.value) {
    closeLocaleMenu()
    return
  }
  openLocaleMenu()
}

const handleLocaleSelect = async (code) => {
  closeLocaleMenu()
  await setLocale(code)
}

onMounted(() => {
  const handler = (e) => {
    const el = localeDropdownRef.value
    if (!el) return
    if (isLocaleMenuOpen.value && !el.contains(e.target)) closeLocaleMenu()
  }
  window.addEventListener('pointerdown', handler)
  onBeforeUnmount(() => {
    window.removeEventListener('pointerdown', handler)
  })
})

const resolveTo = (item) => {
  if (item.anchor) return `${localePath(item.path)}${item.anchor}`
  return localePath(item.path)
}
</script>
