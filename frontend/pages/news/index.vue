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
          <span class="text-blue-600 font-medium">{{ $t('common.breadcrumbs.news') }}</span>
        </nav>
      </div>
    </div>

    <!-- Page Header -->
    <section class="bg-slate-900 py-16 lg:py-28 relative overflow-hidden">
      <div class="absolute inset-0 opacity-50">
        <img src="/img/nydt.jpg" class="w-full h-full object-cover">
      </div>
      <div class="container mx-auto px-4 relative z-10 text-center">
        <h1 class="text-3xl lg:text-4xl font-bold text-white mb-4">
          {{ $t('news.list.title') }}
        </h1>
        <p class="text-slate-300 max-w-2xl mx-auto">
          {{ $t('news.list.subtitle') }}
        </p>
      </div>
    </section>

    <!-- Categories / Tabs -->
    <div class="container mx-auto px-4 mt-8 lg:mt-12">
      <div class="flex flex-wrap justify-center gap-4 mb-12">
        <button 
          v-for="cat in categories" 
          :key="cat.id"
          @click="selectCategory(cat.id)"
          :class="[
            'px-6 py-2 rounded-full font-medium transition-all border',
            activeCategoryId === cat.id 
              ? 'bg-blue-600 border-blue-600 text-white shadow-lg shadow-blue-200' 
              : 'bg-white border-gray-200 text-slate-600 hover:border-blue-600 hover:text-blue-600'
          ]"
        >
          {{ cat.name }}
        </button>
      </div>

      <!-- Article Grid -->
      <div v-if="pending" class="py-12 text-center text-slate-500">
        {{ $t('common.status.loading') }}
      </div>
      <div v-else-if="articles.length === 0" class="py-12 text-center text-slate-500">
        {{ $t('common.status.empty') }}
      </div>
      <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        <article 
          v-for="post in articles" 
          :key="post.id"
          class="bg-white rounded-xl overflow-hidden border border-gray-100 shadow-sm hover:shadow-xl transition-all duration-500 group"
        >
          <NuxtLink :to="localePath(`/news/${post.id}`)" class="block aspect-[16/10] overflow-hidden relative">
            <img 
              :src="post.image" 
              :alt="post.title"
              class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110"
              @error="handleCoverError"
            >
            <div class="absolute top-4 left-4 bg-white/90 backdrop-blur-sm px-3 py-1 rounded-full text-xs font-bold text-blue-600 uppercase">
              {{ post.categoryName }}
            </div>
          </NuxtLink>
          <div class="p-6 lg:p-8">
            <div class="flex items-center text-xs text-slate-400 mb-4">
              <i class="ri-calendar-line mr-2"></i>
              {{ post.date }}
            </div>
            <h3 class="text-xl font-bold text-slate-900 mb-4 group-hover:text-blue-600 transition-colors line-clamp-2">
              <NuxtLink :to="localePath(`/news/${post.id}`)">{{ post.title }}</NuxtLink>
            </h3>
            <p class="text-slate-600 text-sm leading-relaxed mb-6 line-clamp-3">
              {{ post.excerpt }}
            </p>
            <NuxtLink 
              :to="localePath(`/news/${post.id}`)"
              class="text-blue-600 font-bold text-sm flex items-center hover:gap-2 transition-all"
            >
              {{ $t('common.actions.learn_more') }}
              <i class="ri-arrow-right-line ml-1"></i>
            </NuxtLink>
          </div>
        </article>
      </div>

      <!-- Pagination -->
      <div v-if="totalPages > 1" class="mt-16 flex justify-center">
        <nav class="flex items-center gap-2">
          <button
            class="w-12 h-12 rounded-2xl border border-gray-200 flex items-center justify-center hover:bg-white hover:border-blue-600 hover:text-blue-600 transition-all disabled:opacity-50"
            :disabled="page <= 1"
            @click="goToPage(page - 1)"
          >
            <i class="ri-arrow-left-s-line text-xl"></i>
          </button>
          <button
            v-for="p in pageNumbers"
            :key="p"
            class="w-12 h-12 rounded-2xl flex items-center justify-center font-bold transition-all"
            :class="p === page ? 'bg-blue-600 text-white shadow-lg shadow-blue-200' : 'border border-gray-200 hover:bg-white hover:border-blue-600 hover:text-blue-600'"
            @click="goToPage(p)"
          >
            {{ p }}
          </button>
          <button
            class="w-12 h-12 rounded-2xl border border-gray-200 flex items-center justify-center hover:bg-white hover:border-blue-600 hover:text-blue-600 transition-all disabled:opacity-50"
            :disabled="page >= totalPages"
            @click="goToPage(page + 1)"
          >
            <i class="ri-arrow-right-s-line text-xl"></i>
          </button>
        </nav>
      </div>
    </div>
  </div>
</template>

<script setup>
const { t, locale } = useI18n()
const localePath = useLocalePath()
const route = useRoute()
const config = useRuntimeConfig()

