// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',
  devtools: { enabled: true },
  modules: ['@nuxtjs/tailwindcss', '@nuxtjs/i18n'],

  i18n: {
    locales: [
      { code: 'zh', name: '中文', file: 'zh.json' },
      { code: 'en', name: 'English', file: 'en.json' },
      { code: 'ar', name: 'العربية', file: 'ar.json', dir: 'rtl' },
      { code: 'th', name: 'ไทย', file: 'th.json' },
      { code: 'ms', name: 'Melayu', file: 'ms.json' },
      { code: 'id', name: 'Bahasa Indonesia', file: 'id.json' },
      { code: 'vi', name: 'Tiếng Việt', file: 'vi.json' },
      { code: 'fr', name: 'Français', file: 'fr.json' },
      { code: 'it', name: 'Italiano', file: 'it.json' },
      { code: 'km', name: 'ភាសាខ្មែរ', file: 'km.json' }
    ],
    lazy: true,
    langDir: '../lang',
    defaultLocale: 'en',
    fallbackLocale: 'en',
    strategy: 'prefix_except_default',
    detectBrowserLanguage: false,
    seo: true,
    baseUrl: (globalThis as any).process?.env?.NUXT_PUBLIC_SITE_URL || (globalThis as any).process?.env?.SITE_URL || ''
  } as any,

  runtimeConfig: {
    public: {
      apiBase: (globalThis as any).process?.env?.NUXT_PUBLIC_API_BASE || 'http://localhost:8000/api/v1',
      siteUrl: (globalThis as any).process?.env?.NUXT_PUBLIC_SITE_URL || (globalThis as any).process?.env?.SITE_URL || ''
    }
  },

  css: ['~/assets/css/main.css', 'remixicon/fonts/remixicon.css'],

  app: {
    head: {
      titleTemplate: '%s',
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        { name: 'robots', content: 'index,follow' }
      ],
      link: [
        { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
      ]
    }
  }
})
