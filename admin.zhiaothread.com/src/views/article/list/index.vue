<template>
  <div class="page-container">
    <el-card class="page-search" shadow="never">
      <el-form ref="queryFormRef" :model="queryParams" :inline="true">
        <el-form-item label="文章分类" prop="cateId">
          <el-select v-model="queryParams.cateId" placeholder="全部" clearable style="width: 150px">
            <el-option label="全部分类" value="" />
            <el-option
              v-for="item in categoryOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="关键字" prop="keywords">
          <el-input
            v-model="queryParams.keywords"
            placeholder="文章标题"
            @keyup.enter="handleQuery"
          />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="queryParams.status" placeholder="全部" clearable style="width: 100px">
            <el-option :value="1" label="发布" />
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
          <el-button
            type="danger"
            :disabled="selectIds.length === 0"
            icon="delete"
            @click="handleDelete()"
          >
            删除
          </el-button>
        </div>
      </div>

      <el-table v-loading="loading" :data="articleList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column prop="cover" label="封面图" width="100">
          <template #default="scope">
            <el-image
              v-if="scope.row.cover"
              :src="resolveImageUrl(scope.row.cover)"
              :preview-src-list="[resolveImageUrl(scope.row.cover)]"
              fit="cover"
              style="width: 60px; height: 60px"
            />
          </template>
        </el-table-column>
        <el-table-column prop="langData" label="文章标题" min-width="200">
          <template #default="scope">
            <span>{{ scope.row.langData?.zh?.title || `文章 ID: ${scope.row.id}` }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="categoryName" label="文章分类" width="150" />
        <el-table-column prop="createTime" label="发布时间" width="160" />
        <el-table-column prop="sort" label="排序" width="80" />
        <el-table-column prop="status" label="状态" width="80">
          <template #default="scope">
            <el-tag v-if="scope.row.status == 1" type="success">发布</el-tag>
            <el-tag v-else type="info">隐藏</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" fixed="right" align="left" width="150">
          <template #default="scope">
            <el-button
              type="primary"
              link
              size="small"
              icon="edit"
              @click.stop="openDialog(scope.row.id)"
            >
              编辑
            </el-button>
            <el-button
              type="danger"
              link
              size="small"
              icon="delete"
              @click.stop="handleDelete(scope.row.id)"
            >
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>

      <Pagination
        v-show="total > 0"
        v-model:page="queryParams.page"
        v-model:limit="queryParams.limit"
        :total="total"
        @pagination="fetchData"
      />
    </el-card>

    <el-dialog
      v-model="dialogState.visible"
      :title="dialogState.title"
      width="70%"
      top="10px"
      @closed="closeDialog"
    >
      <el-form
        ref="articleFormRef"
        v-loading="dialogLoading"
        :model="formData"
        :rules="rules"
        label-width="100px"
      >
        <el-form-item label="文章分类" prop="cateId">
          <el-select v-model="formData.cateId" placeholder="请选择分类" style="width: 100%">
            <el-option
              v-for="item in categoryOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            />
          </el-select>
        </el-form-item>

        <el-form-item label="多语言内容">
          <el-tabs v-model="activeTab" type="border-card" style="width: 100%">
            <el-tab-pane
              v-for="lang in languageList"
              :key="lang.code"
              :label="lang.name"
              :name="lang.code"
            >
              <el-form-item label="文章标题" label-width="80px" style="margin-bottom: 20px">
                <el-input
                  v-model="getLangData(lang.code).title"
                  :placeholder="`请输入 ${lang.name} 标题`"
                />
              </el-form-item>
              <el-form-item label="文章详情" label-width="80px">
                <WangEditor
                  v-model="getLangData(lang.code).content"
                  :placeholder="`请输入 ${lang.name} 详情内容`"
                  height="400px"
                />
              </el-form-item>
              <div style="margin-top: 20px; border-top: 1px solid #eee; padding-top: 20px">
                <el-divider content-position="left">SEO 设置 ({{ lang.name }})</el-divider>
                <el-form-item label="关键词" label-width="80px" style="margin-bottom: 8px">
                  <el-input v-model="getLangData(lang.code).keywords" placeholder="Keywords" />
                </el-form-item>
                <el-form-item label="描述" label-width="80px">
                  <el-input
                    v-model="getLangData(lang.code).description"
                    type="textarea"
                    placeholder="Description"
                  />
                </el-form-item>
              </div>
            </el-tab-pane>
          </el-tabs>
        </el-form-item>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="封面图" prop="cover">
              <SingleImageUpload v-model="formData.cover" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="显示排序" prop="sort">
              <el-input-number
                v-model="formData.sort"
                controls-position="right"
                :min="0"
                style="width: 100%"
              />
            </el-form-item>
            <el-form-item label="状态">
              <el-radio-group v-model="formData.status">
                <el-radio :value="1">发布</el-radio>
                <el-radio :value="0">隐藏</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>

      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" :loading="dialogLoading" @click="handleSubmit">确定</el-button>
          <el-button @click="closeDialog">取消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
defineOptions({ name: "ArticleList", inheritAttrs: false });

import { ref, reactive, nextTick } from "vue";
import ArticleAPI from "@/api/article/article";
import CategoryAPI from "@/api/article/category";
import DictAPI from "@/api/system/dict";
import type { FormInstance, FormRules } from "element-plus";

const queryFormRef = ref<FormInstance>();
const articleFormRef = ref<FormInstance>();

const queryParams = reactive<any>({
  page: 1,
  limit: 10,
  cateId: undefined,
  keywords: "",
  status: undefined,
});
const articleList = ref<any[]>([]);
const categoryOptions = ref<any[]>([]);
const loading = ref(false);
const selectIds = ref<number[]>([]);
const total = ref(0);

const dialogState = reactive({ title: "", visible: false });
const activeTab = ref("zh");
const dialogLoading = ref(false);

const formData = reactive<any>({
  id: undefined,
  cateId: undefined,
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
}

const rules: FormRules = {
  cateId: [{ required: true, message: "请选择分类", trigger: "change" }],
};

/**
 * 解析图片 URL
 */
function resolveImageUrl(url?: string) {
  if (!url) return "";
  if (url.startsWith("http")) return url;
  // 如果是相对路径且不以 /oss 开头，则补全 /oss (兼容旧数据)
  if (url.startsWith("/") && !url.startsWith("/oss")) {
    return `/oss${url}`;
  }
  return url;
}

function getLangData(code: string): any {
  if (!formData.langData[code] || typeof formData.langData[code] !== "object") {
    formData.langData[code] = { title: "", content: "", keywords: "", description: "" };
  }
  return formData.langData[code];
}

function initLangData() {
  languageList.value.forEach((lang: any) => {
    getLangData(lang.code);
  });
}

async function fetchCategoryOptions() {
  const data = await CategoryAPI.getOptions();
  categoryOptions.value = data;
}

function fetchData() {
  loading.value = true;
  ArticleAPI.getList(queryParams)
    .then((data) => {
      articleList.value = data.items;
      total.value = data.total;
    })
    .finally(() => {
      loading.value = false;
    });
}

function handleQuery() {
  queryParams.page = 1;
  fetchData();
}

function handleResetQuery() {
  queryFormRef.value?.resetFields();
  queryParams.page = 1;
  fetchData();
}

function handleSelectionChange(selection: any[]) {
  selectIds.value = selection.map((item) => item.id).filter(Boolean) as number[];
}

async function openDialog(id?: number) {
  dialogState.visible = true;
  dialogLoading.value = true;
  try {
    if (languageList.value.length === 0) {
      await fetchLanguages();
    }
    await fetchCategoryOptions();

    if (id !== undefined && id !== null) {
      dialogState.title = "修改文章";
      formData.id = Number(id);
      const data = await ArticleAPI.getFormData(Number(id));
      Object.assign(formData, data);
      formData.id = Number((data as any)?.id ?? id);
    } else {
      dialogState.title = "新增文章";
      formData.id = undefined;
      formData.cateId = undefined;
      formData.cover = "";
      formData.sort = 100;
      formData.status = 1;
      formData.langData = {};
    }

    if (!formData.langData || typeof formData.langData !== "object") {
      formData.langData = {};
    }

    await nextTick();
    initLangData();
  } finally {
    dialogLoading.value = false;
  }
}

function handleSubmit() {
  articleFormRef.value?.validate(async (valid) => {
    if (valid) {
      loading.value = true;
      try {
        if (formData.id !== undefined && formData.id !== null) {
          await ArticleAPI.update(Number(formData.id), formData);
          ElMessage.success("修改成功");
        } else {
          await ArticleAPI.create(formData);
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

function handleDelete(id?: any) {
  const ids = id && typeof id === "number" ? [id] : [...selectIds.value];
  if (ids.length === 0) {
    ElMessage.warning("请勾选删除项");
    return;
  }

  ElMessageBox.confirm("确认删除已选中的数据项？", "警告", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning",
  }).then(
    () => {
      loading.value = true;
      ArticleAPI.deleteByIds(ids.join(","))
        .then(() => {
          ElMessage.success("删除成功");
          selectIds.value = [];
          fetchData();
        })
        .finally(() => (loading.value = false));
    },
    () => {
      ElMessage.info("已取消删除");
    }
  );
}

function closeDialog() {
  dialogState.visible = false;
  articleFormRef.value?.resetFields();
  formData.id = undefined;
  initLangData();
}

onMounted(() => {
  fetchCategoryOptions();
  fetchData();
  fetchLanguages();
});
</script>
