<template>
  <section class="relative text-white overflow-hidden">
    <div
      ref="carouselRef"
      class="relative"
      @mouseenter="pause"
      @mouseleave="resume"
      @wheel.passive="onWheel"
      @pointerdown="onPointerDown"
      @pointermove="onPointerMove"
      @pointerup="onPointerUp"
      @pointercancel="onPointerUp"
    >
      <div
        class="flex will-change-transform transition-transform duration-700 ease-out"
        :style="{ transform: `translateX(-${activeIndex * 100}%)` }"
      >
        <div
          v-for="(s, i) in slides"
          :key="i"
          class="w-full flex-shrink-0"
          :class="s.bgClass"
        >
          <div class="mx-auto max-w-[1440px] px-4 lg:px-[80px] py-16 lg:py-[80px]">
            <div class="flex flex-col lg:flex-row items-center justify-between gap-10 lg:gap-[100px]">
              <div class="w-full lg:w-[600px]">
                <div class="inline-flex items-center rounded-full bg-white/20 px-[20px] py-[8px]">
                  <i
                    v-if="s.badgeIcon"
                    :class="`${s.badgeIcon} text-[16px] leading-[1.2]`"
                    :style="{ color: s.badgeIconColor }"
                  ></i>
                  <span v-if="s.badgeIcon" class="w-2"></span>
                  <span class="text-[14px] font-medium leading-[1.2] text-white">{{ s.badge }}</span>
                </div>

                <div class="h-[32px]"></div>

                <div class="text-[64px] leading-[1.2] font-extrabold text-white">
                  <div>{{ s.titleLine1 }}</div>
                  <div class="h-[8px]"></div>
                  <div>{{ s.titleLine2 }}</div>
                </div>

                <div class="h-[32px]"></div>

                <p class="text-[20px] leading-[1.2] font-light" :style="{ color: s.subtitleColor }">
                  {{ s.subtitle }}
                </p>

                <div v-if="s.params?.length" class="h-[48px]"></div>
                <div v-if="s.params?.length" class="space-y-[16px]">
                  <div class="grid grid-cols-1 md:grid-cols-3 gap-[16px]">
                    <div
                      v-for="(p, idx) in s.params.slice(0, 3)"
                      :key="idx"
                      class="rounded-[12px] bg-white/10 p-[16px]"
                    >
                      <div class="text-[14px] leading-[1.2]" :style="{ color: s.paramLabelColor }">
                        {{ p.label }}
                      </div>
                      <div class="h-[4px]"></div>
                      <div class="text-[24px] leading-[1.2] font-bold text-white">{{ p.value }}</div>
                    </div>
                  </div>
                  <div class="grid grid-cols-1 md:grid-cols-3 gap-[16px]">
                    <div
                      v-for="(p, idx) in s.params.slice(3, 6)"
                      :key="idx"
                      class="rounded-[12px] bg-white/10 p-[16px]"
                    >
                      <div class="text-[14px] leading-[1.2]" :style="{ color: s.paramLabelColor }">
                        {{ p.label }}
                      </div>
                      <div class="h-[4px]"></div>
                      <div class="text-[24px] leading-[1.2] font-bold text-white">{{ p.value }}</div>
                    </div>
                  </div>
                </div>

                <div :class="s.params?.length ? 'h-[80px]' : 'h-[48px]'"></div>

                <div class="flex items-center">
                  <NuxtLink
                    :to="s.primary.to"
                    class="h-[63px] rounded-[12px] px-[40px] py-[16px] bg-white flex items-center"
                  >
                    <span class="text-[18px] leading-[1.2] font-semibold" :style="{ color: s.primary.textColor }">
                      {{ s.primary.label }}
                    </span>
                    <span class="w-2"></span>
                    <i :class="`${s.primary.icon} text-[18px]`" :style="{ color: s.primary.iconColor }"></i>
                  </NuxtLink>
                  <div class="w-[20px]"></div>
                  <NuxtLink
                    :to="s.secondary.to"
                    class="h-[63px] rounded-[12px] px-[40px] py-[16px] border-2 border-white flex items-center"
                  >
                    <span class="text-[18px] leading-[1.2] font-semibold text-white">{{ s.secondary.label }}</span>
                    <span class="w-2"></span>
                    <i :class="`${s.secondary.icon} text-[18px] text-white`"></i>
                  </NuxtLink>
                </div>

                <div v-if="s.trust?.length" class="h-[64px]"></div>
                <div v-if="s.trust?.length" class="rounded-[12px] bg-white/10 p-[24px]">
                  <div class="text-[14px] leading-[1.2] font-medium" :style="{ color: s.subtitleColor }">
                    {{ s.trustTitle }}
                  </div>
                  <div class="h-[16px]"></div>
                  <div class="flex items-start justify-between">
                    <div v-for="(t, idx) in s.trust" :key="idx" class="flex items-center">
                      <div
                        class="w-[41px] h-[44px] rounded-[8px] flex items-center justify-center"
                        :style="{ backgroundColor: t.iconBg }"
                      >
                        <i :class="`${t.icon} text-[24px] leading-[1.2]`" :style="{ color: t.iconColor }"></i>
                      </div>
                      <div class="w-[12px]"></div>
                      <div>
                        <div class="text-[16px] leading-[1.2] font-semibold text-white">{{ t.title }}</div>
                        <div class="h-[4px]"></div>
                        <div class="text-[12px] leading-[1.2]" :style="{ color: t.subColor }">{{ t.subtitle }}</div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <div class="w-full lg:w-[580px]">
                <div
                  class="bg-white rounded-[16px] shadow-[0_25px_50px_rgba(0,0,0,0.25)] overflow-hidden"
                  :class="s.cardPaddingClass"
                >
                  <div
                    class="w-full rounded-[12px] overflow-hidden"
                    :style="{ height: `${s.cardImageHeight}px` }"
                  >
                    <img :src="s.image" alt="" class="w-full h-full object-cover" />
                  </div>

                  <template v-if="s.cardType === 'label'">
                    <div class="h-[8px]"></div>
                    <div class="px-[16px] py-[16px] flex items-center justify-between">
                      <div>
                        <div class="text-[18px] leading-[1.2] font-semibold text-slate-800">{{ s.cardTitle }}</div>
                        <div class="h-[4px]"></div>
                        <div class="text-[14px] leading-[1.2] text-slate-500">{{ s.cardSubtitle }}</div>
                      </div>
                      <div class="bg-emerald-50 text-emerald-700 rounded-[8px] px-[12px] py-[4px]">
                        <span class="text-[12px] leading-[1.2] font-semibold">{{ s.cardTag }}</span>
                      </div>
                    </div>
                  </template>

                  <template v-else>
                    <div class="h-[24px]"></div>
                    <div class="text-[16px] leading-[1.2] font-semibold text-slate-800">{{ s.sceneTitle }}</div>
                    <div class="h-[12px]"></div>
                    <div class="flex flex-wrap gap-[8px]">
                      <div
                        v-for="(tag, idx) in s.sceneTags"
                        :key="idx"
                        class="h-[30px] rounded-[8px] px-[12px] py-[6px] flex items-center"
                        :style="{ backgroundColor: s.sceneTagBg }"
                      >
                        <span class="text-[13px] leading-[1.2] font-medium" :style="{ color: s.sceneTagText }">
                          {{ tag }}
                        </span>
                      </div>
                    </div>
                  </template>
                </div>
              </div>
            </div>

            <div class="h-[64px]"></div>
            <div class="flex justify-center">
              <div class="flex items-center gap-[12px]">
                <button
                  v-for="(_, j) in slides"
                  :key="j"
                  type="button"
                  class="h-[12px] rounded-full transition-all"
                  :class="j === activeIndex ? 'w-[34px] bg-white' : 'w-[14px] bg-white/30 hover:bg-white/50'"
                  @click="go(j)"
                ></button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
