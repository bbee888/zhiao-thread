<template>
  <div class="bg-gray-50 min-h-screen pb-16">
    <section class="py-10 lg:py-16">
      <div class="container mx-auto px-4 max-w-5xl">
        <div class="grid grid-cols-1 gap-8">
          <div class="text-center">
            <h1 class="text-3xl font-bold text-slate-900 mb-3">{{ $t('inquiry.hero.title') }}</h1>
            <p class="text-slate-600">{{ $t('inquiry.hero.subtitle') }}</p>
          </div>
        </div>
        <div class="h-6"></div>
        <div class="bg-white rounded-2xl border border-gray-100 p-6 lg:p-10 shadow-sm">
          <form class="grid grid-cols-1 md:grid-cols-2 gap-6" @submit.prevent="handleSubmit">
            <div>
              <label class="flex items-center gap-1 text-sm font-semibold text-slate-700">
                <span>{{ $t('inquiry.form.name') }}</span><span class="text-red-600">*</span>
              </label>
              <div class="h-2"></div>
              <input v-model="form.name" required type="text" :placeholder="$t('inquiry.form.placeholder_name')"
                class="w-full h-11 rounded-md border border-gray-200 bg-white px-4 text-sm text-slate-900 placeholder:text-slate-500 focus:outline-none focus:ring-2 focus:ring-blue-600/20 focus:border-blue-600">
            </div>
            <div>
              <label class="flex items-center gap-1 text-sm font-semibold text-slate-700">
                <span>{{ $t('inquiry.form.email') }}</span><span class="text-red-600">*</span>
              </label>
              <div class="h-2"></div>
              <input v-model="form.email" required type="email" :placeholder="$t('inquiry.form.placeholder_email')"
                class="w-full h-11 rounded-md border border-gray-200 bg-white px-4 text-sm text-slate-900 placeholder:text-slate-500 focus:outline-none focus:ring-2 focus:ring-blue-600/20 focus:border-blue-600">
            </div>
            <div>
              <label class="text-sm font-semibold text-slate-700">{{ $t('inquiry.form.company') }}</label>
              <div class="h-2"></div>
              <input v-model="form.company" type="text" :placeholder="$t('inquiry.form.placeholder_company')"
                class="w-full h-11 rounded-md border border-gray-200 bg-white px-4 text-sm text-slate-900 placeholder:text-slate-500 focus:outline-none focus:ring-2 focus:ring-blue-600/20 focus:border-blue-600">
            </div>
            <div>
              <label class="flex items-center gap-1 text-sm font-semibold text-slate-700">
                <span>{{ $t('inquiry.form.phone') }}</span><span class="text-red-600">*</span>
              </label>
              <div class="h-2"></div>
              <input v-model="form.phone" required type="text" :placeholder="$t('inquiry.form.placeholder_phone')"
                class="w-full h-11 rounded-md border border-gray-200 bg-white px-4 text-sm text-slate-900 placeholder:text-slate-500 focus:outline-none focus:ring-2 focus:ring-blue-600/20 focus:border-blue-600">
            </div>
            <div>
              <label class="flex items-center gap-1 text-sm font-semibold text-slate-700">
                <span>{{ $t('inquiry.form.country') }}</span><span class="text-red-600">*</span>
              </label>
              <div class="h-2"></div>
              <select v-model="form.country" required
                class="w-full h-11 rounded-md border border-gray-200 bg-white px-4 text-sm text-slate-900 focus:outline-none focus:ring-2 focus:ring-blue-600/20 focus:border-blue-600">
                <option value="" disabled>{{ $t('inquiry.form.placeholder_country') }}</option>
                <option v-for="code in countries" :key="code" :value="code">
                  {{ $t(`contact.form.countries.${code}`) }}
                </option>
              </select>
            </div>
            <div>
              <label class="text-sm font-semibold text-slate-700">{{ $t('inquiry.form.model') }}</label>
              <div class="h-2"></div>
              <select v-model="form.model"
                class="w-full h-11 rounded-md border border-gray-200 bg-white px-4 text-sm text-slate-900 focus:outline-none focus:ring-2 focus:ring-blue-600/20 focus:border-blue-600">
                <option value="" disabled>{{ $t('inquiry.form.placeholder_model') }}</option>
                <option v-for="item in modelOptions" :key="item.value" :value="item.value">{{ item.label }}</option>
              </select>
            </div>
            <div>
              <label class="text-sm font-semibold text-slate-700">{{ $t('inquiry.form.quantity') }}</label>
              <div class="h-2"></div>
              <input v-model="form.quantity" type="text" :placeholder="$t('inquiry.form.placeholder_quantity')"
                class="w-full h-11 rounded-md border border-gray-200 bg-white px-4 text-sm text-slate-900 placeholder:text-slate-500 focus:outline-none focus:ring-2 focus:ring-blue-600/20 focus:border-blue-600">
            </div>
            <div>
              <label class="text-sm font-semibold text-slate-700">{{ $t('inquiry.form.color') }}</label>
              <div class="h-2"></div>
              <select v-model="form.color"
                class="w-full h-11 rounded-md border border-gray-200 bg-white px-4 text-sm text-slate-900 focus:outline-none focus:ring-2 focus:ring-blue-600/20 focus:border-blue-600">
                <option value="" disabled>{{ $t('inquiry.form.placeholder_color') }}</option>
                <option v-for="item in colorOptions" :key="item.value" :value="item.value">{{ item.label }}</option>
              </select>
            </div>
            <div class="md:col-span-2">
              <label class="flex items-center gap-1 text-sm font-semibold text-slate-700">
                <span>{{ $t('inquiry.form.message') }}</span><span class="text-red-600">*</span>
              </label>
              <div class="h-2"></div>
              <textarea v-model="form.message" required rows="6" :placeholder="$t('inquiry.form.placeholder_message')"
                class="w-full rounded-md border border-gray-200 bg-white p-4 text-sm text-slate-900 placeholder:text-slate-500 focus:outline-none focus:ring-2 focus:ring-blue-600/20 focus:border-blue-600 resize-none"></textarea>
            </div>
            <div class="md:col-span-2">
              <input ref="fileInputRef" type="file" class="hidden" @change="handleFileChange">
              <button type="button"
                class="w-full rounded-md border border-gray-200 bg-white px-6 py-4 flex flex-col items-center justify-center hover:bg-gray-50 transition-colors"
                @click="fileInputRef?.click()">
                <i class="ri-upload-cloud-2-line text-xl text-slate-400"></i>
                <div class="h-2"></div>
                <div class="text-sm text-slate-600 text-center">{{ $t('inquiry.form.upload_title') }}</div>
                <div class="text-xs text-slate-400 text-center">{{ $t('inquiry.form.upload_hint') }}</div>
              </button>
              <div v-if="selectedFileName" class="mt-3 text-sm text-slate-600">
                {{ selectedFileName }}
              </div>
            </div>
            <div class="md:col-span-2">
              <button type="submit" :disabled="loading"
                class="w-full h-14 rounded-lg bg-blue-700 hover:bg-blue-800 disabled:bg-blue-400 text-white font-semibold text-base transition-colors">
                <span v-if="!loading">{{ $t('inquiry.form.submit') }}</span>
                <span v-else>{{ $t('inquiry.form.submitting') }}</span>
              </button>
              <div v-if="submitted" class="mt-3 text-green-600 text-sm">{{ $t('inquiry.form.success_msg') }}</div>
            </div>
          </form>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
