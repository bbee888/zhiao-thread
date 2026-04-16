<template>
  <div class="bg-white min-h-screen pb-16">
    <!-- Breadcrumbs -->
    <div class="bg-white border-b border-gray-100">
      <div class="container mx-auto px-4 py-4">
        <nav class="flex items-center text-sm text-gray-500">
          <NuxtLink :to="localePath('/')" class="hover:text-blue-600 transition-colors">
            {{ $t('common.breadcrumbs.home') }}
          </NuxtLink>
          <i class="ri-arrow-right-s-line mx-2"></i>
          <NuxtLink :to="localePath('/news')" class="hover:text-blue-600 transition-colors">
            {{ $t('common.breadcrumbs.news') }}
          </NuxtLink>
          <i class="ri-arrow-right-s-line mx-2"></i>
          <span class="text-blue-600 font-medium line-clamp-1">{{ article.title }}</span>
        </nav>
      </div>
    </div>

    <!-- Article Header -->
    <header class="py-12 lg:py-20 bg-slate-50 border-b border-gray-100">
      <div class="container mx-auto px-4">
        <div class="max-w-4xl mx-auto text-center">
          <div class="flex flex-wrap items-center justify-center gap-x-4 gap-y-2 mb-6">
            <span class="px-4 py-1 bg-blue-100 text-blue-600 text-xs font-bold rounded-full uppercase tracking-wider">
              {{ article.categoryName }}
            </span>
            <span class="text-slate-400 text-sm flex items-center">
              <i class="ri-calendar-line mr-2"></i>
              {{ article.date }}
            </span>
          </div>
          <h1 class="text-3xl lg:text-5xl font-bold text-slate-900 mb-8 leading-tight">
            {{ article.title }}
          </h1>
          <p class="text-base sm:text-lg lg:text-xl text-slate-500 leading-relaxed italic">
            {{ article.excerpt }}
          </p>
        </div>
      </div>
    </header>

    <!-- Article Content -->
    <div class="container mx-auto px-4 py-12 lg:py-16">
      <div class="flex flex-col lg:flex-row gap-12 max-w-6xl mx-auto">
        <!-- Main Content -->
        <main class="lg:w-2/3">
          <div v-if="article.image" class="aspect-[16/9] rounded-3xl overflow-hidden mb-12 shadow-2xl">
            <img :src="article.image" :alt="article.title" class="w-full h-full object-cover" @error="handleCoverError">
          </div>
          
          <div class="prose prose-lg prose-slate max-w-none prose-headings:text-slate-900 prose-p:text-slate-600 prose-p:leading-relaxed prose-a:text-blue-600 prose-img:rounded-3xl">
            <div class="my-content" v-html="article.content"></div>
          </div>

          <!-- Share & Back -->
          <div class="mt-16 pt-8 border-t border-gray-100 flex flex-col sm:flex-row justify-between items-center gap-6">
            <div class="flex items-center gap-4">
              <span class="text-sm font-bold text-slate-900 uppercase">{{ $t('news.detail.share') }}</span>
              <button class="w-10 h-10 rounded-full bg-slate-50 text-slate-400 hover:bg-blue-600 hover:text-white transition-all flex items-center justify-center">
                <i class="ri-facebook-fill"></i>
              </button>
              <button class="w-10 h-10 rounded-full bg-slate-50 text-slate-400 hover:bg-blue-400 hover:text-white transition-all flex items-center justify-center">
                <i class="ri-twitter-fill"></i>
              </button>
              <button class="w-10 h-10 rounded-full bg-slate-50 text-slate-400 hover:bg-blue-700 hover:text-white transition-all flex items-center justify-center">
                <i class="ri-linkedin-fill"></i>
              </button>
            </div>
            <NuxtLink 
              :to="localePath('/news')"
              class="flex items-center text-blue-600 font-bold hover:gap-2 transition-all"
            >
              <i class="ri-arrow-left-line mr-2"></i>
              {{ $t('news.detail.back') }}
            </NuxtLink>
          </div>
        </main>

        <!-- Sidebar -->
        <aside class="lg:w-1/3">
          <div class="lg:sticky lg:top-24 space-y-10 lg:space-y-12">
            <!-- Latest News -->
            <div>
              <h3 class="text-xl font-bold text-slate-900 mb-6 flex items-center">
                <span class="w-2 h-6 bg-blue-600 mr-3 rounded-full"></span>
                {{ $t('news.detail.latest') }}
              </h3>
              <div class="space-y-6">
                <NuxtLink 
                  v-for="post in latestNews" 
                  :key="post.id"
                  :to="localePath(`/news/${post.id}`)"
                  class="flex gap-4 group"
                >
                  <div class="w-20 h-20 flex-shrink-0 rounded-xl overflow-hidden bg-gray-100">
                    <img
                      v-if="post.image"
                      :src="post.image"
                      class="w-full h-full object-cover group-hover:scale-110 transition-all duration-500"
                      @error="handleCoverError"
                    >
                  </div>
                  <div>
                    <h4 class="text-sm font-bold text-slate-900 group-hover:text-blue-600 transition-colors line-clamp-2 mb-2">
                      {{ post.title }}
                    </h4>
                    <div class="text-xs text-slate-400">{{ post.date }}</div>
                  </div>
                </NuxtLink>
              </div>
            </div>

            <!-- Categories Card -->
            <div class="bg-slate-50 p-6 sm:p-8 rounded-xl">
              <h3 class="text-xl font-bold text-slate-900 mb-6">{{ $t('news.detail.categories') }}</h3>
              <div class="space-y-3">
                <button
                  v-for="cat in categories"
                  :key="cat.id"
                  type="button"
                  class="w-full flex justify-between items-center group"
                  @click="goToCategory(cat.id)"
                >
                  <span class="text-slate-600 group-hover:text-blue-600 transition-all">{{ cat.name }}</span>
                  <span class="text-xs bg-white px-2 py-1 rounded-md text-slate-400 border border-gray-100 group-hover:border-blue-200 group-hover:text-blue-600 transition-all">
                    {{ cat.count }}
                  </span>
                </button>
              </div>
            </div>
          </div>
        </aside>
      </div>
    </div>
  </div>