const slides = [
  {
    bgClass: 'bg-gradient-to-br from-[#1E40AF] to-[#3B82F6]',
    badgeIcon: 'ri-star-fill',
    badgeIconColor: 'rgba(250,204,21,1)',
    badge: '20年专注缝纫线生产',
    titleLine1: '为各行业提供高品质',
    titleLine2: '缝纫线解决方案',
    subtitleColor: 'rgba(224,231,255,1)',
    subtitle:
      '专业生产高品质涤纶、尼龙、棉线及特种缝纫线，适用于服装、鞋类、家居软装及工业等多领域应用。',
    primary: {
      label: '浏览产品',
      to: '/products',
      icon: 'ri-arrow-right-line',
      textColor: 'rgba(29,78,216,1)',
      iconColor: 'rgba(37,99,235,1)'
    },
    secondary: {
      label: '联系销售',
      to: '/inquiry',
      icon: 'ri-customer-service-2-line'
    },
    trustTitle: '我们的核心优势',
    trust: [
      {
        icon: 'ri-award-fill',
        iconBg: 'rgba(250,204,21,0.2)',
        iconColor: 'rgba(250,204,21,1)',
        title: 'ISO 9001认证',
        subtitle: '国际质量体系认证',
        subColor: 'rgba(191,219,254,1)'
      },
      {
        icon: 'ri-time-fill',
        iconBg: 'rgba(250,204,21,0.2)',
        iconColor: 'rgba(250,204,21,1)',
        title: '7-15天快速交付',
        subtitle: '高效生产供应链',
        subColor: 'rgba(191,219,254,1)'
      },
      {
        icon: 'ri-palette-fill',
        iconBg: 'rgba(250,204,21,0.2)',
        iconColor: 'rgba(250,204,21,1)',
        title: '支持定制颜色',
        subtitle: '满足个性化需求',
        subColor: 'rgba(191,219,254,1)'
      }
    ],
    cardType: 'label',
    cardPaddingClass: 'p-[8px]',
    cardImageHeight: 580,
    image: '/img/ba1.jpg',
    cardTitle: '高品质缝纫线系列',
    cardSubtitle: '适用于多种行业应用',
    cardTag: '热销产品'
  },
  {
    bgClass: 'bg-gradient-to-br from-[#075985] to-[#0EA5E9]',
    badgeIcon: '',
    badgeIconColor: '',
    badge: '爆款产品系列',
    titleLine1: '40/2 涤纶缝纫线',
    titleLine2: '高性价比之选',
    subtitleColor: 'rgba(224,242,254,1)',
    subtitle:
      '40/2规格涤纶缝纫线是我们的明星产品，采用高品质聚酯纤维原料制作，具有强度高、耐磨性好、色牢度高、不易断线等特点，适用于绝大多数服装生产场景。',
    paramLabelColor: 'rgba(186,230,253,1)',
    params: [
      { label: '线密度', value: '40S/2' },
      { label: '断裂强度', value: '≥4.5 cN/dtex' },
      { label: '伸长率', value: '20±3%' },
      { label: '耐洗温度', value: '≤95℃' },
      { label: '色牢度', value: '≥4级' },
      { label: '包装规格', value: '3000Y/5000Y' }
    ],
    primary: {
      label: '立即咨询报价',
      to: '/inquiry',
      icon: 'ri-arrow-right-line',
      textColor: 'rgba(7,89,133,1)',
      iconColor: 'rgba(14,116,144,1)'
    },
    secondary: {
      label: '免费申请样品',
      to: '/inquiry',
      icon: 'ri-mail-send-line'
    },
    cardType: 'scene',
    cardPaddingClass: 'p-[24px]',
    cardImageHeight: 400,
    image: '/img/ba2.jpg',
    sceneTitle: '适用场景',
    sceneTags: ['梭织服装', '针织服装', '童装', '家纺产品', '箱包', '皮革制品'],
    sceneTagBg: 'rgba(239,246,255,1)',
    sceneTagText: 'rgba(7,89,133,1)'
  },
  {
    bgClass: 'bg-gradient-to-br from-[#064E3B] to-[#10B981]',
    badgeIcon: 'ri-leaf-fill',
    badgeIconColor: 'rgba(110,231,183,1)',
    badge: '粗线规格系列',
    titleLine1: '20/2 涤纶缝纫线',
    titleLine2: '高强度粗线',
    subtitleColor: 'rgba(209,250,229,1)',
    subtitle:
      '20/2规格粗涤纶缝纫线专为厚重面料设计，采用高强度聚酯纤维双股合捻，具有极佳的抗拉强度和耐磨性，适用于厚料、重料的缝纫需求，满足箱包、沙发、汽车内饰等特殊场景。',
    paramLabelColor: 'rgba(167,243,208,1)',
    params: [
      { label: '线密度', value: '20S/2' },
      { label: '断裂强度', value: '≥5.0 cN/dtex' },
      { label: '伸长率', value: '18±3%' },
      { label: '耐温性能', value: '≤180℃' },
      { label: '耐磨次数', value: '≥3000次' },
      { label: '包装规格', value: '2000Y/3000Y' }
    ],
    primary: {
      label: '立即咨询报价',
      to: '/inquiry',
      icon: 'ri-arrow-right-line',
      textColor: 'rgba(6,78,59,1)',
      iconColor: 'rgba(4,120,87,1)'
    },
    secondary: {
      label: '免费申请样品',
      to: '/inquiry',
      icon: 'ri-mail-send-line'
    },
    cardType: 'scene',
    cardPaddingClass: 'p-[24px]',
    cardImageHeight: 400,
    image: '/img/ba3.jpg',
    sceneTitle: '适用场景',
    sceneTags: ['皮革箱包', '沙发家具', '汽车内饰', '户外用品', '安全带', '工业帆布'],
    sceneTagBg: 'rgba(236,253,245,1)',
    sceneTagText: 'rgba(6,78,59,1)'
  }
]

