<template>
  <div class="page-container">
    <el-card class="page-search" shadow="never">
      <el-form ref="queryFormRef" :model="queryParams" :inline="true">
        <el-form-item label="关键字" prop="keyword">
          <el-input v-model="queryParams.keyword" placeholder="标题" @keyup.enter="handleQuery" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="queryParams.status" placeholder="全部" clearable style="width: 100px">
            <el-option :value="1" label="显示" />
            <el-option :value="0" label="隐藏" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="search" @click="handleQuery">搜索</el-button>
          <el-button icon="refresh" @click="handleResetQuery">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <el-card class="page-content" shadow="never">
      <div class="page-toolbar">
        <div class="page-toolbar__left">
          <el-button type="success" icon="plus" @click="openDialog()">新增</el-button>
          <el-button type="danger" :disabled="selectIds.length === 0" icon="delete" @click="handleDelete()">
            删除
          </el-button>
        </div>
      </div>

      <el-table v-loading="loading" :data="companyList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column prop="logo" label="LOGO" width="100">
          <template #default="scope">
            <el-image v-if="scope.row.logo" :src="resolveImageUrl(scope.row.logo)" :preview-src-list="[resolveImageUrl(scope.row.logo)]" fit="cover"
              style="width: 60px; height: 60px" />
          </template>
        </el-table-column>
        <el-table-column prop="title" label="标题" min-width="200" />
        <el-table-column prop="createTime" label="创建时间" width="160" />
        <el-table-column prop="sort" label="排序" width="80" />
        <el-table-column prop="status" label="状态" width="80">
          <template #default="scope">
            <el-tag v-if="scope.row.status == 1" type="success">显示</el-tag>
            <el-tag v-else type="info">隐藏</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" fixed="right" align="left" width="150">
          <template #default="scope">
            <el-button type="primary" link size="small" icon="edit" @click.stop="openDialog(scope.row.id)">
              编辑
            </el-button>
            <el-button type="danger" link size="small" icon="delete" @click.stop="handleDelete(scope.row.id)">
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>

      <Pagination v-show="total > 0" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize"
        :total="total" @pagination="fetchData" />
    </el-card>

    <el-dialog v-model="dialogState.visible" :title="dialogState.title" width="70%" @closed="closeDialog" top="10px">
      <el-form ref="companyFormRef" :model="formData" :rules="rules" label-width="100px">
        <el-form-item label="多语言内容">
          <el-tabs v-model="activeTab" type="border-card" style="width: 100%">
            <el-tab-pane v-for="lang in languageList" :key="lang.code" :label="lang.name" :name="lang.code">
              <el-form-item label="标题" label-width="80px" style="margin-bottom: 20px">
                <el-input v-model="getLangData(lang.code).title" :placeholder="`请输入 ${lang.name} 标题`" />
              </el-form-item>
              <el-form-item label="详情内容" label-width="80px">
                <WangEditor v-model="getLangData(lang.code).content" :placeholder="`请输入 ${lang.name} 详情内容`" height="400px" width="100%" />
              </el-form-item>
              <div style="margin-top: 20px; border-top: 1px solid #eee; padding-top: 20px">
                <el-divider content-position="left">SEO 设置 ({{ lang.name }})</el-divider>
                <el-form-item label="SEO 标题" label-width="80px" style="margin-bottom: 8px;">
                  <el-input v-model="getLangData(lang.code).seoTitle" placeholder="SEO Title" />
                </el-form-item>
                <el-form-item label="SEO 关键词" label-width="80px" style="margin-bottom: 8px;">
                  <el-input v-model="getLangData(lang.code).seoKeywords" placeholder="SEO Keywords" />
                </el-form-item>
                <el-form-item label="SEO 描述" label-width="80px">
                  <el-input v-model="getLangData(lang.code).seoDescription" type="textarea" placeholder="SEO Description" />
                </el-form-item>
              </div>
            </el-tab-pane>
          </el-tabs>
        </el-form-item>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="公司LOGO" prop="logo">
              <SingleImageUpload v-model="formData.logo" />
            </el-form-item>
            <el-form-item label="封面图" prop="cover">
              <SingleImageUpload v-model="formData.cover" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="显示排序" prop="sort">
              <el-input-number v-model="formData.sort" controls-position="right" :min="0" style="width: 100%" />
            </el-form-item>
            <el-form-item label="状态">
              <el-radio-group v-model="formData.status">
                <el-radio :value="1">显示</el-radio>
                <el-radio :value="0">隐藏</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>

      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="handleSubmit">确定</el-button>
          <el-button @click="closeDialog">取消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
