<template>
  <section class="py-24 bg-white">
    <div class="container mx-auto max-w-7xl px-4 md:px-8">
      <!-- Section Header -->
      <div class="text-center max-w-3xl mx-auto mb-16">
        <h2 class="text-3xl md:text-4xl font-bold text-slate-900 mb-4">{{ $t('home.blog.title') }}</h2>
        <div class="w-20 h-1.5 bg-blue-600 mx-auto mb-6 rounded-full"></div>
        <p class="text-lg text-slate-600">{{ $t('home.blog.subtitle') }}</p>
      </div>

      <!-- Blog Grid -->
      <div class="grid grid-cols-1 md:grid-cols-3 gap-10">
        <article v-for="post in posts" :key="post.id" class="group cursor-pointer">
          <NuxtLink :to="localePath(`/news/${post.id}`)" class="relative aspect-[16/10] rounded-xl overflow-hidden mb-6 block">
            <img
              :src="post.image"
              :alt="post.title"
              class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
              @error="handleCoverError"
            />
            <div class="absolute top-4 left-4">
              <span class="px-3 py-1 bg-white text-slate-900 text-xs font-bold rounded-full shadow-sm">{{ post.category }}</span>
            </div>
          </NuxtLink>
          
          <div class="flex items-center gap-4 text-slate-400 text-sm mb-4">
            <span class="flex items-center gap-1">
              <i class="ri-calendar-line"></i>
              {{ post.date }}
            </span>
            <span class="w-1 h-1 bg-slate-300 rounded-full"></span>
            <span class="flex items-center gap-1">
              <i class="ri-time-line"></i>
              {{ post.readTime }}
            </span>
          </div>
          
          <h3 class="text-xl font-bold text-slate-900 mb-4 group-hover:text-blue-600 transition-colors line-clamp-2">
            <NuxtLink :to="localePath(`/news/${post.id}`)">
              {{ post.title }}
            </NuxtLink>
          </h3>
          
          <p class="text-slate-500 text-sm mb-6 line-clamp-3 leading-relaxed">
            {{ post.excerpt }}
          </p>
          
          <NuxtLink :to="localePath(`/news/${post.id}`)" class="inline-flex items-center gap-2 text-slate-900 font-bold text-sm border-b-2 border-transparent hover:border-blue-600 transition-all pb-1">
            {{ $t('home.blog.read_full') }}
            <i class="ri-arrow-right-line"></i>
          </NuxtLink>
        </article>
      </div>
    </div>
  </section>
</template>

<script setup>
const localePath = useLocalePath()
const { locale } = useI18n()
const config = useRuntimeConfig()
const apiBase = config.public.apiBase
const fallbackCover = '/img/a3.jpg'

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
  el.onerror = null
  el.src = fallbackCover
}

const formatReadTime = (contentHtml) => {
  const text = toPlainText(contentHtml)
  const minutes = Math.max(1, Math.ceil(text.length / 600))
  if (locale.value === 'zh') return `${minutes} 分钟阅读`
  return `${minutes} min read`
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

const { data: articlesRes } = await useFetch('/articles', {
  baseURL: apiBase,
  query: { page: 1, limit: 3, status: 1 },
  watch: [locale]
})

const articlesList = computed(() => {
  return articlesRes.value?.data?.list || articlesRes.value?.data?.items || []
})

const posts = computed(() => {
  return articlesList.value.map((a) => {
    const lang = pickLang(a.langData)
    return {
      id: a.id,
      title: lang?.title || '',
      excerpt: lang?.description || makeExcerpt(lang?.content, 120),
      date: formatDate(a.createTime),
      readTime: formatReadTime(lang?.content),
      category: cateNameById.value.get(String(a.cateId)) || '',
      image: normalizeCover(a.cover)
    }
  })
})
</script>
