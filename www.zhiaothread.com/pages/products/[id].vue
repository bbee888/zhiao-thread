<template>
  <div class="bg-gray-50 min-h-screen pb-16">
    <div v-if="productFetchError" class="container mx-auto px-4 pt-6">
      <div class="rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700">
        {{ productFetchErrorMessage }}
      </div>
    </div>

    <!-- Breadcrumbs -->
    <div class="bg-white border-b border-gray-100">
      <div class="container mx-auto px-4 py-4">
        <nav class="flex items-center text-sm text-gray-500">
          <NuxtLink :to="localePath('/')" class="hover:text-blue-600 transition-colors">
            {{ $t('common.breadcrumbs.home') }}
          </NuxtLink>
          <i class="ri-arrow-right-s-line mx-2"></i>
          <NuxtLink :to="localePath('/products')" class="hover:text-blue-600 transition-colors">
            {{ $t('common.breadcrumbs.products') }}
          </NuxtLink>
          <i class="ri-arrow-right-s-line mx-2"></i>
          <span class="text-blue-600 font-medium">{{ product.name }}</span>
        </nav>
      </div>
    </div>

    <!-- Product Header & Main Info -->
    <section class="py-8 lg:py-12">
      <div class="container mx-auto px-4">
        <div class="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
          <div class="flex flex-col lg:flex-row">
            <!-- Left: Gallery -->
            <div class="lg:w-1/2 p-6 lg:p-10 border-r border-gray-50">
              <div class="aspect-square rounded-xl overflow-hidden bg-gray-100">
                <img 
                  :src="mainImage" 
                  :alt="product.name" 
                  class="w-full h-full object-cover transition-transform duration-500 hover:scale-110"
                >
              </div>
            </div>

            <!-- Right: Details -->
            <div class="lg:w-1/2 p-6 lg:p-10 flex flex-col">
              <div class="mb-6">
                <span class="inline-block px-3 py-1 bg-blue-50 text-blue-600 text-xs font-bold rounded-full uppercase tracking-wider mb-4">
                  {{ product.categoryName }}
                </span>
                <h1 class="text-2xl lg:text-3xl font-bold text-slate-900 mb-4">
                  {{ product.name }}
                </h1>
                <p class="text-slate-600 leading-relaxed">
                  {{ product.shortDesc }}
                </p>
              </div>

              <!-- Quick Specs -->
              <div class="grid grid-cols-1 sm:grid-cols-2 gap-3 sm:gap-4 mb-8">
                <div class="bg-slate-50 rounded-xl p-4">
                  <div class="text-xs text-slate-400 uppercase mb-1">{{ $t('products.detail.model') }}</div>
                  <div class="font-semibold text-slate-900">{{ product.model || product.sku || '-' }}</div>
                </div>
                <div class="bg-slate-50 rounded-xl p-4">
                  <div class="text-xs text-slate-400 uppercase mb-1">{{ $t('products.detail.color') }}</div>
                  <div class="font-semibold text-slate-900">{{ product.color || '-' }}</div>
                </div>
                <div class="bg-slate-50 rounded-xl p-4">
                  <div class="text-xs text-slate-400 uppercase mb-1">{{ $t('products.detail.length') }}</div>
                  <div class="font-semibold text-slate-900">{{ product.length || '-' }}</div>
                </div>
                <div class="bg-slate-50 rounded-xl p-4">
                  <div class="text-xs text-slate-400 uppercase mb-1">{{ $t('products.detail.tenacity') }}</div>
                  <div class="font-semibold text-slate-900">{{ product.tenacity || '-' }}</div>
                </div>
              </div>

              <!-- Action -->
              <div class="mt-auto pt-8 border-t border-gray-50 flex flex-col sm:flex-row gap-4">
                <NuxtLink
                  :to="localePath({ path: '/inquiry', query: { model: product.model || product.sku || '', productId: product.id } })"
                  class="flex-grow bg-blue-600 hover:bg-blue-700 text-white font-bold py-4 px-8 rounded-xl transition-all shadow-lg shadow-blue-200 flex items-center justify-center"
                >
                  <i class="ri-mail-send-line mr-2"></i>
                  {{ $t('products.detail.inquiry') }}
                </NuxtLink>
                <NuxtLink 
                  :to="localePath('/products')" 
                  class="flex-grow sm:flex-grow-0 bg-white hover:bg-gray-50 text-slate-700 font-bold py-4 px-8 rounded-xl border border-gray-200 transition-all flex items-center justify-center"
                >
                  {{ $t('products.detail.back_to_list') }}
                </NuxtLink>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Detail Tabs -->
    <section class="py-8">
      <div class="container mx-auto px-4">
        <div class="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
          <!-- Tab Headers -->
          <div class="flex border-b border-gray-50 overflow-x-auto scrollbar-hide">
            <button 
              v-for="tab in tabs" 
              :key="tab.id"
              @click="activeTab = tab.id"
              :class="[
                'px-8 py-5 text-sm font-bold transition-all whitespace-nowrap border-b-2',
                activeTab === tab.id 
                  ? 'text-blue-600 border-blue-600 bg-blue-50/30' 
                  : 'text-slate-400 border-transparent hover:text-slate-600'
              ]"
            >
              {{ $t(`products.detail.${tab.id}`) }}
            </button>
          </div>

          <!-- Tab Content -->
          <div class="p-6 lg:p-10">
            <div v-show="activeTab === 'description'" class="prose prose-slate max-w-none">
              <div class="text-slate-600 leading-relaxed mb-6" v-html="product.longDesc"></div>
            </div>

            <div v-show="activeTab === 'specifications'">
              <table class="w-full border-collapse">
                <tbody>
                  <tr v-for="(val, key) in product.specTable" :key="key" class="border-b border-gray-50 last:border-0">
                    <td class="py-4 font-semibold text-slate-900 w-1/3">{{ key }}</td>
                    <td class="py-4 text-slate-600">{{ val }}</td>
                  </tr>
                </tbody>
              </table>
            </div>

            <div v-show="activeTab === 'faq'">
              <div class="space-y-4">
                <div
                  v-for="(item, index) in faqItems"
                  :key="index"
                  class="rounded-xl border border-gray-100 bg-gray-50"
                >
                  <button
                    type="button"
                    class="w-full px-6 py-5 flex items-center justify-between gap-6 text-left"
                    @click="toggleFaq(index)"
                  >
                    <span class="text-slate-900 font-semibold">{{ rt(item.q) }}</span>
                    <i
                      :class="openFaqIndex === index ? 'ri-subtract-line text-blue-600' : 'ri-add-line text-slate-400'"
                      class="text-xl"
                    ></i>
                  </button>
                  <div v-if="openFaqIndex === index" class="px-6 pb-6 text-slate-600 leading-relaxed">
                    {{ rt(item.a) }}
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Related Products -->
    <section class="py-12 lg:py-16">
      <div class="container mx-auto px-4">
        <h2 class="text-2xl font-bold text-slate-900 mb-8 flex items-center">
          <span class="w-8 h-1 bg-blue-600 mr-4 rounded-full"></span>
          {{ $t('products.detail.related_products') }}
        </h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
          <ProductCard 
            v-for="item in relatedProducts" 
            :key="item.id" 
            :product="item" 
          />
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
const route = useRoute()
const localePath = useLocalePath()
const { t, tm, rt, locale } = useI18n()
const requestURL = useRequestURL()
const config = useRuntimeConfig()
const apiBase = process.server ? config.apiBase : config.public.apiBase

