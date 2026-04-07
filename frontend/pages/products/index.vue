<template>
  <div class="bg-gray-50 min-h-screen pb-16">
    <!-- Breadcrumbs -->
    <div class="bg-white border-b border-gray-100">
      <div class="container mx-auto px-4 py-4">
        <nav class="flex items-center text-sm text-gray-500">
          <NuxtLink :to="localePath('/')" class="hover:text-blue-600 transition-colors">
            {{ $t('common.breadcrumbs.home') }}
          </NuxtLink>
          <i class="ri-arrow-right-s-line mx-2"></i>
          <span class="text-blue-600 font-medium">{{ $t('common.breadcrumbs.products') }}</span>
        </nav>
      </div>
    </div>

    <!-- Page Header -->
    <section class="relative border-b border-gray-200 py-12 lg:py-24 overflow-hidden">
      <div class="absolute inset-0">
        <img src="/img/nypro.jpg" alt="" class="w-full h-full object-cover">
        <div class="absolute inset-0 bg-white/60"></div>
      </div>
      <div class="container mx-auto px-4 text-center lg:text-left relative">
        <h1 class="text-3xl lg:text-4xl font-bold text-slate-900 mb-4">
          {{ $t('products.list.title') }}
        </h1>
        <p class="text-lg text-slate-600 max-w-2xl">
          {{ $t('products.list.subtitle') }}
        </p>
      </div>
    </section>

    <!-- Main Content -->
    <div class="container mx-auto px-4 mt-8 lg:mt-12">
      <div class="flex flex-col lg:flex-row gap-8">
        <!-- Sidebar Filters -->
        <aside class="w-full lg:w-64 flex-shrink-0">
          <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6 sticky top-24">
            <h2 class="text-lg font-bold text-slate-900 mb-6 flex items-center">
              <i class="ri-filter-3-line mr-2 text-blue-600"></i>
              {{ $t('products.list.filter_title') }}
            </h2>

            <!-- Categories -->
            <div class="mb-8">
              <h3 class="text-sm font-semibold text-slate-900 uppercase tracking-wider mb-4">
                {{ $t('products.list.categories') }}
              </h3>
              <ul class="space-y-2">
                <li v-for="cat in categories" :key="cat.id">
                  <label class="flex items-center group cursor-pointer">
                    <input 
                      type="checkbox" 
                      v-model="selectedCategories" 
                      :value="cat.id"
                      class="w-4 h-4 rounded border-gray-300 text-blue-600 focus:ring-blue-500"
                    >
                    <span class="ml-3 text-slate-600 group-hover:text-blue-600 transition-colors">
                      {{ cat.name }}
                    </span>
                  </label>
                </li>
              </ul>
            </div>

            <!-- Specifications -->
            <div class="mb-8">
              <h3 class="text-sm font-semibold text-slate-900 uppercase tracking-wider mb-4">
                {{ $t('products.list.specs') }}
              </h3>
              <div class="grid grid-cols-2 gap-2">
                <button 
                  v-for="spec in specs"
                  :key="spec.value"
                  @click="toggleSpec(spec.value)"
                  :class="[
                    'px-3 py-2 text-xs font-medium rounded-lg border transition-all',
                    selectedSpecs.includes(spec.value) 
                      ? 'bg-blue-600 border-blue-600 text-white' 
                      : 'bg-white border-gray-200 text-slate-600 hover:border-blue-600 hover:text-blue-600'
                  ]"
                >
                  {{ spec.label }}
                </button>
              </div>
            </div>

            <!-- Reset Button -->
            <button 
              @click="resetFilters"
              class="w-full py-2 text-sm text-gray-500 hover:text-blue-600 transition-colors flex items-center justify-center border border-dashed border-gray-200 rounded-lg"
            >
              <i class="ri-refresh-line mr-2"></i>
              重置筛选
            </button>
          </div>
        </aside>

        <!-- Product Grid -->
        <main class="flex-grow">
          <!-- Top Bar -->
          <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-4 mb-6 flex flex-col sm:flex-row justify-between items-center gap-4">
            <div class="text-slate-600 text-sm">
              {{ $t('products.list.items_count', { count: totalProducts }) }}
            </div>
            <div class="relative w-full sm:w-64">
              <input 
                type="text" 
                v-model="searchQuery"
                :placeholder="$t('products.list.search_placeholder')"
                class="w-full pl-10 pr-4 py-2 bg-gray-50 border border-gray-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-500 transition-all"
              >
              <i class="ri-search-line absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"></i>
            </div>
          </div>

          <!-- Grid -->
          <div v-if="filteredProducts.length > 0" class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-6">
            <ProductCard 
              v-for="product in filteredProducts" 
              :key="product.id" 
              :product="product" 
            />
          </div>

          <!-- Empty State -->
          <div v-else class="bg-white rounded-xl border border-gray-100 p-12 text-center">
            <div class="w-20 h-20 bg-gray-50 rounded-full flex items-center justify-center mx-auto mb-4">
              <i class="ri-search-eye-line text-4xl text-gray-300"></i>
            </div>
            <h3 class="text-lg font-bold text-slate-900 mb-2">
              {{ $t('products.list.no_results') }}
            </h3>
            <button 
              @click="resetFilters"
              class="text-blue-600 font-medium hover:underline"
            >
              尝试清除所有筛选条件
            </button>
          </div>

          <!-- Pagination -->
          <div v-if="totalPages > 1" class="mt-12 flex justify-center">
            <nav class="flex items-center gap-2">
              <button
                class="w-10 h-10 rounded-lg border border-gray-200 flex items-center justify-center hover:bg-white hover:border-blue-600 hover:text-blue-600 transition-all disabled:opacity-50"
                :disabled="page <= 1"
                @click="goPage(page - 1)"
              >
                <i class="ri-arrow-left-s-line"></i>
              </button>
              <button
                v-for="p in pageNumbers"
                :key="p"
                type="button"
                :class="[
                  'w-10 h-10 rounded-lg flex items-center justify-center font-bold transition-all',
                  p === page
                    ? 'bg-blue-600 text-white'
                    : 'border border-gray-200 hover:bg-white hover:border-blue-600 hover:text-blue-600'
                ]"
                @click="goPage(p)"
              >
                {{ p }}
              </button>
              <button
                class="w-10 h-10 rounded-lg border border-gray-200 flex items-center justify-center hover:bg-white hover:border-blue-600 hover:text-blue-600 transition-all disabled:opacity-50"
                :disabled="page >= totalPages"
                @click="goPage(page + 1)"
              >
                <i class="ri-arrow-right-s-line"></i>
              </button>
            </nav>
          </div>
        </main>
      </div>
    </div>
  </div>
