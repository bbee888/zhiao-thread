<template>
  <section id="quality" class="py-24 bg-slate-900 text-white overflow-hidden relative scroll-mt-24">
    <!-- Decorative background element -->
    <div class="absolute top-0 right-0 w-1/2 h-full bg-blue-600/10 skew-x-12 translate-x-1/4"></div>
    
    <div class="container mx-auto max-w-7xl px-4 md:px-8 relative z-10">
      <div class="flex flex-col lg:flex-row items-center gap-16">
        <!-- Left: Text Content -->
        <div class="lg:w-1/2">
          <span class="inline-block px-4 py-1 bg-blue-600/20 text-blue-400 text-xs font-bold rounded-full mb-6 uppercase tracking-widest border border-blue-600/30">
            {{ $t('home.trust.assurance') }}
          </span>
          <h2 class="text-3xl md:text-5xl font-bold mb-8 leading-tight">
            {{ $t('home.trust.title') }}
          </h2>
          <p class="text-slate-400 text-lg mb-10 leading-relaxed">
            {{ $t('home.trust.desc') }}
          </p>
          
          <div class="grid grid-cols-2 gap-8 mb-12">
            <div v-for="(stat, index) in stats" :key="index" class="border-l-2 border-blue-600 pl-6">
              <div class="text-3xl font-bold mb-1">{{ stat.value }}</div>
              <div class="text-slate-500 text-sm uppercase tracking-wider">{{ stat.label }}</div>
            </div>
          </div>
          
          <!-- <NuxtLink :to="localePath('/#quality')" class="inline-flex items-center gap-3 text-blue-400 font-bold hover:text-blue-300 transition-colors group">
            LEARN ABOUT OUR QC PROCESS
            <i class="ri-arrow-right-line group-hover:translate-x-2 transition-transform"></i>
          </NuxtLink> -->
        </div>
        
        <!-- Right: Certifications Grid -->
        <div class="lg:w-1/2 grid grid-cols-2 gap-4">
          <div v-for="(cert, index) in certs" :key="index" class="bg-white/5 border border-white/10 p-8 rounded-2xl hover:bg-white/10 transition-colors flex flex-col items-center text-center">
            <div class="w-16 h-16 bg-white rounded-2xl flex items-center justify-center mb-6 p-3">
              <img :src="cert.logo" :alt="cert.name" class="max-w-full max-h-full grayscale hover:grayscale-0 transition-all" />
            </div>
            <h4 class="font-bold mb-2">{{ cert.name }}</h4>
            <p class="text-slate-500 text-xs leading-relaxed">{{ cert.desc }}</p>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
const localePath = useLocalePath()

const stats = [
  { value: '20+', label: $t('home.trust.experience') },
  { value: '100%', label: $t('home.trust.certifications') },
  { value: '5000+', label: $t('home.trust.color') },
  { value: '120+', label: $t('home.trust.global') }
]

const certs = [
  {
    name: 'ISO 9001:2015',
    desc: $t('home.trust.iso_certification'),
    logo: '/img/1087815.png'
  },
  {
    name: 'OEKO-TEX 100',
    desc: $t('home.trust.oeko_tex_certification'),
    logo: '/img/1087815.png'
  },
  {
    name: 'GRS Certified',
    desc: $t('home.trust.grs_certification'),
    logo: '/img/1087815.png'
  },
  {
    name: 'SGS Verified',
    desc: $t('home.trust.sgs_certification'),
    logo: '/img/1087815.png'
  }
]
</script>