</template>

<script setup>
const route = useRoute()
const localePath = useLocalePath()
const { t, locale } = useI18n()
const config = useRuntimeConfig()
const apiBase = process.server ? config.apiBase : config.public.apiBase
const requestURL = useRequestURL()

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

const makeExcerpt = (html, maxLen = 140) => {
  const text = toPlainText(html)
  if (text.length <= maxLen) return text
  return `${text.slice(0, maxLen)}...`
}

const formatDate = (dt) => String(dt || '').slice(0, 10)

const normalizeCover = (cover) => {
  const v = String(cover || '').trim()
  if (!v || v === 'null' || v === 'undefined') return ''
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
  el.src = ''
  el.classList.add('hidden')
}

const { data: categoryRes } = await useFetch('/articles/categories', {
  baseURL: apiBase,
  query: { status: 1 }
})

const remoteCategories = computed(() => categoryRes.value?.data || [])
const cateNameById = computed(() => {
  const m = new Map()
  for (const c of remoteCategories.value) {
    m.set(String(c.id), pickCategoryName(c.langData) || String(c.id))
  }
  return m
})

const articleId = computed(() => {
  const raw = Array.isArray(route.params.id) ? route.params.id[0] : route.params.id
  return String(raw || '')
})

const { data: allArticlesRes } = await useFetch('/articles', {
  baseURL: apiBase,
  query: { page: 1, limit: 1000, status: 1 }
})

const allArticlesList = computed(() => {
  return allArticlesRes.value?.data?.list || allArticlesRes.value?.data?.items || []
})