</template>

<script setup>
const { t, locale } = useI18n()
const config = useRuntimeConfig()
const apiBase = config.public.apiBase

useHead({
  title: t('products.seo.title'),
  meta: [
    { name: 'description', content: t('products.seo.description'), key: 'description' },
    { name: 'keywords', content: t('products.seo.keywords'), key: 'keywords' }
  ]
})
const localePath = useLocalePath()
const route = useRoute()

const searchQuery = ref('')
const selectedCategories = ref([])
const selectedSpecs = ref([])
const page = ref(1)
const limit = ref(9)

watch(
  () => route.query.cateId,
  (v) => {
    if (v === undefined || v === null || v === '') return
    const id = Number(Array.isArray(v) ? v[0] : v)
    if (!Number.isFinite(id)) return
    selectedCategories.value = [id]
    page.value = 1
  },
  { immediate: true }
)

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

const unwrapItems = (res) => {
  if (!res) return []
  if (Array.isArray(res)) return res
  if (res && typeof res === 'object') {
    const d = res.data ?? res
    if (Array.isArray(d.items)) return d.items
    if (Array.isArray(d.list)) return d.list
    if (Array.isArray(d)) return d
  }
  return []
}

const unwrapTotal = (res) => {
  if (!res || typeof res !== 'object') return 0
  const d = res.data ?? res
  if (d && typeof d === 'object') {
    const v = d.total ?? d?.data?.total
    return Number(v || 0)
  }
  return 0
}

const pickLangValue = (langData) => {
  if (!langData || typeof langData !== 'object') return ''
  return langData?.[locale.value] ?? langData?.zh ?? Object.values(langData)[0] ?? ''
}

