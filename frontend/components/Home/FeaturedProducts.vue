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
const { t } = useI18n()

// Mock data - in production this would come from an API
const products = [
  {
    id: 1,
    name: '100% Spun Polyester Sewing Thread',
    category: 'Polyester',
    description: 'High tenacity, low shrinkage, and excellent color fastness. Ideal for apparel, sportswear, and home textiles.',
    image: 'https://images.unsplash.com/photo-1605810230434-7631ac76ec81?w=800&auto=format&fit=crop&q=60',
    specs: ['40/2', '20/2', '50/3']
  },
  {
    id: 2,
    name: 'High Tenacity Nylon 66 Thread',
    category: 'Nylon',
    description: 'Superior strength and durability. Perfect for leather goods, footwear, and automotive upholstery.',
    image: 'https://images.unsplash.com/photo-1584184924103-e310d9dc82fc?w=800&auto=format&fit=crop&q=60',
    specs: ['210D/3', '280D/3', '420D/3']
  },
  {
    id: 3,
    name: 'Premium Cotton Sewing Thread',
    category: 'Cotton',
    description: 'Natural touch and soft feel. Suitable for delicate fabrics, children\'s wear, and organic clothing.',
    image: 'https://images.unsplash.com/photo-1528476513691-07e6f563d97f?w=800&auto=format&fit=crop&q=60',
    specs: ['40/2', '50/3', '60/3']
  },
  {
    id: 4,
    name: 'Core Spun Sewing Thread',
    category: 'Core Spun',
    description: 'Combining the strength of polyester core with the softness of cotton or polyester wrap.',
    image: 'https://images.unsplash.com/photo-1544441893-675973e31985?w=800&auto=format&fit=crop&q=60',
    specs: ['29tex', '40tex', '60tex']
  }
]
</script>
