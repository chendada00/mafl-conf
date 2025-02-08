#!/bin/bash

# 日志文件路径
LOG_FILE="update.log"

# 获取当前分支的最新提交哈希
current_hash=$(git rev-parse HEAD)

# 从远程仓库获取最新代码
git fetch origin

# 获取远程仓库的最新提交哈希
remote_hash=$(git rev-parse origin/$(git branch --show-current))

# 比较本地和远程的提交哈希
if [ "$current_hash" != "$remote_hash" ]; then
    echo "$(date): 代码已更新，正在同步远程代码到本地..." | tee -a "$LOG_FILE"
    # 将远程代码合并到本地分支
    git merge origin/$(git branch --show-current) | tee -a "$LOG_FILE"
    echo "$(date): 远程代码已同步到本地。" | tee -a "$LOG_FILE"

    # 重启 Docker 容器
    echo "$(date): 正在重启 Docker 容器..." | tee -a "$LOG_FILE"
    docker restart mafl-mafl-1 | tee -a "$LOG_FILE"
    echo "$(date): Docker 容器已重启。" | tee -a "$LOG_FILE"
else
    echo "$(date): 代码未更新，无需同步或重启 Docker 容器。" | tee -a "$LOG_FILE"
fi