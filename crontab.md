# 排程設定

## 設定排程
```
crontab -e
```
- 同步 obsidian 文件到 git
    ```
    * * * * * cd /home/maxime/data/openclaw && ./sync-obsidian.sh > /home/maxime/data/openclaw/sync-obsidian.log 2>&1
    ```