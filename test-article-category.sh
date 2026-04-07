#!/bin/bash

echo "=== 测试文章分类多语言数据保存 ==="
echo ""

# 1. 重启后端服务
echo "1. 请确保后端服务已重启:"
echo "   cd /Users/shangxb/fastapi-vue3/nextjs+vue3/youlai-nest"
echo "   npm run start:dev"
echo ""

# 2. 在前端添加文章分类
echo "2. 在前端添加文章分类:"
echo "   - 访问: http://localhost:3000/article/category"
echo "   - 点击'新增'按钮"
echo "   - 填写分类名称:"
echo "     * 中文: 测试分类"
echo "     * 英文: Test Category"
echo "   - 点击'确定'保存"
echo ""

# 3. 查看日志
echo "3. 查看后端日志，确认输出以下内容:"
echo "   ✓ [文章分类Controller] 接收到的DTO"
echo "   ✓ [文章分类] 接收到的DTO"
echo "   ✓ [文章分类] 主表保存成功, ID: [数字]"
echo "   ✓ [文章分类] 开始保存多语言数据: {\"zh\":\"测试分类\",\"en\":\"Test Category\"}"
echo "   ✓ [文章分类] saveCategoryLangData 参数"
echo "   ✓ [文章分类] 过滤后的多语言数据"
echo "   ✓ [文章分类] 准备保存的多语言实体"
echo "   ✓ [文章分类] 多语言数据保存成功"
echo ""

# 4. 验证数据库
echo "4. 验证数据库中的数据:"
echo "   运行: /Users/shangxb/fastapi-vue3/nextjs+vue3/verify-multilingual.sh"
echo ""

# 5. 验证前端显示
echo "5. 验证前端显示:"
echo "   - 刷新分类列表页面"
echo "   - 确认分类名称正确显示"
echo ""

# 6. 如果失败，检查错误日志
echo "6. 如果保存失败，请检查日志中的错误信息:"
echo "   - 查看是否有红色的错误日志"
echo "   - 查看错误堆栈信息"
echo "   - 分享完整的日志输出给我"
echo ""

echo "=== 测试完成 ==="