const route = useRoute()
const { t, locale } = useI18n()
const config = useRuntimeConfig()
const apiBase = config.public.apiBase

useHead({
  title: t('inquiry.seo.title'),
  meta: [
    { name: 'description', content: t('inquiry.seo.description'), key: 'description' },
    { name: 'keywords', content: t('inquiry.seo.keywords'), key: 'keywords' }
  ]
})

const loading = ref(false)
const submitted = ref(false)
const fileInputRef = ref()
const selectedFileName = ref('')

const countries = ['CN', 'VN', 'TH', 'ID', 'KH', 'FR', 'IT', 'AE', 'US']

const normalizeOptions = (res) => {
  if (Array.isArray(res)) return res
  const d = res?.data ?? res
  if (Array.isArray(d)) return d
  if (Array.isArray(d.list)) return d.list
  if (Array.isArray(d.items)) return d.items
  return []
}

const [{ data: modelRes }, { data: colorRes }] = await Promise.all([
  useFetch('/dicts/model/items/options', { baseURL: apiBase }),
  useFetch('/dicts/color/items/options', { baseURL: apiBase }),
])

const modelOptions = computed(() => normalizeOptions(modelRes.value))
const colorOptions = computed(() => normalizeOptions(colorRes.value))

const form = reactive({
  name: '',
  email: '',
  company: '',
  phone: '',
  country: '',
  model: '',
  quantity: '',
  color: '',
  message: '',
  productId: undefined
})

const applyPrefillFromQuery = () => {
  const { model, productId } = route.query
  form.model = typeof model === 'string' ? model : ''
  form.productId = typeof productId === 'string' && /^\d+$/.test(productId) ? Number(productId) : undefined
}

onMounted(() => {
  applyPrefillFromQuery()
})

const handleFileChange = (e) => {
  const file = e?.target?.files?.[0]
  selectedFileName.value = file?.name || ''
}

const resetForm = () => {
  form.name = ''
  form.email = ''
  form.company = ''
  form.phone = ''
  form.country = ''
  form.model = ''
  form.quantity = ''
  form.color = ''
  form.message = ''
  form.productId = undefined
  selectedFileName.value = ''
  if (fileInputRef.value) fileInputRef.value.value = ''
  applyPrefillFromQuery()
}

const handleSubmit = async () => {
  loading.value = true
  try {
    await $fetch('/inquiries', {
      baseURL: apiBase,
      method: 'POST',
      body: {
        ...form,
        subject: t('inquiry.form.subject_default'),
        locale: locale.value,
        attachmentName: selectedFileName.value || ''
      }
    })
    submitted.value = true
  } finally {
    loading.value = false
  }
  resetForm()
  setTimeout(() => (submitted.value = false), 5000)
}
</script>

<style scoped>
</style>
