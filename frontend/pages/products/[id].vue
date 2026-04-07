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
              <div class="grid grid-cols-2 gap-4 mb-8">
                <div class="bg-slate-50 rounded-xl p-4">
                  <div class="text-xs text-slate-400 uppercase mb-1">{{ $t('products.detail.model') }}</div>
                  <div class="font-semibold text-slate-900">{{ product.model || product.model || '-' }}</div>
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
              <p class="text-slate-600 leading-relaxed mb-6">
                {{ product.longDesc }}
              </p>
              <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                <img :src="product.detailImage1" class="rounded-2xl w-full">
                <img :src="product.detailImage2" class="rounded-2xl w-full">
              </div>
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
const { tm, rt } = useI18n()

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

// Mock dynamic product data based on ID
const product = ref({
  id: route.params.id,
  name: '高强涤纶缝纫线 SP-100',
  categoryName: '涤纶缝纫线',
  sku: 'SEW-PL-100-BLUE',
  model: '40s/2',
  color: 'Blue',
  length: '5000 yards',
  tenacity: 'High',
  spec: '40s/2',
  shortDesc: '这款高品质涤纶缝纫线具有卓越的强度和色牢度，适用于各种中等厚度的织物，是服装制造和家用缝纫的理想选择。',
  longDesc: '我们的高强涤纶缝纫线采用优质涤纶长丝制成，经过精密捻线和先进的染色工艺。具有耐磨损、抗紫外线、耐高温等特点。在高速工业缝纫机上表现卓越，不易断线。通过OEKO-TEX Standard 100认证，环保安全。',
  features: [
    '超高断裂强度，减少缝纫断线率',
    '优异的色牢度，耐洗涤，不退色',
    '表面光滑，经过特殊硅油处理，过机顺滑',
    '通过OEKO-TEX环保认证，不含有害物质'
  ],
  images: [
    'https://images.unsplash.com/photo-1605518216938-7c31b7b14ad0?q=80&w=800&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1528476513691-07e6f563d97f?q=80&w=800&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?q=80&w=800&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1589149098258-3e9102ca63d3?q=80&w=800&auto=format&fit=crop'
  ],
  detailImage1: 'https://images.unsplash.com/photo-1584290867415-527a8475726d?q=80&w=800&auto=format&fit=crop',
  detailImage2: 'https://images.unsplash.com/photo-1544441893-675973e31d85?q=80&w=800&auto=format&fit=crop',
  specTable: {
    '材质': '100% 涤纶',
    '捻向': 'Z捻 (左捻)',
    '颜色': '500+ 可选颜色',
    '包装': '5000码/卷, 12卷/盒',
    '用途': '服装, 衬衫, 内衣, 绣花'
  },
  faqs: [
    { q: '这种线适合哪种缝纫机？', a: '适用于各种工业缝纫机和家用缝纫机。' },
    { q: '起订量是多少？', a: '常规颜色12卷起订，定制颜色需要一定数量。' }
  ]
})

const mainImage = ref(product.value.images?.[0] || '')

const relatedProducts = [
  {
    id: 2,
    name: '纯棉平光缝纫线 CT-200',
    category: 2,
    spec: '20s/2',
    image: 'https://images.unsplash.com/photo-1528476513691-07e6f563d97f?q=80&w=800&auto=format&fit=crop',
    tags: ['棉线', '柔软']
  },
  {
    id: 3,
    name: '尼龙高弹缝纫线 NY-300',
    category: 3,
    spec: '60s/2',
    image: 'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?q=80&w=800&auto=format&fit=crop',
    tags: ['尼龙', '高弹']
  },
  {
    id: 4,
    name: '再生环保涤纶线 RE-400',
    category: 5,
    spec: '40s/2',
    image: 'https://images.unsplash.com/photo-1584290867415-527a8475726d?q=80&w=800&auto=format&fit=crop',
    tags: ['环保', '再生']
  },
  {
    id: 5,
    name: '工业用超高强线 HT-500',
    category: 4,
    spec: '20s/3',
    image: 'https://images.unsplash.com/photo-1544441893-675973e31d85?q=80&w=800&auto=format&fit=crop',
    tags: ['工业', '超强']
  }
]
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
