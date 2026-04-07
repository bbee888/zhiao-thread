#!/bin/bash

echo "=== 收集产品分类多语言日志 ==="
echo ""
echo "请按以下步骤操作："
echo ""
echo "1. 确保后端服务正在运行 (npm run start:dev)"
echo ""
echo "2. 在前端添加产品分类:"
echo "   - 访问: http://localhost:3000/product/category"
echo "   - 点击'新增'按钮"
echo "   - 填写分类名称（至少填中文和英文）"
echo "   - 点击'确定'保存"
echo ""
echo "3. 立即运行此脚本收集日志:"
echo ""

# 获取最新的日志文件
LOG_DIR="/Users/shangxb/fastapi-vue3/nextjs+vue3/youlai-nest/logs"
LATEST_LOG=$(ls -t "$LOG_DIR"/*.log 2>/dev/null | head -1)

if [ -z "$LATEST_LOG" ]; then
    echo "错误: 找不到日志文件"
    echo "请确保后端服务已启动并生成了日志文件"
    exit 1
fi

echo "正在读取日志文件: $LATEST_LOG"
echo ""
echo "=== 产品分类相关日志 ==="
echo ""

# 提取产品分类相关日志
grep -A2 -B2 "产品分类" "$LATEST_LOG" | tail -100

echo ""
echo "=== 日志收集完成 ==="
echo ""
echo "请检查以下内容是否都存在:"
echo "  ✓ [产品分类] 接收到的DTO"
echo "  ✓ [产品分类] 主表保存成功, ID"
echo "  ✓ [产品分类] 开始保存多语言数据"
echo "  ✓ [产品分类] saveCategoryLangData 参数"
echo "  ✓ [产品分类] 过滤后的多语言数据"
echo "  ✓ [产品分类] 准备保存的多语言实体"
echo "  ✓ [产品分类] 多语言数据保存成功"
echo ""
echo "如果缺少任何一步，或者出现红色错误信息，"
echo "请把完整日志复制给我分析。"
