<template>
  <div class="bg-gray-50 min-h-screen">
    <div class="bg-white border-b border-gray-100">
      <div class="container mx-auto max-w-7xl px-4 md:px-8 py-4">
        <nav class="flex items-center text-sm text-gray-500">
          <NuxtLink :to="localePath('/')" class="hover:text-blue-600 transition-colors">
            {{ $t('common.breadcrumbs.home') }}
          </NuxtLink>
          <i class="ri-arrow-right-s-line mx-2"></i>
          <span class="text-blue-600 font-medium">{{ $t('common.breadcrumbs.contact') }}</span>
        </nav>
      </div>
    </div>

    <section class="bg-slate-900 py-16 lg:py-32 relative overflow-hidden">
      <div class="absolute inset-0 opacity-80">
        <img src="/img/nylx.jpg" class="w-full h-full object-cover">
      </div>
      <div class="container mx-auto px-4 relative z-10 text-center">
        <h1 class="text-3xl lg:text-4xl font-bold text-white mb-4">
          {{ $t('contact.hero.title') }}
        </h1>
        <p class="text-slate-100 max-w-2xl mx-auto font-light">
          {{ $t('contact.hero.subtitle') }}
        </p>
      </div>
    </section>

    <!-- <section class="bg-gradient-to-r from-blue-800 to-blue-600 py-20 px-4 md:px-8">
      <div class="container mx-auto max-w-7xl">
        <div class="mx-auto w-full max-w-3xl text-center">
          <h1 class="text-5xl font-bold text-white leading-tight">
            {{ $t('contact.hero.title') }}
          </h1>
          <div class="h-4"></div>
          <p class="text-xl text-white/90 font-light">
            {{ $t('contact.hero.subtitle') }}
          </p>
        </div>
      </div>
    </section> -->

    <section class="bg-white py-16 px-4 md:px-8">
      <div class="container mx-auto max-w-7xl">
        <div :class="['flex flex-col gap-12', isRtl ? 'lg:flex-row-reverse' : 'lg:flex-row']">
          <div class="w-full lg:w-[492px]">
            <div class="text-blue-600 font-semibold text-base">
              {{ $t('contact.section.kicker') }}
            </div>
            <div class="h-2"></div>
            <h2 class="text-4xl font-bold text-slate-900">
              {{ $t('contact.section.title') }}
            </h2>
            <div class="h-4"></div>
            <p class="text-slate-600 text-base leading-relaxed">
              {{ $t('contact.section.desc') }}
            </p>
            <div class="h-8"></div>

            <div class="space-y-6">
              <div class="flex items-start gap-4">
                <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center flex-shrink-0">
                  <i class="ri-map-pin-line text-2xl text-blue-700"></i>
                </div>
                <div>
                  <div class="text-lg font-semibold text-slate-900">{{ $t('contact.cards.address.title') }}</div>
                  <div class="h-1"></div>
                  <div class="text-slate-600">{{ $t('contact.cards.address.value') }}</div>
                </div>
              </div>

              <div class="flex items-start gap-4">
                <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center flex-shrink-0">
                  <i class="ri-phone-line text-2xl text-blue-700"></i>
                </div>
                <div>
                  <div class="text-lg font-semibold text-slate-900">{{ $t('contact.cards.phone.title') }}</div>
                  <div class="h-1"></div>
                  <div class="text-slate-600">{{ $t('contact.cards.phone.value') }}</div>
                </div>
              </div>

              <div class="flex items-start gap-4">
                <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center flex-shrink-0">
                  <i class="ri-mail-line text-2xl text-blue-700"></i>
                </div>
                <div>
                  <div class="text-lg font-semibold text-slate-900">{{ $t('contact.cards.email.title') }}</div>
                  <div class="h-1"></div>
                  <div class="text-slate-600">{{ $t('contact.cards.email.value') }}</div>
                </div>
              </div>

              <div class="flex items-start gap-4">
                <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center flex-shrink-0">
                  <i class="ri-time-line text-2xl text-blue-700"></i>
                </div>
                <div>
                  <div class="text-lg font-semibold text-slate-900">{{ $t('contact.cards.hours.title') }}</div>
                  <div class="h-1"></div>
                  <div class="text-slate-600">{{ $t('contact.cards.hours.value_1') }}</div>
                  <div class="text-slate-600">{{ $t('contact.cards.hours.value_2') }}</div>
                </div>
              </div>
            </div>

            <div class="h-12"></div>
            <div class="text-lg font-semibold text-slate-900">{{ $t('contact.follow.title') }}</div>
            <div class="h-4"></div>
            <div class="flex items-center gap-4">
              <a href="#" class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center">
                <i class="ri-facebook-fill text-xl text-blue-700"></i>
              </a>
              <a href="#" class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center">
                <i class="ri-linkedin-fill text-xl text-blue-700"></i>
              </a>
              <a href="#" class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center">
                <i class="ri-instagram-line text-xl text-blue-700"></i>
              </a>
              <a href="#" class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center">
                <i class="ri-whatsapp-line text-xl text-blue-700"></i>
              </a>
              <a href="#" class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center">
                <i class="ri-youtube-fill text-xl text-blue-700"></i>
              </a>
            </div>
          </div>

          <div class="flex-1 rounded-2xl border border-gray-200 bg-gray-50 p-6 md:p-10 shadow-sm">
            <h3 class="text-[28px] font-bold text-slate-900">
              {{ $t('contact.form.title') }}
            </h3>
            <div class="h-2"></div>
            <p class="text-slate-500">
              {{ $t('contact.form.subtitle') }}
            </p>
            <div class="h-8"></div>

            <form @submit.prevent="handleSubmit" class="space-y-6">
              <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                  <label class="flex items-center gap-1 text-sm font-semibold text-slate-700">
                    <span>{{ $t('contact.form.name') }}</span>
                    <span class="text-red-600">*</span>
                  </label>
                  <div class="h-2"></div>
                  <input
                    v-model="form.name"
                    type="text"
                    required
                    :placeholder="$t('contact.form.placeholder_name')"
                    class="w-full h-11 rounded-md border border-gray-200 bg-white px-4 text-sm text-slate-900 placeholder:text-slate-500 focus:outline-none focus:ring-2 focus:ring-blue-600/20 focus:border-blue-600"
                  >
                </div>

                <div>
                  <label class="flex items-center gap-1 text-sm font-semibold text-slate-700">
                    <span>{{ $t('contact.form.email') }}</span>
                    <span class="text-red-600">*</span>
                  </label>
                  <div class="h-2"></div>
                  <input
                    v-model="form.email"
                    type="email"
                    required
                    :placeholder="$t('contact.form.placeholder_email')"
                    class="w-full h-11 rounded-md border border-gray-200 bg-white px-4 text-sm text-slate-900 placeholder:text-slate-500 focus:outline-none focus:ring-2 focus:ring-blue-600/20 focus:border-blue-600"
                  >
                </div>

                <div>
                  <label class="text-sm font-semibold text-slate-700">{{ $t('contact.form.company') }}</label>
                  <div class="h-2"></div>
                  <input
                    v-model="form.company"
                    type="text"
                    :placeholder="$t('contact.form.placeholder_company')"
                    class="w-full h-11 rounded-md border border-gray-200 bg-white px-4 text-sm text-slate-900 placeholder:text-slate-500 focus:outline-none focus:ring-2 focus:ring-blue-600/20 focus:border-blue-600"
                  >
                </div>

                <div>
                  <label class="text-sm font-semibold text-slate-700">{{ $t('contact.form.phone') }}</label>
                  <div class="h-2"></div>
                  <input
                    v-model="form.phone"
                    type="text"
                    :placeholder="$t('contact.form.placeholder_phone')"
                    class="w-full h-11 rounded-md border border-gray-200 bg-white px-4 text-sm text-slate-900 placeholder:text-slate-500 focus:outline-none focus:ring-2 focus:ring-blue-600/20 focus:border-blue-600"
                  >
                </div>

                <div>
                  <label class="flex items-center gap-1 text-sm font-semibold text-slate-700">
                    <span>{{ $t('contact.form.country') }}</span>
                    <span class="text-red-600">*</span>
                  </label>
                  <div class="h-2"></div>
                  <select
                    v-model="form.country"
                    required
                    class="w-full h-11 rounded-md border border-gray-200 bg-white px-4 text-sm text-slate-900 focus:outline-none focus:ring-2 focus:ring-blue-600/20 focus:border-blue-600"
                  >
                    <option value="" disabled>{{ $t('contact.form.placeholder_country') }}</option>
                    <option v-for="code in countries" :key="code" :value="code">
                      {{ $t(`contact.form.countries.${code}`) }}
                    </option>
                  </select>
                </div>

                <div>
                  <label class="text-sm font-semibold text-slate-700">{{ $t('contact.form.interest') }}</label>
                  <div class="h-2"></div>
                  <select
                    v-model="form.interest"
                    class="w-full h-11 rounded-md border border-gray-200 bg-white px-4 text-sm text-slate-900 focus:outline-none focus:ring-2 focus:ring-blue-600/20 focus:border-blue-600"
                  >
                    <option value="" disabled>{{ $t('contact.form.placeholder_interest') }}</option>
                    <option v-for="item in modelOptions" :key="item.value" :value="item.value">
                      {{ item.label }}
                    </option>
                  </select>
                </div>
              </div>

              <div>
                <label class="flex items-center gap-1 text-sm font-semibold text-slate-700">
                  <span>{{ $t('contact.form.subject') }}</span>
                  <span class="text-red-600">*</span>
                </label>
                <div class="h-2"></div>
                <input
                  v-model="form.subject"
                  type="text"
                  required
                  :placeholder="$t('contact.form.placeholder_subject')"
                  class="w-full h-11 rounded-md border border-gray-200 bg-white px-4 text-sm text-slate-900 placeholder:text-slate-500 focus:outline-none focus:ring-2 focus:ring-blue-600/20 focus:border-blue-600"
                >
              </div>

              <div>
                <label class="flex items-center gap-1 text-sm font-semibold text-slate-700">
                  <span>{{ $t('contact.form.message') }}</span>
                  <span class="text-red-600">*</span>
                </label>
                <div class="h-2"></div>
                <textarea
                  v-model="form.message"
                  required
                  rows="6"
                  :placeholder="$t('contact.form.placeholder_message')"
                  class="w-full rounded-md border border-gray-200 bg-white p-4 text-sm text-slate-900 placeholder:text-slate-500 focus:outline-none focus:ring-2 focus:ring-blue-600/20 focus:border-blue-600 resize-none"
                ></textarea>
              </div>

              <div>
                <input ref="fileInputRef" type="file" class="hidden" @change="handleFileChange">
                <button
                  type="button"
                  class="w-full rounded-md border border-gray-200 bg-white px-6 py-4 flex flex-col items-center justify-center hover:bg-gray-50 transition-colors"
                  @click="fileInputRef?.click()"
                >
                  <i class="ri-upload-cloud-2-line text-xl text-slate-400"></i>
                  <div class="h-2"></div>
                  <div class="text-sm text-slate-600 text-center">{{ $t('contact.form.upload_title') }}</div>
                  <div class="text-xs text-slate-400 text-center">{{ $t('contact.form.upload_hint') }}</div>
                </button>
                <div v-if="selectedFileName" class="mt-3 text-sm text-slate-600">
                  {{ selectedFileName }}
                </div>
              </div>

              <div class="pt-2">
                <button
                  type="submit"
                  :disabled="loading"
                  class="w-full h-14 rounded-lg bg-blue-700 hover:bg-blue-800 disabled:bg-blue-400 text-white font-semibold text-base transition-colors"
                >
                  <span v-if="!loading">{{ $t('contact.form.submit') }}</span>
                  <span v-else class="inline-flex items-center justify-center gap-2">
                    <i class="ri-loader-4-line animate-spin"></i>
                    {{ $t('contact.form.submitting') }}
                  </span>
                </button>
              </div>

              <div v-if="submitted" class="text-green-600 font-medium flex items-center gap-2">
                <i class="ri-checkbox-circle-line text-xl"></i>
                {{ $t('contact.form.success_msg') }}
              </div>
            </form>
          </div>
        </div>
      </div>
    </section>


    <section class="bg-white py-16 px-4 md:px-8">
      <div class="container mx-auto max-w-5xl">
        <div class="mx-auto w-full max-w-3xl text-center">
          <div class="text-blue-600 font-semibold text-base">{{ $t('contact.faq.kicker') }}</div>
          <div class="h-2"></div>
          <h2 class="text-4xl font-bold text-slate-900">{{ $t('contact.faq.title') }}</h2>
          <div class="h-4"></div>
          <p class="text-slate-600">{{ $t('contact.faq.subtitle') }}</p>
        </div>
        <div class="h-10"></div>

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
    </section>

    <section class="bg-gradient-to-r from-blue-800 to-blue-600 py-16 px-4 md:px-8">
      <div class="container mx-auto max-w-7xl">
        <div :class="['flex flex-col gap-8', isRtl ? 'lg:flex-row-reverse' : 'lg:flex-row', 'lg:items-center lg:justify-between']">
          <div class="w-full max-w-2xl">
            <h2 class="text-4xl font-bold text-white">{{ $t('contact.cta.title') }}</h2>
            <div class="h-3"></div>
            <p class="text-white/90">{{ $t('contact.cta.subtitle') }}</p>
          </div>

          <div class="flex flex-col sm:flex-row gap-4 w-full lg:w-auto">
            <div class="flex-1 sm:flex-none bg-white rounded-xl px-6 py-4 flex items-center gap-3 shadow-sm">
              <i class="ri-mail-line text-blue-700 text-xl"></i>
              <div class="min-w-0">
                <div class="text-xs text-slate-500">{{ $t('contact.cta.email_label') }}</div>
                <div class="text-slate-900 font-semibold truncate">{{ $t('contact.cards.email.value') }}</div>
              </div>
            </div>
            <div class="flex-1 sm:flex-none bg-emerald-500 rounded-xl px-6 py-4 flex items-center gap-3 shadow-sm">
              <i class="ri-wechat-line text-white text-xl"></i>
              <div class="min-w-0">
                <div class="text-xs text-white/90">{{ $t('contact.cta.wechat_label') }}</div>
                <div class="text-white font-semibold truncate">{{ $t('contact.cards.phone.value') }}</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
