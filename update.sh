#!/bin/bash

# 获取当前分支的最新提交哈希
current_hash=$(git rev-parse HEAD)

# 从远程仓库获取最新代码
git fetch origin

# 获取远程仓库的最新提交哈希
remote_hash=$(git rev-parse origin/$(git branch --show-current))

# 比较本地和远程的提交哈希
if [ "$current_hash" != "$remote_hash" ]; then
    echo "$(date): 代码已更新，正在重启 Docker 容器..." >> update.log
    docker restart mafl-mafl-1
    echo "$(date): Docker 容器已重启。" >> update.log
else
    echo "$(date): 代码未更新，无需重启 Docker 容器。" >> update.log
fi