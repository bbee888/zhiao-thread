<template>
  <div class="group bg-white rounded-xl overflow-hidden border border-slate-100 hover:shadow-xl transition-all duration-300">
    <!-- Product Image -->
    <div class="relative aspect-square overflow-hidden bg-slate-50">
      <NuxtLink :to="localePath(`/products/${product.id}`)" class="block w-full h-full">
        <img :src="product.image" :alt="product.name" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" />
      </NuxtLink>
      <div class="absolute top-4 left-4">
        <span class="px-3 py-1 bg-blue-600 text-white text-xs font-bold rounded-full uppercase tracking-wider">{{ product.category }}</span>
      </div>
    </div>
    
    <!-- Product Info -->
    <div class="p-6">
      <h3 class="text-lg font-bold text-slate-900 mb-2 group-hover:text-blue-600 transition-colors">{{ product.name }}</h3>
      <p class="text-slate-500 text-sm mb-4 line-clamp-2">{{ product.description }}</p>
      
      <!-- Specs -->
      <div class="flex flex-wrap gap-2 mb-6">
        <span v-for="spec in product.specs" :key="spec" class="px-2 py-1 bg-slate-100 text-slate-600 text-xs rounded border border-slate-200">
          {{ spec }}
        </span>
      </div>
      
      <!-- Footer -->
      <div class="flex items-center justify-between pt-4 border-t border-slate-50">
        <NuxtLink :to="localePath(`/products/${product.id}`)" class="text-blue-600 font-semibold text-sm flex items-center gap-1 hover:gap-2 transition-all">
          {{ $t('common.actions.view_details') }}
          <i class="ri-arrow-right-line"></i>
        </NuxtLink>
        <button class="w-10 h-10 flex items-center justify-center rounded-full bg-slate-50 text-slate-400 hover:bg-blue-50 hover:text-blue-600 transition-colors">
          <i class="ri-heart-line"></i>
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
const localePath = useLocalePath()

defineProps({
  product: {
    type: Object,
    required: true
  }
})
</script>