useHead(() => ({
  title: t('news.seo.title'),
  meta: [
    { name: 'description', content: t('news.seo.description'), key: 'description' },
    { name: 'keywords', content: t('news.seo.keywords'), key: 'keywords' }
  ]
}))

const apiBase = config.public.apiBase
const pageSize = 9

const page = computed(() => {
  const raw = Array.isArray(route.query.page) ? route.query.page[0] : route.query.page
  const n = Number(raw || 1)
  return Number.isFinite(n) && n > 0 ? n : 1
})

const activeCategoryId = computed(() => {
  const raw = Array.isArray(route.query.cateId) ? route.query.cateId[0] : route.query.cateId
  return raw ? String(raw) : 'all'
})

const pickLangValue = (langData) => {
  if (!langData || typeof langData !== 'object') return undefined
  return (
    langData?.[locale.value] ||
    langData?.zh ||
    langData?.en ||
    Object.values(langData)[0]
  )
}

const pickLang = (langData) => {
  const v = pickLangValue(langData)
  if (v && typeof v === 'object') return v
  return {}
}

const pickCategoryName = (langData) => {
  const v = pickLangValue(langData)
  if (typeof v === 'string') return v
  if (v && typeof v === 'object') return v.title || v.name || ''
  return ''
}

const toPlainText = (html) => {
  const s = String(html || '')
  return s
    .replace(/<script[\s\S]*?>[\s\S]*?<\/script>/gi, '')
    .replace(/<style[\s\S]*?>[\s\S]*?<\/style>/gi, '')
    .replace(/<[^>]+>/g, ' ')
    .replace(/\s+/g, ' ')
    .trim()
}

const makeExcerpt = (html, maxLen = 120) => {
  const text = toPlainText(html)
  if (text.length <= maxLen) return text
  return `${text.slice(0, maxLen)}...`
}

const formatDate = (dt) => String(dt || '').slice(0, 10)
const fallbackCover = '/img/a3.jpg'

const normalizeCover = (cover) => {
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

const handleCoverError = (e) => {
  const el = e?.target
  if (!el) return
  if (el.dataset && el.dataset.fallbackApplied === '1') return
  if (el.dataset) el.dataset.fallbackApplied = '1'
  el.src = fallbackCover
}

const { data: categoryRes } = await useFetch('/articles/categories', {
  baseURL: apiBase,
  query: { status: 1 }
})

const remoteCategories = computed(() => categoryRes.value?.data || [])

const categories = computed(() => [
  { id: 'all', name: t('news.categories.all') },
  ...remoteCategories.value.map((c) => ({
    id: String(c.id),
    name: pickCategoryName(c.langData) || String(c.id)
  }))
])

const cateNameById = computed(() => {
  const m = new Map()
  for (const c of remoteCategories.value) {
    m.set(String(c.id), pickCategoryName(c.langData) || String(c.id))
  }
  return m
})

const articleQuery = computed(() => {
  const q = {
    page: page.value,
    limit: pageSize,
    status: 1
  }
  if (activeCategoryId.value !== 'all') q.cateId = Number(activeCategoryId.value)
  return q
})

const { data: articlesRes, pending } = await useFetch('/articles', {
  baseURL: apiBase,
  query: articleQuery,
  watch: [articleQuery, locale]
})

const articlesList = computed(() => {
  return articlesRes.value?.data?.list || articlesRes.value?.data?.items || []
})

const articles = computed(() => {
  return articlesList.value.map((a) => {
    const lang = pickLang(a.langData)
    return {
      id: a.id,
      title: lang?.title || '',
      categoryName: cateNameById.value.get(String(a.cateId)) || '',
      date: formatDate(a.createTime),
      excerpt: lang?.description || makeExcerpt(lang?.content, 120),
      image: normalizeCover(a.cover)
    }
  })
})

const total = computed(() => {
  const data = articlesRes.value?.data || {}
  return Number(data.total ?? data?.page?.total ?? 0)
})
const totalPages = computed(() => Math.max(1, Math.ceil(total.value / pageSize)))

const pageNumbers = computed(() => {
  const totalP = totalPages.value
  const current = page.value
  if (totalP <= 7) return Array.from({ length: totalP }, (_, i) => i + 1)
  const start = Math.max(1, current - 2)
  const end = Math.min(totalP, start + 4)
  const start2 = Math.max(1, end - 4)
  return Array.from({ length: end - start2 + 1 }, (_, i) => start2 + i)
})

const buildQuery = (nextPage, nextCateId) => {
  const q = {}
  if (nextCateId && nextCateId !== 'all') q.cateId = String(nextCateId)
  if (nextPage && nextPage !== 1) q.page = String(nextPage)
  return q
}

const goToPage = (p) => {
  const next = Math.min(Math.max(1, p), totalPages.value)
  return navigateTo({ path: localePath('/news'), query: buildQuery(next, activeCategoryId.value) })
}

const selectCategory = (id) => {
  return navigateTo({ path: localePath('/news'), query: buildQuery(1, id) })
}

</script>
