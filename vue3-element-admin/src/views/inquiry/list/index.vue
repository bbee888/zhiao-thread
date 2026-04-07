<template>
  <div class="app-container">
    <el-card shadow="never" class="mb-4">
      <el-form :inline="true" :model="queryParams" class="w-full">
        <el-form-item label="关键词">
          <el-input
            v-model="queryParams.keywords"
            placeholder="姓名/邮箱/公司/主题"
            clearable
            style="width: 240px"
            @keyup.enter="handleQuery"
          />
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="queryParams.status" clearable placeholder="全部" style="width: 160px">
            <el-option :value="0" label="未处理" />
            <el-option :value="1" label="已处理" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleQuery">查询</el-button>
          <el-button @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <el-card shadow="never">
      <el-table v-loading="loading" :data="list" row-key="id" border>
        <el-table-column prop="id" label="ID" width="90" />
        <el-table-column prop="name" label="姓名" min-width="120" />
        <el-table-column prop="email" label="邮箱" min-width="180" />
        <el-table-column prop="country" label="国家/地区" width="110" />
        <el-table-column prop="subject" label="主题" min-width="220" show-overflow-tooltip />
        <el-table-column label="状态" width="110">
          <template #default="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'warning'">
              {{ row.status === 1 ? "已处理" : "未处理" }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="提交时间" width="180" />
        <el-table-column label="操作" width="220" fixed="right">
          <template #default="{ row }">
            <el-button link type="primary" @click="openDetail(row)">查看</el-button>
            <el-button
              link
              type="success"
              :disabled="row.status === 1"
              @click="markProcessed(row)"
            >
              标记已处理
            </el-button>
            <el-button link type="danger" @click="handleDelete(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <div class="flex justify-end mt-4">
        <el-pagination
          background
          layout="total, sizes, prev, pager, next, jumper"
          :total="total"
          :page-size="queryParams.limit"
          :current-page="queryParams.page"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </el-card>

    <el-drawer v-model="detailVisible" title="询盘详情" size="520px">
      <div v-loading="detailLoading" class="space-y-4">
        <el-descriptions :column="1" border>
          <el-descriptions-item label="姓名">{{ detail?.name }}</el-descriptions-item>
          <el-descriptions-item label="邮箱">{{ detail?.email }}</el-descriptions-item>
          <el-descriptions-item label="公司">{{ detail?.company || "-" }}</el-descriptions-item>
          <el-descriptions-item label="电话/微信">{{ detail?.phone || "-" }}</el-descriptions-item>
          <el-descriptions-item label="国家/地区">{{ detail?.country }}</el-descriptions-item>
          <el-descriptions-item label="型号">{{ detail?.model || detail?.interest || "-" }}</el-descriptions-item>
          <el-descriptions-item label="数量">{{ detail?.quantity || "-" }}</el-descriptions-item>
          <el-descriptions-item label="颜色">{{ detail?.color || "-" }}</el-descriptions-item>
          <el-descriptions-item label="长度">{{ detail?.length || "-" }}</el-descriptions-item>
          <el-descriptions-item label="强度">{{ detail?.tenacity || "-" }}</el-descriptions-item>
          <el-descriptions-item label="主题">{{ detail?.subject }}</el-descriptions-item>
          <el-descriptions-item label="提交语言">{{ detail?.locale || "-" }}</el-descriptions-item>
          <el-descriptions-item label="IP">{{ detail?.ip || "-" }}</el-descriptions-item>
          <el-descriptions-item label="提交时间">{{ detail?.createTime || "-" }}</el-descriptions-item>
        </el-descriptions>
        <el-card shadow="never">
          <template #header>
            <span>留言内容</span>
          </template>
          <div class="whitespace-pre-wrap leading-relaxed text-slate-700">
            {{ detail?.message }}
          </div>
        </el-card>
      </div>
    </el-drawer>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from "vue";
import { ElMessage, ElMessageBox } from "element-plus";
import type { InquiryItem } from "@/api/inquiry/inquiry";
import { deleteInquiry, getInquiryDetail, getInquiryPage, updateInquiryStatus } from "@/api/inquiry/inquiry";

const loading = ref(false);
const list = ref<InquiryItem[]>([]);
const total = ref(0);

const queryParams = reactive({
  page: 1,
  limit: 10,
  keywords: "",
  status: undefined as number | undefined,
});

const detailVisible = ref(false);
const detailLoading = ref(false);
const detail = ref<InquiryItem | null>(null);

const fetchList = async () => {
  loading.value = true;
  try {
    const res = await getInquiryPage({
      page: queryParams.page,
      limit: queryParams.limit,
      keywords: queryParams.keywords || undefined,
      status: queryParams.status,
    });
    list.value = res.items || [];
    total.value = res.total || 0;
  } finally {
    loading.value = false;
  }
};

const handleQuery = () => {
  queryParams.page = 1;
  fetchList();
};

const resetQuery = () => {
  queryParams.page = 1;
  queryParams.limit = 10;
  queryParams.keywords = "";
  queryParams.status = undefined;
  fetchList();
};

const handleSizeChange = (size: number) => {
  queryParams.limit = size;
  queryParams.page = 1;
  fetchList();
};

const handleCurrentChange = (page: number) => {
  queryParams.page = page;
  fetchList();
};

const openDetail = async (row: InquiryItem) => {
  detailVisible.value = true;
  detailLoading.value = true;
  try {
    detail.value = await getInquiryDetail(row.id);
  } finally {
    detailLoading.value = false;
  }
};

const markProcessed = async (row: InquiryItem) => {
  await updateInquiryStatus(row.id, 1);
  ElMessage.success("已标记为已处理");
  fetchList();
};

const handleDelete = async (row: InquiryItem) => {
  await ElMessageBox.confirm(`确认删除该询盘（ID: ${row.id}）吗？`, "提示", {
    type: "warning",
    confirmButtonText: "确定",
    cancelButtonText: "取消",
  });
  await deleteInquiry(row.id);
  ElMessage.success("删除成功");
  fetchList();
};

fetchList();
</script>
