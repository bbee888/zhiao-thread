<template>
  <section class="py-24 bg-slate-50">
    <div class="container mx-auto max-w-7xl px-4 md:px-8">
      <!-- Section Header -->
      <div class="flex flex-col md:flex-row items-end justify-between gap-8 mb-16">
        <div class="max-w-2xl">
          <h2 class="text-3xl md:text-4xl font-bold text-slate-900 mb-4">{{ $t('home.products.title') }}</h2>
          <div class="w-20 h-1.5 bg-blue-600 mb-6 rounded-full"></div>
          <p class="text-lg text-slate-600">{{ $t('home.products.subtitle') }}</p>
        </div>
        <NuxtLink to="/products" class="px-8 py-3 bg-white border border-slate-200 text-slate-900 font-bold rounded-full hover:bg-slate-900 hover:text-white hover:border-slate-900 transition-all duration-300">
          {{ $t('home.products.view_all') }}
        </NuxtLink>
      </div>

      <!-- Products Grid -->
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
        <ProductCard v-for="product in products" :key="product.id" :product="product" />
      </div>
    </div>
  </section>
</template>

<script setup>
const { locale } = useI18n()
const config = useRuntimeConfig()
const apiBase = config.public.apiBase

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

const { data: productsRes } = await useFetch('/products', {
  baseURL: apiBase,
  query: { page: 1, limit: 4, status: 1 },
  watch: [locale],
})

const products = computed(() => {
  const list = unwrapItems(productsRes.value)
  return list.map((p) => {
    const lang = p?.langData?.[locale.value] || p?.langData?.zh || {}
    const model = String(p?.model || '')
    return {
      id: p.id,
      name: String(lang?.title || `Product ${p.id}`),
      category: String(p.categoryName || ''),
      description: String(lang?.description || ''),
      image: normalizeCover(p.cover),
      specs: [model, p?.color, p?.length, p?.tenacity].map((v) => String(v || '')).filter(Boolean)
    }
  })
})
</script>
