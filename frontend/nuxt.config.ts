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
    defaultLocale: 'zh',
    fallbackLocale: 'en',
    strategy: 'prefix_except_default',
    detectBrowserLanguage: {
      useCookie: true,
      cookieKey: 'i18n_redirected',
      redirectOn: 'root',
    }
  } as any,

  runtimeConfig: {
    public: {
      apiBase: (globalThis as any).process?.env?.NUXT_PUBLIC_API_BASE || 'http://localhost:8000/api/v1'
    }
  },

  css: ['~/assets/css/main.css', 'remixicon/fonts/remixicon.css'],

  app: {
    head: {
      title: '湖北智奥线业_涤纶缝纫线生产厂家_工业缝纫线定制',
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        { name: 'keywords', content: '湖北智奥线业有限公司专注涤纶缝纫线研发生产，提供高品质工业缝纫线、服装专用线，支持定制，货源稳定，欢迎海内外客户洽谈合作。' },
        { name: 'description', content: '湖北智奥线业有限公司专注涤纶缝纫线研发生产销售，提供高品质工业缝纫线、服装专用线，支持定制，货源稳定，欢迎海内外客户洽谈合作。' }
      ],
      link: [
        { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
      ]
    }
  }
})