const normalizeCover = (cover) => {
  const fallbackCover = '/img/a3.jpg'
  const v = String(cover || '').trim()
  if (!v || v === 'null' || v === 'undefined') return fallbackCover
  if (/^https?:\/\//i.test(v)) return v
  try {
    const origin = new URL(apiBase).origin
    return `${origin}${v.startsWith('/') ? '' : '/'}${v}`
  } catch {
    return v
  }
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
  query: { status: 1 }
})

const categories = computed(() => {
  const list = flattenCategoryTree(unwrapListData(categoryRes.value))
  return list.map((c) => ({
    id: c.id,
    name: pickLangValue(c.langData) || `分类 ${c.id}`
  }))
})

const cateNameById = computed(() => {
  const m = new Map()
  for (const c of categories.value) {
    m.set(Number(c.id), c.name)
  }
  return m
})

const { data: modelRes } = await useFetch('/dicts/model/items/options', {
  baseURL: apiBase
})

const specs = computed(() => {
  const list = unwrapListData(modelRes.value)
  return list.map((i) => ({
    value: String(i.value ?? ''),
    label: String(i.label ?? i.value ?? '')
  })).filter((i) => i.value)
})

const cateId = computed(() => (selectedCategories.value.length === 1 ? selectedCategories.value[0] : undefined))
const productsQuery = computed(() => ({
  page: page.value,
  limit: limit.value,
  status: 1,
  cateId: cateId.value,
  keywords: searchQuery.value || undefined,
}))

watch([selectedCategories, selectedSpecs, searchQuery], () => {
  page.value = 1
}, { deep: true })

const { data: productsRes } = await useFetch('/products', {
  baseURL: apiBase,
  query: productsQuery,
  watch: [productsQuery, locale],
})

const totalProducts = computed(() => unwrapTotal(productsRes.value))
const totalPages = computed(() => Math.max(1, Math.ceil(totalProducts.value / limit.value)))
const pageNumbers = computed(() => {
  const total = totalPages.value
  const cur = page.value
  const start = Math.max(1, cur - 2)
  const end = Math.min(total, start + 4)
  const start2 = Math.max(1, end - 4)
  const res = []
  for (let p = start2; p <= end; p += 1) res.push(p)
  return res
})

const goPage = (p) => {
  const next = Math.min(totalPages.value, Math.max(1, Number(p) || 1))
  page.value = next
}

const allProducts = computed(() => {
  const list = unwrapItems(productsRes.value)
  return list.map((p) => {
    const lang = p?.langData?.[locale.value] || p?.langData?.zh || {}
    const name = String(lang?.title || '')
    const description = String(lang?.description || '')
    const model = String(p?.model || '')
    const categoryId = Number(p?.cateId || 0)
    return {
      id: p.id,
      name: name || `Product ${p.id}`,
      description,
      image: normalizeCover(p.cover),
      category: cateNameById.value.get(categoryId) || String(p.categoryName || ''),
      categoryId,
      model,
      specs: [model, p?.color, p?.length, p?.tenacity].map((v) => String(v || '')).filter(Boolean)
    }
  })
})

const filteredProducts = computed(() => {
  return allProducts.value.filter((product) => {
    const matchesSearch = product.name.toLowerCase().includes(searchQuery.value.toLowerCase())
    const matchesCategory =
      selectedCategories.value.length === 0 || selectedCategories.value.includes(product.categoryId)
    const matchesSpec = selectedSpecs.value.length === 0 || selectedSpecs.value.includes(product.model)
    return matchesSearch && matchesCategory && matchesSpec
  })
})

const toggleSpec = (spec) => {
  const index = selectedSpecs.value.indexOf(spec)
  if (index > -1) {
    selectedSpecs.value.splice(index, 1)
  } else {
    selectedSpecs.value.push(spec)
  }
}

const resetFilters = () => {
  searchQuery.value = ''
  selectedCategories.value = []
  selectedSpecs.value = []
  page.value = 1
}
</script>

<style scoped>
/* Custom checkbox styling if needed */
input[type="checkbox"] {
  @apply transition-all duration-200;
}
</style>