const activeIndex = ref(0)
const autoplayTimer = ref()
const wheelLock = ref(false)
const carouselRef = ref()

const pointer = reactive({
  startX: 0,
  deltaX: 0,
  dragging: false
})

const mod = (n, m) => ((n % m) + m) % m

const go = (i) => {
  activeIndex.value = mod(i, slides.length)
}

const next = () => {
  go(activeIndex.value + 1)
}

const prev = () => {
  go(activeIndex.value - 1)
}

const pause = () => {
  if (autoplayTimer.value) clearInterval(autoplayTimer.value)
  autoplayTimer.value = undefined
}

const resume = () => {
  pause()
  autoplayTimer.value = setInterval(() => {
    next()
  }, 4500)
}

const onWheel = (e) => {
  if (wheelLock.value) return
  wheelLock.value = true
  if (e.deltaY > 0) next()
  else prev()
  setTimeout(() => {
    wheelLock.value = false
  }, 420)
}

const onPointerDown = (e) => {
  if (!carouselRef.value) return
  pointer.dragging = true
  pointer.startX = e.clientX
  pointer.deltaX = 0
  pause()
  carouselRef.value.setPointerCapture?.(e.pointerId)
}

const onPointerMove = (e) => {
  if (!pointer.dragging) return
  pointer.deltaX = e.clientX - pointer.startX
}

const onPointerUp = () => {
  if (!pointer.dragging) return
  pointer.dragging = false
  const threshold = 60
  if (pointer.deltaX <= -threshold) next()
  else if (pointer.deltaX >= threshold) prev()
  pointer.deltaX = 0
  resume()
}

onMounted(() => {
  resume()
})

onBeforeUnmount(() => {
  pause()
})
</script>