const unwrapItem = (res) => {
  if (!res) return undefined
  if (res && typeof res === 'object' && 'data' in res) return res.data
  return res
}

const normalizeAssetUrl = (value) => {
  const v = String(value || '').trim()
  if (!v || v === 'null' || v === 'undefined') return ''
  if (/^https?:\/\//i.test(v)) return v
  try {
    const origin = new URL(apiBase).origin
    return `${origin}${v.startsWith('/') ? '' : '/'}${v}`
  } catch {
    return v
  }
}

const id = computed(() => String(route.params.id || ''))

const { data: productRes, error: productFetchError } = await useFetch(() => `/products/${id.value}`, {
  baseURL: apiBase,
  watch: [id, locale],
})

const productFetchErrorMessage = computed(() => {
  if (!productFetchError.value) return ""
  const statusCode = productFetchError.value?.statusCode
  return statusCode ? `Failed to load product (HTTP ${statusCode})` : "Failed to load product"
})

const product = computed(() => {
  const raw = unwrapItem(productRes.value) || {}
  const lang = raw?.langData?.[locale.value] || raw?.langData?.zh || {}
  const categoryLang = raw?.categoryLangData?.[locale.value] || raw?.categoryLangData?.zh || {}

  const images = Array.isArray(raw.images) ? raw.images : []
  const normalizedImages = images.map(normalizeAssetUrl).filter(Boolean)

  const cover = normalizeAssetUrl(raw.cover)
  const detailImage1 = normalizeAssetUrl(raw.detailImage1)
  const detailImage2 = normalizeAssetUrl(raw.detailImage2)

  const longDesc = String(lang?.content || raw.longDesc || raw.content || '').trim() || String(lang?.description || '').trim()
  const shortDesc = String(lang?.description || raw.shortDesc || '').trim() || longDesc.slice(0, 160)

  const specTableRaw = raw?.specTable && typeof raw.specTable === 'object' ? raw.specTable : undefined
  const specTable = specTableRaw || {
    [t('products.detail.model')]: raw.model || raw.sku || '-',
    [t('products.detail.color')]: raw.color || '-',
    [t('products.detail.length')]: raw.length || '-',
    [t('products.detail.tenacity')]: raw.tenacity || '-',
  }

  return {
    id: raw.id ?? (Number(id.value) || 0),
    name: String(lang?.title || raw.name || `Product ${id.value}`),
    sku: raw.sku,
    model: raw.model,
    color: raw.color,
    length: raw.length,
    tenacity: raw.tenacity,
    categoryName: String(categoryLang?.name || raw.categoryName || ''),
    shortDesc,
    longDesc,
    cover,
    images: normalizedImages.length ? normalizedImages : (cover ? [cover] : []),
    detailImage1: detailImage1 || (cover || ''),
    detailImage2: detailImage2 || (cover || ''),
    specTable,
  }
})

const activeTab = ref('description')
const tabs = [
  { id: 'description' },
  { id: 'specifications' },
  { id: 'faq' }
]

const openFaqIndex = ref(0)
const faqItems = computed(() => tm('contact.faq.items') || [])
const toggleFaq = (index) => {
  openFaqIndex.value = openFaqIndex.value === index ? -1 : index
}


const mainImage = computed(() => product.value.images?.[0] || '/img/ba2.jpg')

const canonicalUrl = computed(() => {
  return `${requestURL.origin}${route.path}`
})

const pageTitle = computed(() => {
  const name = String(product.value?.name || '').trim()
  return name ? `${name} - ${t('products.seo.title')}` : t('products.seo.title')
})

const pageDescription = computed(() => {
  return String(product.value?.shortDesc || '').trim() || t('products.seo.description')
})

useHead(() => ({
  title: pageTitle.value,
  meta: [
    { name: 'description', content: pageDescription.value, key: 'description' },
    { name: 'keywords', content: t('products.seo.keywords'), key: 'keywords' },
    { property: 'og:title', content: pageTitle.value, key: 'og:title' },
    { property: 'og:description', content: pageDescription.value, key: 'og:description' },
    { property: 'og:type', content: 'product', key: 'og:type' },
    { property: 'og:url', content: canonicalUrl.value, key: 'og:url' },
    ...(mainImage.value ? [{ property: 'og:image', content: mainImage.value, key: 'og:image' }] : []),
    { name: 'twitter:card', content: mainImage.value ? 'summary_large_image' : 'summary', key: 'twitter:card' },
    { name: 'twitter:title', content: pageTitle.value, key: 'twitter:title' },
    { name: 'twitter:description', content: pageDescription.value, key: 'twitter:description' },
    ...(mainImage.value ? [{ name: 'twitter:image', content: mainImage.value, key: 'twitter:image' }] : [])
  ],
  link: [{ rel: 'canonical', href: canonicalUrl.value }]
}))

const relatedProducts = []

</script>

<style scoped>
.scrollbar-hide::-webkit-scrollbar {
  display: none;
}
.scrollbar-hide {
  -ms-overflow-style: none;
  scrollbar-width: none;
}
</style>