defineOptions({ name: "CompanyList", inheritAttrs: false });

import { ref, reactive, nextTick } from "vue";
import CompanyAPI from "@/api/company";
import DictAPI from "@/api/system/dict";
import type { FormInstance, FormRules } from "element-plus";
import { ElMessage, ElMessageBox } from "element-plus";

const queryFormRef = ref<FormInstance>();
const companyFormRef = ref<FormInstance>();

const queryParams = reactive<any>({ pageNum: 1, pageSize: 10, keyword: "", status: undefined });
const companyList = ref<any[]>([]);
const loading = ref(false);
const selectIds = ref<number[]>([]);
const total = ref(0);

const dialogState = reactive({ title: "", visible: false });
const activeTab = ref("zh");

const formData = reactive<any>({
  logo: "",
  cover: "",
  sort: 100,
  status: 1,
  langData: {},
});

const languageList = ref<any[]>([]);

async function fetchLanguages() {
  const data = await DictAPI.getDictItems("language");
  languageList.value = data.map((item: any) => ({
    code: item.value,
    name: item.label,
  }));
  console.log('66666',languageList.value)
}

const rules: FormRules = {
  // 可以根据需要添加校验规则
};

/**
 * 解析图片 URL
 */
function resolveImageUrl(url?: string) {
  if (!url) return "";
  if (url.startsWith("http")) return url;
  if (url.startsWith("/") && !url.startsWith("/oss")) {
    return `/oss${url}`;
  }
  return url;
}

function getLangData(code: string): any {
  if (!formData.langData[code] || typeof formData.langData[code] !== 'object') {
    formData.langData[code] = { title: "", content: "", seoTitle: "", seoKeywords: "", seoDescription: "" };
  }
  return formData.langData[code];
}

function initLangData() {
  languageList.value.forEach((lang: any) => {
    getLangData(lang.code);
  });
}

function fetchData() {
  loading.value = true;
  CompanyAPI.getPage(queryParams)
    .then((data) => {
      companyList.value = data.items;
      total.value = data.total;
    })
    .finally(() => {
      loading.value = false;
    });
}

function handleQuery() {
  queryParams.pageNum = 1;
  fetchData();
}

function handleResetQuery() {
  queryFormRef.value?.resetFields();
  queryParams.pageNum = 1;
  fetchData();
}

function handleSelectionChange(selection: any[]) {
  selectIds.value = selection.map((item) => item.id).filter(Boolean) as number[];
}

async function openDialog(id?: number) {
  dialogState.visible = true;
  if (id) {
    dialogState.title = "修改公司信息";
    const data = await CompanyAPI.getFormData(id);
    Object.assign(formData, data);
    if (!formData.langData || typeof formData.langData !== 'object') {
      formData.langData = {};
    }
  } else {
    dialogState.title = "新增公司信息";
    formData.id = undefined;
    formData.logo = "";
    formData.cover = "";
    formData.sort = 100;
    formData.status = 1;
    formData.langData = {};
  }
  await nextTick();
  initLangData();
}

function handleSubmit() {
  companyFormRef.value?.validate(async (valid) => {
    if (valid) {
      loading.value = true;
      try {
        if (formData.id) {
          await CompanyAPI.update(formData.id, formData);
          ElMessage.success("修改成功");
        } else {
          await CompanyAPI.create(formData);
          ElMessage.success("新增成功");
        }
        closeDialog();
        fetchData();
      } finally {
        loading.value = false;
      }
    }
  });
}

function closeDialog() {
  dialogState.visible = false;
  companyFormRef.value?.resetFields();
  formData.langData = {};
}

function handleDelete(id?: number) {
  const ids = id ? [id] : selectIds.value;
  if (ids.length === 0) return;
  ElMessageBox.confirm("确定要删除选中的项吗？", "提示", {
    type: "warning",
  }).then(async () => {
    loading.value = true;
    try {
      await CompanyAPI.deleteByIds(ids.join(","));
      ElMessage.success("删除成功");
      fetchData();
    } finally {
      loading.value = false;
    }
  });
}

fetchData();
fetchLanguages();
</script>

<style scoped>
.page-container {
  padding: 20px;
}
.page-search {
  margin-bottom: 20px;
}
.page-toolbar {
  margin-bottom: 20px;
}
</style>
