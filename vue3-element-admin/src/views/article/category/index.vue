<template>
  <div class="page-container">
    <el-card class="page-search" shadow="never">
      <el-form ref="queryFormRef" :model="queryParams" :inline="true">
        <el-form-item label="关键字" prop="keywords">
          <el-input v-model="queryParams.keywords" placeholder="分类名称" @keyup.enter="handleQuery" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="queryParams.status" placeholder="全部" clearable style="width: 100px">
            <el-option :value="1" label="启用" />
            <el-option :value="0" label="禁用" />
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

      <el-table v-loading="loading" :data="categoryList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column prop="langData" label="分类名称" min-width="300">
          <template #default="scope">
            <span>{{ formatLangNames(scope.row.langData) || `分类 ID: ${scope.row.id}` }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="100">
          <template #default="scope">
            <el-tag v-if="scope.row.status == 1" type="success">启用</el-tag>
            <el-tag v-else type="info">禁用</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="sort" label="排序" width="100" />
        <el-table-column label="操作" fixed="right" align="left" width="200">
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
    </el-card>

    <el-dialog v-model="dialogState.visible" :title="dialogState.title" width="1000px" @closed="closeDialog">
      <el-form ref="categoryFormRef" :model="formData" :rules="rules" label-width="100px">
        <el-form-item label="分类名称" prop="langData">
          <el-tabs v-model="activeTab" type="border-card" style="width: 100%">
            <el-tab-pane v-for="lang in languageList" :key="lang.code" :label="lang.name" :name="lang.code">
              <el-input
                v-model="formData.langData[lang.code]"
                :placeholder="`请输入 ${lang.name} 分类名称`"
                clearable
              />
            </el-tab-pane>
          </el-tabs>
        </el-form-item>
        <el-form-item label="显示排序" prop="sort">
          <el-input-number v-model="formData.sort" controls-position="right" style="width: 120px" :min="0" />
        </el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="formData.status">
            <el-radio :value="1">启用</el-radio>
            <el-radio :value="0">禁用</el-radio>
          </el-radio-group>
        </el-form-item>
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
defineOptions({ name: "ArticleCategory", inheritAttrs: false });

import CategoryAPI from "@/api/article/category";
import DictAPI from "@/api/system/dict";
import type { FormInstance, FormRules } from "element-plus";

const queryFormRef = ref<FormInstance>();
const categoryFormRef = ref<FormInstance>();

const queryParams = reactive<any>({});
const categoryList = ref<any[]>([]);
const loading = ref(false);
const selectIds = ref<number[]>([]);

const dialogState = reactive({ title: "", visible: false });
const activeTab = ref("zh");

const formData = reactive<any>({
  status: 1,
  sort: 100,
  langData: {},
});

// 支持的语言列表
const languageList = ref<any[]>([]);

async function fetchLanguages() {
  const data = await DictAPI.getDictItems("language");
  languageList.value = data.map((item: any) => ({
    code: item.value,
    name: item.label,
  }));
}

/**
 * 格式化显示多语言名称
 * 格式：中文名称 / English Name / العربية / ...
 */
function formatLangNames(langData?: Record<string, string>): string {
  if (!langData || Object.keys(langData).length === 0) {
    return "未命名";
  }

  // 过滤掉空值，只显示有内容的语言
  const validLangs = languageList.value.filter((lang: any) => {
    const value = langData[lang.code];
    return value && value.trim() !== "";
  });

  if (validLangs.length === 0) {
    return "未命名";
  }

  // 格式化为：中文名称 / English Name / العربية
  return validLangs.map((lang: any) => `${langData[lang.code]}`).join(" / ");
}

const rules: FormRules = {
  langData: [{ required: true, message: "请输入分类名称", trigger: "blur" }],
};

function initLangData() {
  languageList.value.forEach((lang: any) => {
    if (!formData.langData[lang.code]) {
      formData.langData[lang.code] = "";
    }
  });
}

function fetchData() {
  loading.value = true;
  CategoryAPI.getList(queryParams)
    .then((data) => {
      categoryList.value = data;
    })
    .finally(() => {
      loading.value = false;
    });
}

function handleQuery() {
  fetchData();
}

function handleResetQuery() {
  queryFormRef.value?.resetFields();
  fetchData();
}

function handleSelectionChange(selection: any[]) {
  selectIds.value = selection.map((item) => item.id).filter(Boolean) as number[];
}

async function openDialog(id?: number) {
  dialogState.visible = true;
  if (id) {
    dialogState.title = "修改分类";
    const data = await CategoryAPI.getFormData(id);
    Object.assign(formData, data);
    initLangData();
  } else {
    dialogState.title = "新增分类";
    formData.langData = {};
    initLangData();
  }
}

function handleSubmit() {
  categoryFormRef.value?.validate(async (valid) => {
    if (valid) {
      loading.value = true;
      try {
        if (formData.id) {
          await CategoryAPI.update(formData.id, formData);
          ElMessage.success("修改成功");
        } else {
          await CategoryAPI.create(formData);
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
  const ids = (id && typeof id === "number") ? [id] : [...selectIds.value];
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
      CategoryAPI.deleteByIds(ids.join(","))
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
  categoryFormRef.value?.resetFields();
  formData.id = undefined;
  formData.status = 1;
  formData.sort = 100;
  formData.langData = {};
}

onMounted(() => {
  fetchData();
  fetchLanguages();
});
</script>