const localePath = useLocalePath()
const { t, locale, tm, rt } = useI18n()
const config = useRuntimeConfig()
const apiBase = config.public.apiBase
const isRtl = computed(() => locale.value === 'ar')

useHead(() => ({
  title: t('contact.seo.title'),
  meta: [
    { name: 'description', content: t('contact.seo.description'), key: 'description' },
    { name: 'keywords', content: t('contact.seo.keywords'), key: 'keywords' }
  ]
}))

const loading = ref(false)
const submitted = ref(false)
const form = reactive({
  name: '',
  email: '',
  company: '',
  phone: '',
  country: '',
  interest: '',
  subject: '',
  message: ''
})

const fileInputRef = ref()
const selectedFileName = ref('')

const countries = ['CN', 'VN', 'TH', 'ID', 'KH', 'FR', 'IT', 'AE', 'US']
const { data: modelOptions } = await useAsyncData('dict-model-options', async () => {
  const normalizeOptions = (res) => {
    if (Array.isArray(res)) return res
    if (res && typeof res === 'object') {
      const data = res.data
      if (Array.isArray(data)) return data
      if (data && Array.isArray(data.list)) return data.list
    }
    return []
  }

  const fetchOptions = async (dictCode) => {
    const res = await $fetch(`/dicts/${dictCode}/items/options`, { baseURL: apiBase })
    return normalizeOptions(res)
  }

  try {
    return await fetchOptions('model')
  } catch {
    return []
  }
})

const openFaqIndex = ref(0)
const faqItems = computed(() => tm('contact.faq.items') || [])

const toggleFaq = (index) => {
  openFaqIndex.value = openFaqIndex.value === index ? -1 : index
}

const handleFileChange = (e) => {
  const file = e?.target?.files?.[0]
  selectedFileName.value = file?.name || ''
}

const handleSubmit = async () => {
  loading.value = true
  try {
    await $fetch('/inquiries', {
      baseURL: apiBase,
      method: 'POST',
      body: {
        ...form,
        locale: locale.value,
        attachmentName: selectedFileName.value || ''
      }
    })
    submitted.value = true
  } finally {
    loading.value = false
  }
  form.name = ''
  form.email = ''
  form.company = ''
  form.phone = ''
  form.country = ''
  form.interest = ''
  form.subject = ''
  form.message = ''
  selectedFileName.value = ''
  setTimeout(() => {
    submitted.value = false
  }, 5000)
}
</script>