const rawArticle = computed(() => {
  return allArticlesList.value.find((a) => String(a.id) === articleId.value)
})

if (!rawArticle.value) {
  throw createError({ statusCode: 404, statusMessage: 'Not Found' })
}

const articleLang = computed(() => pickLang(rawArticle.value?.langData))

const article = computed(() => {
  const a = rawArticle.value || {}
  const lang = articleLang.value || {}
  return {
    id: a.id,
    title: lang.title || '',
    rawTitle: lang.title || '',
    categoryName: cateNameById.value.get(String(a.cateId)) || '',
    date: formatDate(a.createTime),
    excerpt: lang.description || makeExcerpt(lang.content, 180),
    image: normalizeCover(a.cover),
    content: lang.content || '',
    keywords: lang.keywords || '',
    description: lang.description || ''
  }
})

const canonicalUrl = computed(() => {
  return `${requestURL.origin}${route.path}`
})

useHead(() => ({
  title: article.value.rawTitle || t('news.seo.title'),
  meta: [
    { name: 'description', content: article.value.description || article.value.excerpt, key: 'description' },
    { name: 'keywords', content: article.value.keywords || t('news.seo.keywords'), key: 'keywords' },
    { property: 'og:title', content: article.value.rawTitle || t('news.seo.title'), key: 'og:title' },
    { property: 'og:description', content: article.value.description || article.value.excerpt, key: 'og:description' },
    { property: 'og:type', content: 'article', key: 'og:type' },
    { property: 'og:url', content: canonicalUrl.value, key: 'og:url' },
    ...(article.value.image ? [{ property: 'og:image', content: article.value.image, key: 'og:image' }] : []),
    { name: 'twitter:card', content: article.value.image ? 'summary_large_image' : 'summary', key: 'twitter:card' },
    { name: 'twitter:title', content: article.value.rawTitle || t('news.seo.title'), key: 'twitter:title' },
    { name: 'twitter:description', content: article.value.description || article.value.excerpt, key: 'twitter:description' },
    ...(article.value.image ? [{ name: 'twitter:image', content: article.value.image, key: 'twitter:image' }] : [])
  ],
  link: [{ rel: 'canonical', href: canonicalUrl.value }]
}))

const { data: latestRes } = await useFetch('/articles', {
  baseURL: apiBase,
  query: { page: 1, limit: 6, status: 1 }
})

const latestNews = computed(() => {
  const list = latestRes.value?.data?.list || latestRes.value?.data?.items || []
  return list
    .filter((a) => String(a.id) !== articleId.value)
    .slice(0, 3)
    .map((a) => {
      const lang = pickLang(a.langData)
      return {
        id: a.id,
        title: lang?.title || '',
        date: formatDate(a.createTime),
        image: normalizeCover(a.cover)
      }
    })
})

const { data: cateCounts } = await useAsyncData(
  'news-cate-counts',
  async () => {
    const entries = await Promise.all(
      remoteCategories.value.map(async (c) => {
        try {
          const res = await $fetch('/articles', {
            baseURL: apiBase,
            query: { page: 1, limit: 1, status: 1, cateId: c.id }
          })
          return [String(c.id), Number(res?.data?.total ?? res?.data?.page?.total ?? 0)]
        } catch {
          return [String(c.id), 0]
        }
      })
    )
    return Object.fromEntries(entries)
  },
  { watch: [remoteCategories, locale] }
)

const categories = computed(() =>
  remoteCategories.value.map((c) => ({
    id: String(c.id),
    name: pickCategoryName(c.langData) || String(c.id),
    count: cateCounts.value?.[String(c.id)] ?? 0
  }))
)

const goToCategory = (id) => {
  return navigateTo({ path: localePath('/news'), query: { cateId: String(id) } })
}
</script>

<style scoped>
.my-content {
  padding: 10px;
}
.my-content :deep(p) {
  margin: 15px 0;
  text-indent: 2em;
}
</style>
