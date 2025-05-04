#!/bin/bash

# 清空html目录（保留.gitkeep）
find html/ -type f ! -name '.gitkeep' -delete

# 遍历doc目录所有.md文件
find doc/ -type f -name "*.md" | while read file; do
    # 生成目标路径
    relative_path="${file#doc/}"
    html_path="html/${relative_path%.md}.html"
    
    # 创建目标目录
    mkdir -p "$(dirname "$html_path")"
    
    # 使用pandoc转换
    pandoc "$file" -o "$html_path" --standalone --template=template.html
done

# 可选：添加自动提交
# git add html/
# git commit -m "Auto-update html files"
# git push