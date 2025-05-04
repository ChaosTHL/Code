#!/bin/bash

# 清空html目录（保留.gitkeep）
find html/ -type f ! -name '.gitkeep' -delete

# 遍历doc目录所有.docx文件
find doc/ -type f -name "*.docx" | while read file; do
    # 生成目标路径
    relative_path="${file#doc/}"
    html_path="html/${relative_path%.docx}.html"  # 修改后缀替换
    
    # 创建目标目录
    mkdir -p "$(dirname "$html_path")"
    
    # 使用pandoc转换（关键参数调整）
    pandoc "$file" -o "$html_path" \
        --standalone \
        --template=template.html \
        --mathjax \                # 支持数学公式
        --extract-media=html/assets # 提取图片到指定目录
done